Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3339B97F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhFDNJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:09:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37946 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhFDNIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:08:52 -0400
Received: from zn.tnic (p200300ec2f1385004faffa1744dfe63e.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:8500:4faf:fa17:44df:e63e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE0351EC023E;
        Fri,  4 Jun 2021 15:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1622812025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/KPgq/2N3PlTtxCD7KCcmnsHEOIIiWqFzn4jWFnhUpQ=;
        b=OlRa6cZCQMuTBK+N2DihQdmJFvMVDCE25L9WwYCqHgzWvrGQp4Pfs0zsSHuMC9xdDBuawd
        SQ0Ls8RlTdCkbU9+JGLWIx1Nuc6sYnJiLVJcjW+pqZkSbakaocikMA9YgrkY7xvHwYFBxd
        P2jqaz8IX/VWLDVR7zj+JWYdg+4cq0g=
Date:   Fri, 4 Jun 2021 15:06:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jiashuo Liang <liangjs@pku.edu.cn>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal/x86: Don't send SIGSEGV twice on SEGV_PKUERR
Message-ID: <YLolc7z64h9yHNao@zn.tnic>
References: <20210601085203.40214-1-liangjs@pku.edu.cn>
 <YLkhV+lSqXlcfUc5@zn.tnic>
 <87lf7qocsd.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lf7qocsd.fsf@disp2133>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 04:31:46PM -0500, Eric W. Biederman wrote:
> There are two ways signals get delivered.  The old fashioned way in the
> signal bitmap, and the new fangled way by queuing sigqueue_info.

By that you mean that third arg siginfo_t to

SYSCALL_DEFINE3(rt_sigqueueinfo, pid_t, pid, int, sig,
                siginfo_t __user *, uinfo)

I presume?

Which, as sigqueue(3) says, is what is called on Linux.

> In the old fashioned way there is no information except that the
> signal itself was delivered, and if the signal is sent twice it
> is impossible to find out. In the new fangled way because the
> sigqueue_info can vary between different times a signal is sent you
> can both see that a signal was delivered twice (because there are two
> distinct entries in the queue), but also possibly tell those two times
> a signal was sent apart.
>
> The new real time signals can queue as many sigqueue_info's as their
> rlimit allows.  The old signals are limited to exactly one sigqueue_info
> per signal number.

Aha.

> In this case the legacy_queue check tests to see if the signal is
> already pending (present in the signal bitmap) and not a new real time
> signal (which means only one sigqueue_info entry is allowed in the
> signal queue).

Aha, that sigismember() call in legacy_queue().

> Or in short I think everything turns out ok because the first signal is
> delivered, and the second just happens to get dropped as a duplicate by
> __send_signal.

Right, it is a SIGSEGV in both cases. So it is a legacy signal, and
that'll get marked in that sigset->sig array. Which is per task... ok.

> That is fragile and confusing to depend on so we should just fix the
> code to not send the wrong signal.

Yap.

> I hope that clears things up.

Very much so, thanks for taking the time!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
