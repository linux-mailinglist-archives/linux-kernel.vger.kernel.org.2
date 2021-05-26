Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0853912CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhEZItf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbhEZItP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:49:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF0C061760
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:42 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v12so204307wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjYtCEx4Gm+TGSpGlmvvhCGW5wnbP6a4KsRuIEipo4s=;
        b=k1w7aNlLT1e33HjFRfzfE/UNKNo0S/GpjOvyoBjBf/hSBqbU+mHpuVOC4MwqDZJDv0
         snC2Kzgy1Bmynda/6vGqWZAcIoOhIL201vTq6tYQVFZD/1G23DST+cA1Bn0EErZVOVWh
         J+81I50IbJqyFwwd+QKxO+UmcFzA0CQpPxsEmbzJrBnenMZs+9twXLjtaCkJvWf4LXLL
         HjC+MCrFrmUZNx2KrSyaJHPpyqc+jQiJZ0HlkjWoceJSs5UR2J4Lk4BMmvZSPhCMLLJB
         eeMSoO4uXccH9L0S4w9Rk9YQ5zJkC5Z/f2nJmK6Kl/ob+2DCmdVDD51nnJdAiYtHcGFO
         5z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjYtCEx4Gm+TGSpGlmvvhCGW5wnbP6a4KsRuIEipo4s=;
        b=SVMJREpByTnSV67LBN7nMWT0k4BTxybH6BzsESbwMknwYnYOVYt2FLh71HlAZtt5DD
         t2sKP4XHZ60K/+cUp2VhfA7QJM0zWWSiq8Xru6vFn2PZJioelBRnZfr54vJpVWwlvpmc
         /cpD9lgeDNvH0GHXEb558XfzJkK1BMVz4DjoGWgkVSgiabRaFky/Gdn4MeBCcJFmS6kn
         7V9GrASEMa5/SZBH3YK3r/N2az9+MKeR6SaLZguM/as5z7X9aLVNwbUdvfazzFvYINLX
         fXRbrVjR36iDXUNBaJMpZSHwiXCIb7auqzv79UdaItnWMx5vp7y0GucqlmHhymlKALHW
         b0YA==
X-Gm-Message-State: AOAM532JlWqAoL4O3Ntu94RBHw7te0SsjJSxCN79B+aTsWfaraZ3bLsA
        m3I+rdDCt2aWjfQh3eBasRftrQ==
X-Google-Smtp-Source: ABdhPJxkBloP9sj4QDUuVgg6Pp0GCfuC1kUavbMKW3GJ7C1DQ9Z+b1WzJFjhv91nuhvw1t+89Vvu6g==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr32450663wrr.336.1622018861604;
        Wed, 26 May 2021 01:47:41 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 01:47:41 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 11/34] drm/nouveau/nvkm/subdev/mc/tu102: Make functions called by reference static
Date:   Wed, 26 May 2021 09:47:03 +0100
Message-Id: <20210526084726.552052-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:50:1: warning: no previous prototype for ‘tu102_mc_intr_unarm’ [-Wmissing-prototypes]
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:62:1: warning: no previous prototype for ‘tu102_mc_intr_rearm’ [-Wmissing-prototypes]
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c:74:1: warning: no previous prototype for ‘tu102_mc_intr_mask’ [-Wmissing-prototypes]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
index 58db83ebadc5f..a96084b34a788 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c
@@ -46,7 +46,7 @@ tu102_mc_intr_update(struct tu102_mc *mc)
 		nvkm_wr32(device, 0xb81610, 0x6);
 }
 
-void
+static void
 tu102_mc_intr_unarm(struct nvkm_mc *base)
 {
 	struct tu102_mc *mc = tu102_mc(base);
@@ -58,7 +58,7 @@ tu102_mc_intr_unarm(struct nvkm_mc *base)
 	spin_unlock_irqrestore(&mc->lock, flags);
 }
 
-void
+static void
 tu102_mc_intr_rearm(struct nvkm_mc *base)
 {
 	struct tu102_mc *mc = tu102_mc(base);
@@ -70,7 +70,7 @@ tu102_mc_intr_rearm(struct nvkm_mc *base)
 	spin_unlock_irqrestore(&mc->lock, flags);
 }
 
-void
+static void
 tu102_mc_intr_mask(struct nvkm_mc *base, u32 mask, u32 intr)
 {
 	struct tu102_mc *mc = tu102_mc(base);
-- 
2.31.1

