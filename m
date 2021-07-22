Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4963D1BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhGVCDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhGVCDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:03:37 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82927C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso4007568ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xKV8hlv55ixpHr/xWlsCOYWKdqHbAXYcZUW9Pc8iaEA=;
        b=IzorDbfi4J0yK4IdHULCR9qAHRjagqRlo6FFdpjHS7e93tP4y2cMxhtOq10k2Q6UeG
         iKYKYCdOeywdHLcHZxMvShzyMfyfyQqGP3Sbz+p9+G9DdXGxhbaU/HrLQTx96yIkSv3J
         FCyf3M+5Pz9QjvPfcF1ty/BbOKehfRG5cqA4/8KISGEr1xVXTNUIt+1lAskvVEvH9rx/
         A83k/59flfuGg7xGbZtupKhEiYBu298i9zP6i/xhN1JDUpqh7F7tQ2kPuQlc9I6uaV9I
         i4lfLaUL5LRwClSPU52CW4ZfwQ5bVw9IMwbzfa7UG9rMyHbSw81rWdYbByjVixj7oq4D
         s4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xKV8hlv55ixpHr/xWlsCOYWKdqHbAXYcZUW9Pc8iaEA=;
        b=htslwXzZ3fcSq+63Bo1CSwZa0g7KUmnVNWTDScWL4Ns2r3jweVLfA9w1CNnALV8LNw
         ZuTL1nMIJvmTnz/DAIgRriSCz188wE+q2tTlCHM68TQGfChuOJtBFWKlIfPJMpP0lp5o
         rNHUobOdVuHvThf1ZIlCplg1Fu71kPL1/oYVNcsy/WsLt2zLvsQC7U4G3QpvM+fnKxR+
         y+xuuENI2HKTlAMkmt1Y4GSADd+ZyPmSQQw0fCUuu5QHsLzLQea2pFF/2vfYLTYLdP4R
         QBFJqz9RHxPq4jMtVD/wrwKq9mR5Xg2CDYyuS58J5nt1cP1ECx2KouTY/JCpGTqO0cnr
         GbIA==
X-Gm-Message-State: AOAM531fOS9z+FqMaYSrfGbXRTd3nsH7yu3UnzD9Kn+nbdpFmQQuRcgr
        FlxMfrGhWtw4L5QvwLCcZB+MWA==
X-Google-Smtp-Source: ABdhPJzh1eqPt0fNok4t32PlvpdYBH5n9ebj7NHDBm2wEIBcrsZWeWlQRl5XwMN6ofEKXljlzL1Afw==
X-Received: by 2002:a05:6830:2786:: with SMTP id x6mr25286903otu.359.1626921852888;
        Wed, 21 Jul 2021 19:44:12 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm5346519oif.9.2021.07.21.19.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:44:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/msm/dp: Use devres for ioremap()
Date:   Wed, 21 Jul 2021 19:42:24 -0700
Message-Id: <20210722024227.3313096-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-devres version of ioremap is used, which requires manual
cleanup. But the code paths leading here is mixed with other devres
users, so rely on this for ioremap as well to simplify the code.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_parser.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 0519dd3ac3c3..c064ced78278 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -32,7 +32,7 @@ static int msm_dss_ioremap(struct platform_device *pdev,
 	}
 
 	io_data->len = (u32)resource_size(res);
-	io_data->base = ioremap(res->start, io_data->len);
+	io_data->base = devm_ioremap(&pdev->dev, res->start, io_data->len);
 	if (!io_data->base) {
 		DRM_ERROR("%pS->%s: ioremap failed\n",
 			__builtin_return_address(0), __func__);
@@ -42,22 +42,6 @@ static int msm_dss_ioremap(struct platform_device *pdev,
 	return 0;
 }
 
-static void msm_dss_iounmap(struct dss_io_data *io_data)
-{
-	if (io_data->base) {
-		iounmap(io_data->base);
-		io_data->base = NULL;
-	}
-	io_data->len = 0;
-}
-
-static void dp_parser_unmap_io_resources(struct dp_parser *parser)
-{
-	struct dp_io *io = &parser->io;
-
-	msm_dss_iounmap(&io->dp_controller);
-}
-
 static int dp_parser_ctrl_res(struct dp_parser *parser)
 {
 	int rc = 0;
@@ -67,19 +51,14 @@ static int dp_parser_ctrl_res(struct dp_parser *parser)
 	rc = msm_dss_ioremap(pdev, &io->dp_controller);
 	if (rc) {
 		DRM_ERROR("unable to remap dp io resources, rc=%d\n", rc);
-		goto err;
+		return rc;
 	}
 
 	io->phy = devm_phy_get(&pdev->dev, "dp");
-	if (IS_ERR(io->phy)) {
-		rc = PTR_ERR(io->phy);
-		goto err;
-	}
+	if (IS_ERR(io->phy))
+		return PTR_ERR(io->phy);
 
 	return 0;
-err:
-	dp_parser_unmap_io_resources(parser);
-	return rc;
 }
 
 static int dp_parser_misc(struct dp_parser *parser)
-- 
2.29.2

