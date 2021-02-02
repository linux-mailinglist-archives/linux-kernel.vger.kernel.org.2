Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1F30B951
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbhBBINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhBBINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:13:23 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BACCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:12:43 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w18so13806246pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+cMOXMiJhmN+BhMWGOCZ1mGQnNvZ1HLYwA10LUk+qs=;
        b=BE7+LLk41j5m1eELGRoOKzZpOyZhdKiTFcK4TJIWMv79mn6AOaVvhj5IrKMgLIoNO2
         Yo/GV8+n5rFxI6xgYlyjq1XC3z5pn/8bj3GSO8hFplB6ElygbiKiT5A0Efb6BbLVfHgQ
         XNxFBpDG5Xpv/852PpyOFg8QXk4fymYm7pA0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+cMOXMiJhmN+BhMWGOCZ1mGQnNvZ1HLYwA10LUk+qs=;
        b=aPZ/Mmp8mWF9xjh1nMiCH72snwkghG8kIcLD4BsijHGkGzL1kK+0bRd7he7h82q8kx
         b+4m50GkdNn3KH+BLSWPiQVKzw+2JPpdil6ebAMgJC8nyrd2oQR/14e3OoPJYfXPC26m
         T2UHbFqN+w9RzjbH/5OF6DU6XF/lksQqeWNRDgUTbzCySlf+4KUvqySJIb8WJ4Oozf4T
         rRZbGNwPi2X1shGgKPSYZf67z+p1Oaf8Tfve89U94nLWGnsQIoKcqRX+5qG48mFVXmyW
         F+1nNdxVukNe/7r90JENOjw924kqFnSS4ggHtKlwdWKx4O905e9J7O3uh79LqdrVrqBH
         T7pw==
X-Gm-Message-State: AOAM533QRZWkwho9309MglMVsK2iFhXd2D9cNZ8VbuPITU1JK5F4YFyR
        bFTC/owz1xVlV0J69Mhkw7R5bw==
X-Google-Smtp-Source: ABdhPJw76yjiccRfuMor3XXLd3rnpk4IlwGPyv9gDv0sKW+2j5Rjt4voUr1UMcCID3auXrXGcyIIpg==
X-Received: by 2002:a63:c743:: with SMTP id v3mr20558822pgg.316.1612253562732;
        Tue, 02 Feb 2021 00:12:42 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:743e:7944:50c8:ff72])
        by smtp.gmail.com with ESMTPSA id c8sm21343325pfo.148.2021.02.02.00.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 00:12:42 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v6 0/8] drm/mediatek: add support for mediatek SOC MT8192
Date:   Tue,  2 Feb 2021 16:12:29 +0800
Message-Id: <20210202081237.774442-1-hsinyi@chromium.org>
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

Change since v5:
- move postmask driver into mtk_drm_ddp_comp
- fix review comments

Change since v4:
- fix review comments

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
  drm/mediatek: separate ccorr module
  drm/mediatek: Fix ccorr size config
  drm/mediatek: add matrix_bits private data for ccorr
  soc: mediatek: add mtk mutex support for MT8192
  drm/mediatek: add support for mediatek SOC MT8192

 drivers/gpu/drm/mediatek/Makefile           |   3 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c   | 229 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   9 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c     |  20 ++
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c    |   6 +
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 187 ++++++----------
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |  50 ++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
 drivers/soc/mediatek/mtk-mutex.c            |  35 +++
 10 files changed, 421 insertions(+), 120 deletions(-)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c

-- 
2.30.0.365.g02bc693789-goog

