Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87C388A27
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbhESJHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:07:03 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:41212 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344199AbhESJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:06:59 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 21C44F4064A; Wed, 19 May 2021 11:05:38 +0200 (CEST)
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org
Cc:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Ash Logan <ash@heyquark.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.ne@posteo.net>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] powerpc: wii.dts: Expose the OTP on this platform
Date:   Wed, 19 May 2021 11:05:24 +0200
Message-Id: <20210519090525.1788-4-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519090525.1788-1-linkmauve@linkmauve.fr>
References: <20210519090525.1788-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can be used by the newly-added nintendo-otp nvmem module.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/boot/dts/wii.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index aaa381da1906..7837c4a3f09c 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -219,6 +219,11 @@ control@d800100 {
 			reg = <0x0d800100 0x300>;
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
2.31.1

