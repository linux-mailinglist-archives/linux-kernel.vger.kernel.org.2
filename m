Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663BA411552
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhITNPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239211AbhITNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:15:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE1BC061760
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:13:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k17so1854145pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=rGxsOML45WI9SaJFmPmMPdVFz9lkK8hsoiCkoDAAJ4A=;
        b=SMosLvcIkiFcR3Bnd/yz8iske0uOWnyBD73JSrF5I0TQHolzdp9JQjNxeBhBZ3vPBw
         oZXlj7KbpRN6w3hBYTOeTffKSr4PzoVFG0m5QNIQTPtTeMsGt86WWrRNcc/FLBmY23Az
         iDbikd4IcNGy5i1g9iZ/iCf6ybGe54UPR/vTxa2ECcdQo2lO7E+gg1fuqfSqIQmZo+Av
         oQWhvGiboH3qZnxbw2KH92EpyioIV0T/eTzNQbFYJBlvxqpCgymumL+mxluAI4BvWmmO
         avd/nLjOWZh0AyrxXb9pvmdjsUizqAhdj0O04A4P3NpZDTOnMWLYAo2fqHiLP7vqGyCk
         Tvbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rGxsOML45WI9SaJFmPmMPdVFz9lkK8hsoiCkoDAAJ4A=;
        b=UOmZlzJL/FSZGWHtKGFZoEhg3n3GFf4K0DGKwxipYWATpxbg6UVb/nEEg0jJ/h2QDE
         Fo+6MYCooDYXyKIu7knHSAq1NCqD61yuuhU7tmrEDUTJb5N1mxGXPlcJ1oEmBIamxfJH
         AHsKjY43uEk164haavP1twJuJpJThFKiJvNEG+4wykJ9gSr1dmNxKuEbBWHFiclcCMS3
         8g4bSsOsdQLbLrBc9g13Oay+SlwnmCoQLwGvv1NNUTLRuYn/rMmt2+G0Be9KKEoLykTA
         poMi8NDH3/MMQXsgutqR4AkNFOlZ9lsTVZ18bPQ3CeTP1wcLhMDTXpBibrgFzpQbYc7n
         zqfQ==
X-Gm-Message-State: AOAM533L+a/GvVQ679+PRpabf7WUuz06jLMKIFrQoU3MXUpW6jZtesns
        kdPPOnkCVDKSnQtMNBhtCgtYYNySMiAbTzqxqehCgThIVg==
X-Google-Smtp-Source: ABdhPJxrmU/hZhXrcyFFdBrXBfYSRMDPf2lZNoo6H2mPUghroGcG6NZEwdTrEkhFeAOdOdPk81W6tw89AQmOTUqv1qo=
X-Received: by 2002:a05:6a00:2449:b0:43c:4a5e:55a6 with SMTP id
 d9-20020a056a00244900b0043c4a5e55a6mr25085771pfj.43.1632143579826; Mon, 20
 Sep 2021 06:12:59 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 20 Sep 2021 21:13:07 +0800
Message-ID: <CACkBjsZB8iYMX9Gp7yorf09PFnTUFw267ULsbRMy_NZcJckYKw@mail.gmail.com>
Subject: WARNING in __queue_work
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tj@kernel.org, jiangshanlai@gmail.com
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
https://drive.google.com/file/d/10dFvcbiBLWmCS05daXKnBH-ZEa8M7aI9/view?usp=sharing
kernel config: https://drive.google.com/file/d/1HKZtF_s3l6PL3OoQbNq_ei9CdBus-Tz0/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

Bluetooth: hci1: command 0x040f tx timeout
------------[ cut here ]------------
WARNING: CPU: 2 PID: 10555 at kernel/workqueue.c:1440
__queue_work+0x437/0x8d0 kernel/workqueue.c:1440
Modules linked in:
CPU: 2 PID: 10555 Comm: kworker/2:7 Not tainted 5.15.0-rc1+ #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events hci_cmd_timeout
RIP: 0010:__queue_work+0x437/0x8d0 kernel/workqueue.c:1440
Code: 11 00 48 89 df e8 09 a7 00 00 48 85 c0 48 89 c3 74 13 e8 ec c7
11 00 48 8b 43 20 4c 3b 70 08 0f 84 22 fc ff ff e8 d9 c7 11 00 <0f> 0b
e9 30 fe ff ff e8 cd c7 11 00 65 ff 05 a6 a6 db 7e 48 8b 05
RSP: 0018:ffffc90000b93dd0 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff88813db5af60 RCX: 0000000000000000
RDX: ffff88800d752240 RSI: ffffffff8125c947 RDI: ffff88800d752240
RBP: ffffc90000b93e10 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90000b93d18 R11: 0000000000000002 R12: ffff888111f8ab30
R13: 0000000000000008 R14: ffff88810c7fb000 R15: 0000000000000008
FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f5a4c974a8 CR3: 0000000046d36000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 queue_work_on+0x97/0xb0 kernel/workqueue.c:1546
 process_one_work+0x359/0x850 kernel/workqueue.c:2297
 worker_thread+0x41/0x4d0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
