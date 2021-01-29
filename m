Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E17308695
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhA2HiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:38:24 -0500
Received: from st43p00im-ztbu10073601.me.com ([17.58.63.184]:44875 "EHLO
        st43p00im-ztbu10073601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232322AbhA2HhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1611905777; bh=EtIBL5r4/ZRTUX+loqJ5m2791/RWUC4onGbM+ik/Iq0=;
        h=From:To:Subject:Date:Message-Id;
        b=lSYzmDJysnzf/uRud0OapWdKJwMxNIX0BEBL2h8NmQ2rod7yZwHo8kmX43uYIrykF
         lYSZsJlPtaPWcSHQFOsmbbSsa2dApv9O69IH+u6fAhczdd+O6rHO5YeURvSPwUsQ1N
         2zu2SOtU/YTTl5/BMUXRqMgSPVQuCc1UvNLi8z94TCBClf9ngLsFhZQWeqQwLRMWGJ
         qDYw/ggLn42SCSEoe+xKzibFkNc9HO2KtL3xndlFbXzSlYfgD3F7GWI8apkZkAZWsg
         ymqmy4fst2vmDt5SuolrtWzvmjy3WOhGzFhOHCrNRESUzH59b6YDBBcPjflw+97IRs
         9dCHoDf6r1SdQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztbu10073601.me.com (Postfix) with ESMTPSA id 4490D82096B;
        Fri, 29 Jan 2021 07:36:15 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 2/3] ARM: dts: sti: disable rng11 on the stih418 platform
Date:   Fri, 29 Jan 2021 08:34:46 +0100
Message-Id: <20210129073447.18778-3-avolmat@me.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210129073447.18778-1-avolmat@me.com>
References: <20210129073447.18778-1-avolmat@me.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-29_03:2021-01-28,2021-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2101290039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rng11 is not available on the STiH418 hence is disabled in the
stih418.dtsi

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih418.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index a05e2278b448..39a249983496 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -27,6 +27,10 @@
 	};
 
 	soc {
+		rng11: rng@8a8a000 {
+			status = "disabled";
+		};
+
 		usb2_picophy1: phy2@0 {
 			compatible = "st,stih407-usb2-phy";
 			reg = <0 0>;
-- 
2.17.1

