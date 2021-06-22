Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6A3AFDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFVHOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFVHOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:14:39 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37063C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:24 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so4507537pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 00:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3/sIHwJYhbBDupt7I2q95bUQGJfnSsX7iETKC6YWdHo=;
        b=mbqVA/6UEPdHcJQb/cYKOJReXkiIcbjEHFD6LxnuIH2cEA2H0SIqDgtJb6oJ5dWwGU
         XafWPaHDos4sPe02Gx/w7+IeIRd+wVJAqJONeXynuEgF40xVUzVS+zAtm48ZfkvwLHf3
         pEpJfhrAMBfl+7BtE1oBcTpbpDe+pWL0zgCv/HCWfJ8DNzU8Lc+Re8Vt3VA3KscfOC3Y
         gPsBpDO+MuyAVItVR6/ZKXhbfQmFoch6ipb/3nh1xE/EH4lf++5/XF5T/v5N+HRFZyMt
         4kMaNKGyH11HGPtsd2HRm6LQKg9LdAc0ltLsEm+mVMTlEu3qz6t+KW27ygMQxdk1d8Ws
         e7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3/sIHwJYhbBDupt7I2q95bUQGJfnSsX7iETKC6YWdHo=;
        b=daOxoMBgGwOIO+c6CNxZh8bGDismrUScUtpwCEroJHXoAwDQgsuGjhAhcfi6y2NCo+
         5PXzh5R9x3UIHMz1IRQTrb6wIgUIN5wtf5wMvqkHa8cNBW4NwvWQvk82qCwYIttyaImb
         pHeI0U7Q88dITmu0jC0qQwnuX1IK9xoNeZ2kk1HP27LeEa3wJx8SPbovkF8trGQ4rvAP
         t9/DGTIE8RHS1wBaMf0lTZGu4AxwBSwmSC+3AoEmVTDgjxwFjyxqqPDqRgdJnRVmKDps
         xG8BsYAkU/6TsSb3vfhZ6vZRcXKHC4RcvRQPvRD4wYiSRkR59sCLEVEWQRMJOy4izzfk
         tI7w==
X-Gm-Message-State: AOAM530OsxAzlq59klsknHN0ILokuNikLubbQO78+OETbFMP9Ki5YOiZ
        RjGoYH8p+MPo5DLqq8N9PA==
X-Google-Smtp-Source: ABdhPJzEmM/IKDRy37Jj2wZu7z2dCPSpDHR8zs/JfgT0d7qskIHfydT3u99OCS2kDoPRbZ5aEVw8cA==
X-Received: by 2002:a05:6a00:998:b029:305:a6bf:f8eb with SMTP id u24-20020a056a000998b0290305a6bff8ebmr737129pfg.60.1624345943746;
        Tue, 22 Jun 2021 00:12:23 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id n8sm1373798pjo.1.2021.06.22.00.12.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jun 2021 00:12:22 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] pcmcia: i82092: fix a null pointer dereference bug
Date:   Tue, 22 Jun 2021 07:11:31 +0000
Message-Id: <1624345891-4215-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the driver loading process, the 'dev' field was not assigned, but
the 'dev' field was referenced in the subsequent 'i82092aa_set_mem_map'
function.

This log reveals it:

