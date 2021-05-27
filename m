Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABA73935EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhE0TGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhE0TGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:06:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17300C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 12:05:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622142307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25M0C2YZgyEZxti8qOzHVEHGW5tdGz4sUGTF5ch8E/I=;
        b=uuxVyfxNEYiQzvquDvi758SAutgtAPuxLBU9cAJBklcWIgB92wsAIFUrmL4hZ7gsVxiooA
        kolmywVAvA3XPV8L6sFKKelBVe2xdImVY8qCaCDCuGTw+UjLqSo/rPLreHfVaejVnFWpHm
        JB+Jt2hECpRG+xV3Cmz7DRs2ORr6pNeaptsA6JRSpKCB0KV+HnFkW+9D6RA9q9oTX0OhsO
        IyHFKnzrELoEUowhBIt4p4iONqjIbcvVwE1OLfR8XQhxHYjZoAS+wcjhhUJ5fHbef97YbM
        HpgAg8mDKwOhAZ+NSVH8vfWPGMk1tZhZwKzT1LIDm2mEkwLX/WIW5+FrJw4DJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622142307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=25M0C2YZgyEZxti8qOzHVEHGW5tdGz4sUGTF5ch8E/I=;
        b=3hwU/ieqCIAZauQaorB+76feAxHBk//GVxB/LoHeiC0mfOk9mLq63BJr28pO0GmIUtO4Xi
        6LaN8rfIN4RkaaDQ==
To:     Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com,
        x86@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
In-Reply-To: <87bl8w86m3.ffs@nanos.tec.linutronix.de>
References: <0000000000004c453905c30f8334@google.com> <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org> <87sg29886g.ffs@nanos.tec.linutronix.de> <87bl8w86m3.ffs@nanos.tec.linutronix.de>
Date:   Thu, 27 May 2021 21:05:06 +0200
Message-ID: <874keo80bh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27 2021 at 18:49, Thomas Gleixner wrote:
> On Thu, May 27 2021 at 00:03, Thomas Gleixner wrote:
> The original code kinda worked because fpu__clear() reinitialized the
> task fpu state, but as this code is preemptible the same issue can
> happen pre 5.8 as well if I'm not missing something. I'll verify that
> after dinner.

Yes, I was missing something and pre 5.8 _IS_ safe because fpu__clear()
wipes task->fpu.state. Preemption does not matter because
TIF_NEED_FPU_LOAD is set _before_ the copy from user happens and in the
failure case it is guaranteed that fpu__clear() is invoked before a
XRSTOR can happen from that wreckaged buffer.

So it's clearly this particular commit, which is sooo innocent according
to the submitter and fpu__clear() just helps to clean up the mess. It
just fails to clean up the mess which that commit created inside
fpu__clear() in the first place.

Clearly nothing of this whole system/user state seperation was
thoroughly tested, which means ANY patch which is XSTATE related is
blocked until this mess is analyzed and cleaned up.

From now on ANY patch which extends or modifies XSTATE handling has to
be accompanied by proper test cases and analysis. Without that such
patches are not even going to be reviewed. This applies to all patches
in flight as well.

I don't mind bugs, but unprofessionally dismissing a conclusive bisect
and handwaving about ptrace modified segment registers on X86_64 is just
not acceptable.

Thanks,

        tglx
