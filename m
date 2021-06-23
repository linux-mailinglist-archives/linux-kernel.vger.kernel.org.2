Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458643B2045
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWS1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 14:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229934AbhFWS05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nnushO3xnTHoZzlU30ytNGeGLULTAlS7H2DDhaf9BHk=;
        b=Hb+LLHJImoK2EsHZb3NFUpOJsgUGAef1oAcRkrhTMB38Cfwc85mTnIrfvUNSAYCISp7ILo
        Ix+/t5weEHCzzQ+RNpnnJc4jp7GoLSL4vlTYR7sGH1MfXLiVzyFxR/BJoGN8EvpdEevth+
        jM/6/c8BMq7hkSGDojzgg2kmC3HA+pY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-t-XP6kyNNzypVpCjzEZqHA-1; Wed, 23 Jun 2021 14:24:37 -0400
X-MC-Unique: t-XP6kyNNzypVpCjzEZqHA-1
Received: by mail-oi1-f200.google.com with SMTP id v142-20020acaac940000b02901f80189ca30so2199249oie.22
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnushO3xnTHoZzlU30ytNGeGLULTAlS7H2DDhaf9BHk=;
        b=MJCYlBv9uoFKxMQRCrl8CexSOxf+TxftPv+Q/0yfrY7//DCEQOagJif6mDq5l7usES
         eFkTk8cDeBOaHcm37sljCnnVjS74LTmd5FLNPdrrE7jkm7LvWkmWaJm95C75h8IbuL8O
         4LSTdh0nfoAooeZEKQzJ67zEkZkZ3KKfQlAVTqIVPtp89xDY2oY7P1AQkgMQA5xf+0ty
         aK8358XBg0Md72GzZktc0srSsmGnlOQR5mYHROYGIxmzYEdxa7f+f5gi3Bnt4YvbvooQ
         XgW+aGp9VU/dwPRPmW2ujstIwYOaRMWs35I+rSS+Kt3ERz4uB9Xa/YgrgDL6udCtLrDc
         tFtw==
X-Gm-Message-State: AOAM532bu7WjVosR1ZaMjen8Ob8pJsqDi55/vqa6dYrXcTPIn+upkkD7
        F0wN6FG1pu+Q5tAWDtGiAfFyxmoD08VPChCB+BAZHLaExnABHWIhXJNcflzdfKBk2esK48DkEDB
        XADOGqMF0QzCkz56XAxI4eHyo
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr1085015otf.282.1624472676162;
        Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRwK3CQevF5ggD6yIeDOdZ80qiz0j6vxnsGn0oIWl17p/tCiW1qUTO4zyKA8PqRdv8zMXuLg==
X-Received: by 2002:a9d:4a8a:: with SMTP id i10mr1084998otf.282.1624472676003;
        Wed, 23 Jun 2021 11:24:36 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:35 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 5/7] fpga-mgr: wrap the state() op
Date:   Wed, 23 Jun 2021 11:24:08 -0700
Message-Id: <20210623182410.3787784-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager should not be required to provide a state() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.
Default to FPGA_MGR_STATE_UNKNOWN, what noop state() ops use.
Remove unneeded noop state() ops

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-fme-mgr.c   |  6 ------
 drivers/fpga/fpga-mgr.c      | 11 +++++++++--
 drivers/fpga/stratix10-soc.c |  6 ------
 drivers/fpga/ts73xx-fpga.c   |  6 ------
 4 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index d5861d13b3069..313420405d5e8 100644
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
index 6bfc4482abbf4..7d50ce26bf00c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -589,7 +589,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->state) {
+	if (!mops) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
@@ -692,6 +692,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *nam
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
  * fpga_mgr_register - register an FPGA manager
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
index a2cea500f7cc6..047fd7f237069 100644
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
index 101f016c6ed8c..167abb0b08d40 100644
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

