Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDE5F3F88A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242583AbhHZNUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241738AbhHZNUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:20:34 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159B6C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 06:19:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:91f7:1ea1:147b:586f])
        by baptiste.telenet-ops.be with bizsmtp
        id mDKh2500934CCxU01DKhqY; Thu, 26 Aug 2021 15:19:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mJFID-0064Nn-1B; Thu, 26 Aug 2021 15:19:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mJFIC-00Daia-59; Thu, 26 Aug 2021 15:19:40 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>
Cc:     Bin Meng <bin.meng@windriver.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2] riscv: dts: microchip: mpfs-icicle: Fix serial console
Date:   Thu, 26 Aug 2021 15:19:39 +0200
Message-Id: <01b0aaeb50a960e36077669449a854e5d4c18a83.1629983839.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nothing is output on the serial console, unless
"console=ttyS0,115200n8" or "earlycon" are appended to the kernel
command line.  Enable automatic console selection using
chosen/stdout-path by adding a proper alias, and configure the expected
serial rate.

While at it, add aliases for the other three serial ports, which are
provided on the same micro-USB connector as the first one.

Fixes: 0fa6107eca4186ad ("RISC-V: Initial DTS for Microchip ICICLE board")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
v2:
  - Add Reviewed-by,
  - Rebase on top of 417166ddec020c4e ("riscv: dts: microchip: Add
    ethernet0 to the aliases node"), as requested by Bin.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index baea7d204639a185..b254c60589a1cc8b 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -16,10 +16,14 @@ / {
 
 	aliases {
 		ethernet0 = &emac1;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
 	};
 
 	chosen {
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	cpus {
-- 
2.25.1

