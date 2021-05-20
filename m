Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23EC38ACD8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbhETLuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:50:02 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.170]:27285 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbhETL1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:27:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1621509958; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GDx9DO8+B6qQBe4gvli1ho6qi/qluGb1O3JTJacqR4s9fmB8Obx6eOYSLYSqyF574Y
    74laAnxdy8s83rkDTfsb9zvzcDctVhIAjJMo5brdyjulGB2NZz817AQ7Nh7IJxOCQxov
    tapPlGwzsvWT+ZAIMRJ5SlJHENGeuyZ/qbFf9gYKqAx7TVkGCc/EkGN5o2p3orJbmEKw
    Ky+5fnkunFR4Upp5KGOIiaPh0fTlLd9cI0wPFTYLGxVOoMc7PgWPt93m4+f1h9wTL8Ne
    q3pmfVTtclNC3+FkT5OXAx4A4oWmrIiux1QHr1CNWgEIxjk1IFb3j6UmA+1wT3hONNsL
    XtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509958;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WusjepEf0ImZGQpetBmFDA0rblZD8nyERdVuhtSp86Q=;
    b=B+X/P+JeEtIaJwYWoiPQ6eB3KXYY21ya7gQw7GTOifcK7BDT4zMerZNjrcPJFgfEKR
    lPdAbfOVff/FIk455kWdnvmADjEUHxqVSLkrO6UUwL+NbT2xgfgk3h6rQ0hFih864Lom
    Puxd+qBy1kOKtqE8aYxSsVwf6IXe8a5Ac+EzootHa8bYMfJtHgr+dvvdAjAVz//qgOKL
    BpG3drkOGbo7RrBuhoeMTNsrrqrtyCX38cu6OwwpNcUbY3Yd7qkncXXceq79Xh+x9Nxz
    /8zwxiHRz2ofn4dli/vjZRB95RlnGNFcblGRWiHixWYRokMe8prG+NjaETmovKlT0iEf
    Dn6A==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1621509958;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=WusjepEf0ImZGQpetBmFDA0rblZD8nyERdVuhtSp86Q=;
    b=FUw3GgIQXe23hDTOe4lQc9IGF/2vlesAIEnkLX/snJNwERSkEF6o6DSeUhAGd9JtbY
    x5wMpJdk9ccRG8P2dlIaGEMeo+pNtBVgZqyz54GTa0lFt599jnMZ67oYIXFiL00DUNNF
    0XzAzlvage7jyEbwL9tfMWR9EXafWefQjesKgBUD8wH/mMH4eDp0gVy1fbvvElCY/868
    /z+vwLm0IDXyC5wP1sEw0klQ2yN/8s/dYF0491Hn6BOCdq04Bi9s50NvbvCOveHsb1aa
    P1mNRpVmzhZODiafR8bT+yIaeWxqDC3PjLOCkmPm0v/bh7G/tw3BCzNXBrfX3Mdz6eyi
    w5XA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6FtFQ="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.26.1 DYNA|AUTH)
    with ESMTPSA id 400bd8x4KBPw22X
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 20 May 2021 13:25:58 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 5/6] dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
Date:   Thu, 20 May 2021 13:23:33 +0200
Message-Id: <20210520112334.129556-6-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520112334.129556-1-stephan@gerhold.net>
References: <20210520112334.129556-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for SM5504 with the new siliconmitus,sm5504-muic
compatible.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/extcon/siliconmitus,sm5502-muic.yaml           | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
index 0432b0502e0b..fd2e55088888 100644
--- a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
+++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/extcon/siliconmitus,sm5502-muic.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SM5502 MUIC (Micro-USB Interface Controller) device
+title: SM5502/SM5504 MUIC (Micro-USB Interface Controller) device
 
 maintainers:
   - Chanwoo Choi <cw00.choi@samsung.com>
@@ -19,10 +19,12 @@ properties:
   compatible:
     enum:
       - siliconmitus,sm5502-muic
+      - siliconmitus,sm5504-muic
 
   reg:
     maxItems: 1
-    description: I2C slave address of the device. Usually 0x25 for SM5502.
+    description: I2C slave address of the device. Usually 0x25 for SM5502,
+      0x14 for SM5504.
 
   interrupts:
     maxItems: 1
-- 
2.31.1

