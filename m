Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFB423201
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhJEUbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:31:11 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:56908 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236188AbhJEUbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:31:09 -0400
Received: from localhost.localdomain (ip-213-127-63-121.ip.prioritytelecom.net [213.127.63.121])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B15B8C9158;
        Tue,  5 Oct 2021 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1633465757; bh=frxoBNTsUZRbITBdNSe5aGy6uhU1HOv6AQ3q+VXoaXA=;
        h=From:To:Cc:Subject:Date;
        b=X0ujESeE0xHg0RTUID+yhgBnuvIcoCWFv5zHu3Ga9cnC9+IrR8fe/7NIxT/qlysZ1
         /a5cS2myucCbWz3BV7KZ+TNYVm/1NmlJ4XszrKcbFultyujpeeTM6sQryoKME1NjNW
         z2hLdL3vIpj7x8Nv0/La3dMbBIHDTYLcRdkJin0s=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-mediatek@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: Add MT6589 Fairphone 1
Date:   Tue,  5 Oct 2021 22:28:30 +0200
Message-Id: <20211005202833.96526-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatible for Fairphone 1 smartphone with MT6589 SoC.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 80a05f6fee85..0fa55497b96f 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -32,6 +32,7 @@ properties:
           - const: mediatek,mt6580
       - items:
           - enum:
+              - fairphone,fp1
               - mundoreader,bq-aquaris5
           - const: mediatek,mt6589
       - items:
-- 
2.33.0

