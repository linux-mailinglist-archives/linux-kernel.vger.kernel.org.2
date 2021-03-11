Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B01337BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCKSKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCKSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:10:01 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809FEC061763
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:10:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id mm21so48079811ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfcdS0huGYBFauDoZapDpV12oshuFzeyuB4yCyBnMLQ=;
        b=ydIMlSNT7f30UN/TTjCPavpqxIDelgxtq3P9yAlxTrbFMpWeJDvGahPFj87qJc47Lk
         hnqXeX117+jSwo8lMEVdFTYS5xUvhFfhwoBIWZAxeLb/8ZmvGKRj0EAxYzgzIHCJBiBS
         yEu1ZAjgwV+LT4tnn8irFGa9SVPnOQaIkz5qNq0qP8L4dE6LDzp6u7bK6kV3Mlnj9y9j
         81kfK4lgikbBz3Kl3UzVMrcz2pAj/vbGk3Aug18w64+y/XbfXmrP9pQr/QZrvaGsV6gj
         iKtRuz3FsSZPwDjsdWCIhOOHnbj13c4RlPkzB2/A9rxDjNpFcGzUyGnU8OvU9Qm8Qkt0
         UDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfcdS0huGYBFauDoZapDpV12oshuFzeyuB4yCyBnMLQ=;
        b=F6RSYub0pRAHAjh8P7NpyTTKxZMATQppmkTgjy2UWKIUW4YCcNayvQc9jr6EdEG4F3
         eQJeKH1YfSBHoOi2s2xHoIMKsEY6Z+IcorwMzDUbwbzn2SpVa9xtL3SxNpQe4RPPRDmN
         X0P0bN1EVi1IXwDR4UIjjLDHk/+JAZdkaOota5d7IsArS4OPmnMvq8HQKLaIrI7lP2xV
         3R7LS+o1/85yx381lPlCTch1muzSFNQCPync8Bxcl1T+43FFOUwX3GaY9QHyNZ+DbKNS
         5/SdTC8c4SCEohqiJqVWwuqUtG32y0T7BPQ+GXc2021k1vlR2meFFLMfx1VlyWLic97a
         zCZg==
X-Gm-Message-State: AOAM530b1f/DziW2rXQC/vquPbngnpZ+ogmLzX7mxf85EBA7dF+oPR3l
        8AJ0+X+RQhxaPIfAc9rOWIdvyQ==
X-Google-Smtp-Source: ABdhPJxczMFaJENfbxPAZ4jjiF0dAom6VDWrN5gcEjx7WdvfHE6cwU7dibV98WBNFdrAWpN1SK0Pxw==
X-Received: by 2002:a17:906:2551:: with SMTP id j17mr4282436ejb.441.1615486199236;
        Thu, 11 Mar 2021 10:09:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:2454:3e3:5f00:8e01:34c:da50:eb7e])
        by smtp.gmail.com with ESMTPSA id a22sm1741290ejr.89.2021.03.11.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 10:09:58 -0800 (PST)
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
Subject: [PATCH v7 01/22] media: camss: Fix vfe_isr_comp_done() documentation
Date:   Thu, 11 Mar 2021 19:09:27 +0100
Message-Id: <20210311180948.268343-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210311180948.268343-1-robert.foss@linaro.org>
References: <20210311180948.268343-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function name in comment is wrong, and was changed to be
the same as the actual function name.

The comment was changed to kerneldoc format.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Andrey Konovalov <andrey.konovalov@linaro.org>
---

Changes since v1:
 - Bjorn: Fix function doc name & use kerneldoc format

Changes since v5:
 - Nicolas: Fixed typo in commit message
 - Andrey: Added r-b


 drivers/media/platform/qcom/camss/camss-vfe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index b2c95b46ce66..f50e08c4fd11 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1076,8 +1076,8 @@ static void vfe_isr_wm_done(struct vfe_device *vfe, u8 wm)
 	spin_unlock_irqrestore(&vfe->output_lock, flags);
 }
 
-/*
- * vfe_isr_wm_done - Process composite image done interrupt
+/**
+ * vfe_isr_comp_done() - Process composite image done interrupt
  * @vfe: VFE Device
  * @comp: Composite image id
  */
-- 
2.27.0

