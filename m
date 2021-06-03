Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8967399D30
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhFCIyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:54:36 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:28028 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhFCIy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622710351; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z0zxayotQgwmZjnzhSw2Qr3Orn+TIEhcSXDKgCfxvfsXROFE/9QJGygLLqW3D7GT87
    T0fYI+pVOYdwfQXuhKpsEpmzRT8hRfR+ER23014BQ6Fcv9WlWNPqmQALgWghEBgTOTgh
    omUpfeMZ6phUk8BeOrJzhCazfFNJxdidXHABEzyGBHmyg4WbEikObPsm4WLEdSE6gxJn
    7IwHSw5SCoIvMZlCSUJWxFN57VaDoql1wA/p4wFlALOTWwzZoJljiWoiSB2FtVtRvEzF
    qwEkyTngkOrQnyjqBaaYze7oOxTZ/LJd+brk5W8ajIfJStbhiQl9gKiChFTnzAqdABjL
    erKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622710351;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LM5CS7HXO43+fNXoKDK6ehRNNCx0xHXfVrLDztxyTDY=;
    b=Brfn0iHdDsOce2pSqRLX7iCwcVA+qzlqdaBvkBW+seb426VZ0nR2AnZpCKyH6SM3aw
    Lt70s41HUtzQWKKkizMtLuBBQWaRENQSIMLELuS4QGWpqHj4EUqeoCb0WjOu08qQoeBr
    NhYQLEbo3Z2vWMSeS2E30vhFOzI6MJaHi9B96LkiDeGRLDqcT0TOH4bZQsEYwRIfjADc
    OZMu4DkzHfLW1l8/eWFWr37DLZ6qt7Z7hM5E4QQDA/eAcE39oybU5oitggMjDAyC+m3j
    isRdUzYr3t39A1puDjgukwVyvLMj2bBNLhItP2Hj4jLpzntSZDIFwwTJ4k5ckOtzupj7
    9S+w==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622710351;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=LM5CS7HXO43+fNXoKDK6ehRNNCx0xHXfVrLDztxyTDY=;
    b=YCngD97Oy5UT7EUYSLWb1pCO759kpjrSRgQ9RwFFmzPtnnBBJJzckgeKXl2B/hrpQT
    8RWf0PXLvHL2oAaFchYGnNRB1uTSlarDTHesqQzUK5vwd3jekg84LVlh0z2gHBCX1fLs
    sSr04CfHwM8TzwMkqjCnyK5L0yPnN95FV9RxxnOl+SdhYbt/F+4HDOzz3zPIj/x7A/Dj
    c5qCCbpc9caN+ktXCTRFXXlkupUgeEAtK9938tJj1wWx/lZeIIoi8Hxn8apYC1oGu2sP
    rXZbGoaPSTSj5HsOHS8yivr7nyZ43JpN7E/+qxSgNY5Zs5i8OJXX8F8UzCw3HoN30C+A
    Ob9w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4G6OIkHH"
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x538qV65l
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 3 Jun 2021 10:52:31 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: extcon: sm5502: Document siliconmitus,sm5504-muic
Date:   Thu,  3 Jun 2021 10:52:20 +0200
Message-Id: <20210603085222.89465-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210603085222.89465-1-stephan@gerhold.net>
References: <20210603085222.89465-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document support for SM5504 with the new siliconmitus,sm5504-muic
compatible.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4: Added Rob's Acked-by
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

