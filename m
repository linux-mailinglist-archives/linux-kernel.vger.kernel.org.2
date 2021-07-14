Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199A03C83C8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhGNLZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGNLZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:25:29 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EACC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:22:37 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:39cc:190a:2775:cfe7])
        by laurent.telenet-ops.be with bizsmtp
        id UzNa2500A1ccfby01zNa2P; Wed, 14 Jul 2021 13:22:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3cyH-0017Wr-VG; Wed, 14 Jul 2021 13:22:33 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3cyH-00A7kH-Gk; Wed, 14 Jul 2021 13:22:33 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v3] x86: ce4100: Replace "ti,pcf8575" by "nxp,pcf8575"
Date:   Wed, 14 Jul 2021 13:22:32 +0200
Message-Id: <24300cf6ef1d7c5243f379d5a5965c5ece40ad32.1626261651.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI part is equivalent to the NXP part, and its compatible value is
not documented in the DT bindings.

Note that while the Linux driver DT match table does not contain the
compatible value of the TI part, it could still match to this part, as
i2c_device_id-based matching ignores the vendor part of the compatible
value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
v3:
  - Add Reviewed-by,

v2:
  - New.
---
 arch/x86/platform/ce4100/falconfalls.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/ce4100/falconfalls.dts b/arch/x86/platform/ce4100/falconfalls.dts
index 0ac3d43571361112..65fa3d866226ce97 100644
--- a/arch/x86/platform/ce4100/falconfalls.dts
+++ b/arch/x86/platform/ce4100/falconfalls.dts
@@ -249,7 +249,7 @@ i2c@1 {
 
 						gpio@26 {
 							#gpio-cells = <2>;
-							compatible = "ti,pcf8575";
+							compatible = "nxp,pcf8575";
 							reg = <0x26>;
 							gpio-controller;
 						};
@@ -263,7 +263,7 @@ i2c@2 {
 
 						gpio@26 {
 							#gpio-cells = <2>;
-							compatible = "ti,pcf8575";
+							compatible = "nxp,pcf8575";
 							reg = <0x26>;
 							gpio-controller;
 						};
-- 
2.25.1

