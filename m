Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5396439E54E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhFGR0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231225AbhFGR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sw7849LMLQbMNBNh72cG9DpmFetu7hYYk7CqmCZ+A8c=;
        b=avs8jXP9e8d0fdn1GpPLfJ1iZ2vrlX9WG6Ha4d/mBHzWLE4FNJZCKIDyBOmz+8sjI9QuZ7
        pCN2VPfJ1V00p36yZuQnBkjaicDNQk62/0eFq5Xd89/0mUC6/KmeJbBl/oM66IS1mTHADy
        1fMx7TGZyMvXwFX4AN63LdzEZzov//o=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-BgxpKPrVNt2HS6d9mVR8Xg-1; Mon, 07 Jun 2021 13:24:33 -0400
X-MC-Unique: BgxpKPrVNt2HS6d9mVR8Xg-1
Received: by mail-ot1-f72.google.com with SMTP id 96-20020a9d07e90000b02903c030760be3so11864390oto.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw7849LMLQbMNBNh72cG9DpmFetu7hYYk7CqmCZ+A8c=;
        b=dRYIt7jXQ2UakPsQsosHmLeJbX6dDGc80oI7P4foDJdPEHQ66UgriaM+6W32sM+GTD
         +SuA8fO1vg9Ypf9D0SNB7f+B0PuTg5Iq3t8jZuf64ip+CxFcO2cH6fyqMQbUIG6jAYqD
         WpjT/xBZWShysnlSfL1tOCULzbKSwxE45EPKF12UL6ENzpyoqybjG525XV1+7QmDaMrK
         EKT9hdSGRUp2nvZ7878TBoOze6IENZswZlXyBCN125B5VEmVXrZex65v4AkeaXQ7U8Ry
         apecZyMoZdu+yDRqgtVsHRjyeA2NS84RDsQEwLHui2jWnewLMyo/BJdemBww4XUg/lJa
         3uZw==
X-Gm-Message-State: AOAM532tuNpZC2BMS8eq5KUbSNGIhXTxjVAw11Xzp24bAm4y0WMjDu8b
        IiCiR33M4PXzTcwesHJwyvknpEmjM/ID5qNW3R3DURQhhBVl8YblN4d00AAjpcWHbhdmDRtDo3X
        NmUpykqZ1ODghNO8akEXc/n5I
X-Received: by 2002:a9d:249:: with SMTP id 67mr14552435otb.356.1623086673292;
        Mon, 07 Jun 2021 10:24:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaxynMSyVdOH834Xr+aDUn5sjwj9lSK2uSYH4p7kRGsbU3UK3AsLkYepvXRVkAP7p0oedWLA==
X-Received: by 2002:a9d:249:: with SMTP id 67mr14552418otb.356.1623086673160;
        Mon, 07 Jun 2021 10:24:33 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:32 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 4/7] fpga: wrap the status() op
Date:   Mon,  7 Jun 2021 10:23:59 -0700
Message-Id: <20210607172402.2938697-5-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The board is not required to provide a status() op.
Add a wrapper consistent with the other op wrappers.
Move the op check to the wrapper.
Default to 0, no errors to report.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c484b4309b2f..cc531f0537ac 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -426,6 +426,14 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static u64 fpga_mgr_status(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->status)
+		return mgr->mops->status(mgr);
+
+	return 0;
+}
+
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -433,10 +441,7 @@ static ssize_t status_show(struct device *dev,
 	u64 status;
 	int len = 0;
 
-	if (!mgr->mops->status)
-		return -ENOENT;
-
-	status = mgr->mops->status(mgr);
+	status = fpga_mgr_status(mgr);
 
 	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
 		len += sprintf(buf + len, "reconfig operation error\n");
-- 
2.26.3

