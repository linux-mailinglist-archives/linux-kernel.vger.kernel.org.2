Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA303A072C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 00:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbhFHWlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 18:41:05 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:33679 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbhFHWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 18:40:52 -0400
Received: by mail-qt1-f174.google.com with SMTP id e3so4948862qte.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 15:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3ZK6tm1P5krabHbpmSBHMbnkFWqAx9kN5/b3XPjOKg=;
        b=NqPm7TqbijVDkgRuQXoc5fYOUssLlZwiS0KacjYPXYq2g+AJEfnpm1VBbQxO7ChWnD
         0nrz56qzj7VB746EF8ihDdrk6sDkNrMABmRsymcvOsJpx6CV4xVAe7YCauw2U82ULC7K
         0AfDnjsqVWKp5jPlOjkjUH6IoXrTWzM0n5gRS8r4xk5PuTyYZg+XXT65LdK+A9aAwQSV
         sNGLOG//qjUdGzMTRmHFkj9GUb6YwiwocX96hVo6+sNmEa7NR1gXBSPg3SVkMwRpGNwV
         yOQ3/1e074rgjSKAvdbKZcDEDVpTVrNeofygDQkcZ1aWMay35e8aA4Mu5c+fHHwFttgW
         Hhwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3ZK6tm1P5krabHbpmSBHMbnkFWqAx9kN5/b3XPjOKg=;
        b=nViQUiQMsV2IAhmJ4SDejBYJ+qrBx6pF+cy8dF52QXiZLViilHAcBfj0GLkxaU3JtK
         rgfN6t7UmsPnfw1B1erDcchlHbRJ9y2Im7RXkSYTOjdSn0NmO0Js/XRn7615kFSXm7rN
         /rI8u6gJzPwGo2sEsGO/KIRwgJzLBU51Wg+Mwmv05FV2iRXqYf765VnoaT3TWZUdcqh6
         wALokWJzYGcjJ5S1cd5rEVlvBJb6y52wFuiNFlIPSruf14DFwwFzXre6ryGee1Z5Um0y
         cK79HtiWrEiQHJz1eZLzbBsKwREzhmHTzrzs61g4tvCezQ7ftY2dIlAqxekGnVc+V2as
         xNeQ==
X-Gm-Message-State: AOAM5306r+H7bJS7c+McvAiLBbS7DftP42Fz4qajx5vwb3EMwBz7ZXa/
        f+NRLeGLC1rCsmD+CFDmzS0LkA==
X-Google-Smtp-Source: ABdhPJwa2jZlve0GnDig3FLTCu8hwvY4Jr42GtEtOB+PC0Id/IXOIO+U6nEi4Cv/6rq9mHW6b64eBg==
X-Received: by 2002:ac8:7092:: with SMTP id y18mr23984864qto.2.1623191878941;
        Tue, 08 Jun 2021 15:37:58 -0700 (PDT)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id m3sm2324266qkh.135.2021.06.08.15.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 15:37:58 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     robert.foss@linaro.org, andrey.konovalov@linaro.org,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org (open list:QUALCOMM CAMERA SUBSYSTEM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 11/17] media: camss: fix VFE irq name
Date:   Tue,  8 Jun 2021 18:35:00 -0400
Message-Id: <20210608223513.23193-12-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210608223513.23193-1-jonathan@marek.ca>
References: <20210608223513.23193-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vfe->id isn't set yet, so use "id" instead here.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 15695fd466c4d..dec89079c6ae4 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1290,7 +1290,6 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 	case CAMSS_660:
 		vfe->ops = &vfe_ops_4_8;
 		break;
-
 	case CAMSS_845:
 		vfe->ops = &vfe_ops_170;
 		break;
@@ -1319,7 +1318,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
 
 	vfe->irq = r->start;
 	snprintf(vfe->irq_name, sizeof(vfe->irq_name), "%s_%s%d",
-		 dev_name(dev), MSM_VFE_NAME, vfe->id);
+		 dev_name(dev), MSM_VFE_NAME, id);
 	ret = devm_request_irq(dev, vfe->irq, vfe->ops->isr,
 			       IRQF_TRIGGER_RISING, vfe->irq_name, vfe);
 	if (ret < 0) {
-- 
2.26.1

