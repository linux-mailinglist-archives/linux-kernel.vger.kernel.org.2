Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21127362CA5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 03:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbhDQBMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 21:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhDQBL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 21:11:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8C2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s14so10056628pjl.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 18:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpFNR7GakxyWW4TgxZZHx0a179MD/+kz0HEu0bWO0a8=;
        b=Po04f5sBLq7CyI8NVDbw/oRJPwJrkwmlN5bP8ByR58YDJv+L9Grp4W25XVsVqoX50U
         VAfoQJEiLxxgSS6cIDQv3YuoH2WxogF9nVU7CRgkamzQj1t7F7C1M5UWw+55cn3fLuQT
         BOgHL49GK0Zg7IzYDsct+zh1egbo8TNUa+3Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpFNR7GakxyWW4TgxZZHx0a179MD/+kz0HEu0bWO0a8=;
        b=s1VDw2LCycyWu/bQ7FNzzMZo5jTprtx0OeBX2+cASpBqFu830f9qPo9dq3OttiM5u8
         XX5sKbaLmKxMTl1mPMs0ddaBeUn+Emqyp5wBCkI1Apoy+iKcy2TnL25bCkUzQAnqFVDa
         zvWXOEw2n2+t2XqWNLqr+svDGljm2g1gGr1tfbz5mwNveDeIt6eJ0OYikK0eicKPv5b4
         8gXAr/vDyC9RZ6+hcjpKJpRNk6h1JvXjsufr7EInx6ZVmQWlAavpQ4unz0TCmnGTI1Ai
         pkz+06sZm4qWllcJO6CBbymAUL4g7qnKgq7WI2sF8pfy2x3wt61VM1Ezu5fIGHnVGrjq
         5SUg==
X-Gm-Message-State: AOAM533Mjj9XHR1TFT8y+ULzu+/jZ3AF2APdv7FtL4o0rUjJRboA46Mf
        SH70RFOwWgpXdQBAkP5iluB9Mg==
X-Google-Smtp-Source: ABdhPJzbgyZPwNL7XTnTWHarGeS8Luqog9MeO9ogPU0obIFCDGmVAGgPhcXB6udRhP8Z5OWNJLE7Dg==
X-Received: by 2002:a17:90a:64c9:: with SMTP id i9mr12919746pjm.213.1618621892443;
        Fri, 16 Apr 2021 18:11:32 -0700 (PDT)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id x17sm2181515pjr.0.2021.04.16.18.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 18:11:32 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, olof@lixom.net, arnd@kernel.org
Cc:     w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add vendor prefix for M5Stack
Date:   Sat, 17 Apr 2021 10:10:13 +0900
Message-Id: <20210417011015.2105280-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210417011015.2105280-1-daniel@0x0f.com>
References: <20210417011015.2105280-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M5Stack make various modules for STEM, Makers, IoT.
Their UnitV2 is based on a SigmaStar SSD202D SoC which
we already have some minimal support for so add a
prefix in preparation for UnitV2 board support.

Link: https://m5stack.com/
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index f6064d84a424..7129fe3b9144 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -651,6 +651,8 @@ patternProperties:
     description: Liebherr-Werk Nenzing GmbH
   "^lxa,.*":
     description: Linux Automation GmbH
+  "^m5stack,.*":
+    description: M5Stack
   "^macnica,.*":
     description: Macnica Americas
   "^mantix,.*":
-- 
2.31.0

