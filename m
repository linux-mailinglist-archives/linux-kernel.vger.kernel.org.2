Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 406AD33B0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCOLPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhCOLPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:15:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 04:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wYk19foR0NdhgMjWstK6udYO/Zyawyo/Qzqsxoi3rt4=; b=fzumvFOSL8Taz/qc1bDNhAW40H
        O+nRKudLxtQDciVnnuZAs5TfWUKsg1m8CzjtBvztzeqXJbHTFoEbkoBXd2Ik3J/qAcJxP6O/gpt8U
        6B9hZGLBCvQ0z7HEKKE0vGWoZtqnG85M3uUD7enjz2j9c/0ZqsTTxQW6tola/seuxLeuzAwjhPRbl
        8FVa5jj9aSBfh1aw2GqKtgsAK9tOsUo4KFGkGmCSzqWgbyKQPrmQm6XCeHZx37AEocFluUZL2oUcl
        WueMhIJoHmXkR5O/Qf1k2NB710/IdRYhb93xJrw9/cLWua6OR7yOblnvaCE61zwihQE1dlsoRaIfN
        l3oU/2+Q==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLlBf-00FdvK-BP; Mon, 15 Mar 2021 11:15:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lLlBe-001qao-So; Mon, 15 Mar 2021 11:15:02 +0000
From:   David Woodhouse <dwmw2@infradead.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, matejm98mthw@gmail.com,
        Steven Barrett <steven@liquorix.net>, Mav <basic89@gmail.com>
Subject: [PATCH] iommu/amd: Don't initialise remapping irqdomain if IOMMU is disabled
Date:   Mon, 15 Mar 2021 11:15:02 +0000
Message-Id: <20210315111502.440451-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw@amazon.co.uk>

When the IOMMU is disabled, the driver still enumerates and initialises
the hardware in order to turn it off. Because IRQ remapping setup is
done early, the irqdomain is set up opportunistically.

In commit b34f10c2dc59 ("iommu/amd: Stop irq_remapping_select() matching
when remapping is disabled") I already make the irq_remapping_select()
function check the amd_iommu_irq_setup flag because that might get
cleared only after the irqdomain setup is done, when the IVRS is parsed.

However, in the case where 'amd_iommu=off' is passed on the command line,
the IRQ remapping setup isn't done but the amd_iommu_irq_setup flag is
still set by the early IRQ remap init code. Stop it doing that, by
bailing out of amd_iommu_prepare() early when it's disabled.

This avoids the crash in irq_remapping_select() as it dereferences the
NULL amd_iommu_rlookup_table[]:

[    0.243659] Switched APIC routing to physical x2apic.
[    0.262206] BUG: kernel NULL pointer dereference, address: 0000000000000500
[    0.262927] #PF: supervisor read access in kernel mode
[    0.263390] #PF: error_code(0x0000) - not-present page
[    0.263844] PGD 0 P4D 0
[    0.264135] Oops: 0000 [#1] SMP PTI
[    0.264460] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc3 #831
[    0.265069] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1.fc33 04/01/2014
[    0.265825] RIP: 0010:irq_remapping_select+0x57/0xb0
[    0.266327] Code: 4b 0c 48 3d 30 e0 a7 9e 75 0d eb 35 48 8b 00 48 3d 30 e0 a7 9e 74 2a 0f b6 50 10 39 d1 75 ed 0f b7 40 12 48 8b 15 69 e3 d2 01 <48> 8b 14 c2 48 85 d2 74 0e b8 01 00 00 00 48 3b aa 90 04 00 00 74
[    0.268412] RSP: 0000:ffffffff9e803db0 EFLAGS: 00010246
[    0.268919] RAX: 00000000000000a0 RBX: ffffffff9e803df8 RCX: 0000000000000000
[    0.269550] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff98120112fe79
[    0.270245] RBP: ffff9812011c8218 R08: 0000000000000001 R09: 000000000000000a
[    0.270922] R10: 000000000000000a R11: f000000000000000 R12: ffff9812011c8218
[    0.271549] R13: ffff98120181ed88 R14: 0000000000000000 R15: 0000000000000000
[    0.272221] FS:  0000000000000000(0000) GS:ffff98127dc00000(0000) knlGS:0000000000000000
[    0.272997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.273508] CR2: 0000000000000500 CR3: 0000000030810000 CR4: 00000000000006b0
[    0.274178] Call Trace:
[    0.274416]  irq_find_matching_fwspec+0x41/0xc0
[    0.274812]  mp_irqdomain_create+0x65/0x150
[    0.275251]  setup_IO_APIC+0x70/0x811

Fixes: a1a785b57242 ("iommu/amd: Implement select() method on remapping irqdomain")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212017
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 drivers/iommu/amd/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9126efcbaf2c..07edd837b076 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2998,6 +2998,9 @@ int __init amd_iommu_prepare(void)
 {
 	int ret;
 
+	if (amd_iommu_disabled)
+		return -ENODEV;
+
 	amd_iommu_irq_remap = true;
 
 	ret = iommu_go_to_state(IOMMU_ACPI_FINISHED);
-- 
2.29.2

