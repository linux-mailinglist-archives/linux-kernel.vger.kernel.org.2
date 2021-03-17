Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E6B33EBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCQI5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhCQI5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC3AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so4966424wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXzZsgME51o5a4S3G/qD/qZyWpfOm8qpjFIuUNjewrU=;
        b=QGHZI5JZVjfZ5Tep79BLQwCQgui+6efCtb3xulzDRViNdHHCrKeA9iGbsam5qHCR4F
         gY5m3K642uohesxcMXHKjHWXIWZ47/XuEx2konxYR6T+rcJd70So+lDNa7l6dqB1HjlH
         Jb59p8pF15hJ14Vux6S8wVGLkwhYSy2KvTBaV3rvFufg7+1RDRd4co7Cg3XPXYe3nTK1
         TMB/DOouGq0U9JhIPkGRGwF6AmwqLuBp89OlYBgvpyicBDXIyuvim0IoehV1s/5ITCHD
         6l6h3aLIG/Ij/daPoiMZAWU2YtkvkbhnmbTV0/MvamzGBwm0tmlo5hZOq0zVpgCzSMvs
         IWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXzZsgME51o5a4S3G/qD/qZyWpfOm8qpjFIuUNjewrU=;
        b=KdDX5MElczgBtnPxGKnXguIW5Dq4bm6D5g/xZsfEh6G2FeN+JHOa/VTDFAXPWpCS80
         1HURt6/VZYpo88pk0GMWtTDLu69zWHDNM+eUQr+tyrMe/pAGdUtNSAQxDHmm3GKae3vM
         EhHXKFG+mnb5b5c0WQshC/iwkxcBvFbPB/cwg3MF0E4MNP6sJqeMN6govFe8nMQeYs3m
         EzKCBcoNXM1dP/QWDE3/AJJ/P78hshq2vKrNSfvO7nR42FUnkDZ9i1Ii3CJLuiFXtWgg
         msUsUgM3etK4uNlQivvOYfG2yt8wz+48HMcdA8yUZZcJfJzEYA8TaGBRut6snigyJNE/
         ePCg==
X-Gm-Message-State: AOAM532+LgqzxwCRb+6KPAzImaN+h9BBpi8qDvmdOuPIVAN1vtocpse3
        bv9XPOnJaX4a08E/0BOY4apltw==
X-Google-Smtp-Source: ABdhPJwKpTHxLaetDBDHclcEHKeMcsLIkvwLk9lByiEkCRoyiM00PiF+OHH8mHkrLiqBPZVObm6hhw==
X-Received: by 2002:a1c:67d6:: with SMTP id b205mr2684189wmc.118.1615971434702;
        Wed, 17 Mar 2021 01:57:14 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:14 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux GmbH <hare@suse.com>,
        "Leonard N. Zubkoff" <lnz@dandelion.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 09/18] scsi: myrs: Remove a couple of unused 'status' variables
Date:   Wed, 17 Mar 2021 08:56:52 +0000
Message-Id: <20210317085701.2891231-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/myrs.c: In function ‘consistency_check_show’:
 drivers/scsi/myrs.c:1193:16: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]
 drivers/scsi/myrs.c: In function ‘myrs_get_resync’:
 drivers/scsi/myrs.c:1984:5: warning: variable ‘status’ set but not used [-Wunused-but-set-variable]

Cc: Hannes Reinecke <hare@kernel.org>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Linux GmbH <hare@suse.com>
Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/myrs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 4adf9ded296aa..48e399f057d5c 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -1190,7 +1190,6 @@ static ssize_t consistency_check_show(struct device *dev,
 	struct myrs_hba *cs = shost_priv(sdev->host);
 	struct myrs_ldev_info *ldev_info;
 	unsigned short ldev_num;
-	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
 		return snprintf(buf, 32, "physical device - not checking\n");
@@ -1199,7 +1198,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	if (!ldev_info)
 		return -ENXIO;
 	ldev_num = ldev_info->ldev_num;
-	status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+	myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
 		return snprintf(buf, 32, "checking block %zu of %zu\n",
 				(size_t)ldev_info->cc_lba,
@@ -1981,14 +1980,13 @@ myrs_get_resync(struct device *dev)
 	struct myrs_hba *cs = shost_priv(sdev->host);
 	struct myrs_ldev_info *ldev_info = sdev->hostdata;
 	u64 percent_complete = 0;
-	u8 status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present || !ldev_info)
 		return;
 	if (ldev_info->rbld_active) {
 		unsigned short ldev_num = ldev_info->ldev_num;
 
-		status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+		myrs_get_ldev_info(cs, ldev_num, ldev_info);
 		percent_complete = ldev_info->rbld_lba * 100;
 		do_div(percent_complete, ldev_info->cfg_devsize);
 	}
-- 
2.27.0

