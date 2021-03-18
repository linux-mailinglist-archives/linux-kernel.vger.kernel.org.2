Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86711340B99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhCRRTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhCRRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:19:14 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C0C06175F;
        Thu, 18 Mar 2021 10:19:14 -0700 (PDT)
Received: from mwalle01.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:fa59:71ff:fe9b:b851])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8C14D22239;
        Thu, 18 Mar 2021 18:19:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1616087952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBlcjfZUbD5yHqYYKcO3IKUFgPQENmUM+k3k8YFGv6Y=;
        b=VDDG17lQaMaTCAxI/LwelU+ko+3knXkNZoyYGUx+tKSliF6Uh7TDKkOebA5U/2V3AbxgRo
        /6OolT9iw7I+nT/LRJsSHlfSbyuUzOnjDuNzx2nw+aR0uJ24t9LX/bwtVMJrTD0Sdj3f7F
        x+Q76J+qivItudJigEJZb8kVjl3m3SI=
From:   Michael Walle <michael@walle.cc>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 2/2] arm64: dts: fsl-ls1028a-kontron-sl28: combine unused partitions
Date:   Thu, 18 Mar 2021 18:18:56 +0100
Message-Id: <20210318171856.3487-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318171856.3487-1-michael@walle.cc>
References: <20210318171856.3487-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The failsafe partitions for the DP firmware and for AT-F are unused. If
AT-F will ever be supported in the failsafe mode, then it will be a FIT
image. Thus fold the unused partitions into the failsafe bootloader one
to have enough storage if the bootloader image will grow.

While at it, remove the reserved partition. It served no purpose other
than having no hole in the map.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../freescale/fsl-ls1028a-kontron-sl28.dts    | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
index 7e3a33eb2045..311e3aae0a3c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
@@ -135,29 +135,11 @@
 			};
 
 			partition@10000 {
-				reg = <0x010000 0x0f0000>;
+				reg = <0x010000 0x1d0000>;
 				label = "failsafe bootloader";
 				read-only;
 			};
 
-			partition@100000 {
-				reg = <0x100000 0x040000>;
-				label = "failsafe DP firmware";
-				read-only;
-			};
-
-			partition@140000 {
-				reg = <0x140000 0x0a0000>;
-				label = "failsafe trusted firmware";
-				read-only;
-			};
-
-			partition@1e0000 {
-				reg = <0x1e0000 0x020000>;
-				label = "reserved";
-				read-only;
-			};
-
 			partition@200000 {
 				reg = <0x200000 0x010000>;
 				label = "configuration store";
-- 
2.20.1

