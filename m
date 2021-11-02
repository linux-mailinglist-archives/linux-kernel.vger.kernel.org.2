Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC282443599
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhKBScO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhKBScN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:32:13 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BFAC061203;
        Tue,  2 Nov 2021 11:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=npkhrwshLLK5QryVWsdoS2NtRhtUIKXUFOMLqsdxyaQ=; b=O4z9mzsh0pFmBSYUvtb2QOtU6D
        7aPdht0qgpXiWv2eZ85+A+PL9msXJKZXEhjSFCOEQKT6vd3wcuqpwnDQMdBqh8meq1wjUMdVdBtU2
        IwN2WppT7beLeElkFbxBEpUAke9t7UJhQoG0u4qLslfaMQ6F/ypj/pujx2d95aqVeYSp1v/a4yXKm
        h3ZpaZSIQ53S+SJOSO5LfI1wsUdhYb/HEno24UH8piCSyOUmlG2BD37HZYte4ilkh6Za5+sKMCmTY
        ThQVdzhbpsHGHqzoYWeOimOR7cUby7tp/5Mat9wZfSbtMWdwgq5mUtgJEuRMtg7E2v2t2ypOnrDEl
        IaPEn8sQ==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mhyXK-0004Uv-6u; Tue, 02 Nov 2021 18:29:30 +0000
From:   John Keeping <john@metanate.com>
To:     linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andyshrk@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>
Subject: [PATCH 1/2] arm64: dts: rockchip: fix rk3308-roc-cc vcc-sd supply
Date:   Tue,  2 Nov 2021 18:29:07 +0000
Message-Id: <20211102182908.3409670-2-john@metanate.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211102182908.3409670-1-john@metanate.com>
References: <20211102182908.3409670-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct a typo in the vin-supply property.  The input supply is
always-on, so this mistake doesn't affect whether the supply is actually
enabled correctly.

Fixes: 4403e1237be3 ("arm64: dts: rockchip: Add devicetree for board roc-rk3308-cc")
Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
index 665b2e69455d..ea6820902ede 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3308-roc-cc.dts
@@ -97,7 +97,7 @@ vcc_sd: vcc-sd {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vim-supply = <&vcc_io>;
+		vin-supply = <&vcc_io>;
 	};
 
 	vdd_core: vdd-core {
-- 
2.33.1

