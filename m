Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D343536B12E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbhDZKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232990AbhDZKAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:00:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9D1611BD;
        Mon, 26 Apr 2021 09:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619431162;
        bh=Eo8NG9Ku8sejeKmIVqKHo9XuftmdYKyt1K/FbjHeb6s=;
        h=From:To:Cc:Subject:Date:From;
        b=JwF3hfw7NUXS91lbnW+cWlgAHGQs0NQ7P/ATY9Ts042O9qLyncQ2QSIJs+zbT+an6
         k+vJ81LQ7MsDdf+sJf0f22rZ+Ji886NBs0OZvf4/FPXXQVbEOMCiSYaUMB5PraidaS
         JykACDxEDr0a/jbx+cWW5plB3vOjfQuLcxqhUlavhiaLEllJpPwhfOTiFibWfGf5uV
         WF0dWYqDX3xzptmZohi9GQg0MPIAm/oehfA6UJAkukNkOvgwBfoP5fEfkfGLK+U20n
         7Ie8rOjDZX/zqh7I9qxCnLf3iOZ6ay1OSN0YbOwK94LjwjE/F6owa5tRD07VsnSL9J
         9rV1VFuMzIDBw==
Received: by wens.tw (Postfix, from userid 1000)
        id C2D935FBEA; Mon, 26 Apr 2021 17:59:19 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: rk3328: rock-pi-e: Drop fephy pinctrl from gmac2phy
Date:   Mon, 26 Apr 2021 17:59:16 +0800
Message-Id: <20210426095916.14574-1-wens@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Turns out the fephy pins are already claimed in the phy node, which is
rightfully where they should be claimed.

Drop the pinctrl properties from the gmac2phy node for the ROCK Pi E.

Fixes: b918e81f2145 ("arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
index 07538951a3a6..018a3a5075c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock-pi-e.dts
@@ -177,8 +177,6 @@ rtl8211e: ethernet-phy@1 {
 };
 
 &gmac2phy {
-	pinctrl-names = "default";
-	pinctrl-0 = <&fephyled_linkm1>, <&fephyled_rxm1>;
 	status = "okay";
 };
 
-- 
2.31.1

