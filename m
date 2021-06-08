Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD13A04B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhFHT5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234565AbhFHT5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcdIlm0NN5VNBYEPRLo+XaYQu2TJXZBESFHXWMw15dI=;
        b=E23t18+q7gPHJhXQiHciAGnJkppP5iNF+Vlau+XPuwHTpIeRe2Q8lkx7Vif57LlnP6Miqw
        CA7+RFnAA8n1urozoaLo9IlnKhBhxSCY66vlR94JJ6XAZu1ClkJiuMl9AWYQ5Qp+t/Iftr
        hr2v5gOYwdyiZHr3QTe6c7B0ONUhv44=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-6ZHk2VSbNQ-aUBRPzpi_9A-1; Tue, 08 Jun 2021 15:55:14 -0400
X-MC-Unique: 6ZHk2VSbNQ-aUBRPzpi_9A-1
Received: by mail-ot1-f71.google.com with SMTP id r16-20020a0568301350b0290363e6a9392fso14673952otq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcdIlm0NN5VNBYEPRLo+XaYQu2TJXZBESFHXWMw15dI=;
        b=ULEp039zQbhkkCVh2E5rE8fWr2UWHljwG1H7B3c/PCviaP9TpSbxBxAfNQZcsRRWhv
         WHbIn4kC3r1iUeY899i/treiNWzB3u7AkwuDCAOHBT6gtwg1vJwlceownDx8DhSsWLxc
         nXSi3qEO70v4q9G+UymAS9ZEo0PAoWicF2R4hGZfD5HPCwR3kRc/t9pMzkY/SiAFk0i2
         RJkiarOuZM6AIlyI1D6WBw2J9XLzHP2C/S8RVd9m5eeb+fCGJifSshw95c3Vr1MbTNDp
         JnwRL+JrsW83dYxEQbMFQzKCi+JHbTJR59hcjwJzIjhujIvgi8H1cJfdCq7A1sJHXvD6
         nz9Q==
X-Gm-Message-State: AOAM5313EPO2vdZb5G2iGVQ64efb4WK16Z4zNtGYPNmhWC1rfGRCF0ez
        L/aHNlIucFiGw2E06kxXkG/fOdWLgEOWAxsJ7dgxCUfOmqINT3RN9LR2g9S7dBb1cJDnoG0n39P
        z/rR2/NSlv8E6v/QA4LjJnNvc
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr19013063otq.247.1623182113731;
        Tue, 08 Jun 2021 12:55:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqo6DxfNK6I+lWN5sfQvkwGiAiPoqkDUE8a+xJp4NKMQdM32CuK6iZZVO/5IicjbQM4Pau3A==
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr19013055otq.247.1623182113585;
        Tue, 08 Jun 2021 12:55:13 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:13 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/7] fpga-mgr: wrap the write_init() op
Date:   Tue,  8 Jun 2021 12:55:00 -0700
Message-Id: <20210608195506.3022550-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
write_init() op if there is nothing for it do.
So add a wrapper and move the op checking.
Default to success.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9a..24547e36a56d8 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
 }
 EXPORT_SYMBOL_GPL(fpga_image_info_free);
 
+static int fpga_mgr_write_init(struct fpga_manager *mgr,
+			       struct fpga_image_info *info,
+			       const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
 /*
  * Call the low level driver's write_init function.  This will do the
  * device-specific things to get the FPGA into the state where it is ready to
@@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = fpga_mgr_write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	int id, ret;
 
 	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
+	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
-- 
2.26.3

