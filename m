Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86F8330BCC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhCHKwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbhCHKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:52:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E01C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:52:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id p1so13989198edy.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mq2bNlOS5Jw/xNPQTz8uc9sf4/Pi/bHXqeAAfOe3FVo=;
        b=B3/CEv3mHHdgJCsQtXoMb0eBAr+GG6/Y9BFIPpz9x/hrGMBoJAPJaxrjz5QI3XSL+u
         E3HUSkYkKbziV10c744WNS7MARvQ/03sK4XdRxPDaZvsr4FsYRt7/raGp2sZbjtDa6Ds
         YUE8O+1HrAa5mVKu5S4IYFTAj9GLVnMSV2hU2akfGtAqR9BJSyTrb83WE8qNAk75fNZ/
         VwJ9UJD6M94l5WndVBKN/RcJRhNsvsHAF+RStQsyWKSTsZEE8tgs2XeDitZUIAqNLaQU
         StBkw/NlMjRu8SbVtBSLH0VO38ueTWWh7Sx8qWHos6mExIL2t15MQntr3nKLKXu3ncB7
         9uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mq2bNlOS5Jw/xNPQTz8uc9sf4/Pi/bHXqeAAfOe3FVo=;
        b=bM0dIR82t4al3ZZiRnavJyDBgh3nboLD/wt5Dvb4/ItS0bMAqjJPTC2fmwIr+oRY12
         rr91f3lGZNQMCA97BUxH1c0tL30CQqmWDhRoMDXrxW+ZEzKaqCe/VBKHJS8cUGZFT+TY
         AdF0JfTgd515O+wBLZiRC9myObXXfHaXOpNfWQ+xIiB9Q136jW1C3yWYVTuyv/0Y2s4O
         96oVh2bB1fNDgbCtxyQDjzoYeLYh9Vo7obHFd+OKU/GjveSSwDWj14eEsMR36Z2DXybv
         FVPtdoE+zVysWW/hX6rL5xRKTbBUA/KuPyX2/rGUUF2PzM29HHePiGTcO4pnhs94G2BG
         FqHA==
X-Gm-Message-State: AOAM531w0b90DM4uiuY5OI44Cl6TRdLp5ZFmmApTPr/fFoMKuk49L2Lo
        Dc244L11+tm9jFSPrye6BdO+FA==
X-Google-Smtp-Source: ABdhPJyOZIcI62WDUpXXqFZiTJ3osRWWB+/yVSWqdZfpOPJT7COdN9pv+PRDKpaTdbDB13CljdftWA==
X-Received: by 2002:a50:81c5:: with SMTP id 63mr22261809ede.356.1615200746576;
        Mon, 08 Mar 2021 02:52:26 -0800 (PST)
Received: from localhost.localdomain (95-43-196-84.ip.btc-net.bg. [95.43.196.84])
        by smtp.gmail.com with ESMTPSA id y9sm6386297ejd.110.2021.03.08.02.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 02:52:26 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 4/5] venus: venc_ctrls: Change default header mode
Date:   Mon,  8 Mar 2021 12:52:04 +0200
Message-Id: <20210308105205.445148-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308105205.445148-1-stanimir.varbanov@linaro.org>
References: <20210308105205.445148-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is observed that on Venus v1 the default header-mode is producing
a bitstream which is not playble. Change the default header-mode to
joined with 1st frame.

Fixes: 002c22bd360e ("media: venus: venc: set inband mode property to FW.")
Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index a52b80055173..abef0037bf55 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -359,7 +359,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 		V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME,
 		~((1 << V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE) |
 		(1 << V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME)),
-		V4L2_MPEG_VIDEO_HEADER_MODE_SEPARATE);
+		V4L2_MPEG_VIDEO_HEADER_MODE_JOINED_WITH_1ST_FRAME);
 
 	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE,
-- 
2.25.1

