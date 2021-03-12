Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3D339349
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhCLQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhCLQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:09 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F7EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so10976031pjc.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z++nDe1KbxQOwXuMBZocx2SGGQIMJC2S/9LC839MlY0=;
        b=dEFpi8aTE2Hk60yckTPByYR568S6yUjP9+TvhjVa2Mk/l9ACJ1m2UU4R6sSPSxPSMO
         RaV70NJQvdzkpX8/C98C7Uj+/Q46X9YPeunzqGsOfwYAQ+gykm43WATfCAszb5tyFmuv
         GST6g8cm1qQW1r8kYic1vLYpwNJdc1FL4JIX62mBrpdQj4+Vqvw7XVXCuYVNWd4uEPev
         lhue/blcKkOvz80iV6ApuJ1owjRkcHIYeDhPeGwwiMGO4ZzMpSNTWycONfAano5e7HMn
         rdAWBdkYF1PmTMf4Ejo0EJDDkh75vUmkeF0vJyuScsqy4vdbwwUtyP92yMSb+66mPMwu
         SbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z++nDe1KbxQOwXuMBZocx2SGGQIMJC2S/9LC839MlY0=;
        b=FBlNhViBOzUqPDf2q2ABa/NreHjiIduViG1VE8pRZnGEck0h+4GMbmcb+mY3qPCiTX
         +FwTGJaiYIJ6s8ngzkNP4FdZz0CDNJpGaTUC4WXBlijDMk6sPGiB4Cjw51d789NSutCU
         a0of2E64oJpkmr+E+QWSFHjJ9TnfXxDT/IqyKrF8qZm0wTNsIy20JTrTjjhSL2pg0ddf
         IQIebM3chzcJ/hQ8tQegGMsLnS7GHvnjPg2Dgswr57cjdSXEhR2/YVXReb+5157GkwZ7
         ZsD2td1jdGACMGurs57bgpmZ4++9NHXGGEdzSxpk3GscdpuywCD1UwumpjJFUv0YYmj2
         YfcA==
X-Gm-Message-State: AOAM5317xRhfrU+1dq6V5JIK7AhnKs6NHSh8DHf6ITw57eHlTqf4L/OM
        xL95ekYj2ovjs/S8MBfHx2L2cdBrgDqzcw==
X-Google-Smtp-Source: ABdhPJwOn+TVghc8Zxb7SvYP0+bKSsV+pl4TagUXNGdkFQEe3TVTEiXDzb5Y0svsD+5a3xOP4wykMQ==
X-Received: by 2002:a17:902:e5c8:b029:e4:c22d:4da6 with SMTP id u8-20020a170902e5c8b02900e4c22d4da6mr14523152plf.10.1615566309105;
        Fri, 12 Mar 2021 08:25:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 12/17] remoteproc: Properly deal with the resource table when stopping
Date:   Fri, 12 Mar 2021 09:24:48 -0700
Message-Id: <20210312162453.1234145-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
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
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reported-by: kernel test robot <lkp@intel.com>
---
New for V8:
  - Removed variable @table_ptr as it served no purpose.
---
 drivers/remoteproc/remoteproc_core.c | 48 +++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 0f151dbcdc36..37b3b7d494e5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1634,6 +1634,47 @@ static int rproc_reset_rsc_table_on_detach(struct rproc *rproc)
 	return 0;
 }
 
+static int rproc_reset_rsc_table_on_stop(struct rproc *rproc)
+{
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
@@ -1759,7 +1800,12 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
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

