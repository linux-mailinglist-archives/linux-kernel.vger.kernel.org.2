Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B531D35E60A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347550AbhDMSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347547AbhDMSML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:12:11 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B7AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:11:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b139so13400324qkc.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10O+jPL+OEccKqpj/hH+I4ElPmWsuuh1UAUW2Q6XaMc=;
        b=peihZeIdAVSH5KcQpZhcxJydUFf5486sTu9ZesihRIbDtWtEQYyF7Am/Rz+3v6wp7/
         Vyz+eoXTtfF+eM7sx5K32zas5MclrOGalteAvd5OCOsmOKEglqH1A5HmdArw1D6Rf3H4
         F55+MPxPMCn4esziaFyVfLhTOJJcoxt+0FlMmSmDNpv7FUlUBla+ajavFeZNhSskhLuO
         +46JZGequ3FKkV8vBx3BedjEguv/Qa7NwdEPgw2xvQ8pMBgM+vQGTaC2D8aXINDLXv0O
         yRhHBo9ekIKjaSwRciHTCWnPYS4QPvACtx26pSSU1Wtax9I62T2OjzyVGMo9fjDLNzhu
         GCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10O+jPL+OEccKqpj/hH+I4ElPmWsuuh1UAUW2Q6XaMc=;
        b=S4n1s6w974qDGoKnEaz2xARxMTnAf+YeRZY1jzwRl2fUO9/MpDvXfwnuWRNbUdg2fK
         z4Zm5dbosziYHA1QROMr7v4eXram6lIebypAMTGdDs1RAS2lD+CBJ58oUi5Ks4zyINoe
         bzb5gFiAMbzQBUdzarIcIZl/h7BWZRiac4OtrHPjpr7gZkNHSLY1wBM7Lkp+V4iqRYhH
         rIk57z6DZ17Z3HDcMOj9JvP3T47bDn97mUwJUrJSDDXc0KcWUra41USQxWEzOZyxrmri
         BpVGNZ7HWasfV6St/O7XGeZR2RDVhGViPN6EDp0VVxSEX9DN9m03+EFhx5B+vkYpLpnw
         uIcA==
X-Gm-Message-State: AOAM5305/EKAE+jrXr37FIo9E3PKZx+k47tVo8ldfdmA5XL8L8ylXu1D
        E+Py9528yqymuqZ1lExoU2fHbz9vInf7pRAKj1k4ug==
X-Google-Smtp-Source: ABdhPJxTzart4cK+GierPgt6a6wC8/NNabJskhlHhlZTyQiQyE41giAZRYB0NYcQosS5+v5vst1pc9CimxrTgi1J7dE=
X-Received: by 2002:a05:620a:146e:: with SMTP id j14mr10312294qkl.424.1618337509665;
 Tue, 13 Apr 2021 11:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000066b6f405bf0d0660@google.com>
In-Reply-To: <00000000000066b6f405bf0d0660@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Apr 2021 20:11:38 +0200
Message-ID: <CACT4Y+a7m9_hGjb0f8r_ZELSGqs=NvpocST9pXex23y57RLGug@mail.gmail.com>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in __schedule
To:     syzbot <syzbot+be81a058b10931003a4a@syzkaller.appspotmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, mbenes@suse.cz,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 3, 2021 at 10:12 AM syzbot
<syzbot+be81a058b10931003a4a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1e43c377 Merge tag 'xtensa-20210329' of git://github.com/j..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1432bd1ad00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=78a83786814e7724
> dashboard link: https://syzkaller.appspot.com/bug?extid=be81a058b10931003a4a
> userspace arch: arm
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+be81a058b10931003a4a@syzkaller.appspotmail.com

#syz dup: WARNING: suspicious RCU usage in getname_flags

> =============================
> WARNING: suspicious RCU usage
> 5.12.0-rc5-syzkaller-00003-g1e43c377a79f #0 Not tainted
> -----------------------------
> kernel/sched/core.c:4841 Illegal context switch in RCU-sched read-side critical section!
>
> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 0
> no locks held by migration/1/17.
>
> stack backtrace:
> CPU: 1 PID: 17 Comm: migration/1 Not tainted 5.12.0-rc5-syzkaller-00003-g1e43c377a79f #0
> Hardware name: linux,dummy-virt (DT)
> Stopper: 0x0 <- 0x0
> Call trace:
>  dump_backtrace+0x0/0x3e0 arch/arm64/include/asm/pointer_auth.h:76
>  show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:191
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x120/0x1a8 lib/dump_stack.c:120
>  lockdep_rcu_suspicious+0x130/0x148 kernel/locking/lockdep.c:6428
>  schedule_debug kernel/sched/core.c:4841 [inline]
>  __schedule+0x1244/0x1bc4 kernel/sched/core.c:4967
>  schedule+0xac/0x22c kernel/sched/core.c:5152
>  smpboot_thread_fn+0x278/0x7f4 kernel/smpboot.c:161
>  kthread+0x320/0x3bc kernel/kthread.c:292
>  ret_from_fork+0x10/0x3c arch/arm64/kernel/entry.S:958
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000066b6f405bf0d0660%40google.com.
