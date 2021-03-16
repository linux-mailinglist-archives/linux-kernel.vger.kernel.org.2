Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5633DBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 19:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbhCPSC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbhCPSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 14:00:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063FDC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:15 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r17so73663537ejy.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8oMD/QgkrLzNEWZ+K26lrfQoeli8yiD0qozk10hUh8=;
        b=LI5CfwGGPY39+fS4JVntvvlCF6rf24a+lwPKZJUp4+BoLx1O3MkRocXjf38pTQdAL4
         DnHPJ0+lsVrUSKOqydfjJ8tKVdkwoKw0/WbXzbGiQDHoRl4DY0EQBOR3SpaPhnPlTHJd
         AuDCk3IDLJH83iCmmvKFdtBIvA0wU1lN/wMc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8oMD/QgkrLzNEWZ+K26lrfQoeli8yiD0qozk10hUh8=;
        b=Mgc9uYnY+fYPdBEZ3j9K3jw9rzpfmWf6x9tMBu4NpQY6it3tv8yFIhu49igWnKWME/
         0lXKf8vppRffdjw8xWtU3LYAcuFz4hxuNsMdGgl0x7ESo5WQPvgIua7ifyAD+NMZFVev
         /45NiyaCph6Ti8q53DVhfQV0tLByQvBCyUa+y5bh/yvWCKP5kRBalhtnOEy39i1NPg7H
         +mYgCSyuvmc5vgreisyij5xIGQ8Gmts711ddr2DSDNWyXiHvOUkE1eUTSVJUvq1H5TtS
         ikE34HJYL/RFxovkbGKZIRxVdp+TMZRqRGCATavtD0gDyiAdArZiyt6CpIsNvj13OAVq
         DpmQ==
X-Gm-Message-State: AOAM533u9juFm5oiT8BZk2QmtBujPRjHu7bRwTKbzLYepIHB39rZDERX
        podZdC0aQodJKTalJguIcGL6sg==
X-Google-Smtp-Source: ABdhPJwSV63qjlNjBJTaIhCNu3u1ldu/2CkqFGvWFQfIU3lOqYgWBje98WC6jOUo27fw6Ow/7D056Q==
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr31061620ejq.1.1615917611763;
        Tue, 16 Mar 2021 11:00:11 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id c19sm10953182edu.20.2021.03.16.11.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 11:00:11 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 07/13] media: uvcvideo: Use dev->name for querycap()
Date:   Tue, 16 Mar 2021 18:59:57 +0100
Message-Id: <20210316180004.1605727-8-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210316180004.1605727-1-ribalda@chromium.org>
References: <20210316180004.1605727-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the device name for the card name instead of cap->card.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index e956d833ed84..d780065f3716 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -617,13 +617,12 @@ static int uvc_v4l2_release(struct file *file)
 static int uvc_ioctl_querycap(struct file *file, void *fh,
 			      struct v4l2_capability *cap)
 {
-	struct video_device *vdev = video_devdata(file);
 	struct uvc_fh *handle = file->private_data;
 	struct uvc_video_chain *chain = handle->chain;
 	struct uvc_streaming *stream = handle->stream;
 
 	strscpy(cap->driver, "uvcvideo", sizeof(cap->driver));
-	strscpy(cap->card, vdev->name, sizeof(cap->card));
+	strscpy(cap->card, handle->stream->dev->name, sizeof(cap->card));
 	usb_make_path(stream->dev->udev, cap->bus_info, sizeof(cap->bus_info));
 	cap->capabilities = V4L2_CAP_DEVICE_CAPS | V4L2_CAP_STREAMING
 			  | chain->caps;
-- 
2.31.0.rc2.261.g7f71774620-goog

