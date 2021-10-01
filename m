Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9544541EBD6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353899AbhJAL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353796AbhJAL1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:27:12 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EA6C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:25:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d6so14881552wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7gLZK8PdbeRKM6yKe+al6KCGRIW1PaVpWWADOyHb+A8=;
        b=c0PIqTzXBtRzvzFVdawJzOuSiftzl9N7n51LfPQzWJaaKBT5JjZq24sk8yNqXjPaXj
         g/1SSy0VHG8sN6JM3Wa8Q+/IGSdMAiqQuyLVe59SeOqwCgXZ3sjZ5xPLvJpLtzOv8rdF
         AOwVrGwpuZOQY86VZAqH8m9gyP4ddgl6WDRVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7gLZK8PdbeRKM6yKe+al6KCGRIW1PaVpWWADOyHb+A8=;
        b=MbK6e+LY0venkvkzPgQyMJKfHTzarTONDO5Q86+7kFCiYDcNfmpcjWv9ct97hSqpv9
         Td+R8ldkxWeaepXox2lk+3B9h9NbQejpqGKsUDslPBwdy2K8xS/sSxEN7rpKa6DKOhAW
         1lg1YE7VP1GIRogbxtnp7pPt+9o2VTZ+R+GHAOHB8QRC+uKxZmRAyPbzYqeQL8ZXXfU4
         zTykFP2Igse8NIU7KtTEwK8ny7OZu2IRdvT5jDWqUdpR+eLWKQmphO/yHGFnI2UJitrN
         gcMGCDsH3wKmMJ6iziBB2f4YdA+gLpHWf2zgANFGNo6rE9r/1cCyceLQEOirbBkKJ2HA
         bXAA==
X-Gm-Message-State: AOAM533Axu42qltuPdvMyvV1ZgajeprJsuApHTEZJLw4vZJW2tGKUhfb
        GjXYQz9qBavamNOGW00scN2VHA==
X-Google-Smtp-Source: ABdhPJy95MV3Hw38b9M9wQ2e1shQruJUA56ulLoiyN0inVxJ49B1Cj2pJDAMgj7NUny7mUv+DLHd/A==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr11481828wrs.122.1633087527336;
        Fri, 01 Oct 2021 04:25:27 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id x17sm5530958wrc.51.2021.10.01.04.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 04:25:27 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 5/8] media: ipu3-imgu: VIDIOC_QUERYCAP: Fix bus_info
Date:   Fri,  1 Oct 2021 11:25:19 +0000
Message-Id: <20211001112522.2839602-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211001112522.2839602-1-ribalda@chromium.org>
References: <20211001112522.2839602-1-ribalda@chromium.org>
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

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index bf3cd1d576280..a2164b6708236 100644
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
2.33.0.800.g4c38ced690-goog

