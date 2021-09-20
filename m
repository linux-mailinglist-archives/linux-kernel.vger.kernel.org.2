Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4654F4114E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhITMxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbhITMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:53:03 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF015C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:51:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id on12-20020a17090b1d0c00b001997c60aa29so11918544pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ExRmR708x/gyL/JtajS5zbwIskm76NdRx84z5ASeZDk=;
        b=QCOrlTCN3Ql3iFrKeHtmbKFIDp3wKRBAHxoIJyRqVnat2HF8Z3kdXV02i6J/isNhby
         eYjjIqiMGci7D3iTKvfIzqmdvIHPm6dast0/xMRaIR0Veg6DnjyFozlzxWHBFsf9gaoz
         KQI7kdvUiI/o9c3z9ozJzsNpCvDWdp7cztBQobAuA5CBkMRUGe33qkg6xJ5NRyS3lqYD
         R1kxqQ8701g/Rr6+5o2FSqDVssdlfAv4lNuA43T56MpY1DJfZLcppcpGPIqwYVJ7ZNDC
         aqkTbG1iiE5trsBH5oEsFeLzsQFC6Ihr8axVKtkjvQlJUxdqBdpT6zT6pR90LAW6jgqH
         1/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ExRmR708x/gyL/JtajS5zbwIskm76NdRx84z5ASeZDk=;
        b=iNgZ5/3zsgzRfx8bRal4hPKiVfVhbY++2fmLzwlio25+eQbYmWXwcpAVfUs3iv2n9/
         DpgIuNTPu2JLKxNDPUmY9g6NxtovDxPq/BJIJtHijEpDdGFaZl1CeR8NpH8lDT5DgOQ4
         nEwPFqt8FwtomOnq309Wli3VTppnaU8w9kUwwjRAhzx/+4CMjUZYnFFIrgyUuDGx2SpN
         Pe9aLpGA4Xe/PKLul5HW1xhkOL48tBW7QJDtdQFuBkUx2kbjn/6g9aOcyXublvwDQ7iX
         h8R3r9FtZ9rRgT997h8BSbghRnnnvqz+569xyOEkiWaBhLDAhp/xCfQvgbCx2YMc3g0V
         GOEw==
X-Gm-Message-State: AOAM530xFzyAf32aMwtJIDl7R+RW0v5TsqpPi8GUGc9BoDb7rpcRTXeN
        BuXXH1p1eRbO8DI6UNqv7c1EjhUUbG7QE9qSbwGB7E6Mzg==
X-Google-Smtp-Source: ABdhPJwgeQXle3QRlvsF8hBSgh6CJnfObZgkS9kVptmVyXFiJCTE3qW2mRqmmL6B3xIEaQsegZm8Nm8XY3EGgPtZSwo=
X-Received: by 2002:a17:902:d892:b0:138:abfd:ec7d with SMTP id
 b18-20020a170902d89200b00138abfdec7dmr22644691plz.15.1632142296178; Mon, 20
 Sep 2021 05:51:36 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 20 Sep 2021 20:51:43 +0800
Message-ID: <CACkBjsY3bxfFWPvijNY7RX=GfXuT5C2av0C_mX1Sxj-+vvv0bA@mail.gmail.com>
Subject: BUG: sleeping function called from invalid context in synchronize_rcu_expedited
To:     akpm@linux-foundation.org, Linux MM <linux-mm@kvack.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 4357f03d6611 Merge tag 'pm-5.15-rc2
git tree: upstream
console output:
https://drive.google.com/file/d/1AJpdt-ENezAYZ0xo3787EvsK09-Vz404/view?usp=sharing
kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

BUG: sleeping function called from invalid context at kernel/rcu/tree_exp.h:854
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 21, name: ksoftirqd/1
2 locks held by ksoftirqd/1/21:
 #0: ffffffff85a1d4a0 (rcu_callback){....}-{0:0}, at: rcu_do_batch
kernel/rcu/tree.c:2500 [inline]
 #0: ffffffff85a1d4a0 (rcu_callback){....}-{0:0}, at:
rcu_core+0x283/0x9f0 kernel/rcu/tree.c:2743
 #1: ffffffff85a1fd28 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
 #1: ffffffff85a1fd28 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x32d/0x460 kernel/rcu/tree_exp.h:837
Preemption disabled at:
[<ffffffff8460005c>] softirq_handle_begin kernel/softirq.c:396 [inline]
[<ffffffff8460005c>] __do_softirq+0x5c/0x561 kernel/softirq.c:534
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 ___might_sleep+0x1f0/0x250 kernel/sched/core.c:9538
 synchronize_rcu_expedited+0x2db/0x460 kernel/rcu/tree_exp.h:853
 bdi_remove_from_list mm/backing-dev.c:938 [inline]
 bdi_unregister+0x97/0x270 mm/backing-dev.c:946
 release_bdi+0x4a/0x70 mm/backing-dev.c:968
 kref_put include/linux/kref.h:65 [inline]
 bdi_put+0x47/0x70 mm/backing-dev.c:976
 bdev_free_inode+0x59/0xc0 block/bdev.c:408
 i_callback+0x24/0x50 fs/inode.c:224
 rcu_do_batch kernel/rcu/tree.c:2508 [inline]
 rcu_core+0x2d6/0x9f0 kernel/rcu/tree.c:2743
 __do_softirq+0xe9/0x561 kernel/softirq.c:558
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:920
 smpboot_thread_fn+0x225/0x320 kernel/smpboot.c:164
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
BUG: scheduling while atomic: ksoftirqd/1/21/0x00000101
2 locks held by ksoftirqd/1/21:
 #0: ffffffff85a1d4a0 (rcu_callback){....}-{0:0}, at: rcu_do_batch
kernel/rcu/tree.c:2500 [inline]
 #0: ffffffff85a1d4a0 (rcu_callback){....}-{0:0}, at:
rcu_core+0x283/0x9f0 kernel/rcu/tree.c:2743
 #1: ffffffff85a1fd28 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
exp_funnel_lock kernel/rcu/tree_exp.h:290 [inline]
 #1: ffffffff85a1fd28 (rcu_state.exp_mutex){+.+.}-{3:3}, at:
synchronize_rcu_expedited+0x32d/0x460 kernel/rcu/tree_exp.h:837
Modules linked in:
Preemption disabled at:
[<ffffffff8460005c>] softirq_handle_begin kernel/softirq.c:396 [inline]
[<ffffffff8460005c>] __do_softirq+0x5c/0x561 kernel/softirq.c:534
