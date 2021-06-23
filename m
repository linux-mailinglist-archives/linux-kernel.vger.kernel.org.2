Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96193B2043
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFWS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34361 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhFWS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PxTldx17CDNKsCv+3pIoboW0CCoBJIoZzyWzxD7ju4=;
        b=ZmA6NBcW4hhIRiwzWyBV7q/VIARbymk3NTL0VssUqlQUdoA3iapSapFkOjL7kNY8Lo6Wxm
        1wDCV2Wv+Sf6NwveBygTG3EogM+YpvTUyQC+4it+9pYWoTGrj/mHg/Ci5Q1cH9IROF65EZ
        4ts+q3p8crZsGhZdDeooNtK7wmQqSpI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500--q9ZGSm_P7KfYqx4i8pJ_A-1; Wed, 23 Jun 2021 14:24:29 -0400
X-MC-Unique: -q9ZGSm_P7KfYqx4i8pJ_A-1
Received: by mail-ot1-f69.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso1804994otf.15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5PxTldx17CDNKsCv+3pIoboW0CCoBJIoZzyWzxD7ju4=;
        b=HISxZQPk64W5ak9zg25cRWREFep50BPXP++aGkDCu/0tbOso7tr2V0/fjiRHpRgMjx
         1EzXmtx8LAxS3fD6jCvw3h/boxtRdgea2x32Q5ZacbH2WZJNyp/ysTrgEp26H16hYQoH
         mMZ4ZwvM5+bqpc44NJWgM28/rUMRsmYSq8t01mh8ZHaI5q0ZL8JdSxmPTFEhePGwQQoX
         BhIWjiQBOFKIm7D1Xm39pysELp3r4MFh5c0tinU5W/pxFdDGm9fVn9FmB87OxiEXAhsv
         bbTENkkQqle6Lk8bNU/4JNKyAPL9RV5H5D+bGqnsouO4afwcRPpZMt8X4TS+vmJja2L1
         e73A==
X-Gm-Message-State: AOAM530xHzgMkRJsNn25vM1iZkjzukLae48rcZNKPijkcnvqKPa7jeEd
        oSY5syX09l3m5vubhwZ1yS/I4lvgnn31vpCk40lTzO2zJAWct2OAjpoMIllxniRbRLHUrG7j9IQ
        UcXsFQS7A42Dcs+jCVulCTCzf
X-Received: by 2002:a9d:6508:: with SMTP id i8mr1032025otl.368.1624472668641;
        Wed, 23 Jun 2021 11:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCRjF7FYY/2Pj0Mk+PNxI071W5obXDGwdzCI4+olhtl6o/gohgN6WImevV4bHQSOtf0rG6uA==
X-Received: by 2002:a9d:6508:: with SMTP id i8mr1032007otl.368.1624472668467;
        Wed, 23 Jun 2021 11:24:28 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:28 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 2/7] fpga-mgr: make write_complete() op optional
Date:   Wed, 23 Jun 2021 11:24:05 -0700
Message-Id: <20210623182410.3787784-4-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a
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
index 87bbb940c9504..1c2cce1320367 100644
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
@@ -576,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->write_complete || !mops->state ||
+	if (!mops || !mops->state ||
 	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797ff..9efbd70aa6864 100644
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

