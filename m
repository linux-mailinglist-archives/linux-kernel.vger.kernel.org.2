Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9872326B86
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 05:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhB0EFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 23:05:13 -0500
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:41588 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229863AbhB0EFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 23:05:11 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7C9841802DE0C;
        Sat, 27 Feb 2021 04:04:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:2897:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:7652:7875:7903:10004:10400:10450:10455:10848:10967:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14181:14659:14721:19904:19999:21067:21080:21611:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hook24_39184a92769f
X-Filterd-Recvd-Size: 2274
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 27 Feb 2021 04:04:29 +0000 (UTC)
Message-ID: <0cb9c9b8ce069a92df8b974d520606a494614892.camel@perches.com>
Subject: Re: [PATCH 0/2] tracing: Detect unsafe dereferencing of pointers
 from trace events
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jacob Wen <jian.w.wen@oracle.com>
Date:   Fri, 26 Feb 2021 20:04:28 -0800
In-Reply-To: <20210226183309.0edcc54d@gandalf.local.home>
References: <20210226185909.100032746@goodmis.org>
         <CAHk-=wiWF=ah_q1HBVUth2vuBx2TieN8U331y5FhXiehX-+=TQ@mail.gmail.com>
         <20210226183309.0edcc54d@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-02-26 at 18:33 -0500, Steven Rostedt wrote:
> On Fri, 26 Feb 2021 14:21:00 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > > The second patch handles strings "%s" [..]  
> > 
> > Doing this at runtime really feels like the wrong thing to do.
> > 
> > It won't even protect us from what happened - people like me and
> > Andrew won't even run those tracepoints in the first place, so we
> > won't notice.
> > 
> > It really would be much better in every respect to have this done by
> > checkpatch, I think.
> 
> They are not mutually exclusive. We could have both. One thing that's nice
> about this patch is that it removes the possibility of a real bug. That is,
> it will catch the dereferencing of a string that is not valid, WARN about
> it, but it wont try to dereference it (outside of the
> strcpy_from_kernel_nofault()). And hopefully the warning and lack of data
> they want, will have this get caught during development.
> 
> Also, there's cases that %s is allowed to reference data that I don't know
> if checkpatch would be able to differentiate.

It's not obvious to me how to do that.


