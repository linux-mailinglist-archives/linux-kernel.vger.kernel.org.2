Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347A2310E64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhBEPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhBEP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:16 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C78C061793
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:07:05 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id n7so8144183oic.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 09:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CiRHiBjfgyKWH3em9AEl+bMDdVNYxlHfJr2DRSDCVA=;
        b=NBKD+zfoWfUVKP89J2Ssz3Psr/aqZy7P/yxdbeUclUL2nsLAmpMJPjuIqgfnO72M+R
         OWbAGtezNS0EqGFi5gs7atqG1Jns61I5+lffC18AMCZ79goL1vtoeakGDY3VGPsFC6pN
         bjNfE2uFHcCWp2BEYsK4eRRuP0vDwyAXBjkx1RnDbA8SM1+volxFk6c+KG+g1urYAERT
         9KsQjcxW6KEFW6jHdWOY9Li4Oq2eVwdJrd4cXiAkocnP5eoAJhVLoBsZ6w39lnLzBAuF
         ofqKCVAaQ1FDA4WK6c4gBoHZvk6Sm8T/WKC3R1WxVfr/bgvVgAXb651Zu+1QJTD6Ye0E
         K4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CiRHiBjfgyKWH3em9AEl+bMDdVNYxlHfJr2DRSDCVA=;
        b=bYaL+4rv7RyKCmSAeyqHvTn9MyrRl/lmJcF3Xkh0z72ejOaUiBE+YVMo4WbjXcXV9Q
         ETKfOBTvroW1zE13Z4YzJYMrDNoW7DYq1zA4rNgNqLvkPTG2zEcjaP5XnmWIMM/a/9WS
         r93tXWizZbYp/O46gcS/B3lsOkb/BQ1Pxb+Jy9vSOBGR8FD+T9mESoE9e8keBJtONiiT
         7qqbeKvbRHcqOuvskjTh2inwtMYp/0OdFNM/WOmCgC7sqLdFZRjv+FC0SfnObcEX0Dou
         VDfRJqdzlXwYNACEzq2sm6t15LYQMgzi6i5YQhR78TIcxs1L4C9CdEFfj5put0B5K+rG
         OwXg==
X-Gm-Message-State: AOAM531ASXvf+6lhb5SpaZZalCH3025F47NfssoQFo0cm5dMQMAGh/Hg
        GPSrZW/BtrXcpyH3W9LOg+OMhcv36K2yAepuUgbVUg==
X-Google-Smtp-Source: ABdhPJwyG5XHMfddTE3lTh9bXPoLB+Ng8ywxGO1+tKiyNWfb5gczV3/qwp51P3hd5Ndbwk/m3ODFCndmdHaw3xEkRrE=
X-Received: by 2002:a54:4482:: with SMTP id v2mr3641744oiv.121.1612544824351;
 Fri, 05 Feb 2021 09:07:04 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006e8af605ba99c1af@google.com>
