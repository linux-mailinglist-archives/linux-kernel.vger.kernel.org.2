Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA77315918
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 23:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhBIWEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 17:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhBIT0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 14:26:05 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E2BC0611BC;
        Tue,  9 Feb 2021 11:24:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lg21so33686246ejb.3;
        Tue, 09 Feb 2021 11:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=14H0f5aEEI+2zFgxOySJ5VK8BkDHBP5qJGIxOOYhz58=;
        b=gMAIk/S9I3iFVCWESma9i7AuSTvZUJpJ5rqGwM8rphZJSjmYSw5wDTa40bpLw7B7Vz
         ZAydfmL8j7caXzB+o3mgGViApPbVoDbzcrw+wF0Hxzao9IrV+Fg3DjBO8I1X1aeAjegb
         /kYh2JBnjBpV/7Cj1idcONsm95EX9bbQmltv8johxwzcI+PLzSMPQiG0i7NSWYbVReP9
         xgUZxPgwZEigzqT5kFKMx61X2h3LXiyat0XAezx3zx4sdKcuAJUi/VcQjgjdJ3sbJgIE
         MQrAdtkVGTL+IeOpuylHqMZPZRncZw/HCsUZn5AZ8OHrwPu0j735rZkYRBQlzGRCh7Es
         AjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=14H0f5aEEI+2zFgxOySJ5VK8BkDHBP5qJGIxOOYhz58=;
        b=j2n0qP3QdTQSDbbPQHo00IqloFkYqO0JHCQDpGLxW32FOaTibfENBS/kat+4pQV2jA
         xjofsQWF6VZ+WwY2ZQMbkzrStbjYSBcTdL6hoR4i/2zvoa4A1bQb22qwO/YIQeXJuThb
         JZZ+mzwys/4HoMRw40WB8s2r+udAgM1C4xI71bb/DqLFWBPTSfBABWEpcCH57JtIfyY4
         SOZdChWZFcayCUPh8v41hkFZLi0mWisb+nYbL7kNXpB4cVzpii7c4Kmi7iJd9EM4Qu+Q
         7aIsDw+FPGLcC9eUPDk7D5x2KADufMAx0rUGFn6ghtq1DudeczjOxrkB01nXIhaziYzU
         njuQ==
X-Gm-Message-State: AOAM531eE5eQ4RyI1EhvLVH7y3lDqxDOGrcPNOl0qlJ/YVFUvArulPpc
        BVptgCMVqLlE5GY80esBppo=
X-Google-Smtp-Source: ABdhPJx8ip8GJWyWEYn2wFpemRPOtuTEtwjD2rTTvXHwWcTT8F0MeWmHOPwUVBGO9at+rVhb13/wug==
X-Received: by 2002:a17:907:1181:: with SMTP id uz1mr24534030ejb.60.1612898643445;
        Tue, 09 Feb 2021 11:24:03 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w3sm11075779eja.52.2021.02.09.11.24.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 11:24:03 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] dt-bindings: usb: dwc3: add description for rk3328
Date:   Tue,  9 Feb 2021 20:23:48 +0100
Message-Id: <20210209192350.7130-6-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
References: <20210209192350.7130-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for "rockchip,rk3328-dwc3".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V5:
  add select
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 9908270a9..04077f2d7 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -28,6 +28,7 @@ select:
     compatible:
       contains:
         enum:
+          - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
   required:
     - compatible
@@ -36,6 +37,7 @@ properties:
   compatible:
     items:
       - enum:
+          - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
       - const: snps,dwc3
 
@@ -46,6 +48,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 3
     items:
       - description:
           Controller reference clock, must to be 24 MHz
@@ -58,6 +61,7 @@ properties:
           Controller grf clock
 
   clock-names:
+    minItems: 3
     items:
       - const: ref_clk
       - const: suspend_clk
-- 
2.11.0

