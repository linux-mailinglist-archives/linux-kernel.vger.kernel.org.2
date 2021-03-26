Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006B534A50F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCZJ64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhCZJ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:58:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC91C0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l4so7465923ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8ftwX2VrGSkfTVVNvT7pPS6qh2Bu/od5mahErd+MM4=;
        b=kzTUDDX8a25F/i/c+v4G5fzlR44A/rmT2kECv9pBhJHo+lau9PUuofsQ+YlK4ppSnD
         O7kf1K88iSJYxmLPQACECAOQWQRGy5DKOZpShKgscx+Q1JM1Tn26K6mGR83xM9azjk7x
         +M8Ua7lcupbG0pFsxDfaby/8GVBJJmVkJHd3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8ftwX2VrGSkfTVVNvT7pPS6qh2Bu/od5mahErd+MM4=;
        b=tD9+X770P4d3JbL19saHcbPS5/SsIHt2+3bRUsGAu1nqrctsE6SQISbhv0cTmN3czB
         5iPi7yA9elV9s85qZ26liApEo03JqS9UFyAy+b0rC4rWHDa9P8RbbYUpyEgiL3qn/Agl
         Kofoc7SdnAh+RS2eXbxtJXzCS9BvPNCVl12S+L9KaQGaWsaKPg66lujhQz8Mx42uVcVg
         BhllzP7u5xfgHIXgOfD1tGSeOxCQWtKop6IxefpNLs+W1BCOQKVRfCytfeVKcAUvzQhC
         GmjdLhgDQk1a1f6B/rxwdWJuTeRBHHq5uCTtewKdL/2MibfrgGRTC0kDWXcdvw/MUiVh
         gm7A==
X-Gm-Message-State: AOAM531SQq8c/KgByukBAIWMDQGwwEh9qAmOKfDJzHkoY/Q8HP8Ibquj
        N+X9ipU5XIRgaY5DfFSLKFrzAA==
X-Google-Smtp-Source: ABdhPJxGoKWw7ZjVZ6bZ6RrZ67SACtFy4QrZjH8SN9zyyybEjjVoNoGBNm2hmhTO8wgoPoLa61gvaw==
X-Received: by 2002:a17:907:7699:: with SMTP id jv25mr13834135ejc.363.1616752725723;
        Fri, 26 Mar 2021 02:58:45 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:45 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mike Isely <isely@pobox.com>
Subject: [PATCH v9 02/22] media: pvrusb2: Do not check for V4L2_CTRL_WHICH_DEF_VAL
Date:   Fri, 26 Mar 2021 10:58:20 +0100
Message-Id: <20210326095840.364424-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
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
2.31.0.291.g576ba9dcdaf-goog

