Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17FD337263
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhCKMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbhCKMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:20:47 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59ABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j3so2439825edp.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R44PHCmTHiOQ1g4PsUUoNvPQgi1yYVMAOT6TAV1uoys=;
        b=Byu0qQk6vIIJ6EeWc0I1toh5q366cq/ebLRYMe82vzVG4YOrdoS3qye9fiu0qkpOJz
         y+YbEtrfpkiTutXJbawer5aLtJutmEauTIEXMCHYIizBZHJX7n8+zr/NEhzXGZSN18rb
         Ix7p2A3pYqjJ4lqWpdLv6enWvhadIpCVet8FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R44PHCmTHiOQ1g4PsUUoNvPQgi1yYVMAOT6TAV1uoys=;
        b=gPfR0K4CmROgrbCG7hK6J+DCoLA1QTT5Shdtjeke5MRQly2cAAsGNEHdrrb5PTwKlf
         Zn0gIc5TV1GHKaD8nNaShOuYH+RNdTlvvw0QqEbTxka0/Ryca8RC6W2rn/dxshg/EKtg
         yH/OZ5iYsn7Z3x+QcRfu7M54Xee5ix0Zm/ErzzK0YhXPV30QPLmC9mCjq3vpMFLX2QQK
         9x/iq9WdYnTW37d+Kx0P/VDbCuTaiUuWoe1W4r4y5vYkw34Lfjb0TVXsxf4RMbO0Vnli
         C2Fv/oOhaBEWyZW7Qzl6/RUlxYdfsiwPNs0QSKAOZHMucq5ITp2TKGZYaelIY/sxgc9z
         wmRQ==
X-Gm-Message-State: AOAM531miXnHKoT1lmS/JVLWkiZ+wznKs1y2c3NjBF2vXW8tCZweM77R
        c0lMFMMAJY6rLbECxfaIONCf8g==
X-Google-Smtp-Source: ABdhPJyszxRremqIrEWWYbkKeAyF8cED7xtBMgGlAUOPtlKpZQzErEt5Xce9oyp508GMZ7r9mzoHzg==
X-Received: by 2002:a05:6402:51d4:: with SMTP id r20mr8250779edd.112.1615465245494;
        Thu, 11 Mar 2021 04:20:45 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id u13sm1264126ejy.31.2021.03.11.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 04:20:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, senozhatsky@chromium.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 04/10] media: uvcvideo: Add support for V4L2_CTRL_TYPE_CTRL_CLASS
Date:   Thu, 11 Mar 2021 13:20:34 +0100
Message-Id: <20210311122040.1264410-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210311122040.1264410-1-ribalda@chromium.org>
References: <20210311122040.1264410-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill all the fields for V4L2_CTRL_TYPE_CTRL_CLASS control types.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index b3dde98499f4..08877897dc5a 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1097,6 +1097,13 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
 		v4l2_ctrl->step = 0;
 		return 0;
 
+	case V4L2_CTRL_TYPE_CTRL_CLASS:
+		v4l2_ctrl->minimum = 0;
+		v4l2_ctrl->maximum = 0;
+		v4l2_ctrl->step = 0;
+		v4l2_ctrl->default_value = 0;
+		return 0;
+
 	default:
 		break;
 	}
-- 
2.31.0.rc2.261.g7f71774620-goog

