Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCE13622E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244915AbhDPOjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbhDPOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0DC061343
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id i3so6880520edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IX4rCKyup2XWGiFmahgmd3kG2O7V506Gam6HuYK+7Ps=;
        b=Ej54r6tzDzb/jAEk8DsTG8FFLNowawyS9Y7KPJNk+nCUiVVYTGPU7BiYh4lB0dLMzI
         as/LgDvmvn6I2NSa0qxFHmmAv/mHrT4y6wEolmkD0awh0pvd7lHlRP19iYwn6ueUWr4S
         Avt2tPLCOco9zFsEBStg2yVR+AKjmrgakl+NTTFRS1UnFcbqXCy7ZpydB3sqeZcVjyvz
         RdSuYPlFokrT7ILCeqj/Uba9bpv0kf4WIzaV1pZzodkG17B9Uq4TLMhZK6Mbb3H1jWZ2
         42DPLS0BCeNeQS75QB7d2LQClfE6f6OotuIBv+gfH/PvR+T1nbHOJpUNeiOREaHaTGwi
         489A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IX4rCKyup2XWGiFmahgmd3kG2O7V506Gam6HuYK+7Ps=;
        b=UiUhSxNotRRsCS86FrVTeZ/Q2F3Igs4DcSWn/T8M2lnkx9VkJDUrd/L5MWk71f2o+q
         vr4hBDqq3jrSdOUa1EYqXNgGcaU20DXySFI9Lrji/defU1Yu2xWspalrkiT8el0cQlSI
         9XBb3TO2BX9Xf7CPlXqIXdhmRtyDxRayP37UhTKd9CERUUzpuIcPJk05oF0GnEtgp4YI
         7sj0FsIDWqfqQ8mhuf5qHWsdG5ICny49hWgPl/Zvq++rtQUYITOOhBq82/RQySFlMJT8
         A4C4He/BoRC6aL9iL2waxuGQ7s8LOmS3jELOg/b9fCMwP9F7N6iF6d7K/2j6fWb1VjoM
         KZSQ==
X-Gm-Message-State: AOAM530+wrMeTTRW4RkdLWRTIaJzLg6CxlR/yL2JyrdAtXwD1HsnPDFZ
        viW4Qx/pyo1u8vKWIyqjzs5dUA==
X-Google-Smtp-Source: ABdhPJy7CdQ4BO7iaHpoPT5kdx+e1sdde7/38ZyJKVpfl3PJHUlcomOr6acsG57c9PQb4MgSMRXtIQ==
X-Received: by 2002:aa7:c518:: with SMTP id o24mr10374073edq.64.1618583871263;
        Fri, 16 Apr 2021 07:37:51 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 20/40] drm/xlnx/zynqmp_disp: Fix incorrectly documented enum 'zynqmp_disp_id'
Date:   Fri, 16 Apr 2021 15:37:05 +0100
Message-Id: <20210416143725.2769053-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/xlnx/zynqmp_disp.c:101: warning: expecting prototype for enum zynqmp_disp_id. Prototype was for enum zynqmp_disp_layer_id instead

Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 109d627968ac0..ca1161ec9e16f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -91,7 +91,7 @@ struct zynqmp_disp_format {
 };
 
 /**
- * enum zynqmp_disp_id - Layer identifier
+ * enum zynqmp_disp_layer_id - Layer identifier
  * @ZYNQMP_DISP_LAYER_VID: Video layer
  * @ZYNQMP_DISP_LAYER_GFX: Graphics layer
  */
-- 
2.27.0

