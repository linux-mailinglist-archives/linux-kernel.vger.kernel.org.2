Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05D442675F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhJHKIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbhJHKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:08:04 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6CBC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:06:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so7160062pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KUHB0swnVu/KYbAl644YyqO7PSS/qaz1tm73DfYZaVs=;
        b=KjcoqE6YX7cIYNyMM5PYyjs3wF5Gr2V320ljZVdIb+8BUaW/8M5CCYKaLtzNoZGRUe
         uX7RLS8mMIbBVIyHfU4+FZU7qGeetDJtcCyahAW9TugFrTxmLr2rwzbIgcHNJDICBion
         2QHzwmrXqPVSsePpTXgSsGzmNzcRd3RM8c36k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUHB0swnVu/KYbAl644YyqO7PSS/qaz1tm73DfYZaVs=;
        b=NwAQ2G0XXYYgOsjZWWfWc5Z5GYvAcK8ATa6sIiPWW304vPRxrdaZOWPiq1riUW8gc8
         s9pTx4vjiaNAMmfB84x0oU5LkMDnYU7a5eCxUV6fAzWI74KSt+KNPdqVBTuIZ0kfGBSK
         yKcTxO7QKcNMtPNWiJDXu7hDwv3LtAatCamG5aQp3aJG9pTc44l+JPB/ASxnSbpb/Llr
         fJSQgrIU7AisF6KBzllUozm2Kkjulh+9xD81N4ITFaOl4uI1HvtWQwjGhwQBI2uzr0zK
         PJWzqsyDTI1+mahAok7+vKrwxF6eU7GXABd1tIgMtzwn9ItD19PnYJ2KJIjr+3F0Yjwp
         1ItQ==
X-Gm-Message-State: AOAM533LMLf479lhmMZM9gguuJWBSBhnW1RUM60qflYX0ljaA9aqKNey
        ftYoj6I/QcKUaqbQpc43K5HwYQ==
X-Google-Smtp-Source: ABdhPJxkBdREzfd4W+kfYcgYxTKjv3LHKdMoe+zGfcZMc2uCzCDqxRU5AMNwaiX+5Rzy51jDyTfhwQ==
X-Received: by 2002:a17:90a:b706:: with SMTP id l6mr11379699pjr.200.1633687569261;
        Fri, 08 Oct 2021 03:06:09 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:ad8d:f936:2048:d735])
        by smtp.gmail.com with ESMTPSA id a7sm2082255pfn.150.2021.10.08.03.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 03:06:08 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        stable@vger.kernel.org
Subject: [PATCH 1/2] media: rkvdec: Do not override sizeimage for output format
Date:   Fri,  8 Oct 2021 18:04:22 +0800
Message-Id: <20211008100423.739462-2-wenst@chromium.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211008100423.739462-1-wenst@chromium.org>
References: <20211008100423.739462-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rkvdec H.264 decoder currently overrides sizeimage for the output
format. This causes issues when userspace requires and requests a larger
buffer, but ends up with one of insufficient size.

Instead, only provide a default size if none was requested. This fixes
the video_decode_accelerator_tests from Chromium failing on the first
frame due to insufficient buffer space. It also aligns the behavior
of the rkvdec driver with the Hantro and Cedrus drivers.

Fixes: cd33c830448b ("media: rkvdec: Add the rkvdec driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 76e97cbe2512..951e19231da2 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -1015,8 +1015,9 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
 	struct v4l2_pix_format_mplane *fmt = &f->fmt.pix_mp;
 
 	fmt->num_planes = 1;
-	fmt->plane_fmt[0].sizeimage = fmt->width * fmt->height *
-				      RKVDEC_H264_MAX_DEPTH_IN_BYTES;
+	if (!fmt->plane_fmt[0].sizeimage)
+		fmt->plane_fmt[0].sizeimage = fmt->width * fmt->height *
+					      RKVDEC_H264_MAX_DEPTH_IN_BYTES;
 	return 0;
 }
 
-- 
2.33.0.882.g93a45727a2-goog

