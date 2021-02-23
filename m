Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86D323494
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhBXAQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbhBWXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:42:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C1C0611BE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b15so48879pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skygqmTpwpFqHXp0ZsK0QIEBfsju4nOHMOtLAZPE+UA=;
        b=Fkfxqba5KS3e8uLyKOIcfVl1j5B95mT1rMRKDnEO5h2ddnC8Bxa9CP4mbLlZtFtkx9
         vqk+yoMuByYC0Mg/maHGla3K2ROMO0yRNYXC4UAXDJMSuMwhidb/MbVKEnK/pY4fXqEZ
         bWnhoj+R99HcmRPHWIbfZkzulHB214Mmsb2vug7Cr7iclMxThGLcHB0HKQ4oXkhsoB0Y
         HiT7tIEtdaBow9CFuyCQkdgjeOjpka+tXtFfdVjWvIrAYiAP04RduYO/euP+hHmCuy/S
         C2EoCSLs3NyndBUtke4wis2WOyNFxZPZFZCQvPLp9UDUcElnRkGyDJeDTIJxHV/3L8FU
         eGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skygqmTpwpFqHXp0ZsK0QIEBfsju4nOHMOtLAZPE+UA=;
        b=VA/Hzu3vQ64ydhhdmY26X74WP4KYy+2O13CEvSaSzoj8Vj6ChTCCGoILx3GgFCtCaF
         q7KygQsqNN4bKJ82MvUvneioVjIlonrMpi2et9JXKP0BNJlQ9M0OJpTr4MkXp7+UDBde
         haPaEN/REye6Syuzx5tgf82y9BJ+068vGh3pM7rwQW2xBvyKrOLF0Q27TyJbE5OwD04t
         09NIqjJQA33B72nBnJ5CYpA/Bv1EdQt7ALSWviMm5iFvPap0VSGrYYa9Sb1DDYUe0N0G
         qljmEDklQjHeMasdiX4IOssdlPmmc8Whjdfc+80Q7vOibyJl0L57M29E3XW6jQFs6cYv
         qE5w==
X-Gm-Message-State: AOAM531iBSszsO8TyNHiuIMjxune+sAL2WU+Izfpyxd7rmCzW6kCTqoK
        KljD9ApsYoTKyNJ/H3ebrj3FJA==
X-Google-Smtp-Source: ABdhPJylws8xRS7yb6Lx8oAsaa4CQlYQ1WGcJw/Rv+dLerg4frRX3/lypczOzj811/g3w5SiIH0aKg==
X-Received: by 2002:a17:902:ec83:b029:e3:ec1f:9def with SMTP id x3-20020a170902ec83b02900e3ec1f9defmr15096233plg.11.1614123332545;
        Tue, 23 Feb 2021 15:35:32 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:32 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 15/16] remoteproc: Properly deal with a detach request when attached
Date:   Tue, 23 Feb 2021 16:35:14 -0700
Message-Id: <20210223233515.3468677-16-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached by the remoteproc core.  For that to happen
a rproc::ops::detach() operation needs to be available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
New for V6:
- The RPROC_RUNNING -> RPROC_DETACHED transition is no longer permitted
  to avoid dealing with complex resource table management problems.
- Removed Peng and Arnaud's RB tags because of the above.
---

 drivers/remoteproc/remoteproc_cdev.c  | 5 +++++
 drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 0249d8f6c3f8..2db494816d5f 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -43,6 +43,11 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
+	} else if (!strncmp(cmd, "detach", len)) {
+		if (rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 09eb700c5e7e..ad3dd208024c 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -207,6 +207,11 @@ static ssize_t state_store(struct device *dev,
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
+	} else if (sysfs_streq(buf, "detach")) {
+		if (rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

