Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740343821EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 01:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhEPXHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 19:07:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:44054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231968AbhEPXHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 19:07:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27C66B1EA;
        Sun, 16 May 2021 23:06:21 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 6/9] dt-bindings: mmc: rockchip-dw-mshc: Add Rockchip RK1808
Date:   Mon, 17 May 2021 01:05:48 +0200
Message-Id: <20210516230551.12469-7-afaerber@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210516230551.12469-1-afaerber@suse.de>
References: <20210516230551.12469-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for Rockchip RK1808 SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
index eaa3b0ef24f6..54fb59820d2b 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
@@ -30,6 +30,7 @@ properties:
       - items:
           - enum:
               - rockchip,px30-dw-mshc
+              - rockchip,rk1808-dw-mshc
               - rockchip,rk3036-dw-mshc
               - rockchip,rk3228-dw-mshc
               - rockchip,rk3308-dw-mshc
-- 
2.31.1

