Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE96319725
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhBKXwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhBKXtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:49:01 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F502C061B3F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:40 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j12so4705107pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8ZgBr2dAQyxtUR61d2cd3HaOU57hXG+26qgFPCFdBI=;
        b=Dl2LvQjPNpm6v5pNg/beWWjx3gn0Yx3N3EKYMuqSRq2/+Wms+YUUpCARpU7RRc13ps
         suzbkYzATDsQV2OWgYy7yVRgiODXzlyQCNqk+YkrM9+/F+uxFv8pHoaKAjcGZivKPROp
         o1Ex0bgngOJ6TDxgT/kfSVe+MmitK/+6qCyLh605rt6twllmfl7aXFiKOGO6GklcqoMT
         WxucP5W2wDMNQbI0qiKK+Rjm7bPKEWoX9t+bvbhXruBPSDJmF7i/AppsIDimmrxr+xfd
         k3Xa7nJF0Ah/BZ1x4tWRJEgVI9iK4zbPWoyViEJLr6lbtnEDiNh+ZpxLbhqENPQjdaKj
         O1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8ZgBr2dAQyxtUR61d2cd3HaOU57hXG+26qgFPCFdBI=;
        b=cBxEuhMrAd1tnNtSoK/VcpGG8wCgeiZNph4+TnnylXmxFqjBEM0HHftlXeVBtKV92v
         nleglZ2kFukZ8mirYsMEaGH6PWwhpX8aZKDMVxp+4lCL4op1Su5dVyUZ/7RwMOM/pwqc
         nl5z7CBJnKe113sQtKTK0NFSxS7sChpULgUOrwzQanNSnuXZDrBSuaVg8AIR7mkwQKLE
         EuWH7BoqlKq9UPhT2bGgkFMXGX68f7vBzMebJf8x51OazycnBDJDYwslSQoX0+Tz2cKq
         gzRSJ5RlZ1Xm+1SPTCfgwe1yHsH7x6eAKKTMcy3KxNTOPyUSpQZrrBmLukoqQcN9eAGo
         3O5w==
X-Gm-Message-State: AOAM5309q4zdAqk0K5Z3E3xTma+I04aaiyQhL8lGIz8D3E8OMgz6Aegf
        ywrvTfTTqU096AbavD9WjXEHsA==
X-Google-Smtp-Source: ABdhPJzmfqQcrjRt/WWfrZZvtqMKwxmZvmqLVJNwaF4bumUxxv1zkneASJ7O/K5PMvd3lzZBSHna7w==
X-Received: by 2002:a62:7dc4:0:b029:1ba:765:3af with SMTP id y187-20020a627dc40000b02901ba076503afmr424252pfc.78.1613087199769;
        Thu, 11 Feb 2021 15:46:39 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:39 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 11/19] remoteproc: Introduce function __rproc_detach()
Date:   Thu, 11 Feb 2021 16:46:19 -0700
Message-Id: <20210211234627.2669674-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce function __rproc_detach() to perform the same kind of
operation as rproc_stop(), but instead of switching off the
remote processor using rproc->ops->stop(), it uses
rproc->ops->detach().  That way it is possible for the core
to release the resources associated with a remote processor while
the latter is kept operating.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
New for V5:
- Removed fancy error recovery when ops->detach() fails to replicate what is
  done in rproc->stop().
---
 drivers/remoteproc/remoteproc_core.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5c52c612a7f0..b150138542d4 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1709,6 +1709,36 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 	return 0;
 }
 
+/*
+ * __rproc_detach(): Does the opposite of __rproc_attach()
+ */
+static int __maybe_unused __rproc_detach(struct rproc *rproc)
+{
+	struct device *dev = &rproc->dev;
+	int ret;
+
+	/* No need to continue if a detach() operation has not been provided */
+	if (!rproc->ops->detach)
+		return -EINVAL;
+
+	/* Stop any subdevices for the remote processor */
+	rproc_stop_subdevices(rproc, false);
+
+	/* Tell the remote processor the core isn't available anymore */
+	ret = rproc->ops->detach(rproc);
+	if (ret) {
+		dev_err(dev, "can't detach from rproc: %d\n", ret);
+		return ret;
+	}
+
+	rproc_unprepare_subdevices(rproc);
+
+	rproc->state = RPROC_DETACHED;
+
+	dev_info(dev, "detached remote processor %s\n", rproc->name);
+
+	return 0;
+}
 
 /**
  * rproc_trigger_recovery() - recover a remoteproc
-- 
2.25.1

