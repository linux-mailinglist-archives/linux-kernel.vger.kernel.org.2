Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC01130B08B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbhBATmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhBATl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:41:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F74C06174A;
        Mon,  1 Feb 2021 11:41:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s11so20299362edd.5;
        Mon, 01 Feb 2021 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqBtzEvAwNKiwVYCrfCe2jfiFhnACOLKHc4Xbe7Gosc=;
        b=GdxxfM5G06yroEWjLqtPD4kPmnDUkQ3xWGnxslPz0GFCgNmobccwnyM02eyfY95jFa
         2TwDRK43sMe9pkNWJDBE5ShS0RqKz4zg5Ye7mCXQtyxmkowfyBe5nOTR33icBwDerEoV
         vSoxMXV3eKOcJbtJIyIMCG+sr3tlIO4SECl/fdby6NW4oYFLJ57oYCTTwkEgdV7gWFsX
         l/K5ISUWrlo2oWyg1lB1+XEWi4Ch+EfB62y5GVAD0iwUJ/MqVtg5GahiWkeuMvB5FBip
         aW0fgTYgqp+poC/QEZfDmWb/GyOh5TNvomoZiO3HUAIFVPZknPHLQ8qT5sy2xJX8x7UN
         ng4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqBtzEvAwNKiwVYCrfCe2jfiFhnACOLKHc4Xbe7Gosc=;
        b=CN/k3Q2xkvC/4AuNgmyQ4/g1Q/johhPJTYMBlXxjT8koEuy6sry0P2emAW49H5Veo0
         aGXNTRue2lAPm+//9Kd63Wi2fwIGJ7v/BO+9uvmaXqDi7hXRrpcMWIB9PJy7hgHhhTF2
         07MKYsWg4qL7HHiRXGhzgTZ/6FXVRYADH73YBv+pxFZLCvHCNsQuCZsrVzamQtUGz73o
         c47vIRry97pNGzXSjGAQNXeSWQg+Vseib6958KRGN0WOrVKc7SdETKp4fYx3QOZP8B7k
         D4FhsKjPn+YE2qvFvooZZjT/eU2cJi4SAY2+D9UD4W+7QzG9DAlRGJEil8ra0S4q2W2r
         0Qjg==
X-Gm-Message-State: AOAM532pB6j/lyGf6WGK+HTIYVkQz2CoV0uuZ7wVtu2YWrSQBNA+OHhV
        SZOIdinROqFVDoGEkqRjq94=
X-Google-Smtp-Source: ABdhPJxPoBbnKGy9ZsZFVlQb7gmSL256Hs0FuaKI09XIprF+AOL90+g2tF8xnMRdc2ztysdU8IaQYQ==
X-Received: by 2002:aa7:d58b:: with SMTP id r11mr2741013edq.241.1612208478309;
        Mon, 01 Feb 2021 11:41:18 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id du6sm6702799ejc.78.2021.02.01.11.41.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:41:17 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] dt-bindings: usb: dwc3: add description for rk3328
Date:   Mon,  1 Feb 2021 20:41:02 +0100
Message-Id: <20210201194105.32673-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201194105.32673-1-jbx6244@gmail.com>
References: <20210201194105.32673-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for "rockchip,rk3328-dwc3".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 681086fa6..f4de1b2ee 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -12,9 +12,11 @@ maintainers:
 properties:
   compatible:
     enum:
+      - rockchip,rk3328-dwc3
       - rockchip,rk3399-dwc3
 
   clocks:
+    minItems: 3
     items:
       - description:
           Controller reference clock, must to be 24 MHz
@@ -31,6 +33,7 @@ properties:
           Controller grf clock
 
   clock-names:
+    minItems: 3
     items:
       - const: ref_clk
       - const: suspend_clk
-- 
2.11.0

