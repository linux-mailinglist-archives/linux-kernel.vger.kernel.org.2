Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014803FD7E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 12:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236858AbhIAKmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 06:42:54 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:47587 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236042AbhIAKmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 06:42:53 -0400
X-QQ-mid: bizesmtp50t1630492892tewf9ssh
Received: from localhost.localdomain (unknown [114.91.2.95])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 01 Sep 2021 18:41:31 +0800 (CST)
X-QQ-SSF: 0140000000700070R000B00A0000000
X-QQ-FEAT: Q1yiNCT1ez4fbPXBeC6Bm3VQ2PP3bbKDosNG1uYhLFxyMZ/nTsMXs4fpEGtAZ
        uvxMwWW3pO6sMCAOUwGV087M4b3x93+/oQwZaovu5FphFhD1OwetBo0WYwT1jvxx89aZ839
        v5VHm4mhyySW5+dCsOqiGZV7z5EiAawtN15QubM9iAMTm5F6r2BG5dDLTWTFMEbPGolrPp/
        n2sJk9R+L46K+h4qDiw7V3f3vrXC/sDJm5vPrlJzGcXkX+bGEDvwiZRFO2EinQe8CUKArnc
        UmyxyZ1kc5PMKZQnr/HExNSb7pV/WyBzPL3oG8yTpjYSy1srBHvnB9u9j5ucBmg1GX2w==
X-QQ-GoodBg: 2
From:   xiaoming <2014500726@smail.xtu.edu.cn>
To:     Gabriel Somlo <somlo@cmu.edu>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org,
        xiaoming <2014500726@smail.xtu.edu.cn>
Subject: [PATCH] [PATCH] drivers/firmware/qemu_fw_cfg: add RISCV support
Date:   Wed,  1 Sep 2021 18:41:30 +0800
Message-Id: <20210901104130.10185-1-2014500726@smail.xtu.edu.cn>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:smail.xtu.edu.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the latest release of qemu (qemu 6.0.0 or higher) riscv virt already supports fw_cfg, but
drivers/firmware/qemu_fw_cfg not support.

Signed-off-by: xiaoming <2014500726@smail.xtu.edu.cn>
---
 drivers/firmware/Kconfig       | 2 +-
 drivers/firmware/qemu_fw_cfg.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 1db738d5b..4eb8d8a3a 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -186,7 +186,7 @@ config RASPBERRYPI_FIRMWARE
 
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
-	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
+	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86 || RISCV)
 	depends on HAS_IOPORT_MAP
 	default n
 	help
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 172c751a4..36b5b2612 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -225,6 +225,10 @@ static void fw_cfg_io_cleanup(void)
 #  define FW_CFG_CTRL_OFF 0x00
 #  define FW_CFG_DATA_OFF 0x01
 #  define FW_CFG_DMA_OFF 0x04
+# elif defined(CONFIG_RISCV)
+#  define FW_CFG_CTRL_OFF 0x08
+#  define FW_CFG_DATA_OFF 0x00
+#  define FW_CFG_DMA_OFF 0x10
 # else
 #  error "QEMU FW_CFG not available on this architecture!"
 # endif
-- 
2.17.1



