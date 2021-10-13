Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1352E42C485
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJMPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMPMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:12:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629EE610E6;
        Wed, 13 Oct 2021 15:10:01 +0000 (UTC)
Date:   Wed, 13 Oct 2021 11:09:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Yordan Karadzhov <y.karadz@gmail.com>
Subject: Re: [PATCH v2] tracing: Fix event probe removal from dynamic events
Message-ID: <20211013110959.5c4d294d@gandalf.local.home>
In-Reply-To: <20211013233244.46341468a06ba43895b99c0e@kernel.org>
References: <20211012081925.0e19cc4f@gandalf.local.home>
 <20211013074611.ea157d4ed04d3c33290361f5@kernel.org>
 <20211012201559.5f0ad249@gandalf.local.home>
 <20211013233244.46341468a06ba43895b99c0e@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 23:32:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > Then the following should work:
> > 
> >   # echo '-:hrstate timer/hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> >   # echo '-:eprobes/hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> >   # echo '-:eprobes/hrstate timer.hrtimer_cancel' >> dynamic_events
> >   # echo '-:eprobes/hrstate' >> dynamic_events  
> 
> Agreed.
> 
> > 
> > But the following will not work:
> > 
> >   # echo '-:hrstate state=+0x38($hrtimer):u8' >> dynamic_events
> >   # echo '-:hrstate timer.hrtimer_cancel state=+0x38($hrtimer):u8' >> dynamic_events
> >   # echo '-:hrstate timer.hrtimer_cancel' >> dynamic_events  
> 
> The first one is agreed. But the rest 2 cases should work because it just omits the
> group name. At least {k,u}probe events work.
> 
> > Should this work?
> > 
> >   # echo '-:hrstate' >> dynamic_events  
> 
> Yes. In this case, all dynamic events which have "hrstate" event name are removed.


Thanks for the feedback. I'll update it.

-- Steve
