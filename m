Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19FAB3DCA8F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhHAHio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:38:44 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:60480 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhHAHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:38:39 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id E65D9F409D0; Sun,  1 Aug 2021 09:38:30 +0200 (CEST)
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
Subject: [PATCH v4 3/5] powerpc: wii.dts: Reduce the size of the control area
Date:   Sun,  1 Aug 2021 09:38:20 +0200
Message-Id: <20210801073822.12452-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210801073822.12452-1-linkmauve@linkmauve.fr>
References: <20210701225743.14631-1-linkmauve@linkmauve.fr>
 <20210801073822.12452-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is wrong, but needed in order to avoid overlapping ranges with the
OTP area added in the next commit.  A refactor of this part of the
device tree is needed: according to Wiibrew[1], this area starts at
0x0d800000 and spans 0x400 bytes (that is, 0x100 32-bit registers),
encompassing PIC and GPIO registers, amongst the ones already exposed in
this device tree, which should become children of the control@d800000
node.

[1] https://wiibrew.org/wiki/Hardware/Hollywood_Registers

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index aaa381da1906..c5fb54f8cc02 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -216,7 +216,13 @@ AVE: audio-video-encoder@70 {
 
 		control@d800100 {
 			compatible = "nintendo,hollywood-control";
-			reg = <0x0d800100 0x300>;
+			/*
+			 * Both the address and length are wrong, according to
+			 * Wiibrew this should be <0x0d800000 0x400>, but it
+			 * requires refactoring the PIC1 and GPIO nodes before
+			 * changing that.
+			 */
+			reg = <0x0d800100 0xa0>;
 		};
 
 		disk@d806000 {
-- 
2.32.0

