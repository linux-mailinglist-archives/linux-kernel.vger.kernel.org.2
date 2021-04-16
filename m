Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA73622E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245047AbhDPOjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244373AbhDPOiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:38:19 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F22C061345
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u21so42486182ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzOG9RqGeFaMEfdkziwldEXIinN2H0fHEk94mLiK7tM=;
        b=pvAQsbMS0eW0KSVhdZlIi1X65LCC3OZTA2uwvSiMbiRwXuPoT70I61NTob4CqqnnIb
         lEa9GWI4NMQrC+HHG/nuGleueQvy3e+Jk8RJiT0TTQjj1ApxXjponcsI8wFS0VxpJ98h
         +u6VmHrvghP3v0NzSKQWR4Ix58u42TgVqSjqmVnkka/vcy4dD4GiuoPyMju4ppTxZkxr
         aBuOAYddcXd0aNuT63USMCfL+9IDptqP3Ii9NR16nZX62hDXIOmcqR6z76h691lMgdeJ
         Tjsp+iSDNEboImnwJqAJkb14ZdxKCQ/oEt/Wuv5KiokWyEU7LOtJyjkm8latXZWFaZFv
         5dWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzOG9RqGeFaMEfdkziwldEXIinN2H0fHEk94mLiK7tM=;
        b=iLqBtuKW0EUkOmtZptTVU4a9VR1Fsdz64dGljnOUPhcLMpbJghhShReYR6f7ES6gJc
         SRMPXOYBARRZ9CiyyTdnZ2f4+y8pq65Bm8uoIWlG+2Uj6tuV7PCB3f9xqTIXlBSFR4EJ
         gEI9n4GiM5S8at4ugdatE46K5hjirbyKYlv2a8ejM0+mBbO+vVjMV8KSPLEqwgj1ylle
         3KTo+61CM/+Sz1qri2rHnB8uqPhsLAJDEsoNX1MYyIBrmvnM6otjOb5vqisbHJvIR0I0
         M7QNmFMxf4K814rQD2K6qWxopfjC+2d5w0pm6fGuBB+RgPUXWFgYM4Z1UyfEUzs+Iad3
         +U7Q==
X-Gm-Message-State: AOAM5324UbYNEyzfJotCtB4/sXUUVss8InP1xG2IQ+XltKYNvIdOsiJP
        GxdP5Hyd4URI1M7XXqx2uFaFVw==
X-Google-Smtp-Source: ABdhPJzm8GoALfykrT/YM+LEqZWqIMBQKJbjiBfCQ6xfllh9OZhl5WNbELvnlVdZs8c8LD/IBpY0OA==
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr8739341ejk.338.1618583872299;
        Fri, 16 Apr 2021 07:37:52 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 07:37:51 -0700 (PDT)
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
Subject: [PATCH 21/40] drm/xlnx/zynqmp_dp: Fix a little potential doc-rot
Date:   Fri, 16 Apr 2021 15:37:06 +0100
Message-Id: <20210416143725.2769053-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
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
index 59d1fb017da01..5ce96421acf40 100644
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
2.27.0

