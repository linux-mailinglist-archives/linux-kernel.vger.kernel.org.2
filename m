Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1350639B8B8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFDMIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 08:08:34 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47153 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhFDMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:08:33 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5C79FE000C;
        Fri,  4 Jun 2021 12:06:41 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes] riscv: Fix BUILTIN_DTB for sifive and microchip soc
Date:   Fri,  4 Jun 2021 14:06:39 +0200
Message-Id: <20210604120639.1447869-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix BUILTIN_DTB config which resulted in a dtb that was actually not built
into the Linux image: in the same manner as Canaan soc does, create an object
file from the dtb file that will get linked into the Linux image.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/boot/dts/microchip/Makefile | 1 +
 arch/riscv/boot/dts/sifive/Makefile    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 622b12771fd3..855c1502d912 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
+obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
index 74c47fe9fc22..d90e4eb0ade8 100644
--- a/arch/riscv/boot/dts/sifive/Makefile
+++ b/arch/riscv/boot/dts/sifive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_SOC_SIFIVE) += hifive-unleashed-a00.dtb \
 			    hifive-unmatched-a00.dtb
+obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
-- 
2.30.2

