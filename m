Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC50388A28
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbhESJHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:07:06 -0400
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:41214 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbhESJHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:07:00 -0400
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id CB893F4064B; Wed, 19 May 2021 11:05:39 +0200 (CEST)
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
Subject: [PATCH 4/4] powerpc: wii_defconfig: Enable OTP by default
Date:   Wed, 19 May 2021 11:05:25 +0200
Message-Id: <20210519090525.1788-5-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519090525.1788-1-linkmauve@linkmauve.fr>
References: <20210519090525.1788-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This selects the nintendo-otp module when building for this platform, if
CONFIG_NVMEM is also selected.

Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
---
 arch/powerpc/configs/wii_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 379c171f3ddd..a0c45bf2bfb1 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -99,6 +99,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_PANIC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
+CONFIG_NVMEM_NINTENDO_OTP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_FUSE_FS=m
-- 
2.31.1