In-Reply-To: <0000000000006e8af605ba99c1af@google.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 5 Feb 2021 18:06:53 +0100
Message-ID: <CANpmjNNX22dDoYK3XgrgCmoEPo5Fv+1dqm=nbYhTJWs7gPSw_A@mail.gmail.com>
Subject: Re: KCSAN: data-race in blk_stat_add / blk_stat_timer_fn (5)
To:     syzbot <syzbot+2b6452167d85a022bc6f@syzkaller.appspotmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 at 18:00, syzbot
<syzbot+2b6452167d85a022bc6f@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2ab38c17 mailmap: remove the "repo-abbrev" comment
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=130e19b4d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=38728258f37833e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=2b6452167d85a022bc6f
> compiler:       clang version 12.0.0 (https://github.com/llvm/llvm-project.git 913f6005669cfb590c99865a90bc51ed0983d09d)
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2b6452167d85a022bc6f@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in blk_stat_add / blk_stat_timer_fn
>
> write to 0xffffe8ffffd35c80 of 8 bytes by interrupt on cpu 0:
>  blk_rq_stat_init block/blk-stat.c:24 [inline]
>  blk_stat_timer_fn+0x349/0x410 block/blk-stat.c:95
>  call_timer_fn+0x2e/0x240 kernel/time/timer.c:1417
>  expire_timers+0x116/0x260 kernel/time/timer.c:1462
>  __run_timers+0x338/0x3d0 kernel/time/timer.c:1731
>  run_timer_softirq+0x19/0x30 kernel/time/timer.c:1744
>  __do_softirq+0x13c/0x2c3 kernel/softirq.c:343
>  asm_call_irq_on_stack+0xf/0x20
>  __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
>  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
>  do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
>  invoke_softirq kernel/softirq.c:226 [inline]
>  __irq_exit_rcu+0xb4/0xc0 kernel/softirq.c:420
>  sysvec_apic_timer_interrupt+0x74/0x90 arch/x86/kernel/apic/apic.c:1096
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:628
>
> read to 0xffffe8ffffd35c80 of 8 bytes by interrupt on cpu 1:
>  blk_rq_stat_add block/blk-stat.c:46 [inline]
>  blk_stat_add+0x13d/0x230 block/blk-stat.c:74
>  __blk_mq_end_request+0x142/0x230 block/blk-mq.c:546
>  scsi_end_request+0x2a6/0x470 drivers/scsi/scsi_lib.c:604
>  scsi_io_completion+0x104/0xfb0 drivers/scsi/scsi_lib.c:969
>  scsi_finish_command+0x263/0x2b0 drivers/scsi/scsi.c:214
>  scsi_softirq_done+0xdf/0x440 drivers/scsi/scsi_lib.c:1449
>  blk_done_softirq+0x145/0x190 block/blk-mq.c:588
>  __do_softirq+0x13c/0x2c3 kernel/softirq.c:343
>  asm_call_irq_on_stack+0xf/0x20
>  __run_on_irqstack arch/x86/include/asm/irq_stack.h:26 [inline]
>  run_on_irqstack_cond arch/x86/include/asm/irq_stack.h:77 [inline]
>  do_softirq_own_stack+0x32/0x40 arch/x86/kernel/irq_64.c:77
>  invoke_softirq kernel/softirq.c:226 [inline]
>  __irq_exit_rcu+0xb4/0xc0 kernel/softirq.c:420
>  common_interrupt+0xb5/0x130 arch/x86/kernel/irq.c:239
>  asm_common_interrupt+0x1e/0x40 arch/x86/include/asm/idtentry.h:619
>  check_access kernel/kcsan/core.c:633 [inline]
>  __tsan_read1+0x156/0x180 kernel/kcsan/core.c:839
>  tomoyo_get_mode security/tomoyo/util.c:1003 [inline]
>  tomoyo_init_request_info+0xfc/0x160 security/tomoyo/util.c:1031
>  tomoyo_path_perm+0x8b/0x330 security/tomoyo/file.c:815
>  tomoyo_inode_getattr+0x18/0x20 security/tomoyo/tomoyo.c:123
>  security_inode_getattr+0x7f/0xd0 security/security.c:1280
>  vfs_getattr fs/stat.c:121 [inline]
>  vfs_fstat+0x45/0x390 fs/stat.c:146
>  __do_sys_newfstat fs/stat.c:386 [inline]
>  __se_sys_newfstat+0x35/0x240 fs/stat.c:383
>  __x64_sys_newfstat+0x2d/0x40 fs/stat.c:383
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 18199 Comm: modprobe Not tainted 5.11.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================

I've been looking at some data races in block/. For this one I was
wondering if there are any requirements for the stats counters? E.g.
do they have to be somewhat consistent, or does it not matter at all?

Because as-is, with concurrent update and aggregation (followed by
reinit) of the per-CPU counters, the values in blk_rq_stat can become
quite inconsistent.

I wanted to throw together a fix for this, but wasn't sure what the
level of tolerable errors for these counters is appropriate. I thought
of 3 options:

1. Just add more data_race() around them and accept whatever
inaccuracies we get due to the data races.

2. Add a per-CPU spinlock. This should be uncontended unless the timer
fires too often.

3. Use per-CPU seqlock. Not sure this buys us much because the timer
also resets the per-CPU counters and has to be serialized with other
potential updaters.

Thanks,
-- Marco
