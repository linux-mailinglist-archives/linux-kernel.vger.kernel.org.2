Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DAC30B034
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhBATRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhBATRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:17:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ACBC06174A;
        Mon,  1 Feb 2021 11:16:28 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d2so20222036edz.3;
        Mon, 01 Feb 2021 11:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqBtzEvAwNKiwVYCrfCe2jfiFhnACOLKHc4Xbe7Gosc=;
        b=bu0rVoGPSwSKExLTfSmlVAFVBon/9mJZ7UwTGVjSDFyIZC1Q9sOh1PCOruOo5BG/y6
         i157uaUV5mLEx1wN/ruIZrAF+wVDGQ6gr/+MlZXKzPyuMklxMGiO0hKJWI36QLwjI7sM
         VLSl7AIqtQDETSW63vbUKPHvbODxhj+d0wBu3NSmMpRi5p4DBxiJHLjdktWAtz4X6nKA
         JmjSEP085O/JfsV7OE1CSo7IwVHXv9Vi8JiDvinw9pfzJcETiKv9U8UIyT7rTgVBVkzQ
         oEUEReoUzz8zbAC9I+C6sb/f3YxBvdzgOm0SYZgnNb1cNauDaMRbEXZIuPKJ2WKk3uzo
         0iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqBtzEvAwNKiwVYCrfCe2jfiFhnACOLKHc4Xbe7Gosc=;
        b=eTRlwWhLaAi748lafuAB8LOV+MMh+f9L0UfH7O41qqsBjRgRC3j7SM//IsMdOvBAo8
         0c47TwOcdZIhkg9oLmpoosQCiJTSq5dqauzM0weNTnAGCmnpaKbgTtFPD86ynGyICk32
         NMP7pvUi9dIjzzCRWzJPFamX1qXYVMvlwe1KwhMnO9oG+jhVZTLmrbTseGln7j9qk0Ju
         EQSKUtee+Sth1+yHWTsTo1zdqq9PSpRb8A6G9totH7l3zsLQYuncTZi4hu2fhLndvwVI
         otnp+zJgkFI91VDpaQ38hrC/lP3q4Bw9prpNDJLygdLIENYgZ1dS5p3bgCH/4AH8tG4U
         /MLw==
X-Gm-Message-State: AOAM533FWsG4tKRRjNa1wjekllK0zXNzwv5vai047RR3A67O8Z0o28Jb
        AY8A/ufb2V0VWpVxX1IvGqU=
X-Google-Smtp-Source: ABdhPJxbs+Ym2jropyx6K/9LFLbzxazDYZZ9G9xEJkeCoz0DjuuSKuYOZUBM+SWujJoSxaiN8wV8hw==
X-Received: by 2002:a50:e80d:: with SMTP id e13mr6226103edn.251.1612206987670;
        Mon, 01 Feb 2021 11:16:27 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a11sm8243630ejc.64.2021.02.01.11.16.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 11:16:27 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] dt-bindings: usb: dwc3: add description for rk3328
Date:   Mon,  1 Feb 2021 20:16:16 +0100
Message-Id: <20210201191619.32353-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210201191619.32353-1-jbx6244@gmail.com>
References: <20210201191619.32353-1-jbx6244@gmail.com>
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

