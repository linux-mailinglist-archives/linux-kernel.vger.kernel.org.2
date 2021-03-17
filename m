Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F219A33F5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhCQQpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbhCQQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:45:16 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8762AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:16 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bm21so3699876ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 09:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsUSbbA0uHXEjQnHfQBh5T5niyqZj1SUeATSCdO5Phc=;
        b=jg6ZPj1GHBpg+UNu/STxxmogka909uzVVaw+ssSVXAdM/KMtvydNTh88SL+rFl8xMH
         +QfuHHwPAzxYC2YmhThgtl813p63/Ry8nU/UskQir83ZmLPQXxSxACUDnkQC6eMNisRd
         7QtVD6O7UFXWb4tsFPCVzueoAvMgOwjE9Uowo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsUSbbA0uHXEjQnHfQBh5T5niyqZj1SUeATSCdO5Phc=;
        b=WaB9CLEuT6EVJiSzC5xsoG1+R81qIyuhHxaG94Bvj3CFPGjAlYmczn32e/lHyx0jYD
         dNRVL9wY+F9I8xgYxfTNkLfgG745oQsSU0DMQTPe5uw7MSxuctNMjPuVV7y1oD8qQHiO
         nIsx9dFTnyQ+l0vS4qk1RZsyns0PuigppTFWAKH0eztUvl/wIPMeXIw+RLZAXlpq+84L
         jSd6nWxLZZo3DVaSYPL//7kvg4JMrnGNdYLEBIEmPVEUktoAH8q4FL9jPWnexiMHTz4l
         ohO7puAHgzMPBjPmxA2u+bVcJCpupGr7O37Oe7sJRCQvubCeGqXqBS9JsUAQsdP+i1rL
         xRJA==
X-Gm-Message-State: AOAM53173iAmMDQ80UW066h+Nf/bcaSB6/D/frd3BnFBr8RAqPc40S5f
        m1BoOfL4feHvMxnDEmz2WPSP/w==
X-Google-Smtp-Source: ABdhPJynhE7YLiG6iyloZwjrJRRnijrWnDf9IIf390NyBfGxnbXR6RgActfTxqcn3/4CR4Vnj4aivw==
X-Received: by 2002:a17:906:fc1c:: with SMTP id ov28mr36496205ejb.342.1615999515294;
        Wed, 17 Mar 2021 09:45:15 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id hy25sm12088128ejc.119.2021.03.17.09.45.14
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
Subject: [PATCH v6 02/17] media: v4l2-ioctl: check_ext_ctrls: Return -EINVAL on V4L2_CTRL_WHICH_REQUEST_VAL
Date:   Wed, 17 Mar 2021 17:44:56 +0100
Message-Id: <20210317164511.39967-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210317164511.39967-1-ribalda@chromium.org>
References: <20210317164511.39967-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that do not use the ctrl-framework use this function instead.

- Return -EINVAL for request_api calls

Fixes v4l2-compliance:
Buffer ioctls (Input 0):
		fail: v4l2-test-buffers.cpp(1994): ret != EINVAL && ret != EBADR && ret != ENOTTY
	test Requests: FAIL

Cc: stable@vger.kernel.org
Fixes: 6fa6f831f095 ("media: v4l2-ctrls: add core request support")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 403f957a1012..76e2e595d88d 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -931,6 +931,8 @@ static bool check_ext_ctrls(struct v4l2_ext_controls *c, unsigned long ioctl)
 	case V4L2_CTRL_WHICH_DEF_VAL:
 	case V4L2_CTRL_WHICH_CUR_VAL:
 		return true;
+	case V4L2_CTRL_WHICH_REQUEST_VAL:
+		return false;
 	}
 
 	/* Check that all controls are from the same control class. */
-- 
2.31.0.rc2.261.g7f71774620-goog

