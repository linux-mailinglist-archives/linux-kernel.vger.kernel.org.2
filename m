Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C64A4031A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345293AbhIGXy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231519AbhIGXyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:54:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D7060E53;
        Tue,  7 Sep 2021 23:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631058797;
        bh=jYhS0ZcKTB6Zz+i0/PZUm2K/I0ZZy5tHzLqtXig4PgU=;
        h=From:To:Cc:Subject:Date:From;
        b=DorsFZIFCMiMbcVg1orT7EPiZAGRvLJR+DRnJ9O0jgSs+1ZLc6yxxUFxNaitLvVEs
         gdzSBZ+xnpD3F0RWGAvb4krbRuMOMMu273u7j5zc/Tf5yK3T5NXgsqr4ywinAKjzWv
         3GF5hkhTAS/qjlQhOsoldg76bn2GJzF2aGyBuED4rq7dKYs2wb+i8pi1bLFqHvKQIT
         6kIw3p2o5yDWPlwA0xeF2qll4Vmcup8UIZfbDmgNSu2Vo9OGXySf+9tPmxeSejR9E1
         Ct1ziFH+6eHpEyVARrFF2KCboLK+UxwmRpfEa4EByTiC84zB0rasCU3pbEJbEjyPZs
         YYw+YqqqtR49A==
From:   Vineet Gupta <vgupta@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] riscv: config: enable default defconfig to boot Hifive Unmatched
Date:   Tue,  7 Sep 2021 16:53:15 -0700
Message-Id: <20210907235315.567614-1-vgupta@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need just a few options related to NLS when mouting boot partition
for Unmatched to boot off of mainline kernels.

Signed-off-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 1f2be234b11c..fc9a4e0a9500 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -108,6 +108,8 @@ CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_9P_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_CRYPTO_USER_API_HASH=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_PRINTK_TIME=y
-- 
2.30.2

