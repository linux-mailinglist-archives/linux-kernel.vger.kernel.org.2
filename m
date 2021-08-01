Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206533DCA93
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhHAHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:38:49 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:60480 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhHAHim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:38:42 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id A89E9F409D1; Sun,  1 Aug 2021 09:38:32 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] powerpc: wii.dts: Expose the OTP on this platform
Date:   Sun,  1 Aug 2021 09:38:21 +0200
Message-Id: <20210801073822.12452-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801073822.12452-1-linkmauve@linkmauve.fr>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by the newly-added nintendo-otp nvmem module.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index c5fb54f8cc02..e9c945b123c6 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -219,12 +219,17 @@ control@d800100 {
 			/*
 			 * Both the address and length are wrong, according to
 			 * Wiibrew this should be <0x0d800000 0x400>, but it
-			 * requires refactoring the PIC1 and GPIO nodes before
-			 * changing that.
+			 * requires refactoring the PIC1, GPIO and OTP nodes
+			 * before changing that.
 			 */
 			reg = <0x0d800100 0xa0>;
 		};
 
+		otp@d8001ec {
+			compatible = "nintendo,hollywood-otp";
+			reg = <0x0d8001ec 0x8>;
+		};
+
 		disk@d806000 {
 			compatible = "nintendo,hollywood-di";
 			reg = <0x0d806000 0x40>;
-- 
2.32.0

