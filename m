Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0153D3B4257
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFYLUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:20:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56946C061766;
        Fri, 25 Jun 2021 04:17:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id nd37so14580344ejc.3;
        Fri, 25 Jun 2021 04:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D6RY/y0lxdahXpEtNonnvg3XqIYy4uZ5acV3CJGaoIw=;
        b=KcEM/T15NcSe3TU7ywBHq1BRDzX1m1modItSI5v2DeBYQroULWQn+Jkn1zaEgL2NUK
         +UExDW9pdZ5vHJ8obmmqXXwWUt2l5g8Y5ppClRlh+S39k2JeckSuiAgDT+4qVPvSnAX5
         YOE4vzD+1O0AnNAtk6WpLOnLg/qaDUQ6xB5lsbS001Q3Xa+xb752hXiYI01VbR5IJ+Ow
         CPYsKXIKa1/v5PMg34E0zfKWCOfjwX8oqS43V6Afj4IEnNZeti1GXlNeslfE1SWZSMRH
         sJN14V8pT1W7lS+IUKvOlvodtlWsxSDZpeyAWfKsH9s7/X4eVJVttKacmtBjeTGIfCWS
         +cuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D6RY/y0lxdahXpEtNonnvg3XqIYy4uZ5acV3CJGaoIw=;
        b=e/gs0zHC7ibBDasqKYXszZqdlgUi9YJp80ul7TtUbLaTMWlfHTZrtyw+cxGPoBIbzq
         +Pgc58p40VQ607GJ4vmVk6QZ4YQ5hNkLpdx87HcYG+bx6XT42iXa0PioCWc7nQaaabqG
         bHo4JClLz8kfzehQE12QLAdHMxrdcAlLVazhohimsvto7b7vVcQYXOBYHwMgxKu8oKh4
         0AMZuQa+uRjF1ELdsg0bRuzC6TdF57zJclXFv38zW8hCSpPItWFNKbJruKrzIZxB/EVk
         5nZ9Ro4GCXfZouxJlts8SH2fRYMN9rBh7iX4lb/H0fm85MWqLGvZL5Fi2M+4vN3JK380
         ULcA==
X-Gm-Message-State: AOAM530NkGNEfXEWxb8x6FSZBBJ4X6OBySPqDyFRmS7IyeYNWzjp/dlp
        7GLoUUhbqph6cHt96dWqlL0=
X-Google-Smtp-Source: ABdhPJyu2pK0wIxtzoJjiX1ZtYTgqrtx2lYio12zhpwIzqKeiZbGinfk26+fPl8pevEYXc9JyoUncg==
X-Received: by 2002:a17:906:82cd:: with SMTP id a13mr10457595ejy.229.1624619873937;
        Fri, 25 Jun 2021 04:17:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b10sm3731238edx.4.2021.06.25.04.17.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jun 2021 04:17:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] dt-bindings: soc: rockchip: add rockchip-io-domain.yaml object to grf.yaml
Date:   Fri, 25 Jun 2021 13:17:44 +0200
Message-Id: <20210625111746.6269-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210625111746.6269-1-jbx6244@gmail.com>
References: <20210625111746.6269-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rockchip-io-domain.txt file was converted to YAML.
IO Voltage Domain nodes are sub nodes of grf and pmugrf nodes.
Add rockchip-io-domain.yaml object to the grf.yaml file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/soc/rockchip/grf.yaml          | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 62fa72cfe..fa010df51 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,7 +15,6 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
-              - rockchip,rv1108-pmugrf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
@@ -41,6 +40,7 @@ properties:
               - rockchip,rk3568-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rv1108-grf
+              - rockchip,rv1108-pmugrf
           - const: syscon
           - const: simple-mfd
 
@@ -198,21 +198,27 @@ allOf:
         compatible:
           contains:
             enum:
-              - rockchip,px30-pmugrf
               - rockchip,px30-grf
+              - rockchip,px30-pmugrf
+              - rockchip,rk3188-grf
               - rockchip,rk3228-grf
               - rockchip,rk3288-grf
               - rockchip,rk3328-grf
-              - rockchip,rk3368-pmugrf
               - rockchip,rk3368-grf
-              - rockchip,rk3399-pmugrf
+              - rockchip,rk3368-pmugrf
               - rockchip,rk3399-grf
+              - rockchip,rk3399-pmugrf
+              - rockchip,rv1108-grf
+              - rockchip,rv1108-pmugrf
 
     then:
       properties:
         io-domains:
-          description:
-            Documentation/devicetree/bindings/power/rockchip-io-domain.txt
+          type: object
+
+          $ref: "/schemas/power/rockchip-io-domain.yaml#"
+
+          unevaluatedProperties: false
 
 examples:
   - |
-- 
2.11.0

