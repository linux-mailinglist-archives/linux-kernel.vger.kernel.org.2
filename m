Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC79F33F5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhCQQpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhCQQpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76288C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h10so3060324edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fA/68we/kMTkpnR4AV+szAmiaqsAOldil+kVUGgOjPk=;
        b=ACrBLyE45qWrT36JGCDQtAW5B4J7WvzPgUK05OiqZsFebHLAGq1PYx9yRpSJ+a5is8
         U6Y0bnResftXQNuiKoga6lM35wXJdOnXOhoMxzieghxNB5/DypnXWlekR2Y9dVt0lXsZ
         bfQh7LbxGT76zH8kM5o3/QjK9M20vBGhdWnkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fA/68we/kMTkpnR4AV+szAmiaqsAOldil+kVUGgOjPk=;
        b=TNz0l4i7/CxIM2+/dNtFuZn0ZfTyoFAe6k8QxmZI4cWPVGKVoc7WlH2rsXdOk2rc7D
         knYFP3dIOhho5VNYbHGhlzOHZtcMZ6DDbFcTDoXplXqErhl6y4hNztOu4ilDynF4sqdl
         iWTh5fQGUChEKVJDgMKHNM8mDRM4C+Hn6JjAoODITHaT75WuC4vSIn3x4giY10IlR2Rl
         pZdavg2h/4Y1WKF3PiK7c+pM+Efmd03qSol0KBf9zVZ6SrBW99DHYu1oJ7nMT+YE7M4O
         TQtsemlYhNUCs+ldmPp4dz/UcLSOsX/8PlgZUJTyed2RerjqKNTBNb8LImxq2NY5ql8J
         J3TA==
X-Gm-Message-State: AOAM530XSGIUEoHyObGqPkMxUvs2OY/W+nFGBgS4ErjPOtU43M1F7SlT
        o2wnz2jJ/g9kpMfYgvBwv19EIA==
X-Google-Smtp-Source: ABdhPJzzRFU4N/D1uk69rbftkzPmtne0jexST67hsnCQIyylvEhXLIX8IpVRkn+ieBP8eKcrnphySA==
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr44276595edy.30.1615999517240;
        Wed, 17 Mar 2021 09:45:17 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:45:16 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mike Isely <isely@pobox.com>
Subject: [PATCH v6 05/17] media: pvrusb2: Do not check for V4L2_CTRL_WHICH_DEF_VAL
Date:   Wed, 17 Mar 2021 17:44:59 +0100
Message-Id: <20210317164511.39967-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The framework already checks for us if V4L2_CTRL_WHICH_DEF_VAL is
written.

Cc: Mike Isely <isely@pobox.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
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

