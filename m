Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F33BB6D6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 07:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhGEFgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 01:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhGEFgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 01:36:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E03C061574
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 22:33:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t9so17242708pgn.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 22:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ty0kyhtWCmc/mJ/gYFroekO5s9jDb3eEISEoLmjArWs=;
        b=IHt5LDTkxbU+zn0VJVhNdjIFM5RDmyGy+Er+nhVpv5o8L/UVrWhzeboTNv6DrlD9C4
         ZYGhOp59nzlOy2KjGuvoLzudSmcIBVAwox69Xdo1bXWPYjLnZfhxQ380dUF5TjNq1G+R
         2ZuikQHoBZv3UbEV3kmf0dZKIHfw5SGf3/5XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ty0kyhtWCmc/mJ/gYFroekO5s9jDb3eEISEoLmjArWs=;
        b=pm9Q0XUHumzPmuemKuzVPxERUHnvAEGCRxhiak2/mOvxcOKo4qzi3eGTncm5INWdav
         vBsoAEiuRLbnh4Siq8l5lfoART1CZbINjmSRG2GfVocEZ6B7zFjVyYcMAvdC1xdswXHP
         VX3UnhrHyd2b7WIvhU49Fcr5WVe1EINes1ansOJv9Lzu6DrhBC0ltveu0eXtYWrl86Rt
         D7oDfLO46L20NaOddZDMd6Qq0HXHeRfgYfwkaNa8CDEkrTcwBifMg3lUn7zQxqoQLrcv
         2vUR4JCN9dXw1DE0kza3wWAl6hi8vgIVx/Wwz0hO/VwIr4UmFZB/W3gMiqvr96I+UB6m
         CIAg==
X-Gm-Message-State: AOAM532KPx1oGKUwXijhZ0qNRFAWR2NiopxTUFfmUD6hu89kmJ3bLV/O
        fQ6AJu8CLhYzqxaRsT7gHFIGuQ==
X-Google-Smtp-Source: ABdhPJxxdPRgp0ZkFWtVg8aX6w6dCuR/4nXM7ru9x489Z7hrvm+B5DFHfvBzYokCC0BlyOVKXsAEAg==
X-Received: by 2002:a62:7c43:0:b029:320:e367:13b0 with SMTP id x64-20020a627c430000b0290320e36713b0mr1397541pfc.18.1625463209164;
        Sun, 04 Jul 2021 22:33:29 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:3fed:7130:60f:265a])
        by smtp.gmail.com with ESMTPSA id x19sm6805245pfp.115.2021.07.04.22.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 22:33:28 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH v6 03/14] media: mtk-vcodec: vdec: clamp OUTPUT resolution to hardware limits
Date:   Mon,  5 Jul 2021 14:32:47 +0900
Message-Id: <20210705053258.1614177-4-acourbot@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210705053258.1614177-1-acourbot@chromium.org>
References: <20210705053258.1614177-1-acourbot@chromium.org>
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
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index 1a633b485a69..16e057f73789 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -649,19 +649,17 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 
 	pix_fmt_mp->field = V4L2_FIELD_NONE;
 
+	pix_fmt_mp->width =
+		clamp(pix_fmt_mp->width, MTK_VDEC_MIN_W, MTK_VDEC_MAX_W);
+	pix_fmt_mp->height =
+		clamp(pix_fmt_mp->height, MTK_VDEC_MIN_H, MTK_VDEC_MAX_H);
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
2.32.0.93.g670b81a890-goog

