Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADD134A537
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhCZKAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCZJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:59:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D072C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:59:00 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h13so5618578eds.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bONtZGsS4XqAKxeuy/H43uHE8WmZWjf3WVxgmtV5zE8=;
        b=W+Hm9SkjmsW0r45zVcLVwAM80sqfX6SfjfmMYq8EWW5OQf5aH5R+wL3veXe34hcJ29
         QFIVN7Vp1P3ODMWodMitoNeSXTnKaVMGiICZqsy7FN900zkOsyRTxnQDqyZIoi0tZvb3
         0T1V3yVIpWDhm2OAz12iHhJqJOuJYouV7Uyfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bONtZGsS4XqAKxeuy/H43uHE8WmZWjf3WVxgmtV5zE8=;
        b=kuhs95WDEpvCz8BZy1UsoZusBFdotLTf3tUjE+KJ7pskAiKZpRfGwytE4akQ/kRt5U
         cYAQSU4ODfGi6uvjtx+Rh94ZhTxK1R5ba3b2HGZYBdcH322sWtlVQ1P0YooKvDpqwlzr
         hYeszQQ0eUYxm+2DpYif6cdFN0si2eFzUgj/Kg+flX67z7bf4rV28NYShKluqcV4fIQj
         aNzaHP/Xgtc8mFIQDhbybgcL2VNMKukXORjRnbM9JYYTLDdbCzQtDMsc3YiFIlpcZonm
         xJc1B5u86hogTeNS530DH/gMGQ0gyFXYBH5TDPWM4aixatDi2SdEbqcj0L/kAKovwhra
         7fKg==
X-Gm-Message-State: AOAM533UE277MjSAxfkT/x7gXtxVDzXrXHfJ3ILaDfu6cBtbJYdGgVbG
        egslXjlRdE2hG4lHe49jHHQu7w==
X-Google-Smtp-Source: ABdhPJwIbtASlZisUUvzHQbZuyZBqTk0Wn+fv19PofYh6AFM9f2DR2r4sbUNnDVTaw9CT+NleZJN8Q==
X-Received: by 2002:aa7:c74a:: with SMTP id c10mr13750092eds.332.1616752739397;
        Fri, 26 Mar 2021 02:58:59 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id h13sm4036658edz.71.2021.03.26.02.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:58:59 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        tfiga@chromium.org
Cc:     Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH v9 21/22] uvcvideo: don't spam the log in uvc_ctrl_restore_values()
Date:   Fri, 26 Mar 2021 10:58:39 +0100
Message-Id: <20210326095840.364424-22-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210326095840.364424-1-ribalda@chromium.org>
References: <20210326095840.364424-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Don't report the restored controls with dev_info, use dev_dbg instead.
This prevents a lot of noise in the kernel log.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 6e7b904bc33d..df6c33932557 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2182,10 +2182,10 @@ int uvc_ctrl_restore_values(struct uvc_device *dev)
 			if (!ctrl->initialized || !ctrl->modified ||
 			    (ctrl->info.flags & UVC_CTRL_FLAG_RESTORE) == 0)
 				continue;
-			dev_info(&dev->udev->dev,
-				 "restoring control %pUl/%u/%u\n",
-				 ctrl->info.entity, ctrl->info.index,
-				 ctrl->info.selector);
+			dev_dbg(&dev->udev->dev,
+				"restoring control %pUl/%u/%u\n",
+				ctrl->info.entity, ctrl->info.index,
+				ctrl->info.selector);
 			ctrl->dirty = 1;
 		}
 
-- 
2.31.0.291.g576ba9dcdaf-goog

