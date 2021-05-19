Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A193890DB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347762AbhESOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347746AbhESOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:32:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F3FC061763
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:30:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b13so6276295pfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kfOa099pLULt6jl0OFN8u1UODEiizY8ZTmqttw30oY=;
        b=YYJFq2dgWieXlD+hnduTh0WtZyYeZa2EiPeTpa57lwQx9mTGzA66B6NQbzCbtqWUL9
         ZaZgHHENzsJ0sk17VTO6z5PDzEw/YKN4yBDtnWhcJkNm320t/00ciQPP/0RXOtEHC8yU
         Q+dm28F+rxbG953RMEJ0ptfP9zNQdFsJklcqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kfOa099pLULt6jl0OFN8u1UODEiizY8ZTmqttw30oY=;
        b=tI9UpPSGRXVosrR/rNxRctSDPIstE8/iqaqfC4ESwQO7zF3ZUD7PEm4uh9r/I6SRZL
         nbH9gmf9+HmmE0ZC++FWMCeGmDirGJ+8bdKuH9lWQsZHaph/8fIqaoPFGgiK6dGZhIj+
         vRX77teCz6Ic4bAxsTygiu6iIbq/6AVkktyqcSGzTAp7LoaiI7GCsTzXUGKMbTaHGYZ0
         SlUlUhV7W+KTiCBY/CvUnfN30MwGMf9Bfgx+DQnpqyfdvvZTRzRF2M+efZX3goFwValn
         CPnxF1z/l7MojtbGRRpL+1Or3N7wUGrxXLrVvQqozpe2t9xxsRpJkE8m81n0n9h1FTnS
         eIwQ==
X-Gm-Message-State: AOAM533Lw5g8i/w4MLEID9cu++pn4g/l3WnfiQmIlMCfFnggHf6qhc/L
        liCwKchDVUxhdAko9q8luPZ7fA==
X-Google-Smtp-Source: ABdhPJx1JoTLdOlAqO91SpwdnBsgYrywh1y4pWh6k1KrKQ93xhy72ahDDweSpIwRMcOnbAGct9eP6w==
X-Received: by 2002:a63:7e13:: with SMTP id z19mr11116767pgc.184.1621434645624;
        Wed, 19 May 2021 07:30:45 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:87ab:ff82:1544:697])
        by smtp.gmail.com with ESMTPSA id 3sm14337661pff.132.2021.05.19.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:30:45 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v5 03/14] media: mtk-vcodec: vdec: clamp OUTPUT resolution to hardware limits
Date:   Wed, 19 May 2021 23:30:00 +0900
Message-Id: <20210519143011.1175546-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210519143011.1175546-1-acourbot@chromium.org>
References: <20210519143011.1175546-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling S_FMT or TRY_FMT on the OUTPUT queue should adjust the
resolution to the limits supported by the hardware. Until now this was
only done on the CAPTURE queue, which could make clients believe that
unsupported resolutions can be used when they set the coded size on the
OUTPUT queue.

In the case of the stateless decoder, the problem was even bigger since
subsequently calling G_FMT on the CAPTURE queue would result in the
unclamped resolution being returned, further inducing the client into
error.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 1a633b485a69..58e521096b94 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -649,19 +649,19 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 
 	pix_fmt_mp->field = V4L2_FIELD_NONE;
 
+	pix_fmt_mp->width = clamp(pix_fmt_mp->width,
+				MTK_VDEC_MIN_W,
+				MTK_VDEC_MAX_W);
+	pix_fmt_mp->height = clamp(pix_fmt_mp->height,
+				MTK_VDEC_MIN_H,
+				MTK_VDEC_MAX_H);
+
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		pix_fmt_mp->num_planes = 1;
 		pix_fmt_mp->plane_fmt[0].bytesperline = 0;
 	} else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		int tmp_w, tmp_h;
 
-		pix_fmt_mp->height = clamp(pix_fmt_mp->height,
-					MTK_VDEC_MIN_H,
-					MTK_VDEC_MAX_H);
-		pix_fmt_mp->width = clamp(pix_fmt_mp->width,
-					MTK_VDEC_MIN_W,
-					MTK_VDEC_MAX_W);
-
 		/*
 		 * Find next closer width align 64, heign align 64, size align
 		 * 64 rectangle
-- 
2.31.1.751.gd2f1c929bd-goog

