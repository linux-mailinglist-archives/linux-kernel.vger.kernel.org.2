Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5944B440EE1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 15:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhJaOpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 10:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhJaOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 10:45:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D59C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so10744219pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=beclhWZk3zZOlcCh3M65MSbbbJkA4NCrMmRNtUJzgjw=;
        b=cPa3TvRtndC9F08ijkVxCIcA9hfQyiCNSmc+5tGVOEvSPq6DeO5449Oc6KSo4drY3W
         2ji9igIaQ3yYPLSLsh7zyZks9JvsZ6+vDEh7pwYpF+syP6JFrUnAmTaFqA299xrBfCqQ
         6ifE52tv6uUQQqoAisDng1ckQ4ZoAzKR+HgvTM5LDdWSrI9vgUjnEplU9ABQALT33R/E
         zDWrTgveSPBVFnT9buDbEjAJcmoKIzekEfdrjVvMsRpTZYGnuH+etosUGIPf3NcJJRnH
         zs5x1OAmDwtEaCpDx0zuokdgg97AWZzm9qGfaCfT70HwTP7XuTr/7+tJMKYlJprusiGa
         Dqkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=beclhWZk3zZOlcCh3M65MSbbbJkA4NCrMmRNtUJzgjw=;
        b=h9YVX9LNuC7LWLrjGKkA05x4Xx1LRm7FGZNzwyNdcIlUoYz2S8G+ra1IwpOSaMVCC/
         GoZx1uT5mVTq3Y/SNc4TBaFpx7WVobSLG4FwlMbrzDKzZ0QfpY0elzpGEe0mWd94A6rJ
         b0bRN/unwoOnLmbErHRw+izl87hkVdOTNHteOAFKIpyv1lClPDuEEFVDFirJ5IFmp/Dh
         /ab5Jsro0zzuXilclJM2M8LyB0mwnfnnMPfG7mVvcqzB4ljrTftg9RsITend81h1PgK7
         /73j5WHzws1ujfE7fKN81BPoMkn6YrVAR9KKeFoZFNeptuf5ExeqeXt6UsZjK2pH2oI5
         DICg==
X-Gm-Message-State: AOAM53041jzaEK4FZGZ7vdDVp2lQPbZpxtRtGYSSKAOCiVEV2GOCtmGm
        2b7UPOpWufwPyJc7WZYIWbCwNA==
X-Google-Smtp-Source: ABdhPJxxP8iviH2KsSwwMEIFD9QUMKimBYb9VpD3xn3ySaU04zl0IWmXoiK1P75a8LNwY/iJAgCpVg==
X-Received: by 2002:a17:902:a70e:b0:141:a01d:9d6c with SMTP id w14-20020a170902a70e00b00141a01d9d6cmr17132607plq.84.1635691360562;
        Sun, 31 Oct 2021 07:42:40 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id o13sm14332316pfu.90.2021.10.31.07.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Oct 2021 07:42:40 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/4] coresight: etm4x: Don't use virtual contextID for non-root PID namespace
Date:   Sun, 31 Oct 2021 22:42:12 +0800
Message-Id: <20211031144214.237879-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211031144214.237879-1-leo.yan@linaro.org>
References: <20211031144214.237879-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commented in the function ctxid_pid_store(), it can cause the PID
values mismatching between context ID tracing and PID allocated in a
non-root namespace, and it can leak kernel information.

For this reason, when a process runs in non-root PID namespace, the
driver doesn't allow contextID tracing and returns failure when access
contextID related sysfs nodes.

VMID works for virtual contextID when the kernel runs in EL2 mode with
VHE; on the other hand, the driver doesn't prevent users from accessing
it when programs run in the non-root namespace.  Thus this can lead
to same issues with contextID described above.

This patch imposes the checking on VMID related sysfs knobs, it returns
failure if current process runs in non-root PID namespace.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index e4c8c44d04ef..e218281703b0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2111,6 +2111,13 @@ static ssize_t vmid_val_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
 	spin_unlock(&drvdata->spinlock);
@@ -2125,6 +2132,13 @@ static ssize_t vmid_val_store(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
@@ -2148,6 +2162,13 @@ static ssize_t vmid_masks_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	spin_lock(&drvdata->spinlock);
 	val1 = config->vmid_mask0;
 	val2 = config->vmid_mask1;
@@ -2165,6 +2186,13 @@ static ssize_t vmid_masks_store(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 	int nr_inputs;
 
+	/*
+	 * Don't use virtual contextID tracing if coming from a PID namespace.
+	 * See comment in ctxid_pid_store().
+	 */
+	if (task_active_pid_ns(current) != &init_pid_ns)
+		return -EINVAL;
+
 	/*
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
-- 
2.25.1

