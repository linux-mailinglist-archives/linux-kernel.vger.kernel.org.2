Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E674301FE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244191AbhJPKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244127AbhJPKYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:24:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA22C061767
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 03:22:41 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ec8so48453578edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UpaN0+D4v6gZi4C1AIXdRvIf3e9k8TCo9M0Z0xiwZZA=;
        b=bVpdXZI2t1pu8Dq2bx9BYsDi8Jaxe8gZVC1bkUVLKjO3ibe87Ybbg1ab+UgLVeXDKb
         m7x45p0HDGuJDf0Dot9aQUuvAnr9q6DMYNrpiiE28WBMTzz7Cmre21wxkaJ8clgPhGeW
         nbd6brzazC4OFiSA9wHzwi0YsAqXfUKfE8qz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UpaN0+D4v6gZi4C1AIXdRvIf3e9k8TCo9M0Z0xiwZZA=;
        b=Z43rbYT5h0iSh45NYtj39BhXZggDFpxMabXLqBURdIyQSrVlwQB8FqeiwNvLc5q/Ma
         XUDiA1v8ATRqfwg+dDjr5vw+18uWc0U01KuNUojpm0rnTcHg3FFAZwI9BmtXDdEF28VP
         H4T7B4YznWE1mP2yxsRDOA4X3UTkoicl9YY0RfYzcXh5aWjpFMisIJ+nWLM+y0KzAnKW
         3e0T3XyMdnsMcw4fWVU3Hh6ysf+vPu+xgSVYioZClFr5/i/+nkb0E+w34O4yo1rAxBrN
         xB3aGF9bTdWKUWbsILBIBrEpj2xI/aCA5q/6na8vI1usRmw5P7/Xj1rsRFMcKEjnfzFS
         y49Q==
X-Gm-Message-State: AOAM5315jXaCAkTvxtwYatiwEblQ2ltzclthdhX7V3k3xTkDxcoeQzWW
        UNnS9OikQb8jGnlHikz5F4PmnA==
X-Google-Smtp-Source: ABdhPJwwaHJDJm9L+CJNdyZDd6ge+ozPrl5Qg+7itKwaQX0evzlEbxXfMHGOf3U9R8mm0BMJs1HoAw==
X-Received: by 2002:a17:906:838c:: with SMTP id p12mr13237355ejx.181.1634379760431;
        Sat, 16 Oct 2021 03:22:40 -0700 (PDT)
Received: from panicking.lan (93-46-124-24.ip107.fastwebnet.it. [93.46.124.24])
        by smtp.gmail.com with ESMTPSA id la1sm6117361ejc.48.2021.10.16.03.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:22:39 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Cc:     devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/panel: ilitek-ili9881c: Make gpio-reset optional
Date:   Sat, 16 Oct 2021 10:22:31 +0000
Message-Id: <20211016102232.202119-5-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211016102232.202119-1-michael@amarulasolutions.com>
References: <20211016102232.202119-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends in how logic is connected to the board the gpio is
not stricly required.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml      | 1 -
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c                   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index 2d4a5643a785..07789d554889 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -27,7 +27,6 @@ required:
   - compatible
   - power-supply
   - reg
-  - reset-gpios
 
 additionalProperties: false
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index d1f20758ed08..103a16018975 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -883,7 +883,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->power);
 	}
 
-	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset)) {
 		dev_err(&dsi->dev, "Couldn't get our reset GPIO\n");
 		return PTR_ERR(ctx->reset);
-- 
2.25.1

