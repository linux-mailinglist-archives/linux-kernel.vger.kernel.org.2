Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F6133934C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhCLQZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhCLQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:13 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBD8C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:12 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t37so5398537pga.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AZdJoSgIJXSU7DnQv8lIz2Iv+j4owVE3/6SK24bo6uk=;
        b=d1s1Hv3DdcHyErIEyqH3yVFpG5V3lO/hah7vzMM+o/RrmOi1nUUVJJOFQid7jaOFqu
         /Rczir59gxWk9v85psOknIOLGxz5eS7nnm7Ep6hKbqUDlwv6X4I03OwKAVgFjsUxH1HM
         BNLWxdZW38ZWyLki1U9PPsl0jwcvcalk0qqzsTPkbFM2aGqBnPn5hQNsZ8qC0VrReK9i
         2GjsDzxSpOm0tQslrAm1L0BkD4b70za/K1TPwEkOLFIonRExzcK3V+kk+GRt1dRbyTV6
         x1dovn6BBe6Dh/sU0KgszeIAzVaPQhtOf5oNCiKqXC99VHyUbYqyTNQWk/HfJVfs/mMD
         mgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AZdJoSgIJXSU7DnQv8lIz2Iv+j4owVE3/6SK24bo6uk=;
        b=syjmNEVyqsfbBYBWIKkitVhzsD/Oc5zCeZbs5MZ9auOa1S7SgnMfRRhucdYc0VI/pq
         EbgBNTfW1lNqK/e/ocjyDZA0ldsAgXb1QCYodyx7bhq7sBOP88iOYkApTiRWEsxZqMSh
         i/lPnWl/GyveMXKoUIM1pnLY6TDO3iOViqPEf/iCLbdFmfR2S9ugmR5UdZPS7UAyeKBu
         0ivhGAxoAy4ims/tgBjYwmGJ04rRW2Q2QYdzcHnzDNOD6sf0F5FhgMYzEQDH5WIzoWuW
         zUchIQBWc5OaYTQP1E8L0OdV8zFRUPtu3myjyO1+bzJ7PQi7kbrRldKjYR/7Wxemyy3o
         incQ==
X-Gm-Message-State: AOAM531wPT4jP25yKk3T7aSsGSIvxNw3LdSSMgsqkjpzNe/Zv5ee0eao
        rQrT5T0oljDJT84m2f/eHewGPQ==
X-Google-Smtp-Source: ABdhPJxlMqe1nJc8niT81bokl2i7FzDOOm3XanPm1WN7Go5cCc4RR+0tUjxJNLyH76LMmwJwrNFCvw==
X-Received: by 2002:a63:d0f:: with SMTP id c15mr12221198pgl.367.1615566312454;
        Fri, 12 Mar 2021 08:25:12 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:12 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 15/17] remoteproc: Properly deal with a stop request when attached
Date:   Fri, 12 Mar 2021 09:24:51 -0700
Message-Id: <20210312162453.1234145-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a remote processor that was started by another entity to be
switched off by the remoteproc core.  For that to happen a
rproc::ops::stop() operation needs to be available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 3 ++-
 drivers/remoteproc/remoteproc_core.c  | 4 ++++
 drivers/remoteproc/remoteproc_sysfs.c | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index b2cee9afb41b..0249d8f6c3f8 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -38,7 +38,8 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 
 		ret = rproc_boot(rproc);
 	} else if (!strncmp(cmd, "stop", len)) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c00f3f8bdfcc..c985c5f6f2f8 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1796,6 +1796,10 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	struct device *dev = &rproc->dev;
 	int ret;
 
+	/* No need to continue if a stop() operation has not been provided */
+	if (!rproc->ops->stop)
+		return -EINVAL;
+
 	/* Stop any subdevices for the remote processor */
 	rproc_stop_subdevices(rproc, crashed);
 
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 66801e6fe5cd..09eb700c5e7e 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -202,7 +202,8 @@ static ssize_t state_store(struct device *dev,
 		if (ret)
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
 	} else if (sysfs_streq(buf, "stop")) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
-- 
2.25.1

