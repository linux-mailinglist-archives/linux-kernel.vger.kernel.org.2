Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBAD3051CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 06:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhA0FPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 00:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238708AbhA0EzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:55:11 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AD1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id u4so577931pjn.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9/iygGEsbCXV7twHQtjrSpr12PzDM9c+Fh0z8xYuMw=;
        b=OztU7czy87n2d9gUaGyLG6kNOv+55ojXybNmqvW09YTEfhNZFSwkBidqBAcnqUBEHx
         5ik+VJOtGheuqOho7F768S0CkhayUtcioUenKzwaeN8rwgq3aeWd7Kf56sL2UOH3sVaU
         qjyMe9vw+Y/3V9tZF3dYSy1+IJQbfvfbZaR0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r9/iygGEsbCXV7twHQtjrSpr12PzDM9c+Fh0z8xYuMw=;
        b=Z2O3CFo2xhcG8cRl14zKHMQ1sCs93ljd5UZkPpK4fv/4smhyte6tfREkrAp1NF4s6N
         YHWWcWLbxuz6Xn4USzo6YSx0YT+7nZnjBQtYBR3XpXomYloT0DECP41FUhgZGKXUzfX0
         crtd1ruBj3TrLDjPRjE1zlIqHGmi+bdNv/SI09ndntg57FpNJWWsB87L9mgXDgl9xLdi
         3gh8kImr5M8rq6MwkPIyMsK9D/N5ON87bOdkKvBooJnY2gaNK0dbvlChgktCZY7XmPmh
         X/o0OdQvjTMq5KWoXYUT6c4DgNNWuT8fN8qp+BoaMdmrhxBBYG294mEE+nPksoTTOmBZ
         OOqA==
X-Gm-Message-State: AOAM532Ba5YMllxcY1VBg2aKTwQbpcMvGtHPcKfin0hM7APXykkMxn/I
        hbtlJTML2wR8h7PyHe1gm1+Ibw==
X-Google-Smtp-Source: ABdhPJw1C1zpxPU5435J6VcpDvDLiXPINRvaNkHHQYv/g9eHyTnv61bvxwVHrMY7s3JauV7WzUR0Bw==
X-Received: by 2002:a17:902:d4c3:b029:de:84a5:aaf2 with SMTP id o3-20020a170902d4c3b02900de84a5aaf2mr9326915plg.80.1611723270673;
        Tue, 26 Jan 2021 20:54:30 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e0a5:d2fc:aaad:1e4a])
        by smtp.gmail.com with ESMTPSA id a141sm684484pfa.189.2021.01.26.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 20:54:29 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v10 0/9] drm/mediatek: add support for mediatek SOC MT8183
Date:   Wed, 27 Jan 2021 12:54:13 +0800
Message-Id: <20210127045422.2418917-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on kernel/git/chunkuang.hu/linux.git mediatek-drm-next
The series is tested on a mt8183 krane device.

Change since v9
- change several function to rebase to mediatek-drm-next

Change since v8
- fix some review comment in v8
- separate gamma module for mt8183 has no dither function in gamma
- enable dither function for 5 or 6 bpc panel display
- separate ddp mutex patch from the whole Soc patch

Change since v7
- add dt-binding for mt8183 display
- base mmsys patch
https://patchwork.kernel.org/project/linux-mediatek/cover/1607506379-10998-1-git-send-email-yongqiang.niu@mediatek.com/
- base dts patch
https://patchwork.kernel.org/project/linux-mediatek/cover/20201127104930.1981497-1-enric.balletbo@collabora.com/
- add mt8183 function call for setting the routing registers
- add RDMA fifo size error handle

Change since v6
- move ddp component define into mtk_mmsys.h
- add mmsys private data to support different ic path connection
- add mt8183-mmsys.c to support 8183 path connection
- fix reviewed issue in v6

Change since v5
- fix reviewed issue in v5
base https://patchwork.kernel.org/project/linux-mediatek/list/?series=213219

Change since v4
- fix reviewed issue in v4

Change since v3
- fix reviewed issue in v3
- fix type error in v3
- fix conflict with iommu patch

Change since v2
- fix reviewed issue in v2
- add mutex node into dts file

Changes since v1:
- fix reviewed issue in v1
- add dts for mt8183 display nodes
- adjust display clock control flow in patch 22
- add vmap support for mediatek drm in patch 23
- fix page offset issue for mmap function in patch 24
- enable allow_fb_modifiers for mediatek drm in patch 25


Hsin-Yi Wang (1):
  drm/mediatek: generalize mtk_dither_set() function

Yongqiang Niu (8):
  arm64: dts: mt8183: rename rdma fifo size
  arm64: dts: mt8183: refine gamma compatible name
  drm/mediatek: add RDMA fifo size error handle
  drm/mediatek: separate gamma module
  drm/mediatek: add has_dither private data for gamma
  drm/mediatek: enable dither function
  drm/mediatek: add DDP support for MT8183
  drm/mediatek: add support for mediatek SOC MT8183

 arch/arm64/boot/dts/mediatek/mt8183.dtsi    |   7 +-
 drivers/gpu/drm/mediatek/Makefile           |   1 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  14 ++
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c   | 195 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  18 ++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |  10 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 131 +++++++------
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  49 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
 drivers/soc/mediatek/mtk-mutex.c            |  50 +++++
 10 files changed, 402 insertions(+), 74 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_gamma.c

-- 
2.30.0.280.ga3ce27912f-goog

