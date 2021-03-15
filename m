Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C892D33C0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhCOQAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhCOQAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:00:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:00:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y6so17912541eds.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8G+ZMr9j2FN56LuTLUOEMncw3y0hwCnmAUfBw5wAtUk=;
        b=ZrcwjVJi1vggBgAijXS7fWzogqwPZmhxk++3O5LC6YHfIQC5fmWlzXsItY8kIN8+Ou
         7ZcXySy3ZDXD8xZKyeblcsI6hCfRleS1AnuyC9aAijXHAUZgPYFBzlIkdp/PvW6a/QHD
         fPJRGm86o5mwbt+302ZF84Y/KbXI3A4IbmebPuZb3elFr06feJ2FrWdnLHCUegQ1CWZF
         IZ/HZU4Ov1X1w8ezhnmJRHhmom4g3jOFON6waUncjoO1MQQbxQiX+Fw5J/r0W+w80fvt
         QMyKxLuQYgGz3P4l5udx7c2oYPVUEgAJNTFRarxg/GbOYROMOZqkBqtoCYk6irURAMDF
         s2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8G+ZMr9j2FN56LuTLUOEMncw3y0hwCnmAUfBw5wAtUk=;
        b=SLrsl4A3o7ZbGlZNv5qA7xiVAwAjMKpHoJ6yaOv6VL/vE2IDpoUN8kibXnSWkBrsCr
         qyRqGBUA4vUP/f7b7NF/c0zwIB4qt5/Bxsjk0xvQzWF8MT5CLyRjVv9GXIPF7UNlLXd2
         ulyWg+uf1GiF+lkxlbEqIrFF6GmWx6vJcjq9n7E+YQZR2T48fuwds9KEhFuuifuYXJM+
         ktOi5ftrQ78uNZPOtVHERgiNsq6ZmfFYhwM89jD/3XXwH2ZSMhltPMkN5QEDEqTwfSoY
         I781hyVREQv/qfboGFvESixJUxyMf5A7wXcZLNyett3tLNomis9ClFj5yvZfmyalfTe4
         FmbQ==
X-Gm-Message-State: AOAM533zZfX5nwI9MH+TL2tMBXX+3Ks3IEm9euwhKieSVNpbD/Kdrr3Y
        a5106FH9LlYbTwIkvqMuwD/thg==
X-Google-Smtp-Source: ABdhPJz42+lxI2nJbwkATPMxbWO08P0hBO6V4zUWE+szxyjhjLd5DyEDE+xH7b2TDQZF9vMnOJ7Onw==
X-Received: by 2002:a05:6402:270e:: with SMTP id y14mr30808206edd.283.1615824017570;
        Mon, 15 Mar 2021 09:00:17 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id r5sm8456445eds.49.2021.03.15.09.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:00:17 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v8 04/22] media: camss: Add CAMSS_845 camss version
Date:   Mon, 15 Mar 2021 16:59:25 +0100
Message-Id: <20210315155942.640889-5-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210315155942.640889-1-robert.foss@linaro.org>
References: <20210315155942.640889-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum representing the SDM845 SOC, which incorporates version
170 of the Titan architecture ISP.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---


Changes since v5:
 - Andrey: Add r-b


 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index e29466d07ad2..63b35ea2ca36 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -66,6 +66,7 @@ enum camss_version {
 	CAMSS_8x16,
 	CAMSS_8x96,
 	CAMSS_660,
+	CAMSS_845,
 };
 
 struct camss {
-- 
2.27.0

