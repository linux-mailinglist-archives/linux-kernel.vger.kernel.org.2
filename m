Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D443CC02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbhJ0OYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:24:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238285AbhJ0OYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:24:00 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F106B60F92;
        Wed, 27 Oct 2021 14:21:33 +0000 (UTC)
Date:   Wed, 27 Oct 2021 10:21:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 08/20] rtla: Helper functions for rtla
Message-ID: <20211027102132.4bb0186b@gandalf.local.home>
In-Reply-To: <YXlcBhnqiKVxV4UX@geo.homenetwork>
References: <cover.1635284863.git.bristot@kernel.org>
        <183637700a31169e5d6d1c8a827c5365599ec806.1635284863.git.bristot@kernel.org>
        <YXlcBhnqiKVxV4UX@geo.homenetwork>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 22:02:46 +0800
Tao Zhou <tao.zhou@linux.dev> wrote:

> > +long parse_ns_duration(char *val)
> > +{
> > +	char *end;
> > +	long t;
> > +
> > +	t = strtol(val, &end, 10);
> > +
> > +	if (end) {
> > +		if (!strncmp(end, "ns", 2)) {
> > +			return t;
> > +		} else if (!strncmp(end, "us", 2)) {
> > +			t *= 1000;
> > +			return t;
> > +		} else if (!strncmp(end, "ms", 2)) {
> > +			t *= 1000 * 1000;
> > +			return t;
> > +		} else if (!strncmp(end, "s", 1)) {
> > +			t *= 1000 * 1000 * 100;  
>                                ^^^
> Ah, 1000 not 100. 

Hi Tao,

Please trim your emails and cut the part that is not needed in your reply.

If I scroll down three times and see no text, I likely just delete the
email without reading further. I know others that do the same.

I exempted your email this time.

-- Steve
