Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4645C3912F7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhEZIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbhEZIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:30 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED8EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id n4so224250wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sC3mIdqFUsQKIxXxCz1K8xBUphxh36SrzQvqXPDvpPY=;
        b=aQRUeFJ1Tv1TRs3shdu+bDGiWPbu0Zzno+WGQszWxUGJrQAFFO4Bx7nN5H7ytxpqA+
         F/dewoVbjvrsn93ZK0fud4nAn9F3KsxZV1HrGheZo4fAlX5hoo15avmNOpo9FC2EnPz/
         qOr/d8N9/wGdnA0p8Kjjr5NsBv6h1SwZmOY8phgTCG//0mK+a0UUCuEptCNU0e8EZY/2
         Ogj27ozvQkDi69ClBZ61X/HPJzp9bMXUFqaGRewYXIs3J3aoKsH6fqXykFkl3ENbdy8/
         /VP3GdF1/mDCHVlOAdbDfCELpVP8ZIumK+upV4e/EzDE4CQfjGSgtHfxTwIHfLoy/JFH
         hCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sC3mIdqFUsQKIxXxCz1K8xBUphxh36SrzQvqXPDvpPY=;
        b=J0nfLBsN55kPrw1yzggljm4exaouFK8cNhyVXYwq/ljeet6NxMCm4s71YCTY8tPVTU
         QY2h0c/5Xm3Zckz9Qd/L/2zJYT7a8isb/m40Wxc0zSgrIaPPr56PYlawi/PlFkAHZOks
         fk15Z7knvtHyftn9lyOnwqv3hmCiQt6SRbwddtx+kDCl7eZJ4/xgfcLAoRYqgkGfp/iP
         VyWGxxO1EoH0ATD/ziiy3KMR/zOl4k8i7g2LromU4xNCZ4q6i8ld4m4N7Q7xL0KxoDWW
         Aaqp3LAp+ASHY0r1u7RiEAkz0/NKKwsLe251oXNz+bM3YdiMac/KSGkmycNTtVUvUEzn
         pUuQ==
X-Gm-Message-State: AOAM531TOnZtEnPAGRDAbtxrlJwAUtbGHp2vIf+s/vk9b5++r7slXSWS
        0ji0f9DL+Cjegcz3hDkdSmNYYg==
X-Google-Smtp-Source: ABdhPJw61xLRdH4uwzLeGWvPWeOtGI2LITlVIBm3U1j6M4H/najTyZjmdkW3FJGtjqnGJdHffJ1EXQ==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr17259894wrv.395.1622018877614;
        Wed, 26 May 2021 01:47:57 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 26/34] drm/xlnx/zynqmp_dp: Fix incorrectly name function 'zynqmp_dp_train()'
Date:   Wed, 26 May 2021 09:47:18 +0100
Message-Id: <20210526084726.552052-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/xlnx/zynqmp_dp.c:806: warning: expecting prototype for zynqmp_dp_link_train(). Prototype was for zynqmp_dp_train() instead

Cc: Hyun Kwon <hyun.kwon@xilinx.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 82430ca9b9133..a1055d5055eab 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -797,7 +797,7 @@ static int zynqmp_dp_link_train_ce(struct zynqmp_dp *dp)
 }
 
 /**
- * zynqmp_dp_link_train - Train the link
+ * zynqmp_dp_train - Train the link
  * @dp: DisplayPort IP core structure
  *
  * Return: 0 if all trains are done successfully, or corresponding error code.
-- 
2.31.1

