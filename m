Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E971233932D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhCLQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhCLQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:24:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17434C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso10966425pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eI1kKtC7UxMHnJr2s3EPvhdO8fxk/LLGwiTP5XOosV0=;
        b=PN3I/N+cZw3h9ju32YnKPePdVIlkb9rWTDrPR1H+sf0iQBboillD1Ozy4XABXxlxgl
         tR4kfyyUndZXkQy20Ue4q6oIooAG7AkJz2xg6OvD5Qn0tdjfUbjRhp6dT+bLmAFnZgIn
         qabxVcYESCFKaeqal12xhsAQVuHOTqfj5i4e3QMLy/ku+D4TqNIJOeyE4sSycoodrqib
         zjQoWnmNoiQ3OGm1Bb30TwajPHCBVtMZwWrsoac6MJLyT98QT70mtWNAPHEd4C6vg3oc
         twqTOthuGaMeqEmLfGPKu6Oz9CUsSrqUZaf4/fBvp3m1ulko7FDGVjbdSZFw08+mhlfQ
         btYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eI1kKtC7UxMHnJr2s3EPvhdO8fxk/LLGwiTP5XOosV0=;
        b=bdJvLFAI4Z6ujklIC91P+SV/tOxXan7GXc25pW1uaJ56SYMYlVlWn8JecOe50yLaFu
         9y3X+4lDX6jn62UVWUsc0mzNfy+21pfUBet1Ivq3ooEefCNLw97YdzmqN2eJSZgYik7r
         RUqwoNzQXro63MpQtkalYza8JSc4f8+x4CsGv7MX+/6crJxFWaEVEWT7YRGJ/QMgiHvG
         UKD8c9VBiu8ku0Lb11nmrSa6bybLE4fk1m8ezYw7tyFSyx7JIlEpWnKaV9sqyFTa7VAs
         pklb7KwOL+vuCleGQP/5jrD6q+N0AixCJFm95jvmDvEiqsa1iiKhCM83B+wEgwW80Agj
         EPfg==
X-Gm-Message-State: AOAM531FU3eLWz9jMcXSTWRg2yoQPe7V6qAEo7D33c0qrZc3p6W8SU/Q
        8mJcJ8pc16ho641xy5AsQwUOqA==
X-Google-Smtp-Source: ABdhPJw9Ety41d9+1S0ehwGBAbtc5PtAZap9bz25QR71iiVhnp4ffpOMpyA/ro2c+7RUb10y9JaF0A==
X-Received: by 2002:a17:90a:aa81:: with SMTP id l1mr15200425pjq.190.1615566297625;
        Fri, 12 Mar 2021 08:24:57 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:24:57 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 02/17] remoteproc: Rename function rproc_actuate()
Date:   Fri, 12 Mar 2021 09:24:38 -0700
Message-Id: <20210312162453.1234145-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename function rproc_actuate() to rproc_attach().  That way it is
easy to understand that it does the opposite of rproc_detach().

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d2704501b653..7b66e1e96e4a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1416,7 +1416,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
-static int rproc_attach(struct rproc *rproc)
+static int __rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1541,7 +1541,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
  * Attach to remote processor - similar to rproc_fw_boot() but without
  * the steps that deal with the firmware image.
  */
-static int rproc_actuate(struct rproc *rproc)
+static int rproc_attach(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	int ret;
@@ -1581,7 +1581,7 @@ static int rproc_actuate(struct rproc *rproc)
 		goto clean_up_resources;
 	}
 
-	ret = rproc_attach(rproc);
+	ret = __rproc_attach(rproc);
 	if (ret)
 		goto clean_up_resources;
 
@@ -1802,7 +1802,7 @@ int rproc_boot(struct rproc *rproc)
 	if (rproc->state == RPROC_DETACHED) {
 		dev_info(dev, "attaching to %s\n", rproc->name);
 
-		ret = rproc_actuate(rproc);
+		ret = rproc_attach(rproc);
 	} else {
 		dev_info(dev, "powering up %s\n", rproc->name);
 
-- 
2.25.1

