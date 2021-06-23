Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506A73B203B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFWS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhFWS0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zt+reJW9iH4L44dg7M6KqKyx61iwDVr84RgiCAGE6Po=;
        b=OLaxUuAp7bXlKX9dAfhlmhBzOTKYzy2n39e+Yw96WWfU6rp1sOVFvMuSU2tdhuBHWFXJ7F
        uB7o85VL4UdwLkej/lEFirqZ3CK0hXyiApMsKlqSL6N5f+6bmvrZiYNmx7/zQ349pnYjko
        qXbZuhkajXe4K8pNGysax0I5+Q2ZBak=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-v9DH9O7MOgaqGmpHtpoLiw-1; Wed, 23 Jun 2021 14:24:34 -0400
X-MC-Unique: v9DH9O7MOgaqGmpHtpoLiw-1
Received: by mail-oo1-f69.google.com with SMTP id d12-20020a4aeb8c0000b029023bbaaddcbbso2211974ooj.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zt+reJW9iH4L44dg7M6KqKyx61iwDVr84RgiCAGE6Po=;
        b=SQP9AFkFE3457ag6t2HYkeyp6jUxt2PXHB6I1FFL8iTQ4OTW/9ByY/enORulzfejvU
         XFikMqXlkmYsN2ZnY6Pu2MvyVKnHPulzsqxOBKkpobuHzbhVWAc/eguhUpwFvwJ50nWY
         yjtfwpqZLk7aMxEHFilT0pwI/CvpUVQsMhAWgznBlZt7S1HNYQyG9EbJR0qWIej/8J4F
         tty7Avg5k7MYGe+6+cxXyjcMMGKsvYrjB3caNea/+oPMQv1S2hzkHSzZScfWn2Scujpm
         Tu+kDPvuJg3qmisMYhCb7EmrlOG0xv6dFug0aYMncdEizSMYUpJTMkZRw5bcI9Jyj1tl
         yAcA==
X-Gm-Message-State: AOAM5329sjrZ4FucB9HkSk5PeEMkYjyyhmNNCPVoo9IxPKKoKWnKsvaS
        2xMQ2u5ssanDuxtXOKngnNNaqEfcNw5GikPjoF0b+ct8UYqYac0uPVD5jzCNFTaoSc9NM4Dna9R
        kQn6xiPgBKWfSIwpHhpzcbOHo
X-Received: by 2002:a4a:db42:: with SMTP id 2mr924974oot.47.1624472673541;
        Wed, 23 Jun 2021 11:24:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz4UFSl246oaEQqLiNgeEp6ZLXg4v/5NOgNJIyJ0IuAfGDYUCGLmn5W16/1naj3Oifo/u2IQ==
X-Received: by 2002:a4a:db42:: with SMTP id 2mr924957oot.47.1624472673390;
        Wed, 23 Jun 2021 11:24:33 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:33 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 4/7] fpga-mgr: wrap the status() op
Date:   Wed, 23 Jun 2021 11:24:07 -0700
Message-Id: <20210623182410.3787784-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a status() op.
Add a wrapper consistent with the other op wrappers.
Move the op check to the wrapper.
Default to 0, no errors to report.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 8f97e16e36f7e..6bfc4482abbf4 100644
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

