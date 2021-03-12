Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B4339345
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhCLQZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCLQZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:06 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A30C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 30so7595576ple.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s41xNBSRWZdaT0/t4ukszEcW0OmYZRiq0VgJP9qHLTU=;
        b=N/OZ19vzKvAIJ45rejwYBpeamiYN00ABVqI68joDL+QjYaI9gYGoCi3Z+3GLz4XRb0
         hI12xVXbF7V1IwT9jLhof8caFqkLO+IZm9vOUqiJbygWJDLp0mNFm4UyeR+hcrxf/cy+
         iUkLGJs/uWcaBAqbAU1UgTlOMpffP4vypEvCfwf9L/vFp+lczPZGKm04wnJvRKhvMLOZ
         18XIb+Uh61beMhRc1ouGNQMo/khePGxGrd3fU9jOpiWdT93Bc/3tZ2VWij1s4tAuXctX
         ATo2QZvC8ey9nk3OEqEs1zWSFu1IrX4PelzWOkOK6eoAvRbLZRmuZn65tL/iOLRkFvs+
         FJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s41xNBSRWZdaT0/t4ukszEcW0OmYZRiq0VgJP9qHLTU=;
        b=k16nKNtsZigNohfldupB/anS/NgEvBXleWuJ9gc/xIsXMChZpaRudGoBnb8Dn7bbiR
         a6HpC0XfZY7W9wyUJZwd0U/DPvDmWLJV4bnbPs7lWx6bbRD+q8LIkhv6Dp82GKnmgf4f
         gCNuBee/rj9SSm7dszoW2lhXlaO+T5vlRLoG5SgT5w2MMA0oYqOyzs/gk2/gexuJtUDU
         Q+UH0m/1y6oXTcxipKYvSk9c5qA20jWY5JjZRZORpTrWAGp3zkUiXfAZbLDhY86tjRmk
         KbWN84CYmd1d7jKziEV4Z1p8GGIREk6bWhYfkGHkCw46uYfTIGOtdF2fz3VxafoZTKIx
         /wpQ==
X-Gm-Message-State: AOAM530QGgnSY4JVFa5Wa2ZIvV6SSufi7zSLTBlqtRFHB5I/RdwRguv2
        QqX+CD/gbdJnHzn+b5RSz5kB8A==
X-Google-Smtp-Source: ABdhPJy4xjO8O6EA3p4/QVUnSBaJ9fYPirTjbD+/VVyrO7DYDSm/KBsbvJSiwwZA7GMRhblw/5m7ug==
X-Received: by 2002:a17:902:da91:b029:e5:cd82:b4c3 with SMTP id j17-20020a170902da91b02900e5cd82b4c3mr13938873plx.73.1615566305939;
        Fri, 12 Mar 2021 08:25:05 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 09/17] remoteproc: Introduce function __rproc_detach()
Date:   Fri, 12 Mar 2021 09:24:45 -0700
Message-Id: <20210312162453.1234145-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
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
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 1d8bb588d996..f2a005eadfd5 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1706,6 +1706,36 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
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

