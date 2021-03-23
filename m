Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1B634625F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 16:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhCWPIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 11:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbhCWPIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 11:08:09 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A502C061763;
        Tue, 23 Mar 2021 08:08:06 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B80722224F;
        Tue, 23 Mar 2021 16:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616512085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hgZoX/1A4E+4j/UeOJncFBXvG6wW18dOBxTkC+qCAK8=;
        b=kRNDnN2GJPtLytk4Q+xguFH0kdlut8usj4ChulCUj4tinZ38D0CoBaD0/Zndci39iMRvEu
        3HX/nLZfvEqH0mxIoYnuFuHfoYsR6nEmtnYjrxjQT3rEILPxYJf3YBplCKYEcfNDHmmkNs
        I9Azsohlksjni85HlHrvT3A3Ew0MGkE=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: dts: fsl-ls1028a-kontron-sl28: add rtc0 alias
Date:   Tue, 23 Mar 2021 16:07:57 +0100
Message-Id: <20210323150757.3771-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210323150757.3771-1-michael@walle.cc>
References: <20210323150757.3771-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For completeness, add the rtc0 alias.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 09f0b11d5705..79a1224035c4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -25,6 +25,7 @@
 		spi1 = &dspi2;
 		mmc0 = &esdhc1;
 		mmc1 = &esdhc;
+		rtc0 = &rtc;
 		rtc1 = &ftm_alarm0;
 	};
 
@@ -202,7 +203,7 @@
 &i2c0 {
 	status = "okay";
 
-	rtc@32 {
+	rtc: rtc@32 {
 		compatible = "microcrystal,rv8803";
 		reg = <0x32>;
 	};
-- 
2.20.1