[    3.928168] BUG: kernel NULL pointer dereference, address: 0000000000000010
[    3.928678] #PF: supervisor read access in kernel mode
[    3.929054] #PF: error_code(0x0000) - not-present page
[    3.929428] PGD 0 P4D 0
[    3.929617] Oops: 0000 [#1] PREEMPT SMP PTI
[    3.929923] CPU: 3 PID: 4409 Comm: pccardd Not tainted 5.13.0-rc7-next-20210621 #1
[    3.930468] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
[    3.931277] RIP: 0010:i82092aa_set_mem_map+0x45/0x2c0
[    3.931649] Code: 28 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 f0 44 8f fd 49 8b 84 24 28 09 00 00 48 8b 53 18 48 8d 75 c0 45 8b 6c 24 f0 <48> 8b 78 10 e8 92 05 2f fe 44 0f b6 33 41 80 fe 04 0f 87 16 02 00
[    3.932973] RSP: 0000:ffffc9000a6bfdb8 EFLAGS: 00010293
[    3.933351] RAX: 0000000000000000 RBX: ffffc9000a6bfe30 RCX: 0000000000000000
[    3.933859] RDX: ffffc9000a6bfe50 RSI: ffffc9000a6bfdc8 RDI: ffffffff88457bb0
[    3.934370] RBP: ffffc9000a6bfe08 R08: 0000000000000001 R09: 0000000000000001
[    3.934876] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff88457bb0
[    3.935385] R13: 0000000000000000 R14: ffffffff839f7b80 R15: ffffffff88457bb0
[    3.935891] FS:  0000000000000000(0000) GS:ffff88817aa00000(0000) knlGS:0000000000000000
[    3.936467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.936877] CR2: 0000000000000010 CR3: 0000000006c32000 CR4: 00000000000006e0
[    3.937391] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.937896] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.938082] Call Trace:
[    3.938082]  ? pcmcia_parse_uevents+0xa0/0xa0
[    3.938082]  i82092aa_init+0xb8/0xf0
[    3.938082]  pccardd+0x64/0x590
[    3.938082]  ? __kthread_parkme+0xba/0xe0
[    3.938082]  ? pcmcia_parse_uevents+0xa0/0xa0
[    3.938082]  kthread+0x19a/0x1e0
[    3.938082]  ? set_kthread_struct+0x60/0x60
[    3.938082]  ret_from_fork+0x1f/0x30
[    3.938082] Modules linked in:
[    3.938082] Dumping ftrace buffer:
[    3.938082]    (ftrace buffer empty)
[    3.938082] CR2: 0000000000000010
[    3.938082] ---[ end trace f4f9ca1497f3c8b2 ]---
[    3.938082] RIP: 0010:i82092aa_set_mem_map+0x45/0x2c0
[    3.938082] Code: 28 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 f0 44 8f fd 49 8b 84 24 28 09 00 00 48 8b 53 18 48 8d 75 c0 45 8b 6c 24 f0 <48> 8b 78 10 e8 92 05 2f fe 44 0f b6 33 41 80 fe 04 0f 87 16 02 00
[    3.938082] RSP: 0000:ffffc9000a6bfdb8 EFLAGS: 00010293
[    3.938082] RAX: 0000000000000000 RBX: ffffc9000a6bfe30 RCX: 0000000000000000
[    3.938082] RDX: ffffc9000a6bfe50 RSI: ffffc9000a6bfdc8 RDI: ffffffff88457bb0
[    3.938082] RBP: ffffc9000a6bfe08 R08: 0000000000000001 R09: 0000000000000001
[    3.938082] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffff88457bb0
[    3.938082] R13: 0000000000000000 R14: ffffffff839f7b80 R15: ffffffff88457bb0
[    3.938082] FS:  0000000000000000(0000) GS:ffff88817aa00000(0000) knlGS:0000000000000000
    3.938082] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.938082] CR2: 0000000000000010 CR3: 0000000006c32000 CR4: 00000000000006e0
[    3.938082] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    3.938082] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    3.938082] Kernel panic - not syncing: Fatal exception
[    3.938082] Dumping ftrace buffer:
[    3.938082]    (ftrace buffer empty)
[    3.938082] Kernel Offset: disabled
[    3.938082] Rebooting in 1 seconds..

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/pcmcia/i82092.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 85887d885b5f..192c9049d654 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -112,6 +112,7 @@ static int i82092aa_pci_probe(struct pci_dev *dev,
 	for (i = 0; i < socket_count; i++) {
 		sockets[i].card_state = 1; /* 1 = present but empty */
 		sockets[i].io_base = pci_resource_start(dev, 0);
+		sockets[i].dev = dev;
 		sockets[i].socket.features |= SS_CAP_PCCARD;
 		sockets[i].socket.map_size = 0x1000;
 		sockets[i].socket.irq_mask = 0;
-- 
2.17.6

