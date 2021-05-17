Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC44383D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhEQTdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhEQTdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:33:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c14so5830110wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QYAhGHTcrzLvh1GZzozNj3ujeM2dW6tSmE2iihma+d8=;
        b=qTnHP7oK4UhH+1Xi16NmsUH5ieKLYYo6wTQJtL2qfKcXye1il5xay4sjiWOSZYnL4H
         FJaPZHygUv4HQgaOUgMmzge4z9aelCHvYnc4nHkONjQRdQgmxnwPo7T4VpWer3Oc5l8K
         ZPqMmrmuJiDUhMha24j6dkEvGziWRUuAJJI1Ccbn083k7g2ciiB7RBRHj6yEwXECfq2e
         LM7uVr9MJBmYAOkGWeMqEh3bCGgBdZsesAmru4Qar3dsGcgnyanpNZ+oHrQLjhMk7uea
         M0woTdyU+o9UvLyMUgms4YAhJ7iQTOtbHGgLafLhZRmMSIrga7zrFUtpbpLXy0LXEImX
         QQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYAhGHTcrzLvh1GZzozNj3ujeM2dW6tSmE2iihma+d8=;
        b=EzzaFZg7QG9hsRHk7ez2BXx6QTeuU7hkqwz6qELJROi22soE43i2BXJPu9Nx+MMzh9
         /A01pQZjSXztGp+XB5pLMP8QdxVkq6GtGmnNzhSK4G7L6ma/EBp8oLf9y3mKv/cXiyks
         e+0lzaPuwVCs0svZzMAhsXYeVEizqXlUfnkh9BFPjY3XW4NZdqmHyLd38CqKKGmwsH1T
         sSsyFsSL/TOVaEt9CsYOmcYtoiH8BfvwP6frrj8F9qpirulN/KSucESnuEV/INHVxUVz
         PUvd+5VKXXe91eeXDnmdsPlKJVutPuwplFRB7xfG60rbsSKy+VLmGJn6zQ6AHnd1sSei
         dRVQ==
X-Gm-Message-State: AOAM530Mu/a5EOZMPIDDlWwrLudkao82Dih/odmDIQcbMBD/Vvi5gJBC
        +k7nkYNGUSeCaHb03/EMMq8VVg==
X-Google-Smtp-Source: ABdhPJzwfsiOYNUSQ5COtoFgPLUXMY8sYNlATGSr/Q/cSZg92rBtQr8f4YWeCUtWRIJT+8Bln1VMzQ==
X-Received: by 2002:adf:cf09:: with SMTP id o9mr1552357wrj.334.1621279939607;
        Mon, 17 May 2021 12:32:19 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e10sm18928907wrw.20.2021.05.17.12.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:32:19 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, olof@lixom.net,
        robh+dt@kernel.org, soc@kernel.org, ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/5] dt-bindings: add vendor prefix for ssi
Date:   Mon, 17 May 2021 19:32:03 +0000
Message-Id: <20210517193205.691147-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193205.691147-1-clabbe@baylibre.com>
References: <20210517193205.691147-1-clabbe@baylibre.com>
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
index 003f6354db04..828ddf7fdbed 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1084,6 +1084,8 @@ patternProperties:
     description: Spansion Inc.
   "^sprd,.*":
     description: Spreadtrum Communications Inc.
+  "^ssi,.*":
+    description: SSI Computer Corp
   "^sst,.*":
     description: Silicon Storage Technology, Inc.
   "^sstar,.*":
-- 
2.26.3

