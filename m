Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E7F435AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJUGjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:39:16 -0400
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:34020 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229499AbhJUGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:39:05 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 4F6AA180A68BF;
        Thu, 21 Oct 2021 06:36:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 27E60315D78;
        Thu, 21 Oct 2021 06:36:48 +0000 (UTC)
Message-ID: <14e76713c9d7dec2ce368a983c67bbffd8691551.camel@perches.com>
Subject: Re: [GIT PULL] tracing: Fix to recursion protection for 5.15
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Wed, 20 Oct 2021 23:36:47 -0700
In-Reply-To: <CAHk-=wicuM=0iMeRCrbG=MMLZRdwihpZ64rWxDqidEjMa-YDsA@mail.gmail.com>
References: <20211019091344.65629198@gandalf.local.home>
         <CAHk-=wjvGRtwMHDJ9VR8197+_rVveqE73Uv-MMFbvuUEbWKNtQ@mail.gmail.com>
         <20211020121727.57f46a15@gandalf.local.home>
         <CAHk-=whr2M-jzyv9B8Co0V0TMvCpnH24fWYwxXrN9YeGKicoVw@mail.gmail.com>
         <20211020181241.0e6a2b47@gandalf.local.home>
         <20211020184101.25b7e583@gandalf.local.home>
         <CAHk-=wgBhyLhQLPem1vybKNt7BKP+=qF=veBgc7VirZaXn4FUw@mail.gmail.com>
         <6ce0c8301cadef76fd45f38ace1e20408f6e52e9.camel@perches.com>
         <CAHk-=wicuM=0iMeRCrbG=MMLZRdwihpZ64rWxDqidEjMa-YDsA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 27E60315D78
X-Spam-Status: No, score=-2.81
X-Stat-Signature: uyk9pwi7came18gwsnr66qm7ga7fy546
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/bMGdFWxya663V7ZUnq+CT3bxpcg/ekUg=
X-HE-Tag: 1634798208-547660
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-20 at 20:27 -1000, Linus Torvalds wrote:
> On Wed, Oct 20, 2021 at 8:16 PM Joe Perches <joe@perches.com> wrote:
> > 
> > Generally, a tool like b4 should be able to create a list of any
> > email addresses in a thread linked commit.
> 
> I really think Cc lines are very useful.
> 
> That said, they are *more* useful when they are thought about, than
> when they are automated.
[]
> I will, for example, strive to put the people who _participated_ in
> some discussion as the "Cc" list - they may not have acked a patch, or
> reviewed it, but they might have piped up in the discussion, and that
> probably merits them then knowing about any problems it causes.

Which is exactly what "thread linked commit" attempted to convey.


