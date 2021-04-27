Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9336C4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbhD0LQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhD0LQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:16:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB0EC061756
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:15:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h11so1480398pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfEaEDQVwiPeknn/7rxsBjQT1YtGx/uq9boloX7WxVM=;
        b=fzagj6SrztFzR6Z2jFqhcDdT94/7HWAM+FEIiDIM1HlVgwA3tIpSPcLl9rX0/e9QnT
         Cqm6X4Ic5TYc/NasXdjqtrQo/XaXbNxEjy+uIwuoY1LxqM+tgHi/JWsqjuAMhk/LM3JY
         k0CkRFGs4EuNsQ2n/AZXjJcwJhac8OHj9Shsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfEaEDQVwiPeknn/7rxsBjQT1YtGx/uq9boloX7WxVM=;
        b=Do5gPolWDJC9R2rVPK6Xn3sVBLhUPgSHfXaku0fhS8BaYJqITsq1nFPnEng3huW50K
         Rf69JPK5pW437v1EzRzPXFgrYdRk4ZKBIafV7HebM1Osrz21QpQl/9+vDHfKf/x+9/tP
         1nfrnjbSq0GqHzpekiPMwkgdTWeqWYaFzezs3idv3F71c660TjYwGDShhIEhr+3finVN
         7O+Zjmd87QRvb9xySQSS7Vqw8v5ynWQOSWpIv96YJUhFoVaFyIf9jqVpgHpp8VQ1+H7Q
         +IZfkKEupzlK8y0t4xQ4bVb11FWUeEsHGssmLKHFToqOOI9BghBSKmsEm0tlkzmThdh4
         nCFQ==
X-Gm-Message-State: AOAM530d7J09CUP83Q/s68yGdDSZnZvZ8yutQDpvBgMyHdBy8ykfR8SN
        kMlatL1SMQUoFKVLllK2yiRbqTyVeTZRLw==
X-Google-Smtp-Source: ABdhPJwjgH60e415wDWfXcaFd6uM2R/hmfsiR2RRRkWnmOvdM+507BfL9a7kjLcmbCn6jt8Uc6Pirw==
X-Received: by 2002:a62:e40a:0:b029:263:e573:e1c9 with SMTP id r10-20020a62e40a0000b0290263e573e1c9mr22903946pfh.74.1619522136692;
        Tue, 27 Apr 2021 04:15:36 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:b182:d363:32d0:53a2])
        by smtp.gmail.com with ESMTPSA id c21sm2347210pfc.165.2021.04.27.04.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:15:36 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 00/15] media: mtk-vcodec: support for MT8183 decoder
Date:   Tue, 27 Apr 2021 20:15:11 +0900
Message-Id: <20210427111526.1772293-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the stateless API into mtk-vcodec, by first
separating the stateful ops into their own source file, and introducing
a new set of ops suitable for stateless decoding. As such, support for
stateful decoders should remain completely unaffected.

This series has been tested with both MT8183 and MT8173. Decoding was
working for both chips, and in the case of MT8173 no regression has been
noticed.

Patches 1-9 add MT8183 support to the decoder using the stateless API.
MT8183 only support H.264 acceleration.

Patches 10-15 are follow-ups that further improve compliance for the
decoder and encoder, by fixing support for commands on both. Patch 11
also makes sure that supported H.264 profiles are exported on MT8173.

Changes since v3:
* Stop checking that controls are set for every request.
* Add V4L2_CID_STATELESS_H264_START_CODE control.
* Stop mapping OUTPUT buffers and getting the NAL type from them, use the
  nal_ref_idc field instead.
* Make V4L2_CID_MIN_BUFFERS_FOR_CAPTURE control stateful-only.
* Set vb2_buffer's field to V4L2_FIELD_NONE in buffer validation hook.

Changes since v2:
* Add follow-up patches fixing support for START/STOP commands for the
  encoder, and stateful decoder.

Alexandre Courbot (8):
  media: mtk-vcodec: vdec: handle firmware version field
  media: mtk-vcodec: support version 2 of decoder firmware ABI
  media: add Mediatek's MM21 format
  dt-bindings: media: document mediatek,mt8183-vcodec-dec
  media: mtk-vcodec: vdec: use helpers in VIDIOC_(TRY_)DECODER_CMD
  media: mtk-vcodec: vdec: clamp OUTPUT resolution to hardware limits
  media: mtk-vcodec: make flush buffer reusable by encoder
  media: mtk-vcodec: venc: support START and STOP commands

Hirokazu Honda (1):
  media: mtk-vcodec: vdec: Support H264 profile control

Hsin-Yi Wang (1):
  media: mtk-vcodec: venc: make sure buffer exists in list before
    removing

Yunfei Dong (5):
  media: mtk-vcodec: vdec: move stateful ops into their own file
  media: mtk-vcodec: vdec: support stateless API
  media: mtk-vcodec: vdec: support stateless H.264 decoding
  media: mtk-vcodec: vdec: add media device if using stateless api
  media: mtk-vcodec: enable MT8183 decoder

 .../bindings/media/mediatek-vcodec.txt        |   1 +
 .../media/v4l/pixfmt-reserved.rst             |   7 +
 drivers/media/platform/Kconfig                |   2 +
 drivers/media/platform/mtk-vcodec/Makefile    |   3 +
 .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 818 +++---------------
 .../platform/mtk-vcodec/mtk_vcodec_dec.h      |  28 +-
 .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  66 +-
 .../mtk-vcodec/mtk_vcodec_dec_stateful.c      | 667 ++++++++++++++
 .../mtk-vcodec/mtk_vcodec_dec_stateless.c     | 370 ++++++++
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  58 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 135 ++-
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |   4 +
 .../mtk-vcodec/vdec/vdec_h264_req_if.c        | 780 +++++++++++++++++
 .../media/platform/mtk-vcodec/vdec_drv_if.c   |   3 +
 .../media/platform/mtk-vcodec/vdec_drv_if.h   |   1 +
 .../media/platform/mtk-vcodec/vdec_ipi_msg.h  |  23 +-
 .../media/platform/mtk-vcodec/vdec_vpu_if.c   |  43 +-
 .../media/platform/mtk-vcodec/vdec_vpu_if.h   |   5 +
 drivers/media/v4l2-core/v4l2-ioctl.c          |   1 +
 include/uapi/linux/videodev2.h                |   1 +
 20 files changed, 2293 insertions(+), 723 deletions(-)
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
 create mode 100644 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
 create mode 100644 drivers/media/platform/mtk-vcodec/vdec/vdec_h264_req_if.c

--
2.31.1.498.g6c1eba8ee3d-goog

