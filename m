Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FC33EBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCQI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhCQI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:14 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2250AC061763
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id g20so990906wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=im+Evr3MfJAtsbpRKrSvBZYIR3R8HYWcJI2GsyeTWRU=;
        b=DM1ORFPtKVJaRVNMisxtioWMH2mlZJEFFRCvJipOaWkDHZB63Rem+T6nvpCOVzeY8q
         NZp+UaPQrGC+vQ/evx+UneOrjxZMFwIJ8DWaxESSZN544FxOVNje/CsPouZ+/l/dQXRo
         sk0zzzGiYEjyLYjkXeYU/7UIXcKUXYvsZ7xdBHGjWi0+CnfzG7WHDINxuGoIBzUscPxc
         5idmZvijQBsKN1M5I+LzcN2E4EjAN6A+YQypx3IUXAQn4ZFXfGZ2uIbqsRLAqIQM9C5x
         BpJmHm4lQFHacPfuWXw+Svk06up4lWy6aqB4wWxqsrFFRF874LoyFzl/4y4qQHsytKaY
         8JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=im+Evr3MfJAtsbpRKrSvBZYIR3R8HYWcJI2GsyeTWRU=;
        b=PJgvg6yHMjAkG1k7u5b9/W85y25sHS1898szP7dnTdGSFnpmwmILetTqp2867+S+6r
         yC1bscTWJYNm6tC2f6sjywh1PtKK2Azr6cCeckMJrQ7jJ9IhLU0++hZ8+uhN/+sqjs2j
         FXc5a7WPui6OapdkKbGr4MmNdBUwwkqY6JxJGbyrM8Ds5NuYu/usjfPadWDD4SmkWMkB
         Q08tP/GWOgxQSQn3SXuy5y8M5qjlc1kXlmHQYyrG9lnNSRZpIGGkJHiFYcTJOVsaZkZs
         z3XXsVHFXuXlPaTaRHBAmyktpXiO8g8XXdspF8+jcFrDFLjmCW1FKRySRlrSDDxgGRnC
         +ETA==
X-Gm-Message-State: AOAM530jFGAKcnklo1juQzNMM5t2zD2HCgcqMOB3tL9jdnjj088vkkCE
        s77YWljJY5rx7W1DXBmYtx8gkA==
X-Google-Smtp-Source: ABdhPJz29XYZWfGQGPHyM7puMmx9SI7VFt1GZ6uHPJidpB+OMbJRhfyZHKT8jmSsGRT/UCHPsOrPBQ==
X-Received: by 2002:a7b:c195:: with SMTP id y21mr2634320wmi.178.1615971432922;
        Wed, 17 Mar 2021 01:57:12 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bas Vermeulen <bvermeul@blackstar.xs4all.nl>,
        Christoph Hellwig <hch@lst.de>,
        Brian Macy <bmacy@sunshinecomputing.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 07/18] scsi: initio: Remove unused variable 'prev'
Date:   Wed, 17 Mar 2021 08:56:50 +0000
Message-Id: <20210317085701.2891231-8-lee.jones@linaro.org>
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

 drivers/scsi/initio.c: In function ‘initio_find_busy_scb’:
 drivers/scsi/initio.c:869:30: warning: variable ‘prev’ set but not used [-Wunused-but-set-variable]

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bas Vermeulen <bvermeul@blackstar.xs4all.nl>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Brian Macy <bmacy@sunshinecomputing.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/initio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 814acc57069dc..926a7045c2e5c 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -866,17 +866,16 @@ static void initio_unlink_busy_scb(struct initio_host * host, struct scsi_ctrl_b
 
 struct scsi_ctrl_blk *initio_find_busy_scb(struct initio_host * host, u16 tarlun)
 {
-	struct scsi_ctrl_blk *tmp, *prev;
+	struct scsi_ctrl_blk *tmp;
 	u16 scbp_tarlun;
 
 
-	prev = tmp = host->first_busy;
+	tmp = host->first_busy;
 	while (tmp != NULL) {
 		scbp_tarlun = (tmp->lun << 8) | (tmp->target);
 		if (scbp_tarlun == tarlun) {	/* Unlink this SCB              */
 			break;
 		}
-		prev = tmp;
 		tmp = tmp->next;
 	}
 #if DEBUG_QUEUE
-- 
2.27.0

