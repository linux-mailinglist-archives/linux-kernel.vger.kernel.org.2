Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E6036E944
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbhD2K7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbhD2K7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:59:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403BC061345
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:58:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t18so8841781wry.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yX68PnWt82JqqvaIeLqptsXuqqdgzkaoY2lNx9HH3fE=;
        b=YnzwceP8U0S+indgF5DyHzwNq2c7+3xad5HCdpCKnt9ggc3qbEePi6z1EFXJw8euGh
         NFrMIWqPIsbzGJRD38ByKvpOupj7Z1WYwU7/6mZQ4Y5izinBcVqtloOPrA69PGA0Grn+
         nXejj9KUG8Sd2BuF0VPqQJiQ2SYDH1tS20jqgZ5nAwYv6fPNSO44jCUGxXhcGvw+3fUw
         qysIYirnk50gA/MrIaAwR+F69aXvKVae9x28EomHs6q6xCp5pXKU6EU/ZU41saoMkoGm
         AzLiZTUtsdoieqlqd2GGbaIWLwHo+IcwwlhmTBLKV602ZMe5aehkTnDbHJGQ1JkR+525
         XMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yX68PnWt82JqqvaIeLqptsXuqqdgzkaoY2lNx9HH3fE=;
        b=Xm76OjI0gt59T0nIt9fgElE+GRvXK5YP2at7h6k7WJPMdizu1KEGeA7TLebdGrZP3s
         IXlQqZFwQUcCJL+KdMp49mnLmpje3hb9rYqos1NQWcpwgnd5aCLCWFt12dHPKQ/KgCEL
         3S0PGsf2LA+wJ0Wu6oARX8azJvXB5GBikxCioFtzGJ3EConAQCtrjMFXmKOrqARkACut
         E8Qjpuyh2PhfUteoFODOP0bDSKxmA5fZLtLHhPDAC4VFkGD++FQOxeUxpMn9UkaUgHXH
         OtNbWCL0RO2zIObPvFaKowEY21AjODkLqLb4uXuloqpwWX08bWF/J6iUr3YGYqIXCv+Y
         9h4w==
X-Gm-Message-State: AOAM53098OlAewnzgol5iTbcSOVqr+/HFmkfxYL6pX0bu2YseJJnkYDM
        WNaAUxi3L7B0MwMGLHD7gbfYCg==
X-Google-Smtp-Source: ABdhPJxXJXDxOHijYlO7spKrJea1/3bsj+kN2SnW3zigQTep6fakuBiYSEjQQQxJWRqUb4UZBa/WWg==
X-Received: by 2002:a5d:60cd:: with SMTP id x13mr21575236wrt.377.1619693902996;
        Thu, 29 Apr 2021 03:58:22 -0700 (PDT)
Received: from localhost.localdomain (hst-221-29.medicom.bg. [84.238.221.29])
        by smtp.gmail.com with ESMTPSA id a9sm3372903wmj.1.2021.04.29.03.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 03:58:22 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 3/3] venus: Add a handling of QC10C compressed format
Date:   Thu, 29 Apr 2021 13:58:15 +0300
Message-Id: <20210429105815.2790770-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
References: <20210429105815.2790770-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds QC10C compressed pixel format in the Venus driver, and
make it enumeratable from v4l2 clients.

Note: The QC10C format shouldn't be possible to enumerate by the
client if the decoded bitstream is not 10bits. This is not
implemented in this patch yet.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 2 ++
 drivers/media/platform/qcom/venus/vdec.c    | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 3a0b07d237a5..58bf2e0654ce 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -563,6 +563,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV21;
 	case V4L2_PIX_FMT_QC8C:
 		return HFI_COLOR_FORMAT_NV12_UBWC;
+	case V4L2_PIX_FMT_QC10C:
+		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
 	default:
 		break;
 	}
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index d4cc51fc019c..7ad8cd66b8bc 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -35,6 +35,10 @@ static const struct venus_format vdec_formats[] = {
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	}, {
+		.pixfmt = V4L2_PIX_FMT_QC10C,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},{
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -1508,7 +1512,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
 static void vdec_inst_init(struct venus_inst *inst)
 {
 	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
-	inst->fmt_out = &vdec_formats[6];
+	inst->fmt_out = &vdec_formats[8];
 	inst->fmt_cap = &vdec_formats[0];
 	inst->width = frame_width_min(inst);
 	inst->height = ALIGN(frame_height_min(inst), 32);
-- 
2.25.1

