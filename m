Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5333499C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhCJVLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhCJVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:45 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61123C061765
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:45 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e6so12231019pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QQx7Pxxx+mjFZmngOFSgRWs39Wy/KkcCLmt4JFXcYU=;
        b=pbQ1RvOYSS9mMpaaqnGD602f1QyLBUTtYQ0Ud9mDz5HuiMsfCp8L6gW2bdhfR1FmhR
         3oJlrbAduJI6RUlrT/YbHj4gilA7BS2Pb3SyTV8Y5zZuOqTiUBIrOyy29TFVl0BiPSV4
         SNjRb0LX0dbl5pK+TWjdyBlfAYFppZYdy6iqQ/WVLlfZ5lwWywjgGgYdRcOd1QEiQTvV
         vD1K+TYfX9eK3v2fq9bTw/wnHByPMgKvmQDjzdXD6gTpHwwYwM4VLlpbQEvgk9vARfCR
         PtrRFD3dk+uxySXXd6ATSWKoGJL0HuwSJAS8FQ4trXCKiEUKwvl9htfR/XxMFiDOL4Hk
         DmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QQx7Pxxx+mjFZmngOFSgRWs39Wy/KkcCLmt4JFXcYU=;
        b=qzJvkMXCY5pE9CTpDAQuh4GH0F3LCYwtmGoZDMMDGkLU2ldGRCzRd6EDqkPGqyfXwZ
         Vms6D5Z2GxrX+CZSwfw2UvsjDsZQS38ak7Bj4G+gbpjlQBwZKP6rBthuW9jcwCkD3psQ
         rlrL2J4APkUfLOXTCZ1h8XA+DwCR5UnR8pRD0ax85hNf8pAqnUJlcwJ4YXY2UNp4u7Go
         Dccz13MQ2CRWbDiR9DMXsaSpMc0X4RN4RG1moE4ZkMaZPM4nqnkY5We0owARiCuiSqi6
         onlXB3yVoVjCQT5rs0WjL68NdGQI19EejxnI7GHfjd0o7Q9V9v4Nedvy0ShCXfN7icRH
         4aew==
X-Gm-Message-State: AOAM531ZEAZgWxM0v+vM0XQYx2rP8tfA80WP7EIqAX9DQB060ZK7L8YJ
        zh3A3aXe1uhkJjdcnFUGnzOyfg==
X-Google-Smtp-Source: ABdhPJzcnnEP/9C1ajt0OE4dPZUc+dynza0TgDIouMzYm24qatT8Y5KboL+6ejQrLMYrWp2BW5rLEg==
X-Received: by 2002:a62:7ac3:0:b029:1f1:5d13:5ec6 with SMTP id v186-20020a627ac30000b02901f15d135ec6mr4671519pfc.14.1615410644837;
        Wed, 10 Mar 2021 13:10:44 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:44 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 12/17] remoteproc: Properly deal with the resource table when stopping
Date:   Wed, 10 Mar 2021 14:10:20 -0700
Message-Id: <20210310211025.1084636-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a remote processor that was attached to is stopped, special care
must be taken to make sure the shutdown process is similar to what
it would be had it been started by the remoteproc core.

This patch takes care of that by making a copy of the resource
table currently used by the remote processor.  From that point on
the copy is used, as if the remote processor had been started by
the remoteproc core.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
New for V7:
  New Patch, used to be part of 11/16 in V6.
---
 drivers/remoteproc/remoteproc_core.c | 53 +++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index e9ea2558432d..c488b1aa6119 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1634,6 +1634,52 @@ static int rproc_reset_rsc_table_on_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
+{
+	struct resource_table *table_ptr;
+
+	/* A resource table was never retrieved, nothing to do here */
+	if (!rproc->table_ptr)
+		return 0;
+
+	/*
+	 * If a cache table exists the remote processor was started by
+	 * the remoteproc core.  That cache table should be used for
+	 * the rest of the shutdown process.
+	 */
+	if (rproc->cached_table)
+		goto out;
+
+	/* Remember where the external entity installed the resource table */
+	table_ptr = rproc->table_ptr;
+
+	/*
+	 * If we made it here the remote processor was started by another
+	 * entity and a cache table doesn't exist.  As such make a copy of
+	 * the resource table currently used by the remote processor and
+	 * use that for the rest of the shutdown process.  The memory
+	 * allocated here is free'd in rproc_shutdown().
+	 */
+	rproc->cached_table = kmemdup(rproc->table_ptr,
+				      rproc->table_sz, GFP_KERNEL);
+	if (!rproc->cached_table)
+		return -ENOMEM;
+
+	/*
+	 * Since the remote processor is being switched off the clean table
+	 * won't be needed.  Allocated in rproc_set_rsc_table().
+	 */
+	kfree(rproc->clean_table);
+
+out:
+	/*
+	 * Use a copy of the resource table for the remainder of the
+	 * shutdown process.
+	 */
+	rproc->table_ptr = rproc->cached_table;
+	return 0;
+}
+
 /*
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
@@ -1759,7 +1805,12 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	rproc_stop_subdevices(rproc, crashed);
 
 	/* the installed resource table is no longer accessible */
-	rproc->table_ptr = rproc->cached_table;
+	ret = rproc_reset_rsc_table_on_stop(rproc);
+	if (ret) {
+		dev_err(dev, "can't reset resource table: %d\n", ret);
+		return ret;
+	}
+
 
 	/* power off the remote processor */
 	ret = rproc->ops->stop(rproc);
-- 
2.25.1

