Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566A242A9E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 18:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhJLQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 12:49:32 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33120
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231565AbhJLQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 12:49:30 -0400
Received: from workstation5.fritz.box (ip-88-152-144-157.hsi03.unitymediagroup.de [88.152.144.157])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A750B3FFF7;
        Tue, 12 Oct 2021 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634057248;
        bh=/P/G2tQaU+J00Hwl+lWdgaHlFqUMRDqts18zTv/hnao=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=wRhM2CKkIllKP94EtAEooVNUqc5wog9LqlVI2CGihLTtA50LpyDCXNHfJssriK+du
         o1zJTnuW1l5BAukX2YDsqDK0lRfej7OsyZJLq4NS1VDBsYZNThfFeB+uScWZVhSt4K
         qbz0aBwZrAtr/iUerZdoBEU+xeMdy52gH1M7bpklChMoIYAsZSmAtJ0UJ8FjpRb9Af
         UzJDs/yquAfxqo3hJvGZxwvYziWFlXb32mzpuuML5ViX0ZohjaST5Tw+/tOtRwclUa
         2FQDzTk4rlZtU4eVOLQlnP+5Y0DshVwQudvTFCBYCgW4MKE4ixrdB7b5pJViUDDaeP
         GGetpzaLavgOQ==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Anup Patel <anup.patel@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: defconfig: enable DRM_NOUVEAU
Date:   Tue, 12 Oct 2021 18:46:58 +0200
Message-Id: <20211012164658.81894-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both RADEON and NOUVEAU graphics cards are supported on RISC-V. Enabling
the one and not the other does not make sense.

As typically at most one of RADEON, NOUVEAU, or VIRTIO GPU support will be
needed DRM drivers should be compiled as modules.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/configs/defconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 4ebc80315f01..c252fd5706d2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -72,9 +72,10 @@ CONFIG_GPIOLIB=y
 CONFIG_GPIO_SIFIVE=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_POWER_RESET=y
-CONFIG_DRM=y
-CONFIG_DRM_RADEON=y
-CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_DRM=m
+CONFIG_DRM_RADEON=m
+CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-- 
2.32.0

