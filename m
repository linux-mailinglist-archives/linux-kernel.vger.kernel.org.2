Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B80344359C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhKBScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhKBScQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:32:16 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C304C061714;
        Tue,  2 Nov 2021 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=+Ul1n4yoKPptLWY+ebpdvAt82oUzxqM4aKQK6FDToeg=; b=oWN+hPiA3Tz2M+Ohb60VR6NptS
        HViu5Oqxd4JwyPmvY2/8aOB+0p6PqVM/0Uvdyo8C9cO8lQRDeCH3teiWxH6yS1zNApGZkBOkzNoDS
        SC0HKPykdoeER0vv9RoPgfeZ6TpjiO7UniwV5OIt/N/zVAlUpxZ/JJW5PoMfE9ge3MvXhBX4kshCe
        UQzSUCu0zrqmCeCvBHC+Wv/qBVIVHGmMVWtHkhqcY/01eracWI5BUPtD2kFTo1atBLzJalSdr930F
        uHkmJrXf/wFasshmp3/2Ap2UpaMqYyDyDS2NlW+FPIPob6f5bA/BuNt6RW7eCPgZ/lmtCL1PNh4K6
        Vh13EQ7w==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mhyXK-0004Uv-FX; Tue, 02 Nov 2021 18:29:30 +0000
From:   John Keeping <john@metanate.com>
To:     linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andyshrk@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: fix rk3399-leez-p710 vcc3v3-lan supply
Date:   Tue,  2 Nov 2021 18:29:08 +0000
Message-Id: <20211102182908.3409670-3-john@metanate.com>
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

Fixes: fc702ed49a86 ("arm64: dts: rockchip: Add dts for Leez RK3399 P710 SBC")
Signed-off-by: John Keeping <john@metanate.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
index 7c93f840bc64..e890166e7fd4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-leez-p710.dts
@@ -55,7 +55,7 @@ vcc3v3_lan: vcc3v3-lan {
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vim-supply = <&vcc3v3_sys>;
+		vin-supply = <&vcc3v3_sys>;
 	};
 
 	vcc3v3_sys: vcc3v3-sys {
-- 
2.33.1

