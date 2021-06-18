Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D62B3AD3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhFRU57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbhFRU5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:57:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5AEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j18so6219865wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nu7i7hLOMrckKPqlCt5sNsYJcGzmceqdUWEuYkCyCyg=;
        b=HVFgLbvqQNXI6qA1sE6VpDEA4GddUHSB6CrLP4qKefQQSXz7W0Ds60omAmp8dIYzWd
         RtyqIEQ2vGMs49bTn+D+djIxm1wpBVX8S1g3HxRCh4Q4y0Fo/4+mS13GxyqbjGdNV45k
         ZDr80L0ZCnDnnGgMclEu8CzEQPo00f/Lgpn/tYLCML8HoMtdqlD+rQsWjGjTj3stoIga
         +TlDXRJhI79hfWcmRVS41GOl0fnRkmCijWNQatXqHszA8Cu8elI2MiwVGlX1xk7uiTaU
         BzANaHT9jvyKszDwr7pPGlKqdtGezM5AJg99C/Hft/5I/NkF1o2vs3+T3k67Ijh8w6nW
         X4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nu7i7hLOMrckKPqlCt5sNsYJcGzmceqdUWEuYkCyCyg=;
        b=TGG5dse0iVzc78FBavnG7D+vhIAFzqBi+6T5/ul6KX6plZjiF4IC7z2r1acn9NpVmX
         q+NM2uzQG9c3f8Me8huCMMnlfC7UQcqsiNWeosswSfzEFHBXYNA7/SsVa4LsJX4+e28y
         CGPzVvcWByrqDF9eFhNTB5j57F3+9t8/RKhMv6FnBCB255HF+2LQ6o9OlLGp1pYEhO96
         mvzwm8bsc2Qdnjx0gAN8ku3naBfWiKjuHoLWlbA+EmJMhmOu19pimUCmtvkurexyJCka
         9VEDeQRA/7H5PqE/36F+/liSNgmKU01XtoGfyyBGyGxOvQPDA2O2IneIZ9sdXA9Dx6WY
         +ycA==
X-Gm-Message-State: AOAM530GQourJuaKcUGy7AcwPFBgv/tjvjADEFxtTXPS+v2jhEdUSSEC
        rB5IvzKPyu8L2I/yevGtlXYTGQ==
X-Google-Smtp-Source: ABdhPJyUSyW4TuFB1EWQs4HKnLWcAB4ImpT6brXRKzrXolm5W20JLasuhMVSS3TqF2YW4sXrOe3zeQ==
X-Received: by 2002:a05:600c:282:: with SMTP id 2mr13775691wmk.98.1624049742338;
        Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm9745476wrt.69.2021.06.18.13.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/5] dt-bindings: add vendor prefix for edimax
Date:   Fri, 18 Jun 2021 20:55:30 +0000
Message-Id: <20210618205533.1527384-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618205533.1527384-1-clabbe@baylibre.com>
References: <20210618205533.1527384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for EDIMAX Technology Co., Ltd (https://www.edimax.com/)

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed1769310f0d..800d0536be75 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -333,6 +333,8 @@ patternProperties:
     description: EBV Elektronik
   "^eckelmann,.*":
     description: Eckelmann AG
+  "^edimax,.*":
+    description: EDIMAX Technology Co., Ltd
   "^edt,.*":
     description: Emerging Display Technologies
   "^eeti,.*":
-- 
2.31.1

