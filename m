Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D23C30867E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 08:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhA2Hf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 02:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhA2HfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 02:35:22 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:42 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y205so5690024pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 23:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+JP5pdQIMiJpdb9A5szcfBUiP1gg4B51D5kz0l1qAg=;
        b=E09IVCDKJaw1pM4q9Xnmre77m650iwDkHBLJ3i/9bSNUoekaS/8ot9t6W56VmjAKwa
         QjiDOqS16pIL5sVYk5KttRbM8MdUaKpIQ541ryhlPLJo44VwPoArxWoB+MH/B7/QUGjU
         5V3VMnLqlD7cvK4kj/n/txS4UXBazFby9qp6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2+JP5pdQIMiJpdb9A5szcfBUiP1gg4B51D5kz0l1qAg=;
        b=o3qX51ALLVM8zwd7D1DDPZ/O3QulAmKcXTB9lnGipCaOlPamTjKthMMq8p358u5O5B
         1DDCuDHpewleUDfVaYHC6fR2gy1CJw33YRcPwTSpjQ53iM3nSmwuGnyurrHR5f9kUrQ7
         R2MCYojPZkodyd0OJy3Jdws9AGgS9TF0zNhlyDLHucLyKADIqqc4I5Jp/Er4Zo1IK6gN
         hLV/JILZQWmI8ion9nbzbgtujFhAANq5e14MlKf4BZ6q4CJNaf3D3N/LMEjin4TATbO7
         434fGjpZ3VMjHGniZuJFTwYLIKTPqE/jy8e2jQa0hC+/4I+eXI1bb3ew89UjHf5WYNfH
         qtfw==
X-Gm-Message-State: AOAM53181+3jV1YyMfpZHc8+Y0j+400McQNzMhhs5RxKkYy9HG4CrvVq
        /GpOI7HltyHlCC5/q7xk1TuNeA==
X-Google-Smtp-Source: ABdhPJyTJmer89hnTyIzUeFUMxU3MW8yNhou7rK4sLjU8tB7m00M0/MUS/wOTfNcVHzJo8qqSaZxiA==
X-Received: by 2002:a05:6a00:14c8:b029:1bb:8436:497c with SMTP id w8-20020a056a0014c8b02901bb8436497cmr3190934pfu.68.1611905681713;
        Thu, 28 Jan 2021 23:34:41 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:51f1:c468:a70b:7c09])
        by smtp.gmail.com with ESMTPSA id p1sm7689980pfn.21.2021.01.28.23.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 23:34:41 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v4 0/8] drm/mediatek: add support for mediatek SOC MT8192
Date:   Fri, 29 Jan 2021 15:34:28 +0800
Message-Id: <20210129073436.2429834-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on kernel/git/chunkuang.hu/linux.git mediatek-drm-next
This series also depends on component support in mmsys[1]:
- [v4,06/10] soc: mediatek: mmsys: add component OVL_2L2
- [v4,07/10] soc: mediatek: mmsys: add component POSTMASK
- [v4,08/10] soc: mediatek: mmsys: add component RDMA4

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1609815993-22744-7-git-send-email-yongqiang.niu@mediatek.com/


Change since v3:
- change several function to rebase to mediatek-drm-next
- drop pm runtime patches due to it's not related to mt8192 support
- fix review comments in v3

Changes since v2:
- fix review comment in v2
- add pm runtime for gamma and color 
- move ddp path select patch to mmsys series
- remove some useless patch

Yongqiang Niu (8):
  drm/mediatek: add component OVL_2L2
  drm/mediatek: add component POSTMASK
  drm/mediatek: add component RDMA4
  drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
  drm/mediatek: separate ccorr module
  drm/mediatek: add matrix bits private data for ccorr
  soc: mediatek: add mtk mutex support for MT8192
  drm/mediatek: add support for mediatek SOC MT8192

 drivers/gpu/drm/mediatek/Makefile            |   4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c    | 244 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h      |  17 ++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c      |  37 +++
 drivers/gpu/drm/mediatek/mtk_disp_postmask.c | 162 ++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c     |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c  | 108 ++------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h  |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c       |  52 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h       |   2 +
 drivers/soc/mediatek/mtk-mutex.c             |  35 +++
 11 files changed, 572 insertions(+), 96 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_postmask.c

-- 
2.30.0.365.g02bc693789-goog

