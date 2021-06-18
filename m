Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FBE3ACADA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhFRMbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhFRMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:31:39 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FA2C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id nd37so15688037ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTV2BvYY8bWiutEhIP2/m/mfzC6d/lLuRadlg4Dfous=;
        b=gcIDPulPQp3gl0wGUFdyXG2mEvhm7yHKumZulkrQ1F8PjggWVC1SGMzEOLqpKTA2Bh
         GU3imyIJLEdpqWIXmJme537HhWSWzY/Juw2PDzHQoL+UF+sRRbu4RbF9/pZFD2XfiGP/
         Sfvb05lauUtgNws0ceox1jyH88q71zrQljLwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTV2BvYY8bWiutEhIP2/m/mfzC6d/lLuRadlg4Dfous=;
        b=r6pf/TeVCeFgwXeefPXAl8e9vd5ryVxrvaZeJnNfQRuGeCpfl+vNTXk+0IGGbmJHGq
         byQIf95ceBXWK+UGf9AvbvqiujcbnJceZpp1zq7e65sCrxAe34tbokDWHIDOww8pZRIk
         WbpubHPsr/jQVwZkH5Ad+qy70i6qgvLM51nCzfG59GouxgY93MQt7JPlsHdod+VDQ2hU
         0rrKm74P7jgi3fZ7cWrzQhHJCGiGGaOj26UOfqMwR4onZuJuO5uX+pA8o0kuQN/1R4t5
         fgvvATxypn9DSe1Ybz9Kc7b1ddBHY5AQ0rKbVh84736yr61o2Mrl2QE02Q5xxSuUJaay
         YZ5A==
X-Gm-Message-State: AOAM530UDZD2n5y7eM2gXOeXEit1+znH2oRWjZNL0FumF+u7VDjhXoTs
        7MncAnb10pZx6zSwByU3+P/U7g==
X-Google-Smtp-Source: ABdhPJyoHanZsBjdG04zfmm0g14w/Fp9HfQ9yadHWdyYmzBTuikt6C/cYUHS17GFGIOdEW8c/Gp6lw==
X-Received: by 2002:a17:906:6847:: with SMTP id a7mr7165661ejs.268.1624019367638;
        Fri, 18 Jun 2021 05:29:27 -0700 (PDT)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o26sm4336403edt.62.2021.06.18.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:29:27 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mike Isely <isely@pobox.com>
Subject: [PATCH v10 02/21] media: pvrusb2: Do not check for V4L2_CTRL_WHICH_DEF_VAL
Date:   Fri, 18 Jun 2021 14:29:04 +0200
Message-Id: <20210618122923.385938-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210618122923.385938-1-ribalda@chromium.org>
References: <20210618122923.385938-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The framework already checks for us if V4L2_CTRL_WHICH_DEF_VAL is
written.

Cc: Mike Isely <isely@pobox.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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
2.32.0.288.g62a8d224e6-goog

