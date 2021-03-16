Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3433DAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239200AbhCPRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbhCPRUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:20:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B76C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:20:09 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b16so9726737eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q74AX0QnK4NC30b7gSbyPRDDArNdJnxnI9fR+sxn8Wc=;
        b=kHycY2ZeIVZcPCWDGTautfwMn/wVLM4S4eYfXtlgu2pPkPoGb/Jk3kU8APco6aMvLS
         oHbtplUmsqRY/tOh6WP7sOfVcOS6kIL4kLQV79nJHEHeEzEORRQ/nqfRW9LDcnvBIbCu
         rmjrTptM0xo6RdEb+ZbksZ7s2DadKSLz7RvP0SjUS/YifwbuQoyOmMMDj9Ot5V+8syIV
         6K60iPzigZ1bNhjKlEXibrjm+mwO/LRdy/hW1cLheyAezCF2OoMXaYyKEIu5WbaK9z5K
         tZ3l380aBFICyb6Cg0hf6UKu8qkFrxSzfZhyw1EaeeGYBQoZcrVyhmuQIQOwqkl4d0RZ
         9G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q74AX0QnK4NC30b7gSbyPRDDArNdJnxnI9fR+sxn8Wc=;
        b=MnplGgHZzmYZwm1RVLc71FFJHDqWkn/81GqnEjq/6euk8MvYZqmYHZQNB6tT+ld+Fa
         OaMzZ1La5zRoE2rQQl2pelHUAuwT61uhP2c5KdeRsk2v1a9UvC7i3/Fy8CUzzNu/IXl0
         k76K9h1DbwuJCizCobrMytZc0UrudO//hiJlyMDC133PumLbb4DDnfcKDf6Q3oQb55RP
         Z2zQLlf1DpOImqgwXHuuXcJlbuOb+mpshuW5fAGeIQzHylwDHCnG4ThAu+cXlSttdIv8
         RPA0w6n45rhQxffG72NDNwMuh4mVwHC8wvX0t5hzxibOdRdgkxVPuXmqsCmvJHbS4sUe
         Mdzw==
X-Gm-Message-State: AOAM531yQpjHjIMpARkFMPj9fUGKSOcIall1d3UYk5wSjD+fme8idk0Q
        n2+zSEv0kXh60VSrWbDS9z1Z5w==
X-Google-Smtp-Source: ABdhPJw6JzJxieBA+RSf4i7D/bkK1q33QmHwm93GLxjeVBCpbCFPFOOnVMcdvTdLCykI/0ziWgHDqQ==
X-Received: by 2002:aa7:c353:: with SMTP id j19mr37063475edr.263.1615915208480;
        Tue, 16 Mar 2021 10:20:08 -0700 (PDT)
Received: from localhost.localdomain ([37.120.1.234])
        by smtp.gmail.com with ESMTPSA id u1sm10571584edv.90.2021.03.16.10.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:20:08 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, mchehab@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@somainline.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
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
Subject: [PATCH v9 02/22] media: camss: Fix vfe_isr comment typo
Date:   Tue, 16 Mar 2021 18:19:11 +0100
Message-Id: <20210316171931.812748-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210316171931.812748-1-robert.foss@linaro.org>
References: <20210316171931.812748-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment refers to ISPIF, but this is incorrect. Only
the VFE interrupts are handled by this function.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---


Changes since v1:
 - Bjorn: Add r-b



 drivers/media/platform/qcom/camss/camss-vfe-4-1.c | 2 +-
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index 174a36be6f5d..a1b56b89130d 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -922,7 +922,7 @@ static void vfe_violation_read(struct vfe_device *vfe)
 }
 
 /*
- * vfe_isr - ISPIF module interrupt handler
+ * vfe_isr - VFE module interrupt handler
  * @irq: Interrupt line
  * @dev: VFE device
  *
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index b5704a2f119b..84c33b8f9fe3 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -1055,7 +1055,7 @@ static void vfe_violation_read(struct vfe_device *vfe)
 }
 
 /*
- * vfe_isr - ISPIF module interrupt handler
+ * vfe_isr - VFE module interrupt handler
  * @irq: Interrupt line
  * @dev: VFE device
  *
-- 
2.27.0

