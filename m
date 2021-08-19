Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAA93F1238
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 06:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhHSEKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 00:10:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhHSEKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 00:10:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EBB610FA;
        Thu, 19 Aug 2021 04:10:06 +0000 (UTC)
Date:   Thu, 19 Aug 2021 00:10:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov" <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] tracing: Add a probe that attaches to trace
 events
Message-ID: <20210819001005.712e542a@oasis.local.home>
In-Reply-To: <20210819000342.615e68c7@oasis.local.home>
References: <20210817034255.421910614@goodmis.org>
        <20210817035028.190000494@goodmis.org>
        <20210819112920.a2fbfdc812967c2743953fd0@kernel.org>
        <20210818233757.686cd7c8@oasis.local.home>
        <20210819125652.bb6b980cf0ef04e0158bc564@kernel.org>
        <20210819000342.615e68c7@oasis.local.home>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2021 00:03:42 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Probably. I noticed that it was updated under the dyn_event_ops_mutex,
> and thought that was enough protection. But I now see the lockdep
> assert on the event_mutex in the other functions.

Anyway, here's the new version:

static bool find_event_probe(const char *group, const char *event)
{
	struct trace_eprobe *ep;
	struct dyn_event *ev;
	bool ret = false;

	/*
	 * Must grab the event_mutex to prevent the list from being modified
	 * by other probes. But the event_probe being only created via the
	 * dynamic_events file, is only added under the dyn_event_ops_mutex,
	 * which is currently held. There is no race between this check and
	 * adding the new probe.
	 */
	mutex_lock(&event_mutex);
	for_each_dyn_event(ev) {
		if (ev->ops != &eprobe_dyn_event_ops)
			continue;
		ep = to_trace_eprobe(ev);
		if (strcmp(ep->tp.event->class.system, group) == 0 &&
		    strcmp(ep->tp.event->call.name, event) == 0) {
			ret = true;
			break;
		}
	}
	mutex_lock(&event_mutex);

	return ret;
}


-- Steve
