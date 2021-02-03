Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC3030E03C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhBCQze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBCQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:53:26 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B661C061788;
        Wed,  3 Feb 2021 08:52:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p20so118577ejb.6;
        Wed, 03 Feb 2021 08:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7vOF3Qw7Vj9m/dEB9LeeFb8gLBtZdZfVq0Dk/c0mkE=;
        b=aUvjXF2gYkIX2+5I20r39jRJwSmcoONANqcrIKNeM5k49o849cAKWT7+oAL6QXgfzt
         FbEHsmXM4FEFSH6IeERpgrmHfxSDmAhQadwoY1iUxpGm4p0d4vTnYLfAhqQqHhDHP2aX
         oCNy1x2QwPJMCb4Oauxx7/opPymql5TI9wLJgpuGbZWDSN6zKGVZ44wufudsULEQyPiY
         z09Piu4uuZFUcbAz9UVe/ZlpL0GjJcU4dnGd2dddH18ri0OH5hEa6b0gL7s8liXO+ahi
         nuAkPrNZKD0FQl1TMelR9gOICPZC8z2u49CSlcOa9IgMqplaV/PJKYOXSw0piV6fy4S4
         EMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7vOF3Qw7Vj9m/dEB9LeeFb8gLBtZdZfVq0Dk/c0mkE=;
        b=h27fgAZOKAVD69p86TcRmKsqWzqutSDY3pLkTSW6ACcCVqwjqTBAgPFxNVB9NKDM2t
         wVlwdnSti1q8azsY53XVs7/At22wl9OfExmxsErQ/4OmSw0nLRNcKwKC7oeQcSRUppEx
         PGm20X93bS+zkmqQllKKj5Sjlwrmz5o4dLSO9/15SaiwyiZAUbajJFTu1Q8uAaoNt+iM
         icJ4KZ3o7IVNqt5kPbLDUAKLSfSQkSyikDUfEbCMBl2Ckl8ngLKClqN0TW2AqEOyX4W3
         VVfo0h93VqAq6sTy8NRUZEkfwGhPHS2CvormFnRTAvastbrrE+BLesrWjDPtxwN2P7iw
         u8+g==
X-Gm-Message-State: AOAM533eGZQzolC3Gw9SyfEUTqLBVO4uX69KK6LV63oNLCiIH+p5VSNz
        YrdRLowguypIx7A2wVblv7g=
X-Google-Smtp-Source: ABdhPJwpI0VZokomRqJXYpQWN3fEr1sQhyr7+sO1T44orVCksMHTtsMSJVYnPKxAbQ9/UJVImnfgxQ==
X-Received: by 2002:a17:906:8410:: with SMTP id n16mr4182326ejx.551.1612371164918;
        Wed, 03 Feb 2021 08:52:44 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a25sm1135471eds.48.2021.02.03.08.52.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 08:52:44 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] dt-bindings: usb: dwc3: add description for rk3328
Date:   Wed,  3 Feb 2021 17:52:30 +0100
Message-Id: <20210203165233.22177-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210203165233.22177-1-jbx6244@gmail.com>
References: <20210203165233.22177-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for "rockchip,rk3328-dwc3".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index fdf9497bc..621166a50 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -27,6 +27,7 @@ properties:
   compatible:
     items:
       - enum:
+          - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
       - const: snps,dwc3
 
@@ -37,6 +38,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     items:
       - description:
           Controller reference clock, must to be 24 MHz
@@ -53,6 +55,7 @@ properties:
           Controller grf clock
 
   clock-names:
+    minItems: 3
     items:
       - const: ref_clk
       - const: suspend_clk
-- 
2.11.0

