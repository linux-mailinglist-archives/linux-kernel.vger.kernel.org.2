Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6505F310A85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhBELoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhBELlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:41:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA690C06178C;
        Fri,  5 Feb 2021 03:40:35 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y8so8467638ede.6;
        Fri, 05 Feb 2021 03:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cNFFFBXY6L5UHLHUyj3rIyUKC+rbFyqqqVFEOT4uqFw=;
        b=ahB32WzDsm/wCAllVe7CyZf0Rf7AO9VVUmt/hYIo2g+23U1fXa4dfkq9r2mMrvq9UE
         D28HY3O2tdoVBYU3FhxzltQZ2CxjV7CQix0uN2m8BvrUEhabYvBEbTXRpZbv1qSpYt7o
         I++opCff3wF+yu5JZGMW7gCWwPp09tjUN1EYjMHHUjuZJlSteyU8H8BLwnw9Bhx+2CdJ
         8sy7PD9a9BNWgAD/BJzYdHNaIpHXI29T11FWcT009Y03sswsw/fg06Lj37a/FrqUdwoa
         8MiYr0oxqZyNfsg2MG2EcbdOOgvIpo50BD5t5NV+eKW4ekUTTy99aOgMCDMmENdcbOZY
         qSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cNFFFBXY6L5UHLHUyj3rIyUKC+rbFyqqqVFEOT4uqFw=;
        b=RjZLQMBBoDcmd9lA7xlp8Q7V+q7LGWMByuifoH2azPQtWkRZursijfiscQnDm0Wx1X
         9Vb1qXIKzMtZ/YuVTMpixM/mkHTSjxmjvVWHntYYU/hW8VhIVIJB7UV3Gt7ltD12u/A5
         iaNOpWNCHybr0N8z3GkA4s8GrEc7+SvolHPrtBqhyZVA8EioDsLWknYnM98u6o9C0oeQ
         OXLhDovl9VRQQSibGNWC5oR6CWdDu4bvK3kqUiRDfhjPLnd9expr7kHyRpG9ZRegmzIY
         es5T/5k4L1/WkidiwZ+6QtQyeEO3l0ZsFLkVNuAczob7ePRdZz+uGjSe3D6r9CVssTTC
         32xA==
X-Gm-Message-State: AOAM531MN6I6BM61FBT76pDB3LenV7pkdP5xOU/WvctkM+263dcbnOrM
        pqnD8cZdMKNHVF2MY8dnp7Gh254tTc4=
X-Google-Smtp-Source: ABdhPJzV30e9Zsy9VnCpm0mQ5RKvCPwM/JwHEW6pk4wgqKQLWPOZYzu9IQTafZp5nbtHqjCTAImsyA==
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr3109884edd.149.1612525234585;
        Fri, 05 Feb 2021 03:40:34 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o4sm3883476edw.78.2021.02.05.03.40.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2021 03:40:34 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] dt-bindings: usb: dwc3: add description for rk3328
Date:   Fri,  5 Feb 2021 12:40:08 +0100
Message-Id: <20210205114011.10381-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210205114011.10381-1-jbx6244@gmail.com>
References: <20210205114011.10381-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for "rockchip,rk3328-dwc3".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index d815aacfc..08a08ffce 100644
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
@@ -49,6 +51,7 @@ properties:
           Controller grf clock
 
   clock-names:
+    minItems: 3
     items:
       - const: ref_clk
       - const: suspend_clk
-- 
2.11.0

