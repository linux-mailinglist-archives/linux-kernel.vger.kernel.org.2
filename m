Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6D40C2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhIOJhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:37:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F1FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:36:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631698583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Sotz2qZ3V6mRPHb85bGHa5oilfi1mvXzoQ/qd51OsQ=;
        b=tybsb7EQDZJPakljkfy2rQMDEepv24ridhEk+PVVEZSp/W29kSsimCX83kInA1nNiVpHSz
        cZIcYmbCIlVoECkJajxaMA1FL8gJDhx0vzJ2rjPiiPxTEMVBcP+i5GtoX0U3+Zi2B0GhEQ
        emThUOti6l8yV9NxUnUm9cL/QT8E9h7xsuENoWIzfhQU7v9T5t9oMZ3ATQaKf1Kga/GZxj
        GDQvGaXi1xtDyO8FtfFVJm1pjWKMxSV5qLGEuV39lqETWrO54Yt1G7fhRim+jjq0Lb9m77
        OKr+6QDMssGzkOBdU6TMui85cuT7L8bsR++F+VSylsC6Pc5mVV/Nv5z3DeFnbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631698583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Sotz2qZ3V6mRPHb85bGHa5oilfi1mvXzoQ/qd51OsQ=;
        b=ZRm6sPGVlsYvyue/PTnPpKUGvBo2kIEfixbagUfzX4moyZzhg5Gn8R+EVxTLTHddBKlTjb
        siJVcMrptAbvxBDQ==
To:     paulmck@kernel.org, Dmitry Vyukov <dvyukov@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
In-Reply-To: <20210914183142.GP4156@paulmck-ThinkPad-P17-Gen-1>
References: <000000000000eaacf005ca975d1a@google.com>
 <20210831074532.2255-1-hdanton@sina.com>
 <20210914123726.4219-1-hdanton@sina.com> <87v933b3wf.ffs@tglx>
 <CACT4Y+Yd3pEfZhRUQS9ymW+sQZ4O58Dz714xSqoZvdKa_9s2oQ@mail.gmail.com>
 <20210914183142.GP4156@paulmck-ThinkPad-P17-Gen-1>
Date:   Wed, 15 Sep 2021 11:36:22 +0200
Message-ID: <87ee9qb2p5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14 2021 at 11:31, Paul E. McKenney wrote:
> On Tue, Sep 14, 2021 at 08:00:04PM +0200, Dmitry Vyukov wrote:
>> If I understand it correctly the timer is not actually set up as
>> periodic, but rather each callback invocation arms it again. Setting
>> up a timer for 1 ns _once_ (or few times) is probably fine (right?),
>> so the check needs to be somewhat more elaborate and detect "infinite"
>> rearming.
>
> If it were practical, I would suggest checking for a CPU never actually
> executing any instructions in the interrupted context.  The old-school
> way of doing this was to check the amount of time spent interrupted,
> perhaps adding some guess at interrupt entry/exit overhead.  Is there
> a better new-school way?

Set NR_CPUS=0 and if then any executed instruction is observed the bug
is pretty obvious, isn't it?
