Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8BA41B90E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbhI1VMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbhI1VMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:12:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788FC061745
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:39 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x20so600662wrg.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BshZZVKwdBlyyHBI8IqWe63R5Yq6DUQYXsV56Yu2uuo=;
        b=IZvfT3BfhcGs94bf3v3Da6bFccLoKIv9+bHRb30GpVaH+wYkDwVdqbe0YRyHsnb3mB
         DHOE2ju3CsckBASRSNzXZiXFTgp2moIS3Ur2zc+F1Oma9jQPSmC3RdZx8cYZISsrFU7k
         hhW/9qLcJYtH/fRUTeOQBprDyJtWcjmXGEqms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BshZZVKwdBlyyHBI8IqWe63R5Yq6DUQYXsV56Yu2uuo=;
        b=c4ZtnW2LKTKtQyrGLuAJPBFFLfrXcYw5zDizyxTkbDMvYmD/7lU3nRZWaKKCmZnkx7
         919NpjVn13rOGOX6vpow4qrF7KSwmSb/KNoi2chO4wNmtqZaeK41tIw9qjWVoPYiKtkl
         o6ptmlKXmF/jHhmeyVlzLvalTccSYSSV4Dse66UWG4LnbN+8q3t5b1yD9rRYjbWsEeEw
         jar2b66DmAhjrk5umYuue8HgQk/2+yJRx9wwlL//Te+MWBbhYTg9EfLnIGtxwdnwUVna
         fKYPVAkcpFsY8zSykqj/37Avo5EhgmJHJhG35s6Y8qauJHplKPGwexTDbubvLQl5W0sq
         TQLw==
X-Gm-Message-State: AOAM530+LLl1dN++s0Hfy71TDJwZJ0ziDYGBVTqPe9RvemGWGar/HBv0
        6/sv4GhLcJZoG1iGvGzf/yQSgw==
X-Google-Smtp-Source: ABdhPJxcTAzxA8tDEC7we03mbt7Mf+/GqBwkhRQ5cM9jkRW7UdSzOjFqXTkEvhjGxPW0mM0hONW9PA==
X-Received: by 2002:adf:f8cc:: with SMTP id f12mr2513838wrq.195.1632863437817;
        Tue, 28 Sep 2021 14:10:37 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n68sm3885773wmn.13.2021.09.28.14.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:10:37 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 4/7] media: ipu3-cio2: VIDIOC_QUERYCAP: Fix bus_info
Date:   Tue, 28 Sep 2021 21:10:30 +0000
Message-Id: <20210928211033.2415162-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928211033.2415162-1-ribalda@chromium.org>
References: <20210928211033.2415162-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bus_info field had a different value for the media entity and the video
device.

Fixes v4l2-compliance:

v4l2-compliance.cpp(637): media bus_info 'PCI:0000:00:05.0' differs from
			  V4L2 bus_info 'PCI:viewfinder'

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 66995c6f15808..2594ac4eb0763 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -592,11 +592,12 @@ static const struct imgu_fmt *find_format(struct v4l2_format *f, u32 type)
 static int imgu_vidioc_querycap(struct file *file, void *fh,
 				struct v4l2_capability *cap)
 {
-	struct imgu_video_device *node = file_to_intel_imgu_node(file);
+	struct imgu_device *imgu = video_drvdata(file);
 
 	strscpy(cap->driver, IMGU_NAME, sizeof(cap->driver));
 	strscpy(cap->card, IMGU_NAME, sizeof(cap->card));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s", node->name);
+	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s",
+		 pci_name(imgu->pci_dev));
 
 	return 0;
 }
-- 
2.33.0.685.g46640cef36-goog

