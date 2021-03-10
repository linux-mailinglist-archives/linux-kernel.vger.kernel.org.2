Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC33933499E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhCJVLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhCJVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:48 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2FDC061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:48 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 16so11472225pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj6WF/1oKuVocPkZDr0q35lcZZqhgtjB+hq21nBtWDQ=;
        b=DCemT085WWh7HRmlOaLcZsNEkgQDeuaeupj4twDJqjKQMYIBaQDdP4B3pYulTZxogm
         xKs8jVFDs0TwS2xzHbOm6tUFl8uSzVzZ2CcVDZY99hcKfe/B0jOaNGYw8Gw6O2fcMbo5
         885qqJ8rL5U8VlgQAwBwBPIgP6Ez6XbRqFc1Jt2Ia40m5zvNcFI2W2SSeLsx601r05tv
         +/hPPYID+yt1kH6NWkR9Z4dYJhHdrOx2VOzw67BtM6ikWSlR4AdrnpovnkiAxPsWlh9T
         2svoVz9KfinhKNXpxOZ0KVZmcBRVd6WhtjA6It2iFK5L43a7EIfMP/W+6cvdKYOJoP2R
         BV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj6WF/1oKuVocPkZDr0q35lcZZqhgtjB+hq21nBtWDQ=;
        b=e3q6PkGIgh+4jk7HMvt9dVHq4Wn+ENEj47NCobPiFFqiJzHJCEd6tcWhZrSH4Dz5T9
         sRNf1FNj7+cIkehPuOlnQdtBna1aLl5sea3Kd8GJuqCIOiM3Q3RILc0agHNT3B2uAfLY
         f+z1mV9cMPNM11Rx8noBIsYPLBYyf1abl9TLZ63gH8GaLzbcQaVcx+latqtaCtonJxOg
         DgwVcKo48XyDAaIntDrq2XA+k5TCTpThF1uBaOcel+1qBdxZ3U7SrwGyDCW/QvNMWn7N
         /0H2d6ckvaHUyZ+z5HB2iWVvtCAla1dCaHgUVuD22s9USZQqiue8bGM6GBzgzcrHqesF
         7dXg==
X-Gm-Message-State: AOAM5338uUFJ3LGNr+1l9yVzapDluwanf4CJhEIwspjr7gt1sRP2SMjA
        c2YBKlgFV0PrUWolERPikbXUmA==
X-Google-Smtp-Source: ABdhPJwmSvQMeZv5nlUk6YGFMWVuo1FI15Bi7595b0pAlm3b0R0XMWk6pjErVCdzPlnE1EBqEBKZlQ==
X-Received: by 2002:a63:531e:: with SMTP id h30mr4387018pgb.158.1615410647791;
        Wed, 10 Mar 2021 13:10:47 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:47 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 14/17] remoteproc: Properly deal with a start request when attached
Date:   Wed, 10 Mar 2021 14:10:22 -0700
Message-Id: <20210310211025.1084636-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch takes into account scenarios where a remote processor
has been attached to when receiving a "start" command from sysfs.

As with the case with the running state, the command can't be
carried out if the remote processor is already in operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 3 ++-
 drivers/remoteproc/remoteproc_sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index b19ea3057bde..b2cee9afb41b 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -32,7 +32,8 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 		return -EFAULT;
 
 	if (!strncmp(cmd, "start", len)) {
-		if (rproc->state == RPROC_RUNNING)
+		if (rproc->state == RPROC_RUNNING ||
+		    rproc->state == RPROC_ATTACHED)
 			return -EBUSY;
 
 		ret = rproc_boot(rproc);
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index f9694def9b54..66801e6fe5cd 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -194,7 +194,8 @@ static ssize_t state_store(struct device *dev,
 	int ret = 0;
 
 	if (sysfs_streq(buf, "start")) {
-		if (rproc->state == RPROC_RUNNING)
+		if (rproc->state == RPROC_RUNNING ||
+		    rproc->state == RPROC_ATTACHED)
 			return -EBUSY;
 
 		ret = rproc_boot(rproc);
-- 
2.25.1

