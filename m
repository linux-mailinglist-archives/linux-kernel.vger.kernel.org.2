Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E21333237
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 01:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCJARB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 19:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhCJAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 19:16:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6EFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 16:16:49 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id r17so33270950ejy.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 16:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nutp93mDHb5cEjtktNc7hYpoY2Gb6DtS9YFtOrP0KY=;
        b=At/Kbc5OmUHxC0v9+TomGng358WQaPZWCCQ7AdMFWYZEJBf+ixxuUmvy35hCUIby+u
         695IqXsuYyK8aBBJYncBfDOl4kdA+fj6wGJ1cUYHjG2OVuLVgD82cMZ6UPK7/feZU7S0
         bW1E+hqmLJPX62zZ6mLk6jlMe+8idlwl3VInU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Nutp93mDHb5cEjtktNc7hYpoY2Gb6DtS9YFtOrP0KY=;
        b=V5DwrPbjNJzHLwgmik0v6Q5TsNLi+yNCQwkZ6XPWpFhjnuawbxnNuozAL99ZIVFhWS
         S7CaJgGuV1I63D2Oz2/piW6VhaHwJC2H/jD5TBdWnp3xU+02Cj8uNT/sXEZRNSOFuZ/1
         r4udzEHy6cX12xC4EtUQlVBCx8sooMvMA5DE8a08R5xeVcbqQnkTUG7sX+1o5NDKfQhT
         dEE8d0G4fTdA3WA1cxjKbbuaUAiW+Aglq34Ij723uSn47BcMocKkeaoiHL1zjA2100jJ
         GZ44QtSfz7YcTWsLZrbgivGTCC4j8fWGWu/1H+SiBDX4AqcekrdBZXeLRDAhTBHULCfU
         cPcw==
X-Gm-Message-State: AOAM530LAOL1yFgezHE9HsL6OwDZd+HD3r64gWJ5+f84MXUERiooFul1
        j1b/nxBi2T8LRBR+m7+Woack0A==
X-Google-Smtp-Source: ABdhPJykuK1NwgMON/87WWXZOt+SX7jB3tSF1UdYKODRl1jNMCe9zB5Wjjaj6n2s6XeGl/hsUchbHg==
X-Received: by 2002:a17:907:7651:: with SMTP id kj17mr648621ejc.127.1615335408007;
        Tue, 09 Mar 2021 16:16:48 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id o1sm9991202eds.26.2021.03.09.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 16:16:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
Subject: [PATCH] media: staging/intel-ipu3: Fix set_fmt error handling
Date:   Wed, 10 Mar 2021 01:16:46 +0100
Message-Id: <20210310001646.1026557-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there in an error during a set_fmt, do not overwrite the previous
sizes with the invalid config.

Without this patch, v4l2-compliance ends up allocating 4GiB of RAM and
causing the following OOPs

[   38.662975] ipu3-imgu 0000:00:05.0: swiotlb buffer is full (sz: 4096 bytes)
[   38.662980] DMA: Out of SW-IOMMU space for 4096 bytes at device 0000:00:05.0
[   38.663010] general protection fault: 0000 [#1] PREEMPT SMP

Cc: stable@vger.kernel.org
Fixes: 6d5f26f2e045 ("media: staging/intel-ipu3-v4l: reduce kernel stack usage")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 60aa02eb7d2a..e8944e489c56 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -669,6 +669,7 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 	struct imgu_css_pipe *css_pipe = &imgu->css.pipes[pipe];
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 	struct imgu_v4l2_subdev *imgu_sd = &imgu_pipe->imgu_sd;
+	struct v4l2_pix_format_mplane fmt_backup;
 
 	dev_dbg(dev, "set fmt node [%u][%u](try = %u)", pipe, node, try);
 
@@ -734,6 +735,7 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 		ret = -EINVAL;
 		goto out;
 	}
+	fmt_backup = *fmts[css_q];
 	*fmts[css_q] = f->fmt.pix_mp;
 
 	if (try)
@@ -741,6 +743,9 @@ static int imgu_fmt(struct imgu_device *imgu, unsigned int pipe, int node,
 	else
 		ret = imgu_css_fmt_set(&imgu->css, fmts, rects, pipe);
 
+	if (try || ret < 0)
+		*fmts[css_q] = fmt_backup;
+
 	/* ret is the binary number in the firmware blob */
 	if (ret < 0)
 		goto out;
-- 
2.30.1.766.gb4fecdf3b7-goog

