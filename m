Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6004D42B0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhJMASH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:18:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhJMASE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:18:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DF1604DA;
        Wed, 13 Oct 2021 00:16:01 +0000 (UTC)
Date:   Tue, 12 Oct 2021 20:15:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-ID: <20211012201559.5f0ad249@gandalf.local.home>
In-Reply-To: <20211013074611.ea157d4ed04d3c33290361f5@kernel.org>
References: <20211012081925.0e19cc4f@gandalf.local.home>
        <20211013074611.ea157d4ed04d3c33290361f5@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 07:46:11 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> The first argument check should be optional. If the event name matches and
> the system name is NULL but argc == 0, it should return true.
> (please consider it is a wild card like "-:*/EVENT *")
> So if the argc == 0 please skip below and check the event name and
> the system name.

OK, so I'll make them all optional, but at least, if they are supplied,
they will be checked.

That is, you can't add the options if you don't add the event as well. But
if you do add the event, then it should work.

Basically, we have the following:

 # echo 'e:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
 # cat dynamic_events
eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8

Then the following should work:

  # echo '-:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
  # echo '-:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
  # echo '-:eprobes/hrstate timer.hrtimer_cancel' >> dynamic_events
  # echo '-:eprobes/hrstate' >> dynamic_events

But the following will not work:

  # echo '-:hrstate state=+0x38($hrtimer):u8' >> dynamic_events
  # echo '-:hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
  # echo '-:hrstate timer.hrtimer_cancel' >> dynamic_events


Should this work?

  # echo '-:hrstate' >> dynamic_events

-- Steve
