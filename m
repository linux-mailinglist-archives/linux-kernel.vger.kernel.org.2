Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2A839E54F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhFGR0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231384AbhFGR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:26:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5k+k/BkzK0E2Fb8ne6IfEyRpjN4V1PdloHP6kDhHkg=;
        b=Fwx/+C/nkOgPIKyr9MjehFDGHSWV3mHMTjCKjrAKODwMf1Eq0CkyWeLyg525X9gmcQkSTk
        M4A5qwmoN7925pXdtJxwgraxrmyb23Fr2G1I5bQ2A1Pi0jZBHrHf/60ACEk22PA2+56mMl
        oGJzC1YAdLtg5koR9GRFHHb7Y3gLayo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-D3v6LDAgN62MJQsqU8Ts5g-1; Mon, 07 Jun 2021 13:24:35 -0400
X-MC-Unique: D3v6LDAgN62MJQsqU8Ts5g-1
Received: by mail-oi1-f197.google.com with SMTP id p5-20020acabf050000b02901eed1481b82so7398605oif.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5k+k/BkzK0E2Fb8ne6IfEyRpjN4V1PdloHP6kDhHkg=;
        b=mv3kPOLFSRJtbhLMxed2Mbs2GaWNIsmqrg86vYPSyUEP9wXzChGzWghgWkIQ/nkC0j
         WNNwqs1scNOBb9pScvH3XH9BnCZ8VIHGJPoWcVJKim7zXgOV3gyX7u1lzV62bc7J+PXL
         60i6X40kpbpMGMBXgjyV1Odo0+0OkKMrSaV6nhHXVitnoYjXxEHCH4XbV0Xk7doIF2ai
         mdiNWi9U3O3CvRiUL+iA7oFE1zmLRfS7juz74daj/avXMWkKOr8n9E46emPwmLaPDTsT
         N0fHLwcnK+7LvI/U4DDRTJ5fuh5l11DCbWeNsjfAei5qMOVkXPSAIcilh4TBcYS3eXs6
         V9rg==
X-Gm-Message-State: AOAM533ZEKas+WdWDoztaSJvw2svcSuRXeTl/aKAuWlDMtW1lqv6dULw
        1RmPgYAJlJwnVy5X9Uwq266QaeJ8TNuJhSyEKfkgdXn31cq99yhA2OHHkEpvT+gSNIAlEhyYW1P
        AU1GMASAUe7x39n4xMJ2P+7hb
X-Received: by 2002:a9d:29:: with SMTP id 38mr14916718ota.30.1623086674615;
        Mon, 07 Jun 2021 10:24:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdkpS0Guz//cpGeFC9kznpgrVRbhlD0K8fyi/LgsZtWiEH9dfWzy9fSlnLDe0GSy4E+y4ipQ==
X-Received: by 2002:a9d:29:: with SMTP id 38mr14916708ota.30.1623086674460;
        Mon, 07 Jun 2021 10:24:34 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:34 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 5/7] fpga: wrap the state() op
Date:   Mon,  7 Jun 2021 10:24:00 -0700
Message-Id: <20210607172402.2938697-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The board should not be required to provide a state() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.
Default to FPGA_MGR_STATE_UNKNOWN, what noop state() uses.
Remove unneeded noop state() ops

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c   |  6 ------
 drivers/fpga/fpga-mgr.c      | 11 +++++++++--
 drivers/fpga/stratix10-soc.c |  6 ------
 drivers/fpga/ts73xx-fpga.c   |  6 ------
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b306..313420405d5e 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -252,11 +252,6 @@ static int fme_mgr_write_complete(struct fpga_manager *mgr,
 	return 0;
 }
 
-static enum fpga_mgr_states fme_mgr_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static u64 fme_mgr_status(struct fpga_manager *mgr)
 {
 	struct fme_mgr_priv *priv = mgr->priv;
@@ -268,7 +263,6 @@ static const struct fpga_manager_ops fme_mgr_ops = {
 	.write_init = fme_mgr_write_init,
 	.write = fme_mgr_write,
 	.write_complete = fme_mgr_write_complete,
-	.state = fme_mgr_state,
 	.status = fme_mgr_status,
 };
 
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index cc531f0537ac..d06752be9c6e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -589,7 +589,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state) {
+	if (!mops) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
@@ -692,6 +692,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
 
+static enum fpga_mgr_states fpga_mgr_state(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->state)
+		return  mgr->mops->state(mgr);
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
 /**
  * fpga_mgr_register - register a FPGA manager
  * @mgr: fpga manager struct
@@ -707,7 +714,7 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 	 * from device.  FPGA may be in reset mode or may have been programmed
 	 * by bootloader or EEPROM.
 	 */
-	mgr->state = mgr->mops->state(mgr);
+	mgr->state = fpga_mgr_state(mgr);
 
 	ret = device_add(&mgr->dev);
 	if (ret)
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc99..5219fa1b555a 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -388,13 +388,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 	return ret;
 }
 
-static enum fpga_mgr_states s10_ops_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static const struct fpga_manager_ops s10_ops = {
-	.state = s10_ops_state,
 	.write_init = s10_ops_write_init,
 	.write = s10_ops_write,
 	.write_complete = s10_ops_write_complete,
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 101f016c6ed8..167abb0b08d4 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -32,11 +32,6 @@ struct ts73xx_fpga_priv {
 	struct device	*dev;
 };
 
-static enum fpga_mgr_states ts73xx_fpga_state(struct fpga_manager *mgr)
-{
-	return FPGA_MGR_STATE_UNKNOWN;
-}
-
 static int ts73xx_fpga_write_init(struct fpga_manager *mgr,
 				  struct fpga_image_info *info,
 				  const char *buf, size_t count)
@@ -98,7 +93,6 @@ static int ts73xx_fpga_write_complete(struct fpga_manager *mgr,
 }
 
 static const struct fpga_manager_ops ts73xx_fpga_ops = {
-	.state		= ts73xx_fpga_state,
 	.write_init	= ts73xx_fpga_write_init,
 	.write		= ts73xx_fpga_write,
 	.write_complete	= ts73xx_fpga_write_complete,
-- 
2.26.3

