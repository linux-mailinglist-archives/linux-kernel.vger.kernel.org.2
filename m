Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9F3CC142
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 06:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhGQFAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 01:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhGQE7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 00:59:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E68C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:56:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id i16-20020a17090acf90b02901736d9d2218so8271209pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8e6XlbKC+KjOCVkxo+Eb2tDouy+mshYsdsUVUAEu5P0=;
        b=gTkFAmbiJ1QVkJ2Vm7kvTo2ZOBk4PVmQMN6bdqkEpl5SDEB0Nw/ioy0AzHHOiyzU+/
         S9R/X+DOAAl1hiTV0UvPhv1kCGUAt+ZNLQdKGk8zt93hzzuVM8eV9B5dOt+infBlHK+Q
         KkEFLJv29N2/Zm7Db64oozASkYgNlD5DaWdG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e6XlbKC+KjOCVkxo+Eb2tDouy+mshYsdsUVUAEu5P0=;
        b=gd0KdVdhhvCN7QfXORLFiIhMrifcy3iF1of+c9SOv+i4Ri4UT2DyPTNDE121DteVaC
         w5xkqH3zhRGyR4I9Y03PS3prHQLbZUScFUsPdqe5YezT7w2VsjHh+dDUQSIe0ku2HM6H
         CX5Jux7rJxmk33YT/eI2/U/6BcNbt3O97K6HBo0nq65XQGbbjW3cDPz/dhwZC0E1WE0z
         5yWE8bxit9+n0nX7vwKI4Ahk9Psulf4hmIeyCSoKTC8Iv9E1Y3Cw4QjJKAyk+jRXM9KF
         3iFrSsvu5ufCljxSU0A5Y+we7+4Rm+G9HNMU3BlIzcFY0TfKo2OAxGkLwLnkadOEvxmX
         04FQ==
X-Gm-Message-State: AOAM531SHzqjZ4rqG0pVBkuOGHrsku7twuvdkAEdchkHBMY/F7Jy7R+e
        qsASYl/35ejVCAoTGT8Hmn3ijw==
X-Google-Smtp-Source: ABdhPJwoR0Fkmo9Na2dM1/fOXvJF37GjeGKSSmFizRu+R+7y+/7jIjcFbBQCYikme7Ht5nSy9ZLaWg==
X-Received: by 2002:a17:90a:1d43:: with SMTP id u3mr19190689pju.121.1626497804165;
        Fri, 16 Jul 2021 21:56:44 -0700 (PDT)
Received: from shiro.work (p866038-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.60.38])
        by smtp.googlemail.com with ESMTPSA id w2sm12522885pjf.2.2021.07.16.21.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 21:56:43 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, romain.perier@gmail.com,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 01/10] dt-bindings: gpio: msc313: Add compatible for ssd20xd
Date:   Sat, 17 Jul 2021 13:56:18 +0900
Message-Id: <20210717045627.1739959-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210717045627.1739959-1-daniel@0x0f.com>
References: <20210717045627.1739959-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for "ssd20xd" for the SigmaStar SSD201
and SSD202D chips. These chips are the same die with different
memory bonded so they don't need their own strings.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
index fe1e1c63ffe3..18fe90387b87 100644
--- a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
@@ -14,7 +14,9 @@ properties:
     pattern: "^gpio@[0-9a-f]+$"
 
   compatible:
-    const: mstar,msc313-gpio
+    enum:
+      - mstar,msc313-gpio
+      - sstar,ssd20xd-gpio
 
   reg:
     maxItems: 1
-- 
2.32.0

