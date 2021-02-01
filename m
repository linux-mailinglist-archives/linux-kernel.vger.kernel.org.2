Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F230A582
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhBAKi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhBAKiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:38:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37785C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:37:33 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so9720359plh.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wI/EH3fEWAPQS3Xf8crYapoATgbi++9o7dF8fi8itpo=;
        b=GvSpQ9KHSTEV3BtrFXzKZ3LVIY2dzpbcfAEmkcSMsAdAS2jsalfwuq6eL1iePNGt96
         gg2Cjr2vDVh7p+8JwUfH7Z0/Z6bfThDA8mpL0fWg5zUsQ5JXFRJt9L7pvBCHJyaRyGio
         i/6A3ji1ouqhJEhaC9dqkaMDSoPcM2xAoMTvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wI/EH3fEWAPQS3Xf8crYapoATgbi++9o7dF8fi8itpo=;
        b=ragsjioAbaHdNmEutiHPTFtzAeMz1xRohOWAIoPu+PaZdxUiP/ni1RBqyLQe7rkv/o
         VOYQcaHybtuNkqNRDJvRSuoQiT/85ED5yLY4O6H3zSpQmtl7ckDufrOpYCX9pYYBcYHt
         mYNibbn3AysamGlrqFOV42CKoq0NPz3xT11bC0My4NwDHi8J0F/xRZLhVBCXeGwvLy6Z
         BPiSgbfBkYFnsBd2HsXv9hGTMafACuFC0ntKR+qmnpHreYuEeg05//nF5wUQCP8sD9HX
         MFrZpoyG7ZTwVtrNMjp1biZaoYaYaVdk+Wkw8gWUXFOQc0dYtZEfItaiZd/FknDiuAA5
         srfA==
X-Gm-Message-State: AOAM533BBAckeXBZ0i+TLI9uG43675hHxxTkQ62fja71cLND2wcyBn0q
        ZPYB3v23sKzQuv2rUgR8rPkGzw==
X-Google-Smtp-Source: ABdhPJxv3LXDVs7fBfg/uKaO6x5vyk1u6dhU+xMb6ixBUYJz8bISQZMnKJFdPHiRfCAsn90W3LZJRg==
X-Received: by 2002:a17:902:67:b029:de:c5e0:87ca with SMTP id 94-20020a1709020067b02900dec5e087camr17600276pla.64.1612175852674;
        Mon, 01 Feb 2021 02:37:32 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0cd:1b84:6d56:68e1])
        by smtp.gmail.com with ESMTPSA id 76sm17610356pfz.174.2021.02.01.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 02:37:32 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v5 0/8] drm/mediatek: add support for mediatek SOC MT8192
Date:   Mon,  1 Feb 2021 18:37:19 +0800
Message-Id: <20210201103727.376721-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series are based on kernel/git/chunkuang.hu/linux.git mediatek-drm-next
and following patch:
("soc: mediatek: add mtk mutex support for MT8183")
https://patchwork.kernel.org/project/linux-mediatek/patch/20210129092209.2584718-8-hsinyi@chromium.org/

This series also depends on component support in mmsys[1]:
- [v4,06/10] soc: mediatek: mmsys: add component OVL_2L2
- [v4,07/10] soc: mediatek: mmsys: add component POSTMASK
- [v4,08/10] soc: mediatek: mmsys: add component RDMA4

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/1609815993-22744-7-git-send-email-yongqiang.niu@mediatek.com/


Yongqiang Niu (8):
  drm/mediatek: add component OVL_2L2
  drm/mediatek: add component POSTMASK
  drm/mediatek: add component RDMA4
  drm/mediatek: separate ccorr module
  drm/mediatek: Fix ccorr size config
  drm/mediatek: add matrix_bits private data for ccorr
  soc: mediatek: add mtk mutex support for MT8192
  drm/mediatek: add support for mediatek SOC MT8192

 drivers/gpu/drm/mediatek/Makefile            |   4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c    | 236 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h      |  17 ++
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c      |  20 ++
 drivers/gpu/drm/mediatek/mtk_disp_postmask.c | 150 ++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c     |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c  | 166 ++++---------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h  |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c       |  52 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h       |   2 +
 drivers/soc/mediatek/mtk-mutex.c             |  35 +++
 11 files changed, 564 insertions(+), 125 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_postmask.c

-- 
2.30.0.365.g02bc693789-goog

