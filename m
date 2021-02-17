Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE331D832
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBQLZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 06:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhBQLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:23:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A71C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:22:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t11so1239324ejx.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 03:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oxEhFanRiIwaURE1Asj018eMvsFp7g2C+jPywv6JQCM=;
        b=qCnnaF2OLkh0pa1oFwRs9lNbWKszkZlb/pZFSqn57LaXPWCs1/+i9jiBoLv8om4ALg
         UBpJuep9RiRwlzULpDC5wQuwcsQXKWXr7t89CYyWV9PNdCSUwqS36/hKvO5DTa4p8Ff7
         1jP/u8279PvD2fT8tVAZLe9etWpA+iJ2l7WCDQ14grRzrHCUX/AAQGHTnPyNeOwtRlPy
         /C8g6B2Tqc4FKj5maDlqLAXEpfErHC64x+GsSN3HJ9S1fjDYfQw6k/bHupqN4JBfeutl
         +5zbTh2vquc2Y5INni8djti63ivnIpodUfj7fj422g3q+GDBBimi7GoCF10O+XjS1XVC
         wSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oxEhFanRiIwaURE1Asj018eMvsFp7g2C+jPywv6JQCM=;
        b=iJ4Pq1G7v15zSHHc17CJIfsMkjlXptT9gtARri6Ey4A7R0GygrxEVXwA7v7VnhxN82
         KGoqRMkafh6C5kJ1AMndprM7AmaPTiMeyNaes6OFU0IFUowsuBQR1xdnM219y7qMeDt8
         tQ2LqSPMMdeoasGcH6N+y0KPZZWm55hQy72/TXKh5GZyBZTdr+encIAXHjitLE9mjVL6
         xk+r9QNqz/ZfhBYNB+9TpcOD4YKk2GUWVRJtd1tSvnhcmRuG5H6g3GZrZN3uBKI1eekd
         xC79KwX09wiMUWY0qsygrWPkcH4ZsQPQ+rwnhXoir3qpVHPhir3THvo36NXh3eUL5mrQ
         MCrQ==
X-Gm-Message-State: AOAM5308kOQM8E5AlXchRCZSYV4V32nbRz4b014oqbf2PwGphjWGLJ1L
        ooTdT//plE5TEmN9dR7YNpPGJA==
X-Google-Smtp-Source: ABdhPJwzW155uV1Lp/nync0xOTDYo+Lh9zvYNam1FD9gxnoxVEHlm82NLq1x7ctrELhgndK7Ip6bXQ==
X-Received: by 2002:a17:906:380b:: with SMTP id v11mr13514242ejc.183.1613560919007;
        Wed, 17 Feb 2021 03:21:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:4815:d4dc:ff5a:704a])
        by smtp.gmail.com with ESMTPSA id h10sm934344edk.45.2021.02.17.03.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 03:21:58 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v5 02/22] media: camss: Fix vfe_isr comment typo
Date:   Wed, 17 Feb 2021 12:21:02 +0100
Message-Id: <20210217112122.424236-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210217112122.424236-1-robert.foss@linaro.org>
References: <20210217112122.424236-1-robert.foss@linaro.org>
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

Changes since v1
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

