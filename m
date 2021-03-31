Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A995F350873
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 22:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbhCaUoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 16:44:25 -0400
Received: from st43p00im-ztfb10061701.me.com ([17.58.63.172]:35603 "EHLO
        st43p00im-ztfb10061701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236758AbhCaUny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 16:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1617223432; bh=guqjlHmUoqU2kkK2WPOJUt3nCnKjFTkRBUFYV9GMCpw=;
        h=From:To:Subject:Date:Message-Id;
        b=LwVRGL9u3Pd7yk73BrtZ64H0ope5oA0n7AUC3mSQCWQjGF6nIzjS/LVjWm9Tj2Xsz
         KOj6a8TtGL4syOZyLzr/sLzc5xNp2OlD5383KplZqVMNoJT4kCKMXLBwYo4jqtvrZq
         Yqc7MUFC/tYJrc7ev62l96eNYSLTwuf0CMsU6gsq/0zAFQoDJQQQEOSyzQp577w/Ng
         24sW7aYkD8sGK2/5fhoJ9SVvrUNjsX0P+kcNHhjzMPmXAldnbVFlFgsXTJV311pU4q
         Fl0XxkiyKReTUlkMDkub6r4cg4WhV0mZfKuMfdP75tKQ5ST3pRUP4XkogTAAlZp/p4
         wH7Djbppi39mg==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10061701.me.com (Postfix) with ESMTPSA id 6965AAC03CA;
        Wed, 31 Mar 2021 20:43:46 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v3 12/13] ARM: dts: sti: add the thermal sensor node within stih418
Date:   Wed, 31 Mar 2021 22:42:27 +0200
Message-Id: <20210331204228.26107-13-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210331204228.26107-1-avolmat@me.com>
References: <20210331204228.26107-1-avolmat@me.com>
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.369,18.0.761,17.0.607.475.0000000_definitions?=
 =?UTF-8?Q?=3D2021-03-31=5F08:2021-03-30=5F02,2021-03-31=5F08,2020-04-07?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103310144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STiH418 embedded the same sensor as the STiH410.
This commit adds the corresponding node, relying on the st_thermal
driver.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index 39a249983496..97eda4392fbe 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -108,5 +108,13 @@
 			assigned-clock-parents = <&clk_s_c0_pll1 0>;
 			assigned-clock-rates = <200000000>;
 		};
+
+		thermal@91a0000 {
+			compatible = "st,stih407-thermal";
+			reg = <0x91a0000 0x28>;
+			clock-names = "thermal";
+			clocks = <&clk_sysin>;
+			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+		};
 	};
 };
-- 
2.17.1

