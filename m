Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD9334988
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbhCJVK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhCJVKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D637EC061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j6so9114075plx.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eI1kKtC7UxMHnJr2s3EPvhdO8fxk/LLGwiTP5XOosV0=;
        b=UBK4sB9rPqlGopn6Z5INCKpCrPpZzqDE+I4XbK7nThpRAvYlKYvf3tUmJmo+qNLft7
         YEbmENwVcmoNpmuThUeSA66fABdXcBujiuxHZEPpA+IqXN5COkMH+bP1e84DJ9Rvk8zV
         NAdmN2K9aq5Tmi+2m/Y050H1+e3FtbhVLB7+NCUnn0p25IAeju0QiliJYJQFEkDIKVja
         psakErG2aFSIYt715LmTouU0MREfP0KYkWL4PgcZ4M90kwrZSi4Ex70mStUPAqJaFo8v
         bkd/Yd6wg9sis9/FaDXTVKnyAym3NHKxzbLk0HMjXfeFP7JBYOdS46A3WJCEzA+qdzDs
         uD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eI1kKtC7UxMHnJr2s3EPvhdO8fxk/LLGwiTP5XOosV0=;
        b=M6U0viFl01RIIMkEnQKljlIqyTSaj5x2R2Qt5VWIeSgExz3ojms9IubOBt7W9074NX
         bNxICztr94FO7sPJsfnPLptm/s9IOFSiWo/pa7lRjKBZqwMmJ708TEX282NZ+bs6Iftq
         ET2VPueYVcZUee8tSK7g8WroMxjIMELoKpkTjceBqrJASw1Xp2//5KDL3pP47LrmOQ9Z
         uTdupbYvdT6O1uS0MllTZLXK2R1F5yOpea4O14OqowtIAZsq7FO93j/W6YGW0zj15yhL
         UocDy3OPL1zMHPEPj7YoB2E1WU+iULHlpX6u2AYtEGLDrDB+IZas3+yfo2uwOdFsBqqS
         UlwA==
X-Gm-Message-State: AOAM530jdwfpy7ar1d4ABjFEmT6/ASAJ8KT3O8gNiyp1c2baUZJqZ85J
        YjsH9OpFSGUjElmAK1uqYhPJhw==
X-Google-Smtp-Source: ABdhPJy4lW4Frr82V0PylUcRUwzYr/y79yLaMzDeiCIpOzcFfrucwFzywRye98FeurtrRXubLxOEuQ==
X-Received: by 2002:a17:90a:bd90:: with SMTP id z16mr5579736pjr.123.1615410630433;
        Wed, 10 Mar 2021 13:10:30 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:29 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 02/17] remoteproc: Rename function rproc_actuate()
Date:   Wed, 10 Mar 2021 14:10:10 -0700
Message-Id: <20210310211025.1084636-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
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

