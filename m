Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6B398D12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhFBOgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:36:24 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:51782 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhFBOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:36:10 -0400
Received: by mail-wm1-f47.google.com with SMTP id r13so1455437wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SjYtCEx4Gm+TGSpGlmvvhCGW5wnbP6a4KsRuIEipo4s=;
        b=gofFevHTLNP8OF2mr2XqTcfqX1D3ngKNuZkPIThUZ73Sp9nI1B1Y8Tv/hVti3HkZ4s
         tWgT8IUhvVnFoBxbeWx3jn/nCNincbNXHzx9B6lZygFD3Cmrl1/GliP9x5+FqnKxuPfm
         edhx4dGvfjtFqI2hI0dZirgAh2HzbbwtsnovQrHetfPrP5AImxGrEqUHfmWDl53UHqKs
         /+0zrGfOn8gh9ia/+b83GKKJBPIOXAVM31QEAOYOYsPQyU57Q/x0kj+ovAtNleLZnv5t
         00TuL9IjHwDR0WWej7u0zyCtlYD2ZkTnzOWAQUY+i5DZV7ZSP+s5VOJj084G1ZggEaNK
         yZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjYtCEx4Gm+TGSpGlmvvhCGW5wnbP6a4KsRuIEipo4s=;
        b=PIooZoLNa5Jxfn+oMVNCRngKnhrVMHIbzD57br0+UF4SDaf7ATQbbgP97tFdEMwdgW
         G1Gja4NljCLqK5yGponCsk92OI/yRAf11P9/rFrqLs0Xkf8LyP3FM8gx4q/laALLmcEZ
         qJigbcIFsnWGLy1r7duOGev5h/pf8FP/MduB7rvYtYWJjI0zLpSoyN2BjR6NohS/oCI8
         5GMFiKikqaXtjuj1LEehIE1hWoKnVtU3Iou7fV4lHH1OJpDxyIVuwhLdop+5N92Xm7cA
         NTGIHS/cz8rV5Lh/BoVnY3nlREbfai+GhjFS2xYjXzfYT0muCRQpfvk4BmSdDR9WXKpS
         8XeQ==
X-Gm-Message-State: AOAM5322oXbsLTwxXxyay39lJi2fhUhpp5/7r+OrLXfgUoVSSmXouVcR
        jBXlsdOlnl7JAMJFy2s7ovJXbA==
X-Google-Smtp-Source: ABdhPJx3OI3S8vnYR8EVGsMrIxEMMmnLlVVY9ywmN5evmDEYm9hwef+Z9UJbAvOn0EMCoEwbTJPJvg==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr5534394wmi.116.1622644406183;
        Wed, 02 Jun 2021 07:33:26 -0700 (PDT)
Received: from dell.default ([91.110.221.214])
        by smtp.gmail.com with ESMTPSA id o11sm132315wrq.93.2021.06.02.07.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 07:33:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alistair Popple <apopple@nvidia.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [RESEND 15/26] drm/nouveau/nvkm/subdev/mc/tu102: Make functions called by reference static
Date:   Wed,  2 Jun 2021 15:32:49 +0100
Message-Id: <20210602143300.2330146-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602143300.2330146-1-lee.jones@linaro.org>
References: <20210602143300.2330146-1-lee.jones@linaro.org>
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

