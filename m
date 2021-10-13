Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2F142CD48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhJMWHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhJMWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:07:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF8C061570;
        Wed, 13 Oct 2021 15:05:37 -0700 (PDT)
Received: from crub.agik.hopto.org (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id DDEC28360A;
        Thu, 14 Oct 2021 00:05:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634162734;
        bh=lCCP2kpnABG9trPHuTzlDpEXA/5iYV/q/jG2UOBG/kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9XhhAlC2zq3AKBzSg/3aJbk3AgCRVgfGPkpFMS77YeRWVZbHp63A9Gu2/8KXdliX
         +CjzisKvVEAm+xBxc7jq/Sfm0l7C8Ezttu04HGdpPcHNRIBKkBxPu6k6U8UgizMCqs
         yVG1Lqn/YGKpIOsuZFG93XfCH6B3pNQGxELTuGnCOzpHB0LKJOpa3evT1XfigE12WH
         KMw/B4YMYhC21olNWtrxblxHlTEI/3RVM8NXXzTB9rk/SyTDOH/Kpau9pgEPjpCVvN
         R2ViTyjm87LLT4d+PZRPoRHU61c8wCULvjPlXASO7OamqH+t8tTsCfB/BEQHcO0TF+
         8s9ibS65PhEng==
From:   Anatolij Gustschin <agust@denx.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/4] powerpc/5200: dts: add missing pci ranges
Date:   Thu, 14 Oct 2021 00:05:29 +0200
Message-Id: <20211013220532.24759-2-agust@denx.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013220532.24759-1-agust@denx.de>
References: <20211013220532.24759-1-agust@denx.de>
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ranges property to fix build warnings:
Warning (pci_bridge): /pci@f0000d00: missing ranges for PCI bridge (or not a bridge)

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/mpc5200b.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/mpc5200b.dtsi b/arch/powerpc/boot/dts/mpc5200b.dtsi
index 648fe31795f4..8c645d2bc455 100644
--- a/arch/powerpc/boot/dts/mpc5200b.dtsi
+++ b/arch/powerpc/boot/dts/mpc5200b.dtsi
@@ -276,7 +276,9 @@
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		// ranges = need to add
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000>,
+			 <0x02000000 0 0x90000000 0x90000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 
 	localbus: localbus {
-- 
2.17.1

