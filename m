Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F0035F68C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351934AbhDNOrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351910AbhDNOrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:47:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 507E061155;
        Wed, 14 Apr 2021 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618411614;
        bh=rs15LF3rKUgaMNwrFb8ZdV4uSTpiASPmNfBhf2NkQ8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BlWgvxSQ2ZbOX8yA6z647CrPNNwHdGVIuyKWyZAmtLTGxcIfIADJz56cYeUX8yGPt
         UaEwZ384GIUt45h9yTeGAJ9LCbrUnhSyzprk6G6IAgXjbxv/gr1rOt7repANA3QTUO
         TYibzSlsDiR4I8QWliFjqdpDecZP8/yvHFn/fAXfdhLjRpAerflaNUloy9YkVOeMI5
         qje6uKz0HDdsCddm6t+E2x7DET6ZMQ80eVDkVJN+CFhlpM2kBHvCLEVz4AJgx30n5P
         0mQ5/XmpUHKnc9DYaddEvFdt6IHBaWlQb+AuaiTo9FyUara0+Lz5Ba0dqB/GejEixP
         geBE7lYrdoXkw==
From:   matthias.bgg@kernel.org
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: mt8183-kukui: fix dtbs_check warnings
Date:   Wed, 14 Apr 2021 16:46:42 +0200
Message-Id: <20210414144643.17435-3-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414144643.17435-1-matthias.bgg@kernel.org>
References: <20210414144643.17435-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

The dsi children don't have any reg property, so we don't need address and
size cells. This makes dtbs_check happy.

CC: Hsin-Yi Wang <hsinyi@chromium.org>
CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

---

 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index ff56bcfa3370..f4dca6a33168 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -251,8 +251,7 @@ &cpu7 {
 
 &dsi0 {
 	status = "okay";
-	#address-cells = <1>;
-	#size-cells = <0>;
+
 	panel: panel@0 {
 		/* compatible will be set in board dts */
 		reg = <0>;
-- 
2.30.2

