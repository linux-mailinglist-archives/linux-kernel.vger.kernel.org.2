Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A80379E56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhEKEWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKEWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:22:07 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319FBC061761
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:21:01 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso16450138otm.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 21:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgZFlNZfz9EYfzeQvg8JR3pWaua7Txo/La4Xs65mV68=;
        b=e8cVwtdfQWxKumLU3L2sPcRRE88YwVxhHXUc4c3k7eqlRl0thGjwpqhW1we3uS9N7y
         nZ7umVU/j0VZplwCYa/Y2FS57EbEdKIWHRFcrctPTRdENRXjLBtk5jvAsErUM4Ho5QW7
         NPOh4vQUr10l2STyNoCrunsl92Yy6+WF4CfvrgMzXgLUKK2Z2GzHpAK2+BS3z3DuAPG2
         JDfFgYrw6md2QGmT7Ay26TE4qMmGL0eDzqR6x9BTLl+9VBzFE06GX0GTBMf1gMhEEXIt
         DO95hXL2HCB+vHI2f17IgDu6Fw2DtW4stke/2LQGfrnnDdy1i+fR8GWOzw6KU/7wwgti
         0rOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgZFlNZfz9EYfzeQvg8JR3pWaua7Txo/La4Xs65mV68=;
        b=E7Sm249lDHad01hD1hRuGAF8xeSLxSPM1oQ5VSg+qDtW7a5vnSpC+/WgwOqTUVz7TB
         MhBzxKgUAFXce/EJpm/w2W7AAyxOdwEcpOGYzQ9wOdC4Jfpice6+HCfY7CONAJ9Uklgi
         yL/88QDquVsQ7AqkVufJ/Kjox9m0+BCN8ouSTiLiasent3vnvFpTuP6wnc19z2RRjS+E
         eRrWcgqajNgh3LG05jN7nw8/AMFJ/pH5+CgWr5Yd2ACf6UHVTsedKdg8lyJ8lT+5sdsg
         6H7UbTOgW49kSFShlBOg/xLSVguS+h10Fw4zVaqmu3orS5gvuxJzhFjFMoG+Fw0VvRpj
         sNOw==
X-Gm-Message-State: AOAM531CgglHQ5QoOG3sOQ2ViaK7h8mWQuO0vR0qcFftpQceLHgeimnA
        iE9RSDvdIdOunCRAhNyVts8aPw==
X-Google-Smtp-Source: ABdhPJzYz3q7MFfxjCEI/JfYmH/AhONwg4lawUVkKe8sdMsBhbmNaRZcIRoAXDSU/Esv/aaFXnMEug==
X-Received: by 2002:a05:6830:70d:: with SMTP id y13mr3221908ots.191.1620706860591;
        Mon, 10 May 2021 21:21:00 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:e623:42c1:10df:adff:fec2:f1d])
        by smtp.gmail.com with ESMTPSA id r124sm3042294oig.38.2021.05.10.21.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 21:21:00 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>, sbillaka@codeaurora.org
Cc:     Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/msm/dp: Add support for SC8180x eDP
Date:   Mon, 10 May 2021 23:20:43 -0500
Message-Id: <20210511042043.592802-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511042043.592802-1-bjorn.andersson@linaro.org>
References: <20210511042043.592802-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The eDP controller found in SC8180x is at large compatible with the
current implementation, but has its register blocks at slightly
different offsets.

Add the compatible and the new register layout.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  1 +
 drivers/gpu/drm/msm/dp/dp_parser.c  | 28 ++++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d1319b58e901..0be03bdc882c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -121,6 +121,7 @@ struct dp_display_private {
 
 static const struct of_device_id dp_dt_match[] = {
 	{.compatible = "qcom,sc7180-dp"},
+	{ .compatible = "qcom,sc8180x-edp" },
 	{}
 };
 
diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c b/drivers/gpu/drm/msm/dp/dp_parser.c
index 51ec85b4803b..47cf18bba4b2 100644
--- a/drivers/gpu/drm/msm/dp/dp_parser.c
+++ b/drivers/gpu/drm/msm/dp/dp_parser.c
@@ -251,6 +251,7 @@ static int dp_parser_clock(struct dp_parser *parser)
 static int dp_parser_parse(struct dp_parser *parser)
 {
 	struct dss_io_data *io = &parser->io.dp_controller;
+	struct device *dev = &parser->pdev->dev;
 	int rc = 0;
 
 	if (!parser) {
@@ -276,14 +277,25 @@ static int dp_parser_parse(struct dp_parser *parser)
 	 */
 	parser->regulator_cfg = &sdm845_dp_reg_cfg;
 
-	io->ahb = io->base + 0x0;
-	io->ahb_len = 0x200;
-	io->aux = io->base + 0x200;
-	io->aux_len = 0x200;
-	io->link = io->base + 0x400;
-	io->link_len = 0x600;
-	io->p0 = io->base + 0x1000;
-	io->p0_len = 0x400;
+	if (of_device_is_compatible(dev->of_node, "qcom,sc8180x-edp")) {
+		io->ahb = io->base + 0x0;
+		io->ahb_len = 0x200;
+		io->aux = io->base + 0x200;
+		io->aux_len = 0x200;
+		io->link = io->base + 0x400;
+		io->link_len = 0x600;
+		io->p0 = io->base + 0xa00;
+		io->p0_len = 0x400;
+	} else {
+		io->ahb = io->base + 0x0;
+		io->ahb_len = 0x200;
+		io->aux = io->base + 0x200;
+		io->aux_len = 0x200;
+		io->link = io->base + 0x400;
+		io->link_len = 0x600;
+		io->p0 = io->base + 0x1000;
+		io->p0_len = 0x400;
+	}
 
 	return 0;
 }
-- 
2.29.2

