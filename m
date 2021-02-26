Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B0C326094
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBZJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBZJww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:52:52 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E25C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:52:12 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t25so5915394pga.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnnanrWTNg2jT3kmApBFVzR+WBdWvVozJWPDZ+h5DIk=;
        b=mxANwjkh3DAS+qI3KIQXTBgBicNnM8c4B0dLIzPB14c3GMLGfKY6jy8mA+lHlEDl6k
         IUBv7p0li+7WJ3/Vf0e48Nb8IcUO+n+GSAJoBGbBuKxo0cKA6dtxVGlFKbaIVqZx6rwu
         yHPJ8mj2keKM5PP+TXbB6AC7+kTytdIAFYoZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnnanrWTNg2jT3kmApBFVzR+WBdWvVozJWPDZ+h5DIk=;
        b=nDRAMLxjbwJJuTfeHk3qRvYGjzEfr8QuyKi4RnT8rE6mNcbDF7POTzMA7mmHMe8Mwj
         WdKA2GFuz6Ib/MEdvSne3Yp6k4vkZ72Esykms89EbnD0tpVGNFeZr+z5sxpR46ZhKcdT
         N9OCVrI48ZiFigtqbDz9GH3P0CK71E7b/+ys9AxvQZ2xfzS7+8JiKEwPC1gHmypSKGtu
         3B7dg382/45FhTdzE7e58tq9ATYSeWRSRT1e4mlxmU07eQWfZuU45AWBnvML/AY7lzQ5
         cpAOTcqPRVw3KM9jF2Awv+zxX/+ti6BQ42x1xhmUnfSI38orr3l+O35/4O7ghO/4HX7E
         GRgQ==
X-Gm-Message-State: AOAM533z5nzmtuPSHKHNxJ5dtmx09yq9xYGZL8Ds6viZLvvd+WJ8Yx48
        8SVJAhPph/O98fCIVJ3fz3I1IQ==
X-Google-Smtp-Source: ABdhPJxKHWkljHIsQKuRZYIEQtpNxuxOZMJigquhnP9JaQDPwnMLx5mQ2HldGwn7oW0IfteZkCPhZQ==
X-Received: by 2002:a63:1648:: with SMTP id 8mr2275871pgw.392.1614333131763;
        Fri, 26 Feb 2021 01:52:11 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:5c91:233c:dd5b:b1b0])
        by smtp.gmail.com with ESMTPSA id q4sm9013458pfs.134.2021.02.26.01.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 01:52:11 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: mtk-vcodec: venc: remove redundant code
Date:   Fri, 26 Feb 2021 18:52:02 +0900
Message-Id: <20210226095203.1661054-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vidioc_try_fmt() does clamp height and width when called on the OUTPUT
queue, so clamping them prior to calling this function is redundant. Set
the queue's parameters after calling vidioc_try_fmt() so we can use the
values it computed.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../media/platform/mtk-vcodec/mtk_vcodec_enc.c   | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 8c917969c2f1..d16e1ec87a49 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -442,7 +442,6 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 	struct mtk_q_data *q_data;
 	int ret, i;
 	const struct mtk_video_fmt *fmt;
-	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, f->type);
 	if (!vq) {
@@ -467,20 +466,13 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
-	pix_fmt_mp->height = clamp(pix_fmt_mp->height,
-				MTK_VENC_MIN_H,
-				MTK_VENC_MAX_H);
-	pix_fmt_mp->width = clamp(pix_fmt_mp->width,
-				MTK_VENC_MIN_W,
-				MTK_VENC_MAX_W);
-
-	q_data->visible_width = f->fmt.pix_mp.width;
-	q_data->visible_height = f->fmt.pix_mp.height;
-	q_data->fmt = fmt;
-	ret = vidioc_try_fmt(f, q_data->fmt);
+	ret = vidioc_try_fmt(f, fmt);
 	if (ret)
 		return ret;
 
+	q_data->fmt = fmt;
+	q_data->visible_width = f->fmt.pix_mp.width;
+	q_data->visible_height = f->fmt.pix_mp.height;
 	q_data->coded_width = f->fmt.pix_mp.width;
 	q_data->coded_height = f->fmt.pix_mp.height;
 
-- 
2.30.1.766.gb4fecdf3b7-goog

