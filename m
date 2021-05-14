Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D407380C70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhENPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:01:05 -0400
Received: from mail.manjaro.org ([176.9.38.148]:42906 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhENPAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:00:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 04F56222574;
        Fri, 14 May 2021 16:59:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RVUCmKNzUL1i; Fri, 14 May 2021 16:59:33 +0200 (CEST)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 4/5] dt-bindings: soc: rockchip: grf: add compatible for RK3308 USB grf
Date:   Fri, 14 May 2021 17:00:43 +0200
Message-Id: <20210514150044.2099298-5-t.schramm@manjaro.org>
In-Reply-To: <20210514150044.2099298-1-t.schramm@manjaro.org>
References: <20210514150044.2099298-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3308 has a USB GRF.
This patch adds a compatible string for it.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 84bdaf88d5a6..df77bd2e6752 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -30,6 +30,7 @@ properties:
               - rockchip,rk3288-grf
               - rockchip,rk3308-core-grf
               - rockchip,rk3308-detect-grf
+              - rockchip,rk3308-usb2phy-grf
               - rockchip,rk3308-grf
               - rockchip,rk3328-grf
               - rockchip,rk3328-usb2phy-grf
-- 
2.31.1

