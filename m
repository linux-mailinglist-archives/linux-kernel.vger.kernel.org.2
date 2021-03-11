Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B366033802A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCKWUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhCKWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:19:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B38C061764
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:19:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id bm21so49467572ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NbPbhT2DvRa0HxCcGP6PoWLah825bR8ZY4RDvgqg8WA=;
        b=lJicX7FJ5deqI7OwxIw6ZUlwlyGn5VV8CT6UaWcZwBl33WV1vrOfptR4vh95JdLrsE
         GLZW800IXBu8UpyX5AyG8y6tKd3OZz0fCwsZi+QIOJsLnN93K6hHPSisF3+WwDv60Qk8
         YgE3w0emYzudMUqDIn+LluAyEMQGrM5AjE6sU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbPbhT2DvRa0HxCcGP6PoWLah825bR8ZY4RDvgqg8WA=;
        b=Ust2aLcwjIUd8IK5m5mGv8mBTSpQl0pZe66887Ik3iRS/kN/6W1RpoA6QmQnAaBIB8
         4EC2sDS7Fq0mkSUfajlFQvah0eP6NNSaIReq7qnL4kLzyuDiqwpsfJUIgOsfKDbOfdPa
         NRX53zk2MiUyhHFLd8UTqmBRALjNaQo8946YzorAaGQtbzmEdtcWqtnSDFjMbMpBr4M8
         Jvi09LlHV69GAaZP86GC7D2CzSAgKp6OymqxHALqwGn4E8bHZlBXxabGSuM9jgMa1hn1
         WkaJ87cGoKu4hW+YoKDZ9Qykrq2ucKWn7FdkRwWLriRQYeURNyivJe6+U2auHIW6ic/t
         4eFg==
X-Gm-Message-State: AOAM532aTN5+VkRIfXz5DKKUqsIJB3fEm+ERaT4+7dAQHhffc3i8qAJO
        tH9bnPE+5wdzMBG9SdsH1iUifw==
X-Google-Smtp-Source: ABdhPJz5b66NydyOmLZdqz5yFVMU3yKizx+Q6wzTzO5kpoK22o9BnowMprQf8ne1d2TEexE8uudKGg==
X-Received: by 2002:a17:906:18aa:: with SMTP id c10mr5261577ejf.248.1615501197417;
        Thu, 11 Mar 2021 14:19:57 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b18sm1942174ejb.77.2021.03.11.14.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 14:19:57 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 6/6] media: uvcvideo: Set a different name for the metadata entity
Date:   Thu, 11 Mar 2021 23:19:46 +0100
Message-Id: <20210311221946.1319924-7-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311221946.1319924-1-ribalda@chromium.org>
References: <20210311221946.1319924-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the entities must have a unique name.

Fixes v4l2-compliance:
Media Controller ioctls:
                fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
        test MEDIA_IOC_G_TOPOLOGY: FAIL
                fail: v4l2-test-media.cpp(394): num_data_links != num_links
	test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 30ef2a3110f7..47efa9a9be99 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2199,7 +2199,10 @@ int uvc_register_video_device(struct uvc_device *dev,
 		break;
 	}
 
-	strscpy(vdev->name, dev->name, sizeof(vdev->name));
+	if (type == V4L2_BUF_TYPE_META_CAPTURE)
+		strscpy(vdev->name, "Metadata Videodev", sizeof(vdev->name));
+	else
+		strscpy(vdev->name, dev->name, sizeof(vdev->name));
 
 	/*
 	 * Set the driver data before calling video_register_device, otherwise
-- 
2.31.0.rc2.261.g7f71774620-goog

