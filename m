Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05B53349A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhCJVLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhCJVKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:51 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61DCC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:50 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t85so7701113pfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN7h66rSqKzczqrKUwACdy1DE0E9dT7gEJY334oVOV4=;
        b=YsAjFMkpkwep25SwkBMcSnhfdoVYmzl5QqEIPCJbSwI74cnvyGX4V5wUqrnUVokUaa
         Wwe0fGdh9p1WmI8zDIGi0H/2xW+uWaCGsKbpdYsHH0KuFkUC1ijJUlmk4fxphEx+69qg
         HTt1iNg6dk3TlCiNPQpdrB5SA98/PtH21zClh6HwbkMMgDTQK3H4LD/w9Xjtuel9L87Y
         wrcjU/4YeLVOjlmoYb7vCgcbhXxtXTpQlm8/kA7JA0FoWh3bqIps41ay7knAgYM7n8gK
         gZW8oXhs0XmuEBFUWkuoZCdNwRBivGpWiQbNUe3feoCqhkONqvUdtMWWYcxvHwXnZ6+t
         j3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN7h66rSqKzczqrKUwACdy1DE0E9dT7gEJY334oVOV4=;
        b=PVxGuDb0FEmSbxnC4mmT3Qv8xgUPjtIMJR02FjrfdBGWt/qtJ1w3+DD9rzcpSk4f+n
         ieuxcrdnXXQPTJC0usLFa3ONCzza2sd421OVcTRf7ba4q5bAO5YpZBvDVrHDE7Crhkx7
         t0SyhIeeTFZUjAGyRjpUsZI75Do3MftnzIT39VN8wksg9VKaBr/Gfo0b25Og11Orcrly
         u5gQTzhrTxmJq2jfSLjJd505725QGeRD3mGxkmibSLbcUIi6M8/P5gK0YNL1lQz3xoBy
         pEeeQherTAb6UUPv16OxjRpvj7Hd4jsfQcCAS2ZcpBKzCmuxBnjOMBHVydfQiFRUcRVS
         +yRg==
X-Gm-Message-State: AOAM5320l8gLQ52L0B8sQ7hKRFP8ilW17ybgPz3cS4DfRnqA7zCSLTCp
        quSawbKs13HCk5/XbUxLv60IhsEqEhXEow==
X-Google-Smtp-Source: ABdhPJzs6qFZckDYQpoX8ZcZkgPLgiZxCtH5GIit2um4iAczXphI47IzrLx0Fu7OfibLOT1u5w3gIw==
X-Received: by 2002:a65:4386:: with SMTP id m6mr4472767pgp.384.1615410650544;
        Wed, 10 Mar 2021 13:10:50 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:49 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 16/17] remoteproc: Properly deal with a detach request when attached
Date:   Wed, 10 Mar 2021 14:10:24 -0700
Message-Id: <20210310211025.1084636-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached to by the remoteproc core.  For that to happen
a rproc::ops::detach() operation needs to be available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
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

