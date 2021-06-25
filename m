Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C743B4961
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 21:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFYTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 15:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229906AbhFYTy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 15:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624650728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8DrGKCk1PyABrk56DLPAvdbVVOLwe1RJgwvPdYUZWO0=;
        b=Q+aXLhLU/aZi1+4DccLUE/CZ3nx3y43qvvLFSmSQ7Vu7LAQvgMDpcAPdM4XqcQBxIJiYqk
        nJ4hXfNiHjhT2uUtUyr+gJTu/bVHgdia18kc2OfGSqe11m+Zcpn1UZTJD+/M7uFrRxeCB3
        hjb2gl/ltr7dYlfa0/Klg5+aKjTxf1M=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-6JKZmz9KNra4JRMOkoGBmA-1; Fri, 25 Jun 2021 15:52:06 -0400
X-MC-Unique: 6JKZmz9KNra4JRMOkoGBmA-1
Received: by mail-oi1-f200.google.com with SMTP id j20-20020aca17140000b02901f3ef48ce7dso6505590oii.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 12:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DrGKCk1PyABrk56DLPAvdbVVOLwe1RJgwvPdYUZWO0=;
        b=Ikb+jjtmxnAnnIf7vUmL3o9iwqKuXpOQVVfspPrSlkwcykayIiUGG89TCSzuv1az8A
         6v4GGHAaCO5aQoJu00Iuh1gVEq/47dYDCLO7+Ap6UCE1dtDIgGYXiA6JDXpskH7teugl
         qvnV7i6lXdYdUb0nD6YxaNWU9QZea1d37unFWPfmwSCbvsUBL56rredRPhdOn39d7tMY
         OH/xCQeEWiUF9XoI1Nu1n0WJ52b7hL+9l5cQb4QxiNlg0MaezLHJxApaIqll+XJqnlV4
         +EYPvg8SDpzpJEJqAP8tZ0rwdaZB95WbJ2ot0LAqzK9OqB8WJJoj0BokC19NqZGK/7xn
         KbVw==
X-Gm-Message-State: AOAM5302/gAT+dSS2EQOtn03Eon9rkmfua7l8vr0S4xyLqBxQw18NBe2
        3QJ4isAvhXAUJ6xx6otiZ7Ht9UTz/7qNTmUNwO0RwEWQ1FiKGtEGwB0dpt+b75zm5XGTsNGxp9E
        F5Fb9MrjGu5UphspDsWR3wQwr
X-Received: by 2002:aca:de07:: with SMTP id v7mr12660084oig.8.1624650725834;
        Fri, 25 Jun 2021 12:52:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwksAeBpoAvEUezEdyZ5NcQyipuc4+d8PdYoULnG6dzFZDi28TVoKaNvmx21VMJfDFVEgV/4A==
X-Received: by 2002:aca:de07:: with SMTP id v7mr12660075oig.8.1624650725709;
        Fri, 25 Jun 2021 12:52:05 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o25sm1535446ood.20.2021.06.25.12.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 12:52:05 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 1/7] fpga-mgr: wrap the write_init() op
Date:   Fri, 25 Jun 2021 12:51:42 -0700
Message-Id: <20210625195148.837230-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210625195148.837230-1-trix@redhat.com>
References: <20210625195148.837230-1-trix@redhat.com>
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
 drivers/fpga/fpga-mgr.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index ecb4c3c795fa5..c047de8a059b7 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -25,6 +25,15 @@ struct fpga_mgr_devres {
 	struct fpga_manager *mgr;
 };
 
+static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	if (mgr->mops->write_init)
+		return  mgr->mops->write_init(mgr, info, buf, count);
+	return 0;
+}
+
 /**
  * fpga_image_info_alloc - Allocate an FPGA image info struct
  * @dev: owning device
@@ -83,9 +92,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 	if (!mgr->mops->initial_header_size)
-		ret = mgr->mops->write_init(mgr, info, NULL, 0);
+		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = mgr->mops->write_init(
+		ret = fpga_mgr_write_init(
 		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
@@ -569,7 +578,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	int id, ret;
 
 	if (!mops || !mops->write_complete || !mops->state ||
-	    !mops->write_init || (!mops->write && !mops->write_sg) ||
+	    (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
-- 
2.26.3

