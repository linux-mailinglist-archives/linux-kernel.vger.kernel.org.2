Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4945D349BA9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhCYV2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhCYV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:28:25 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68439C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:28:24 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g15so3394022pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ar68jm2yqLLP/HtYyEXI6uh/AJB1y8cS7PMCnpcIT0Y=;
        b=TEhkRsQE/1x3MCeVcTv1S4X5n9NVnMa/jFa1XAMbvGy39rpRV1ols2bNLEAqx+w+h5
         g2Q8Cf5S/EzPjEVGrOQzwY+XfoaFuzar68pfaJd/vxur40Pn9WtqXa1pHKYOkFb2L6Ii
         ZRPcqJ7LOVPXZga+/NH+evnqAMK2sye1eGuMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ar68jm2yqLLP/HtYyEXI6uh/AJB1y8cS7PMCnpcIT0Y=;
        b=M1bZC6ljL2mV41FWuo03qzWCMBSo4hJXHnq8cZPCSjNHPv80HnGkrnvJArmOPAIzK4
         jB0iI5tUWaKK05co4xEIkhLEWPQxjcJfMlDndTlFt//4PgN/+PwLMnPR2/OJZ4V+Tj+V
         HETyLETPEKvX5OGpyfEhUYkpvgiV9iStzVgxuSqZIaNi5SAiAoIU7ZGnGTucBYQ+mrN8
         pYkHKMOVx/cFUS+k7I9nPKAKhEg4QWLpMSAyDR36Lxm6lePjP965s/h8HO0Sb4Ewml+B
         gkhZzIHweRi+9A87Seg+ZK3jWhgwbyjDorUrC29anlYd5T5m36yESz8hz6ZOvkArfd67
         NDxw==
X-Gm-Message-State: AOAM533DZNxt13fTNXCB3XFNK4j/FcBPDkig471H/xxmjF9TiYZ3Xi6u
        ctdq8WVBrcJSt9R5GzQikN6i/A==
X-Google-Smtp-Source: ABdhPJxb+M1K271yeV8ZJZrouwWTafpUJhJVRUBFQFGmitdZRBmwSGYAIxMD8Z4uVYOLg333mONJ/Q==
X-Received: by 2002:a17:902:dad2:b029:e5:e7da:cbb0 with SMTP id q18-20020a170902dad2b02900e5e7dacbb0mr11705640plx.66.1616707703977;
        Thu, 25 Mar 2021 14:28:23 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:18a3:238:26c5:1521])
        by smtp.gmail.com with ESMTPSA id e21sm5880792pgv.74.2021.03.25.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 14:28:23 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krishna Manikandan <mkrishn@codeaurora.org>
Subject: [PATCH] drm/msm: Set drvdata to NULL when msm_drm_init() fails
Date:   Thu, 25 Mar 2021 14:28:22 -0700
Message-Id: <20210325212822.3663144-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should set the platform device's driver data to NULL here so that
code doesn't assume the struct drm_device pointer is valid when it could
have been destroyed. The lifetime of this pointer is managed by a kref
but when msm_drm_init() fails we call drm_dev_put() on the pointer which
will free the pointer's memory. This driver uses the component model, so
there's sort of two "probes" in this file, one for the platform device
i.e. msm_pdev_probe() and one for the component i.e. msm_drm_bind(). The
msm_drm_bind() code is using the platform device's driver data to store
struct drm_device so the two functions are intertwined.

This relationship becomes a problem for msm_pdev_shutdown() when it
tests the NULL-ness of the pointer to see if it should call
drm_atomic_helper_shutdown(). The NULL test is a proxy check for if the
pointer has been freed by kref_put(). If the drm_device has been
destroyed, then we shouldn't call the shutdown helper, and we know that
is the case if msm_drm_init() failed, therefore set the driver data to
NULL so that this pointer liveness is tracked properly.

Fixes: 9d5cbf5fe46e ("drm/msm: add shutdown support for display platform_driver")
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Krishna Manikandan <mkrishn@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index a5c6b8c23336..196907689c82 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -570,6 +570,7 @@ static int msm_drm_init(struct device *dev, const struct drm_driver *drv)
 	kfree(priv);
 err_put_drm_dev:
 	drm_dev_put(ddev);
+	platform_set_drvdata(pdev, NULL);
 	return ret;
 }
 
-- 
https://chromeos.dev

