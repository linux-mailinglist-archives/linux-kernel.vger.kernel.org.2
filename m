Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26987323486
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbhBWXyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhBWXhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:37:19 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E30C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w18so41966pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eI1kKtC7UxMHnJr2s3EPvhdO8fxk/LLGwiTP5XOosV0=;
        b=JYeh3wnybb4/m/UUR8LYuWcMywXegKKe2DxENoFrS8xZIgUWNzlNef/Jz6v/hiVsiP
         vQeR+YNRluWGmPtmVcduAElrCxHj/amtzcAQsk7k1opnA3cxk1NPbEEfW28RCmrCFU+i
         xinri+qaJjiwsZi+zvHwsgM6I4diKQaopxwU8k4vT4g4pPqHGollzxJtHQv+bfp2WUtv
         qcPJsmhxv+NsT4KYpMXyR77TxvcPjIZc2Zq2dF8STNuhPSr3n1dbBPBvmYz6z+LfOEEh
         uUNSv5lOQLVrFtQ81NC0TcOfgxgJloEjFPkP4RS2+8BeivYwe2Zr8/jqxEdYyVWy6qnP
         YnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eI1kKtC7UxMHnJr2s3EPvhdO8fxk/LLGwiTP5XOosV0=;
        b=UWtfA3/QL6drm5F6aLXEDKv0ZlrSt2uThmLoJpzpkmBplnC7RqsTicZqo22XOnKsfb
         x4kkWnUfGOlxifQMf+iioorbVshmxGoVVoMEztQQxW1Oq8IiVh9zMa/pFIjVIAcmBROJ
         GT+9HFe4XOq515Ndg/dk+5mgzuifxAtHCiDdwxyMOHhG+EAEs369OtOonGQAQm6WK0Gt
         6SOxPRXcvZIKpM0HTx3DkLudCtzSbAaADxyEG7ibixMcSxw2nFblNzo3rt+PmlhsMkV+
         LNO83gCzs+ylPJ7+6Wah5isuOIb6OddGmlZhSfcg/y6jjjIAgY4L9PQ5zCYCUjZE231q
         JBPQ==
X-Gm-Message-State: AOAM530k++vMhRCuNkODxFbrNX5A9zeuWZxKIIuC8pNPOvEXP7zvKA8A
        A3er0MNb4ONLKI1tIU/Qed9xQkIqHljN2w==
X-Google-Smtp-Source: ABdhPJzsi6TXNp0kZzJEbaem3F4zHgJtQu4fTQYb8U7x7qnmSjpWBBr5dEjDShlaI4BKVzv+X/STLQ==
X-Received: by 2002:a62:7c15:0:b029:1ed:9e29:5998 with SMTP id x21-20020a627c150000b02901ed9e295998mr12313479pfc.22.1614123319231;
        Tue, 23 Feb 2021 15:35:19 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c24sm311999pfd.11.2021.02.23.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 15:35:18 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 02/16] remoteproc: Rename function rproc_actuate()
Date:   Tue, 23 Feb 2021 16:35:01 -0700
Message-Id: <20210223233515.3468677-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
References: <20210223233515.3468677-1-mathieu.poirier@linaro.org>
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

