Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B843CA38F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhGORIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhGORIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 13:08:41 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F7C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 10:05:47 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bcf3:b2b1:dff6:480b])
        by baptiste.telenet-ops.be with bizsmtp
        id VV5j2500H4sai0K01V5jSP; Thu, 15 Jul 2021 19:05:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m44nv-001QWe-Ee; Thu, 15 Jul 2021 19:05:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m44nu-00BPqa-MB; Thu, 15 Jul 2021 19:05:42 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] riscv: dts: microchip: mpfs-icicle: Fix serial console
Date:   Thu, 15 Jul 2021 19:05:36 +0200
Message-Id: <98082e819007a0f22d7f0f82914b4d84aabdca6d.1626368678.git.geert@linux-m68k.org>
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
---
 .../boot/dts/microchip/microchip-mpfs-icicle-kit.dts     | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index ec79944065c98ef2..d75ea11ed043c1f0 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -14,8 +14,15 @@ / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
 	compatible = "microchip,mpfs-icicle-kit";
 
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+	};
+
 	chosen {
-		stdout-path = &serial0;
+		stdout-path = "serial0:115200n8";
 	};
 
 	cpus {
-- 
2.25.1

