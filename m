Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF513AD3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbhFRU6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbhFRU56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:57:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B0C061767
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r9so12098038wrz.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRLam3ZYflZLVyyutvsIpS6o5/Y7d41E9E4JTAN/wTs=;
        b=gWB6youcrGgkWbJ8AIjkohQ82VUYjFUB3tVCiTMNnPvJVfqZnUw8Zf+NjBvaek04OF
         DaMAja3dMKukQuasVORhFiIRkDUkoXk8la/p2H/rsZQ29LK6lXmene7qa4WP5e4kyw47
         uFgYSvv3zqaqnMhwvdASbSSgYpNLQMHqxl0r5NUPezi9AkJabcDLsgYgT6xauMJCHiw1
         gNRcbeT3GW+4BI/c89H4gjNnpVr0l2C6vg/JVlzEXLL8PwsE2xemRvmm6GO5uRsBpopr
         YlWb4l4Av9h7kKCQqT/gJWq3v7vWGE7gyolC5MzSylgZYAN/UcOZGQ7ErFkOOnCBIwCb
         H8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRLam3ZYflZLVyyutvsIpS6o5/Y7d41E9E4JTAN/wTs=;
        b=SUL53OGm+mWmT3Z+Pq3JRqKx5+P2ucF7Gq61NSJo8kn67jgSB9VTe26vMwqozVmNrU
         72hqPLoTrbIRQ5+1sFAPrsXTOUAmHBivuQHohRJ157WBJzmt3nwLWYyMFgzewVFwgQEa
         RV6LJja2w7SCpg4gsTY4QE7rQ5W5+y7FGD0zdFvCtWSisNyltzZc68DsVPfn0R71CyuK
         pUUZNj6JeJzelKZxXlZIxmCM6y/eWyZogoGCBnsES8IiE12zDu+X/Xw+lKQjY8I7K30j
         jkjeyWW2nxGM1bBmwOJv5aVXtkUXBpTb0QRR6uWv5Wv15bwTZ6a+LEdfhZZwYCsU5ykL
         Ydgg==
X-Gm-Message-State: AOAM532tt8EI/lNGjTfHu+jQBghowyQuBcMlpyPDpghhiE3rIJEVcs17
        ESdh3ByDXLNlIS/y2X2TFffWxg==
X-Google-Smtp-Source: ABdhPJwddHi1wiHWVq/27aORb5P87HAYyN2nQPoE9B42oXNCu4EJgWhDBuV2lIRN+TzjLsnmLMLY8A==
X-Received: by 2002:adf:d229:: with SMTP id k9mr14670400wrh.245.1624049743172;
        Fri, 18 Jun 2021 13:55:43 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j12sm9745476wrt.69.2021.06.18.13.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:55:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/5] dt-bindings: add vendor prefix for ssi
Date:   Fri, 18 Jun 2021 20:55:31 +0000
Message-Id: <20210618205533.1527384-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618205533.1527384-1-clabbe@baylibre.com>
References: <20210618205533.1527384-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for SSI Computer Corp (https://www.ssi.com.tw/)

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 800d0536be75..6d70d6ba60a0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1090,6 +1090,8 @@ patternProperties:
     description: Spansion Inc.
   "^sprd,.*":
     description: Spreadtrum Communications Inc.
+  "^ssi,.*":
+    description: SSI Computer Corp
   "^sst,.*":
     description: Silicon Storage Technology, Inc.
   "^sstar,.*":
-- 
2.31.1

