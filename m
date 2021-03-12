Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB633934B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhCLQZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhCLQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:12 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7581C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:11 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t26so16197006pgv.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj6WF/1oKuVocPkZDr0q35lcZZqhgtjB+hq21nBtWDQ=;
        b=gtz428PBLEgDloxKNuUGPr92ilupj59j2EfFWY0/N6WmAnATRxpQJlW+J2ee8AQHav
         xfm/Xf2HxlRVeNugLHL+U4NK/rWK5UJwdN7EfSosWKr3Zt4TBkWgoN5gxNkvHYyl37ew
         wTLuoegWNmHdbT1yapt1sRmrpbJFDYR80XDVQgf9zEXVpRYxrykMcKshqEyybiNI1g/+
         jIPrVankCXpF2yQKIzgKc3SRrrvlTrz2bdl5FITvFh/l09kH6c8OChMhbgTMBAroPgIq
         dRrowcFVCygaFx/jN2st9jMIN6PuKz34cElkxvTGRjMivbDKekwO6IJqP8vq2Scn2hAs
         yumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj6WF/1oKuVocPkZDr0q35lcZZqhgtjB+hq21nBtWDQ=;
        b=TaZIWbUZTniOSxsPNyiXQQ24GjMYQ24VFz8d+swCw5sJByANWHprBjPGxN3MlgewoD
         pOmAARcLfDer2vV3kDGA0Bppqcg6shqNm1keES6vWgQicjHnVj6cYvtof314glUnAqVb
         GLnjO4ze2ZXm2XW6cWMG/FZvEUnKfAEHIR5hat5jew5XQYziQPfDfZlFID7MyalslXHf
         kNb30LMJeRKd8pMB85ywwDFtpZLn2JyfQ4clcubBy9y2r8iqJmvssXyPiSwM+SsX2o2T
         tzSXlZBco6IjlldQJdNagGlyVulkwnq37mihvkRIjanAoVrIqpCFOsPe9ArI1cyGc9ii
         asuQ==
X-Gm-Message-State: AOAM531gsxkgI2jVjSZ1csF9zmP+ZYnFSk34CbzwxCQy6B5+R9LvYh50
        Sw/dk3C3w0PR9tUfh3scYCPNAg==
X-Google-Smtp-Source: ABdhPJxGBgOg4XUMLZgE8bHRgl/Ot16rbp7CVs6Kqzly1An+KF889/k2eE5hVl0egydVPzDpTey4aQ==
X-Received: by 2002:a63:135e:: with SMTP id 30mr12705562pgt.6.1615566311426;
        Fri, 12 Mar 2021 08:25:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:11 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 14/17] remoteproc: Properly deal with a start request when attached
Date:   Fri, 12 Mar 2021 09:24:50 -0700
Message-Id: <20210312162453.1234145-15-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
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

