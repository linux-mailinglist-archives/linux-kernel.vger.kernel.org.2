Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E5C323AF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhBXLA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:00:57 -0500
Received: from pmg02-out2.zxcs.nl ([185.104.28.196]:60055 "EHLO
        pmg02-out2.zxcs.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhBXLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:00:11 -0500
Received: from pmg02.zxcs.nl (localhost.localdomain [127.0.0.1])
        by pmg02.zxcs.nl (ZXCS) with ESMTP id 285EE83B1F;
        Wed, 24 Feb 2021 11:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=pascalroeleven.nl; s=x; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5iH+f0B18ifcjxW9mghCrDKfJx2VEwYdRjMyyarrnlE=; b=OAMLsf6EsGYaPWvh77MF+kOiMq
        swTMcgC92IJ+vHNg6rUVTGbYypWoHMoCuWLbtBHaSJ3Wp96o+zK9N2Ml+QnVsVFyNYgrX+1hGl55u
        mjkEyBvqD5Za7HZQGe6LI4amXfQXY0Nouik+0CoeYaQpIyeVCoGZ5h55PJ5yLb0JS9OQxkALdf31y
        BTV0dqJrdjUFwdzZYffQT5DcAvXu9SJHXE/cKkTM++f6CED3k6Am/SmCmsKfnNh0TJNaxttOm8mwL
        TvunH+jUfHBYS3d0HLHFTPNyOVZ3FML+/uW5EMdTA0v57vCuCJdNGG4fovm7GhoctIv9tSmodQ22y
        mo30/jNA==;
From:   Pascal Roeleven <dev@pascalroeleven.nl>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Martin Cerveny <m.cerveny@computer.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: Add Topwise A721
Date:   Wed, 24 Feb 2021 11:52:39 +0100
Message-Id: <20210224105240.47754-2-dev@pascalroeleven.nl>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210224105240.47754-1-dev@pascalroeleven.nl>
References: <20210224105240.47754-1-dev@pascalroeleven.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dev@pascalroeleven.nl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings for Topwise A721 tablet

Signed-off-by: Pascal Roeleven <dev@pascalroeleven.nl>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 08607c7ec1..ac750025a2 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -802,6 +802,11 @@ properties:
           - const: tbs-biometrics,a711
           - const: allwinner,sun8i-a83t
 
+      - description: Topwise A721 Tablet
+        items:
+          - const: topwise,a721
+          - const: allwinner,sun4i-a10
+
       - description: Utoo P66
         items:
           - const: utoo,p66
-- 
2.27.0


