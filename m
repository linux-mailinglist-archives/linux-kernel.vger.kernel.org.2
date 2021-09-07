Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FF40305B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347265AbhIGVim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:38:42 -0400
Received: from mother.openwall.net ([195.42.179.200]:47524 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229875AbhIGVii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:38:38 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Sep 2021 17:38:38 EDT
Received: (qmail 8086 invoked from network); 7 Sep 2021 21:30:48 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 7 Sep 2021 21:30:48 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 58A79AB88C; Tue,  7 Sep 2021 23:30:42 +0200 (CEST)
Date:   Tue, 7 Sep 2021 23:30:42 +0200
From:   Solar Designer <solar@openwall.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     CGEL <cgel.zte@gmail.com>, peterz@infradead.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        James Morris <jamorris@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] set_user: add capability check when rlimit(RLIMIT_NPROC) exceeds
Message-ID: <20210907213042.GA22626@openwall.com>
References: <20210728072629.530435-1-ran.xiaokai@zte.com.cn> <20210728115930.2lzs57h4hvnqipue@wittgenstein> <20210730082329.GA544980@www> <20210803100354.GA607722@www> <20210803140702.f3rdnka3e2x6vj4r@wittgenstein>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803140702.f3rdnka3e2x6vj4r@wittgenstein>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Brad Spengler brought this to my attention on Twitter, and Christian
Brauner agreed I should follow up.  So here goes, below the quote:

On Tue, Aug 03, 2021 at 04:07:02PM +0200, Christian Brauner wrote:
> On Tue, Aug 03, 2021 at 03:03:54AM -0700, CGEL wrote:
> > On Fri, Jul 30, 2021 at 01:23:31AM -0700, CGEL wrote:
> > > On Wed, Jul 28, 2021 at 01:59:30PM +0200, Christian Brauner wrote:
> > > > [Ccing a few people that did the PF_NPROC_EXCEEDED changes]
> > > > 
> > > > 
> > > > Hey Cgel,
> > > > Hey Ran,
> > > > 
> > > > The gist seems to me that this code wants to make sure that a program
> > > > can't successfully exec if it has gone through a set*id() transition
> > > > while exceeding its RLIMIT_NPROC.
> > > > 
> > > > But I agree that the semantics here are a bit strange.
> > > > 
> > > > Iicu, a capable but non-INIT_USER caller getting PF_NPROC_EXCEEDED set
> > > > during a set*id() transition wouldn't be able to exec right away if they
> > > > still exceed their RLIMIT_NPROC at the time of exec. So their exec would
> > > > fail in fs/exec.c:
> > > > 
> > > > 	if ((current->flags & PF_NPROC_EXCEEDED) &&
> > > > 	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > > > 		retval = -EAGAIN;
> > > > 		goto out_ret;
> > > > 	}
> > > > 
> > > > However, if the caller were to fork() right after the set*id()
> > > > transition but before the exec while still exceeding their RLIMIT_NPROC
> > > > then they would get PF_NPROC_EXCEEDED cleared (while the child would
> > > > inherit it):
> > > > 
> > > > 	retval = -EAGAIN;
> > > > 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
> > > > 		if (p->real_cred->user != INIT_USER &&
> > > > 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
> > > > 			goto bad_fork_free;
> > > > 	}
> > > > 	current->flags &= ~PF_NPROC_EXCEEDED;
> > > > 
> > > > which means a subsequent exec by the capable caller would now succeed
> > > > even though they could still exceed their RLIMIT_NPROC limit.
> > > > 
> > > > So at first glance, it seems that set_user() should probably get the
> > > > same check as it can be circumvented today unless I misunderstand the
> > > > original motivation.
> > > > 
> > > > Christian
> > > 
> > > Hi Christian,
> > > 
> > > I think i didn't give enough information in the commit message.
> > > When switch to a capable but non-INIT_SUER and the RLIMIT_NPROC limit already exceeded,
> > > and calls these funcs:
> > > 1. set_xxuid()->exec() 
> > >              ---> fail
> > > 2. set_xxuid()->fork()->exec()
> > >              ---> success
> > > Kernel should have the same behavior to uer space.
> > > Also i think non init_user CAN exceed the limit when with proper capability,
> > > so in the patch, set_user() clear PF_NPROC_EXCEEDED flag if capable()
> > > returns true.
> > 
> > Hi, Christian
> > 
> > Do you have any further comments on this patch?
> > is there anything i did not give enough infomation ?
> 
> Yeah, this is fine and how I understood it too. I don't see anything
> obviously wrong with it and the weird detour workaround via fork() seems
> inconsistent. So if I don't here anyone come up with a good reason the
> current behavior makes sense I'll pick this up.
> 
> Christian

As I understand, the resulting commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2863643fb8b92291a7e97ba46e342f1163595fa8

broke RLIMIT_NPROC support for Apache httpd suexec and likely similar.

Yes, I can see how having a detour via fork() was inconsistent, but
since the privileged process can be assumed non-malicious it was no big
deal.  suexec just doesn't have fork() in there.

Historically, the resetting on fork() appears to have been due to my
suggestion here:

https://www.openwall.com/lists/kernel-hardening/2011/07/25/4

"Perhaps also reset the flag on fork() because we have an RLIMIT_NPROC
check on fork() anyway."

Looks like I didn't consider the inconsistency for capable() processes
(or maybe that exception wasn't yet in there?)

Anyway, now I suggest that 2863643fb8b92291a7e97ba46e342f1163595fa8 be
reverted, and if there's any reason to make any change (what reason?
mere consistency or any real issue?) then I suggest that the flag
resetting on fork() be made conditional.  Something like this:

	if (atomic_read(&p->real_cred->user->processes) >=
			task_rlimit(p, RLIMIT_NPROC)) {
		if (p->real_cred->user != INIT_USER &&
		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
			goto bad_fork_free;
-	}
-	current->flags &= ~PF_NPROC_EXCEEDED;
+	} else
+		current->flags &= ~PF_NPROC_EXCEEDED;

Alexander
