Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E070B33F5E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhCQQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbhCQQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:17 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41599C061762
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ox4so3655081ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6LTbHcBkbhI/FZJhKqlMKcO/iXlDKvIfShPxPGQCwfU=;
        b=h446286+JeMUfkpECC0Dvil4bzsjcvh9X8FbvNusKHX+x97NsTfbYQ1iGb2kmxbXXy
         UzIQttGHFyOnQouYYkXoFiBlVtCi2qCSB9A2fZ5oy/kzl2KImL2CpEJfOvbrxGOmTcSl
         frQTa9exOxNrMOk5NXg0141v2ce34vceXqC7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6LTbHcBkbhI/FZJhKqlMKcO/iXlDKvIfShPxPGQCwfU=;
        b=WGl8SRNxJ5NkzUHE5DK93yYeIgRRGMoaAC+ywFBScpjN6EQO1KCnZqdU1S6XI+8d8s
         rA9YDhxGZhoEXY3riZu42rR3/tQC9zJoOmY1vrnuJF+qeIHaHeoMNuEi807zexql03Ie
         /lu4LrWLbPeOY8j0l5z+V/LhTvRICf8FcGbq+RZbNaq8ulgx0mnJLf/JVE/P2G1Q8b9n
         ptvlSa4XLcR66InLVzAsanm01NFEQTeL5rIqmzS1V1s4UNABOoBIHWfOsBfOJtXHyiU5
         pSzl4vfMGnjnt7RNIETa6r9icFKNm/RnBpakY6hMwyHH9gn9jHiZZ/c/+MjSB8RtfcJm
         JXtA==
X-Gm-Message-State: AOAM533qdgL5VAYUFehig/fSNGEIBBfqqb9/6dtWq8tvWRaQ7UQ/Knil
        Lp7yrjteIrL1a70Af/nepfQE2Q==
X-Google-Smtp-Source: ABdhPJz6xT+6FSrpNmMsQ/x+ZrKh5p+Gr3i7+g/+7nwYL130KZTbLH7b9dgxPKD+mX7n3MXSupooYQ==
X-Received: by 2002:a17:906:5e4a:: with SMTP id b10mr36514341eju.116.1615999515929;
        Wed, 17 Mar 2021 09:45:15 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 09:45:15 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
Subject: [PATCH v6 03/17] media: v4l2-ioctl: check_ext_ctrls: Return the right error_idx
Date:   Wed, 17 Mar 2021 17:44:57 +0100
Message-Id: <20210317164511.39967-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that do not use the ctrl-framework use this function instead.

- Return the right error_idx

If an error is found when validating the list of controls passed with
VIDIOC_G_EXT_CTRLS, then error_idx shall be set to ctrls->count to
indicate to userspace that no actual hardware was touched.

It would have been much nicer of course if error_idx could point to the
control index that failed the validation, but sadly that's not how the
API was designed.

Fixes v4l2-compliance:
Control ioctls (Input 0):
        warn: v4l2-test-controls.cpp(834): error_idx should be equal to count
        warn: v4l2-test-controls.cpp(855): error_idx should be equal to count

Cc: stable@vger.kernel.org
Fixes: 6fa6f831f095 ("media: v4l2-ctrls: add core request support")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 76e2e595d88d..528eb5f420f6 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -932,13 +932,14 @@ static bool check_ext_ctrls(struct v4l2_ext_controls *c, unsigned long ioctl)
 	case V4L2_CTRL_WHICH_CUR_VAL:
 		return true;
 	case V4L2_CTRL_WHICH_REQUEST_VAL:
+		c->error_idx = c->count;
 		return false;
 	}
 
 	/* Check that all controls are from the same control class. */
 	for (i = 0; i < c->count; i++) {
 		if (V4L2_CTRL_ID2WHICH(c->controls[i].id) != c->which) {
-			c->error_idx = i;
+			c->error_idx = ioctl == VIDIOC_TRY_EXT_CTRLS ? i : c->count;
 			return false;
 		}
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

