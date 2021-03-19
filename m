Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECDC3422ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhCSRJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhCSRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B552C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:12 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u5so10883797ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9f3bEPb39EYdgaLvGilqzYRCGoUJsSIg+sKNAlvNS7Y=;
        b=EK8Yn9ZSIbHdAirL6Y+31biMHrfgDlDwMbjy6eZBXdlktkNI/dDWVt/FoogHhrFBoe
         qNHQJ3aeYThxpEXcJZcrD3mvFPn87qyjaTN4aAhNpufXOo02xM0+6K+98UIfDiRjyMNp
         0kF8O+TVsyuJihMeRMyTFAkWCJtZ57Y6O+bNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f3bEPb39EYdgaLvGilqzYRCGoUJsSIg+sKNAlvNS7Y=;
        b=F+WJG6UOENs2ejS3w9KcE8ZqkyZFN5UMuyhv27JQBM0jG++EKYKt4cpkOnNeEz2Kbr
         vmk147re3OenEz51axFVm+aUapHLrJ3C4nsKqX+JOmOPELjGnhTQxilGQzBCa0Wbz83H
         YCmqAttqm9gtUSiYblo65vZRFMqVGCbXJE/1jzvnLKT/CTgueaLG3Yu8Pz1JiuB6IYpq
         U41Au1zKF60LOtclwiciILtxgaxsYjWTbceFpru4Xb6BWhHYLiJNRChXdLvbCDW2WYS4
         wqsRfPKzur97VC4a2clJYmt4XpeYgiVbpkB8DgW168fECnahO4fs2eYs1cO2pSAUhhx5
         PEng==
X-Gm-Message-State: AOAM531MsfMPdRPJMHcd3hFTFgRk808g3CiafRvhDfy3sC/XKUL08zyQ
        tyZAIjGAo0Zc4Z5Sbb5lPJrUig==
X-Google-Smtp-Source: ABdhPJwg2hB+f1VC9MtHVbuE+gJ78aBEioA7wuAp1Vf8ci5vMA0v5wlWHP1MGz6NPjlSKyYF4r27EA==
X-Received: by 2002:a17:906:5918:: with SMTP id h24mr5589244ejq.501.1616173751381;
        Fri, 19 Mar 2021 10:09:11 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:11 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v8 03/19] media: uvcvideo: Do not check for V4L2_CTRL_WHICH_DEF_VAL
Date:   Fri, 19 Mar 2021 18:08:50 +0100
Message-Id: <20210319170906.278238-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319170906.278238-1-ribalda@chromium.org>
References: <20210319170906.278238-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The framework already checks for us if V4L2_CTRL_WHICH_DEF_VAL is
written.

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 252136cc885c..47b0e3224205 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1089,10 +1089,6 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	unsigned int i;
 	int ret;
 
-	/* Default value cannot be changed */
-	if (ctrls->which == V4L2_CTRL_WHICH_DEF_VAL)
-		return -EINVAL;
-
 	ret = uvc_ctrl_begin(chain);
 	if (ret < 0)
 		return ret;
-- 
2.31.0.rc2.261.g7f71774620-goog

