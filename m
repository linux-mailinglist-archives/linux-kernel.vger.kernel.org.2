Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5953422E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 18:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCSRJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 13:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCSRJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:09:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E7C061762
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so11588414edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 10:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AikJF0GK0ZzYGbwbgBUzJRLCgyMvlKF2iA5mDBYu/f0=;
        b=atYHlbtsaqi04LfSg5Eox0I8qpNOjB6GEdi0psVT9m5ldSjyzg1eh67CmEdPjM6f2Q
         p7AMVV4XhWzFgVxvstDqqYgicBPRljDxT+CFM0XG48Ck4uEAE1JXuRpZJ2h5YhVRLwj5
         5QyesM2zRMk8xFbagNwTwnbdJLsikJ99YGPnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AikJF0GK0ZzYGbwbgBUzJRLCgyMvlKF2iA5mDBYu/f0=;
        b=r84RQ9IHvVdFPTjxuCVvmM+CDha4NKbvvSzBtE2aGrwXVML2BwfskUkj/3Vfgt7Q3w
         +rTnMAH58+oG/zqTxSFFwJY7Ep4jJ3K/X1+Bw3UjeQcA7shSRKKoXyqy/8BhwFYSD0Bb
         ZUQBbPy76Tjd8Em+f/IJIlEwFwdMIXUPYlrU5X3Yk9JXuAc5MvPM4eo1+ukUIsZQydOD
         HJylIC1ObZpiB+lyz/HT+SEc355BX3DgiCZXLVJ4ds0WO76+DjVbj+6pk/MF/Gcj99Ms
         cWCfE3W9dQxwrUZkxm7zjIeRgq5cv8U0aNPtNobVRrc6CSuFf1cItiC1FoUYXo6IKYzU
         oO2Q==
X-Gm-Message-State: AOAM531z6UPzxfoSx8BgrzDBCx1FRdPno7ewkZSe6iVJgkw+Oh40bL0u
        oonoaHPEy8yd4gydFyX4oZGqnQ==
X-Google-Smtp-Source: ABdhPJxI99fkvrgLJHO5qGgSJ9AaOaaS/tK5beBYqpWjyq91Jv+kmUyBEqUN0D/QActs2iQvgwxihw==
X-Received: by 2002:aa7:c447:: with SMTP id n7mr10623091edr.171.1616173750816;
        Fri, 19 Mar 2021 10:09:10 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id be27sm4506050edb.47.2021.03.19.10.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:09:10 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mike Isely <isely@pobox.com>
Subject: [PATCH v8 02/19] media: pvrusb2: Do not check for V4L2_CTRL_WHICH_DEF_VAL
Date:   Fri, 19 Mar 2021 18:08:49 +0100
Message-Id: <20210319170906.278238-3-ribalda@chromium.org>
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

Cc: Mike Isely <isely@pobox.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 9657c1883311..c04ab7258d64 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -640,10 +640,6 @@ static int pvr2_s_ext_ctrls(struct file *file, void *priv,
 	unsigned int idx;
 	int ret;
 
-	/* Default value cannot be changed */
-	if (ctls->which == V4L2_CTRL_WHICH_DEF_VAL)
-		return -EINVAL;
-
 	ret = 0;
 	for (idx = 0; idx < ctls->count; idx++) {
 		ctrl = ctls->controls + idx;
-- 
2.31.0.rc2.261.g7f71774620-goog

