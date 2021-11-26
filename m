Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1389D45E3BB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbhKZAiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:38:52 -0500
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:34098
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356942AbhKZAgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:36:51 -0500
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A1FAD3F213;
        Fri, 26 Nov 2021 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1637886816;
        bh=pZyOpAOsBNBKC0LJfUWhxgl1vnefr2uNGuiT9FUXFR0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qh0pvH15s2U358i9GjHKYVZiqYQYKWGDApHHx/yQgzTlcdvdlGHJ6s8a6n9caFa7X
         ZOK09d/NWuPNfgWHUsDeov7G1TwrmvxAHLbNgmFH5KLzEPv4RnmueJQsTIwajg+Rkw
         ctUulrZSbNHWA0MP7RP79eoPf/rC/Wd8+hLl4KZsBfjm7JSCxPOz8aJfUYsg2YSf4i
         ZobcJ+327f3AHzdLeEnmp+j3CHsCanzOzGI6cgvVj5CXobVCSXS2w6m3djYxnZcTFK
         wiszkZE/lbbPP2doqhcWnlN3tZ58lyBFhU1AMOncOkhsyXqT7oO7l3eKtr3LZi5sSQ
         KpQpomVlvAEZQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] misc: rtsx: Avoid mangling IRQ during runtime PM
Date:   Fri, 26 Nov 2021 08:32:44 +0800
Message-Id: <20211126003246.1068770-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM"), when the
rtsx controller is runtime suspended, bring CPUs offline and back online, the
runtime resume of the controller will fail:

[   47.319391] smpboot: CPU 1 is now offline
[   47.414140] x86: Booting SMP configuration:
[   47.414147] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   47.571334] smpboot: CPU 2 is now offline
[   47.686055] smpboot: Booting Node 0 Processor 2 APIC 0x4
[   47.808174] smpboot: CPU 3 is now offline
[   47.878146] smpboot: Booting Node 0 Processor 3 APIC 0x6
[   48.003679] smpboot: CPU 4 is now offline
[   48.086187] smpboot: Booting Node 0 Processor 4 APIC 0x1
[   48.239627] smpboot: CPU 5 is now offline
[   48.326059] smpboot: Booting Node 0 Processor 5 APIC 0x3
[   48.472193] smpboot: CPU 6 is now offline
[   48.574181] smpboot: Booting Node 0 Processor 6 APIC 0x5
[   48.743375] smpboot: CPU 7 is now offline
[   48.838047] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   48.965447] __common_interrupt: 1.35 No irq handler for vector
[   51.174065] mmc0: error -110 doing runtime resume
[   54.978088] I/O error, dev mmcblk0, sector 21479 op 0x1:(WRITE) flags 0x0 phys_seg 11 prio class 0
[   54.978108] Buffer I/O error on dev mmcblk0p1, logical block 19431, lost async page write
[   54.978129] Buffer I/O error on dev mmcblk0p1, logical block 19432, lost async page write
[   54.978134] Buffer I/O error on dev mmcblk0p1, logical block 19433, lost async page write
[   54.978137] Buffer I/O error on dev mmcblk0p1, logical block 19434, lost async page write
[   54.978141] Buffer I/O error on dev mmcblk0p1, logical block 19435, lost async page write
[   54.978145] Buffer I/O error on dev mmcblk0p1, logical block 19436, lost async page write
[   54.978148] Buffer I/O error on dev mmcblk0p1, logical block 19437, lost async page write
[   54.978152] Buffer I/O error on dev mmcblk0p1, logical block 19438, lost async page write
[   54.978155] Buffer I/O error on dev mmcblk0p1, logical block 19439, lost async page write
[   54.978160] Buffer I/O error on dev mmcblk0p1, logical block 19440, lost async page write
[   54.978244] mmc0: card aaaa removed
[   54.978452] FAT-fs (mmcblk0p1): FAT read failed (blocknr 4257)

There's interrupt immediately raised on rtsx_pci_write_register() in
runtime resume routine, but the IRQ handler hasn't registered yet.

So we can either move rtsx_pci_write_register() after rtsx_pci_acquire_irq(),
or just stop mangling IRQ on runtime PM. Choose the latter to save some
CPU cycles.

BugLink: https://bugs.launchpad.net/bugs/1951784
Fixes: 5b4258f6721f ("misc: rtsx: rts5249 support runtime PM")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 8c72eb590f79d..6ac509c1821c9 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1803,8 +1803,6 @@ static int rtsx_pci_runtime_suspend(struct device *device)
 	mutex_lock(&pcr->pcr_mutex);
 	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
 
-	free_irq(pcr->irq, (void *)pcr);
-
 	mutex_unlock(&pcr->pcr_mutex);
 
 	pcr->is_runtime_suspended = true;
@@ -1825,8 +1823,6 @@ static int rtsx_pci_runtime_resume(struct device *device)
 	mutex_lock(&pcr->pcr_mutex);
 
 	rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
-	rtsx_pci_acquire_irq(pcr);
-	synchronize_irq(pcr->irq);
 
 	if (pcr->ops->fetch_vendor_settings)
 		pcr->ops->fetch_vendor_settings(pcr);
-- 
2.32.0

