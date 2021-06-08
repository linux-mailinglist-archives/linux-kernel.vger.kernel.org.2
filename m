Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D3A3A04BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhFHT5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234596AbhFHT5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+ieZpNx5CLGtvApXLWeUj3JhBAH5I6pceFuxGmJ04c=;
        b=C7H1GEO/fLNlOc0yN0sP1v3rU6t65UQNq3bLCtvq8U2ibTWxSI0kZlFWkKDrGy8RqnzLXz
        LJSjoZ+OpbWfnd6FbS09W8YjrEa5Aed1596Ixscdty/k2IeZUJK4qjC5kGyEQXuvQLSaoT
        3wjsJOOYKxnFhYSRLLxggJrSiAFr2dA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-rzxOKk-xOaWad4M0ZnjQtg-1; Tue, 08 Jun 2021 15:55:17 -0400
X-MC-Unique: rzxOKk-xOaWad4M0ZnjQtg-1
Received: by mail-oo1-f70.google.com with SMTP id 3-20020a4a03030000b029024950bdb69dso8908240ooi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+ieZpNx5CLGtvApXLWeUj3JhBAH5I6pceFuxGmJ04c=;
        b=NkDeHDV+1xyyilfKYFaMUiH1DXMqZZTyYb4a81wQM+2gFQ7o96/KOEPEgei/eP4mEF
         Rpqf3vxh3hi3RO8nyFOiKKE/MwK9GUM50uQOnIxPTW7UPU6LoqBytxFeKUmbS/uWgPLc
         gSUzd/aFU23+71TzpdusR51mriVcKRAFz0KdKlPajX8co7WE3pKMmNhGcfnUlQhj3RFO
         ZqJ2HCJ26cu1cfMC5fAxP9nue8mhHZTcoLb6X8dCCWShS+XawR6aHhT65zwu3hL9DsYs
         8NfzF8+naricQLzGKv5ZhgPx71H7cKJxwujJjpQQumEKnhtHBjg5X1yTPyH/1IQlCngl
         wBdg==
X-Gm-Message-State: AOAM533SVpeueCrkiT2HQKYPtMiPjC1v1WMTCxG1BIQrWMwBZN/nKACo
        is1ZCzC6MDu40kDXIcQ8vW6oghdaOIRk5QqJtRyMFiyDlnJZsIWv+90MZ4mWGqEwFTOIMzKgay3
        ZlJhlFfk4AF76S+zAPjHmRzEH
X-Received: by 2002:a9d:6d01:: with SMTP id o1mr3273293otp.285.1623182116397;
        Tue, 08 Jun 2021 12:55:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzSar9h1GULVkRSGLcpyrS0rYxMTcGF2lkZPgA01LIMglsS8alL7LOIgUpvolCuPMbXVdeVw==
X-Received: by 2002:a9d:6d01:: with SMTP id o1mr3273286otp.285.1623182116240;
        Tue, 08 Jun 2021 12:55:16 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:15 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 3/7] fpga-mgr: wrap the write() op
Date:   Tue,  8 Jun 2021 12:55:02 -0700
Message-Id: <20210608195506.3022550-5-trix@redhat.com>
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
write function. Move the op check to the wrapper.
Default to -EOPNOTSUP so its users will fail
gracefully.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index dadad24015020..c484b4309b2f4 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -167,6 +167,13 @@ static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
+static int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	if (mgr->mops && mgr->mops->write)
+		return  mgr->mops->write(mgr, buf, count);
+	return -EOPNOTSUPP;
+}
+
 /**
  * fpga_mgr_buf_load_sg - load fpga from image in buffer from a scatter list
  * @mgr:	fpga manager
@@ -203,7 +210,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 
 		sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 		while (sg_miter_next(&miter)) {
-			ret = mgr->mops->write(mgr, miter.addr, miter.length);
+			ret = fpga_mgr_write(mgr, miter.addr, miter.length);
 			if (ret)
 				break;
 		}
@@ -233,7 +240,7 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
-	ret = mgr->mops->write(mgr, buf, count);
+	ret = fpga_mgr_write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
@@ -577,9 +584,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state ||
-	    (!mops->write && !mops->write_sg) ||
-	    (mops->write && mops->write_sg)) {
+	if (!mops || !mops->state) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
-- 
2.26.3

