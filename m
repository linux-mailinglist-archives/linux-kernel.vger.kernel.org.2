Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FA53168D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhBJOMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:12:52 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34044 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231878AbhBJOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:11:21 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11AEARKB031428;
        Wed, 10 Feb 2021 06:10:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=H0+Bw27E1hsV4tlWBk+MNu+1qDVP41OkePVjzvrQDc4=;
 b=DU6Vpmc5YfZi86/TwdK0MeUnaXVsHLI96yvcM+WD7HR1tERZIblvyEQsNP62kQpbcuHS
 Z+uR6yS1mnAdYe11nO5c3jQDwHDGNYvNEElMWFEWWw8VkeXeXJK3+6N7wJBNKa9DqMwA
 UKZ3v6p536KBrxgCk2iTPJlV2HJB+tJNWxyCZQp/tfVMMVpO+Ny8x2FsYdtjjnUfsH9A
 RvVf57H4YB2nbS83lkXyvOKs/OAndy2s+X2AjomElzAq3uZ+tAE1rnnkeUdVTRUHm0lb
 8nll9wFePPPTJ4yXpHJBpYNSeZXH69uScM+r+lws8oWicGuC6599z2rPR18b5l3clXRl Ng== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 36hugqbs0f-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:10:32 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 10 Feb
 2021 06:10:27 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 10 Feb 2021 06:10:27 -0800
Received: from octopus.marvell.com (octopus.marvell.com [10.5.24.3])
        by maili.marvell.com (Postfix) with ESMTP id 9FD2F3F704E;
        Wed, 10 Feb 2021 06:10:24 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <sebastian.hesselbarth@gmail.com>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <stefanc@marvell.com>, <bpeled@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v2 09/12] dts: a3700: enable dma coherence
Date:   Wed, 10 Feb 2021 16:09:46 +0200
Message-ID: <20210210140949.32515-10-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210210140949.32515-1-kostap@marvell.com>
References: <20210210140949.32515-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_05:2021-02-10,2021-02-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Chulski <stefanc@marvell.com>

Enable dma coherence for PCIe and memory-mapped devices
on A3700 platform

Signed-off-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index d5b6c0a1c54a..c01351172875 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -71,6 +71,7 @@
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
+		dma-coherent;
 		ranges;
 
 		internal-regs@d0000000 {
@@ -486,6 +487,7 @@
 			#interrupt-cells = <1>;
 			msi-parent = <&pcie0>;
 			msi-controller;
+			dma-coherent;
 			ranges = <0x82000000 0 0xe8000000   0 0xe8000000 0 0x1000000 /* Port 0 MEM */
 				  0x81000000 0 0xe9000000   0 0xe9000000 0 0x10000>; /* Port 0 IO*/
 			interrupt-map-mask = <0 0 0 7>;
-- 
2.17.1

