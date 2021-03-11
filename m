Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6895933725F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhCKMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhCKMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:20:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139BEC061761
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id x21so2439239eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Adt3VWd7Tr97xOkIDn3xdQPcPlfaPE3dZS8MA+RZVj8=;
        b=WHeLI+EZeWdnBLfu9US6qMqfpgSdFYoKlGy7DNd/hBlMkazrM0ZkVkMJhtB+Y9wBYy
         Cqx71vWATisDUPo/reydXXFvZv+wNnevjhLUNtQg/IIamfzNes1MWNg2+3cszxTOsvkC
         GyFIt+FhwbJdSYNve/ANvnB9WkuUwSysPVZso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Adt3VWd7Tr97xOkIDn3xdQPcPlfaPE3dZS8MA+RZVj8=;
        b=rVX88Jdy5whekxrOIkbhHBUFRm+3imavQzpIixnxn3hiHZaZNUqxxobHkFEhv6kfjm
         1GWuEjIoJeFKX334GcbovgiUh0+2sM4yhM2HGagpxNZk51BccI242dHfol6KoGeex7nC
         qkF+rtjoOoOxTKTpzCOOI0AqD+kz2eP+gvATGSaoT6omSd2jmTEef3UVRV9NbVM4FQNy
         7VP85CR0lJuDzpWC67St+N8dhhd/O+6Tg3VzKUhBRPBXS1eP03+ev2ie3wCFyI2Q71yb
         Z2LWLOMTLkr+Ehry4DSIAJy6kEWN2bBKCvFt7pSgTX9zUDYgxX7QWJdaw+aZrbUQVn/X
         VIFw==
X-Gm-Message-State: AOAM532vNl/LViEcAVlVfgun8GSVWHJwMXACJbRj3obNeMKp5SpiO3TB
        I0Xw3SN1AM7/p4RIau6jgnI1jg==
X-Google-Smtp-Source: ABdhPJwVmOkiZxLlFupp7sYHhXVU2F6SyyyL32qCCJVGSA2zlgH1LGnqJkv7e63m6qGH3s0tbxeYjQ==
X-Received: by 2002:aa7:c0c7:: with SMTP id j7mr8195805edp.298.1615465244891;
        Thu, 11 Mar 2021 04:20:44 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id u13sm1264126ejy.31.2021.03.11.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:20:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 03/10] media: uvcvideo: Return -EIO for control errors
Date:   Thu, 11 Mar 2021 13:20:33 +0100
Message-Id: <20210311122040.1264410-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311122040.1264410-1-ribalda@chromium.org>
References: <20210311122040.1264410-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes v4l2-compliance:

Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(448): s_ctrl returned an error (22)
        test VIDIOC_G/S_CTRL: FAIL
                fail: v4l2-test-controls.cpp(698): s_ext_ctrls returned an error (22)
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f2f565281e63..5442e9be1c55 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -113,7 +113,7 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	case 6: /* Invalid control */
 	case 7: /* Invalid Request */
 	case 8: /* Invalid value within range */
-		return -EINVAL;
+		return -EIO;
 	default: /* reserved or unknown */
 		break;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

