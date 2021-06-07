Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C441539E546
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhFGR00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60363 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230458AbhFGR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5POgGzXgN4h++cWuVkMb7E0DYWkWN/zT+5ctpxHYXH4=;
        b=Lcq44TjP6keku/eoviIaP+15ps4FAqMR85BlLHFj0cc9UnxukFO1t5UpvThx7glL8SzaEI
        tiuuIaZaDtBuh/4ntBJnbPVNIbu5uQT9/KkSd0STSADV5i6UHEZmwnoTfHdNLDizdkxr+3
        vbctgVv0Lad8ZNsbyhgQNP97VFEinD8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-iGwrQ6adN-K1XGAy9rF7rg-1; Mon, 07 Jun 2021 13:24:31 -0400
X-MC-Unique: iGwrQ6adN-K1XGAy9rF7rg-1
Received: by mail-oo1-f71.google.com with SMTP id b9-20020a4a87890000b0290248cb841124so9399989ooi.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5POgGzXgN4h++cWuVkMb7E0DYWkWN/zT+5ctpxHYXH4=;
        b=fya8khz55zE1iwPygDBY0Egh5HL6sU7frpLhlEIDoVr/WyUsDAWkgzob7+FRmwqwnm
         +2ZLkRAP1qEHrtjXciUBfihIRjMha3yFVUCD9sJQtrr3azyw4SNiWndTBjHE3uIftZGr
         CcrIN1hjTWYIeJ1qpZmR8ph7tUIq5xdjvzHHmI3xs4jh5Gm+WR/JWwikXO9U3TVUIWGR
         XrjedVWFhKBnpRx4bxvmZ7LRUcT8pOkQ/ihhaTFqe7cx4VouM7Yl7QW5fo5Q7JWseuzE
         W9+hYSq2rrNpaHwGjfDPs3vaBGOd+d2IYhLrmeZbjoDVu1UDtdtoT1358PLILFrNcPoD
         v3qA==
X-Gm-Message-State: AOAM530YwGpGkyCdeBpXH+pIn3y1MDKYa147pRD0+cvGbEjxBBsH9Qa0
        DeWYTvbDpnVJhghpd5tmJQ1zcCuCq0G8dZA0yGT5f6TmPT+e0RnUvH0eDfuvzz2+oBFSkVCanuY
        IJBY0NjL1CzDwvhucZX20RpB5
X-Received: by 2002:aca:4d3:: with SMTP id 202mr206175oie.9.1623086670703;
        Mon, 07 Jun 2021 10:24:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyErLrAs2nKUGQD+6vZuLJsm5Ds5EU5sJZCfJ1o9Ju4lJGFyG6X2XnaYzYSzpxZbczqt8XM1A==
X-Received: by 2002:aca:4d3:: with SMTP id 202mr206164oie.9.1623086670568;
        Mon, 07 Jun 2021 10:24:30 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:30 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 2/7] fpga: make write_complete() op optional
Date:   Mon,  7 Jun 2021 10:23:57 -0700
Message-Id: <20210607172402.2938697-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The board should not be required to provide a
write_complete function if there is nothing.  Move
the op check to the existing wrapper.
Default to success.
Remove noop function.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c    | 7 ++++---
 drivers/fpga/zynqmp-fpga.c | 7 -------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 24547e36a56d..dadad2401502 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -152,10 +152,11 @@ static int fpga_mgr_write_init_sg(struct fpga_manager *mgr,
 static int fpga_mgr_write_complete(struct fpga_manager *mgr,
 				   struct fpga_image_info *info)
 {
-	int ret;
+	int ret = 0;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
-	ret = mgr->mops->write_complete(mgr, info);
+	if (mgr->mops && mgr->mops->write_complete)
+		ret = mgr->mops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
@@ -576,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
+	if (!mops || !mops->state ||
 	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797f..9efbd70aa686 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -66,12 +66,6 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	return ret;
 }
 
-static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
-					  struct fpga_image_info *info)
-{
-	return 0;
-}
-
 static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 {
 	u32 status = 0;
@@ -87,7 +81,6 @@ static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
-	.write_complete = zynqmp_fpga_ops_write_complete,
 };
 
 static int zynqmp_fpga_probe(struct platform_device *pdev)
-- 
2.26.3

