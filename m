Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66C333802F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 23:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhCKWUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 17:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCKWT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:19:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB8FC061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:19:57 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ox4so33852817ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 14:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PU+PEkxuCZPyUA4RGvtWjC2ZXQnuk3ecTtjzX3NXk28=;
        b=EtzIOLd4WWFG8QSvRxqrGXH1U9iJrjCkW+GGA+/BI1TnQ8jqd0MTuxYGi0nNPbpobz
         WB7oQsrgMESCajedtK31aPnGOYTNFfrGLyEay8xxiocaCSu1OH/slfjPcHRM/UAGS9lf
         CvcVX6BmXFFwJ52Tjv5ZXL9NFiN4rVdofChE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PU+PEkxuCZPyUA4RGvtWjC2ZXQnuk3ecTtjzX3NXk28=;
        b=Y6cyZV3oiHghJDtmX+QEnWjwk4WOtBMLUHK2HJNe6msZhD4Ycpvv/aLrvIyYznmlun
         tyN66RQhJBl+uVaJiKbOljMUvLl8pYUiMdg2S7SoSoFz0UsNA8RDrWaChLYuSv/UDGik
         77BOrrHwrDgbVstsbf1e1nPkPXWLs6rU1DoDFVMSvDAZw47HZFpTs41aKbzP4tLKFH+H
         yXv+NxG3EfwVg8Lew7luXMZcn7eodu8gnLJ0wjohihMM217OpwL1wjB/xejtNboaEnsQ
         TWw9wji60reLdGYQWEi7LoBKp5WloBm7zTIYVUd7l5ohldZLkLNi0gVIWE8QR0x5JkNK
         DP3Q==
X-Gm-Message-State: AOAM533KjfbY1ah5zbVu/5kMDF8qyfIy2DVebIhHu9WtNVGC9Yz/EiZD
        nlf4PVbEtVs/BNnRom5wYlM4Jg==
X-Google-Smtp-Source: ABdhPJzDdIrAnaNzAB/vSFzneUHVBl+Vtdhjrtpf6CG2rGYRHD3MrQdr+JwIQGw4NZenp5G92R2FNQ==
X-Received: by 2002:a17:907:76c7:: with SMTP id kf7mr5173335ejc.470.1615501196346;
        Thu, 11 Mar 2021 14:19:56 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b18sm1942174ejb.77.2021.03.11.14.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 14:19:56 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 4/6] media: uvcvideo: set error_idx to count on EACCESS
Date:   Thu, 11 Mar 2021 23:19:44 +0100
Message-Id: <20210311221946.1319924-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311221946.1319924-1-ribalda@chromium.org>
References: <20210311221946.1319924-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the doc:
The, in hindsight quite poor, solution for that is to set error_idx to
count if the validation failed.

Fixes v4l2-compliance:
Control ioctls (Input 0):
                fail: v4l2-test-controls.cpp(645): invalid error index write only control
        test VIDIOC_G/S/TRY_EXT_CTRLS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 157310c0ca87..36eb48622d48 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1073,7 +1073,8 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 		ret = uvc_ctrl_get(chain, ctrl);
 		if (ret < 0) {
 			uvc_ctrl_rollback(handle);
-			ctrls->error_idx = i;
+			ctrls->error_idx = (ret == -EACCES) ?
+						ctrls->count : i;
 			return ret;
 		}
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

