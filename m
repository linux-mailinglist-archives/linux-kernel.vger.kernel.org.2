Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1DC41B905
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 23:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242868AbhI1VMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 17:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242797AbhI1VMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 17:12:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC94C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i6-20020a1c3b06000000b0030d05169e9bso1181200wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulsXtS9yXRXK3fmG8Kq6rVTZ6stiT7WxNsov9MgqnYk=;
        b=fUO1Up5ZPDDjaFgTuYVcpD9L+mWHHODBNm6yHS3YSEGs45zclxt4vs3t2rRvhcg2tZ
         Wpya/TnG6En8saaJ5RwfXeLNDUP9pzFUdfFRavJuQmXSS45/F5jyS3Se0ktDWVYSjoiQ
         HAe+4vMhEHHHpTs/ZxNNjhsjGYg1A8XshDrSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulsXtS9yXRXK3fmG8Kq6rVTZ6stiT7WxNsov9MgqnYk=;
        b=aqHssCQAKCYmXEqXMmwWF1r3roETEjp9qUmtuNApBgpN9Nt1moqDVzyVFU8L+jr91B
         7woEhY7m8MVMt42JutoKK3/WjvhCTA2+6VzmyhfMIKHby0c1JhoFf8pOnGyFhXC8Wjfz
         208dLBkwt/N9Itf0lo42u6Hk21iFqF//nsNeBQIaabv9lJGZjo1oAKU6RV4uT+SSgZQX
         TJRE94qJ94BYfEeyxVotxWz8JTym52ASNGnksasXIoD1qIyAlx3CkKtUJYv5PI4aA7IM
         erkDrcWsa6AVx3K1a71ldHEHti6Mu/SddDdhPR+sVS3yy1EkN3kxX+tVcvHZPMPrx9EJ
         8D1g==
X-Gm-Message-State: AOAM532AgwGPZL2SiEuJB2OiR/UUF5mWbMQYmJg+dc9gyfX75LDCUC1K
        EkPq1HptlmQOJbeJ0fR0T6MNkA==
X-Google-Smtp-Source: ABdhPJyOjAtlbSv7BuQx8GbjogcUXZtQAsTC3A0qejvUgLNeM78kVlqJuf2sVsGPpm/MTtqa+10/Ww==
X-Received: by 2002:a1c:149:: with SMTP id 70mr6726766wmb.187.1632863435875;
        Tue, 28 Sep 2021 14:10:35 -0700 (PDT)
Received: from beni.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id n68sm3885773wmn.13.2021.09.28.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:10:35 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 2/7] media: ipu3-cio2: Set valid initial format
Date:   Tue, 28 Sep 2021 21:10:28 +0000
Message-Id: <20210928211033.2415162-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928211033.2415162-1-ribalda@chromium.org>
References: <20210928211033.2415162-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial format did not have a valid size.

Fixes v4l2-compliance:

fail: v4l2-test-formats.cpp(723): Video Output Multiplanar:
				  TRY_FMT(G_FMT) != G_FMT
test VIDIOC_TRY_FMT: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/ipu3/ipu3-v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 38a2407645096..fbb9eb2ba99e4 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1136,7 +1136,7 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 	def_pix_fmt.height = def_bus_fmt.height;
 	def_pix_fmt.field = def_bus_fmt.field;
 	def_pix_fmt.num_planes = 1;
-	def_pix_fmt.plane_fmt[0].bytesperline = def_pix_fmt.width * 2;
+	def_pix_fmt.plane_fmt[0].bytesperline = 2496;
 	def_pix_fmt.plane_fmt[0].sizeimage =
 		def_pix_fmt.height * def_pix_fmt.plane_fmt[0].bytesperline;
 	def_pix_fmt.flags = 0;
-- 
2.33.0.685.g46640cef36-goog

