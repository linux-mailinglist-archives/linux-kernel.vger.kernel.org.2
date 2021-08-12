Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05523EA051
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhHLILG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:11:06 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:37498
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234888AbhHLILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:11:04 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4C3FC3F240;
        Thu, 12 Aug 2021 08:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628755838;
        bh=EVzl+nut4bcCX4uigrUTJ8PnzdgozJvsOugMGWOarh8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RpUcynQ/uhI+tBDZ4s/P0rbesGuim7FygsP8r/TOViYJr8beCNljLnsZey0yg7Dep
         wNBpNn3oza789LS2SZUJKuD3c3FniGaM1UieBIucuXT40bKdhpw9WPEcqnC9Mx+jWS
         q8kMF05AHSHvRBqDzM1C4qgZ23ySxvTtgw5O+0UXgDkNA/UOk9Qw4tHY0aWhvCqJkb
         pjYQn/syH9TVVN7G5EGTtMdlgM/gjb4n/KDl26kSynadyzi/S1IWVDQBPHeclU5zY7
         lTuMvHbMrb2oVBJUskyBQsGtkNb39bRd2EGiX0tmCzKYY6IbjotNsQkxG9Ak/tutre
         kThagDumEYb4w==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] riscv: defconfig: enable BLK_DEV_NVME
Date:   Thu, 12 Aug 2021 10:10:26 +0200
Message-Id: <20210812081027.9242-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMe is a non-volatile storage media attached via PCIe.
As NVMe has much higher throughput than other block devices like
SATA it is a must have for RISC-V. Enable CONFIG_BLK_DEV_NVME.

The HiFive Unmatched is a board providing M.2 slots for NVMe drives.
Enable CONFIG_PCIE_FU740.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
resent on Palmer's request due to non-matching e-mail addresses
https://lore.kernel.org/linux-riscv/20210726112511.78350-1-xypron.glpk@gmx.de/
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be234b11c..393bf3843e5c 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -39,10 +39,12 @@ CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCIE_XILINX=y
+CONFIG_PCIE_FU740=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
+CONFIG_BLK_DEV_NVME=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_SCSI_VIRTIO=y
-- 
2.30.2

