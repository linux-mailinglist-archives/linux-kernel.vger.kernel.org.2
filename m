Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9C040C22E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbhIOI7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbhIOI7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:59:12 -0400
Received: from mx.msync.work (mx.msync.work [IPv6:2a01:4f9:2b:2dc2::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB1EC061574;
        Wed, 15 Sep 2021 01:57:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 070AAF6277;
        Wed, 15 Sep 2021 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1631696271; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=kWatsbnRYouuldwb6lqvB/sV7amJutWYUknSlMpmpCc=;
        b=mMzsuhkbOBmY8ySi9D7vdBdrV/XlE05ki6tDf0/MD/1O8kC42f1GlRt+5bWmHrHw6I2Khx
        06CUhWpQRRYrQBvNjH/FXGvQess/Y8Sx8yQAFVIVJW18BlDvSvRyV3qrST5gemc46QLa4c
        BBebpe7mEBCnVgrphjLGXO6fKiE+U68tmqEl4Tlc7NRDb/mv50ModvNEVwIUA6o4IpwA4p
        jSpGXv3K+tSgIivTUM/9FHilJlcsvYNT+YOGjIiVg7yjKGhz+MeF0z2XvDuO6ONbodnEvp
        OLL0DHHOuStE81b90ADZvUFKL7190m/Hfe6R4hnDYdnoJb+PKQp8KhRs0mXY2A==
From:   Vyacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: arm: amlogic: add bindings for Jethub D1/H1
Date:   Wed, 15 Sep 2021 11:57:13 +0300
Message-Id: <20210915085715.1134940-2-adeep@lexina.in>
In-Reply-To: <20210915085715.1134940-1-adeep@lexina.in>
References: <20210915085715.1134940-1-adeep@lexina.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JetHome is a series of home automation controllers:
- Jethub D1 based on Amlogic A113X
- Jethub H1 based on AmLogic S905W

Signed-off-by: Vyacheslav Bocharov <adeep@lexina.in>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6423377710ee..b223d7829c3d 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -86,6 +86,7 @@ properties:
           - enum:
               - amlogic,p281
               - oranth,tx3-mini
+              - jethome,jethub-j80
           - const: amlogic,s905w
           - const: amlogic,meson-gxl
 
@@ -133,6 +134,7 @@ properties:
         items:
           - enum:
               - amlogic,s400
+              - jethome,jethub-j100
           - const: amlogic,a113d
           - const: amlogic,meson-axg
 
-- 
2.30.2

