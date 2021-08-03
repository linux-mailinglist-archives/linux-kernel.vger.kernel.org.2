Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A13DEFBB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhHCOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236045AbhHCOHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:07:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2466960F94;
        Tue,  3 Aug 2021 14:07:04 +0000 (UTC)
Date:   Tue, 3 Aug 2021 16:07:02 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        James Morris <jamorris@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC)
 exceeds
Message-ID: <20210803140702.f3rdnka3e2x6vj4r@wittgenstein>
References: <20210728072629.530435-1-ran.xiaokai@zte.com.cn>
 <20210728115930.2lzs57h4hvnqipue@wittgenstein>
 <20210730082329.GA544980@www>
 <20210803100354.GA607722@www>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803100354.GA607722@www>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 03:03:54AM -0700, CGEL wrote:
> On Fri, Jul 30, 2021 at 01:23:31AM -0700, CGEL wrote:
> > On Wed, Jul 28, 2021 at 01:59:30PM +0200, Christian Brauner wrote:
> > > [Ccing a few people that did the PF_NPROC_EXCEEDED changes]
> > > 
> > > 
> > > Hey Cgel,
> > > Hey Ran,
> > > 
> > > The gist seems to me that this code wants to make sure that a program
> > > can't successfully exec if it has gone through a set*id() transition
> > > while exceeding its RLIMIT_NPROC.
> > > 
> > > But I agree that the semantics here are a bit strange.
> > > 
> > > Iicu, a capable but non-INIT_USER caller getting PF_NPROC_EXCEEDED set
> > > during a set*id() transition wouldn't be able to exec right away if they
> > > still exceed their RLIMIT_NPROC at the time of exec. So their exec would
> > > fail in fs/exec.c:
> > > 
> > > 	if ((current->flags & PF_NPROC_EXCEEDED) &&
> > > 	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > > 		retval = -EAGAIN;
> > > 		goto out_ret;
> > > 	}
> > > 
> > > However, if the caller were to fork() right after the set*id()
> > > transition but before the exec while still exceeding their RLIMIT_NPROC
> > > then they would get PF_NPROC_EXCEEDED cleared (while the child would
> > > inherit it):
> > > 
> > > 	retval = -EAGAIN;
> > > 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > > 		if (p->real_cred->user != INIT_USER &&
> > > 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> > > 			goto bad_fork_free;
> > > 	}
> > > 	current->flags &= ~PF_NPROC_EXCEEDED;
> > > 
> > > which means a subsequent exec by the capable caller would now succeed
> > > even though they could still exceed their RLIMIT_NPROC limit.
> > > 
> > > So at first glance, it seems that set_user() should probably get the
> > > same check as it can be circumvented today unless I misunderstand the
> > > original motivation.
> > > 
> > > Christian
> > 
> > Hi Christian,
> > 
> > I think i didn't give enough information in the commit message.
> > When switch to a capable but non-INIT_SUER and the RLIMIT_NPROC limit already exceeded,
> > and calls these funcs:
> > 1. set_xxuid()->exec() 
> >              ---> fail
> > 2. set_xxuid()->fork()->exec()
> >              ---> success
> > Kernel should have the same behavior to uer space.
> > Also i think non init_user CAN exceed the limit when with proper capability,
> > so in the patch, set_user() clear PF_NPROC_EXCEEDED flag if capable()
> > returns true.
> 
> Hi, Christian
> 
> Do you have any further comments on this patch?
> is there anything i did not give enough infomation ?

Yeah, this is fine and how I understood it too. I don't see anything
obviously wrong with it and the weird detour workaround via fork() seems
inconsistent. So if I don't here anyone come up with a good reason the
current behavior makes sense I'll pick this up.

Christian
