Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942F433499B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhCJVLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbhCJVKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:45 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710BFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:29 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id ba1so9130647plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KkXz7Q+zlIq4fjTeJz23Qytt+RMPnrKFr7q6Kz46gw=;
        b=uxghajg9JyNe+viMY5CmPx45ytmcbsKjTjHHbDoN/ea5chNBMZkGesEQe2w9XtgjeB
         CVLg5EuWCvv7rhnSGVI/+Lls4kdjZrn0JlYogFmvZ/ER9GQdvqRzzQyLMiDrO8uI19kF
         XVbHP9D3FUS+7XMcEEjeRZnrNs64IbV5kd17yqH6tgIyGfCxha6umk5tBaur9NiITS0y
         f9bN7mpQKzYPMKJK+FaGaXUOFLJ4GsVR3o3rAQj8HDAJfJT8v9BTzUIWXDO2SLtDXazN
         BqZO+zTp1ZKx7DELLH83J5maAdF4AWcdS2r13jjL9hb9xIIVCAqOTtcxQMgw7cNSthmm
         yD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KkXz7Q+zlIq4fjTeJz23Qytt+RMPnrKFr7q6Kz46gw=;
        b=d1Fy5XQ7D1WvLp4r31pkkbkoWc3GwIkUKjU8KPImVM5svbIAQwvNfx9XwVc+ArtYns
         XcpLijssk/Mfjn5jpSjMMcku8GdeRzdqzApi98idBGMOS3ATwc3+PRCkZKQgV4OYDnqg
         zYTJnEDxK9Z7Obnj+kaDgLpmlyrU9JLGH2vkoTM5R2WaILCLv//scCUSMhXIvaiHZiA9
         Q48F4vMEg2ClsHiHbKEeypp7dxORueAaQggm8l2DEUDvKU8OGSgCnCkAzGaRgJV+KVZN
         UckLrqD+Vh2sCPBlmw4msxBgyqB48EJnwHN6N78JMbrsaak4IXx6bv5vjaLZnX6pR0eX
         UxGA==
X-Gm-Message-State: AOAM530l9w+Q2q3Ux6kg+IAtp2+E+9WCDssDyJwSZokcjkjjB+wM7QTS
        nmBurqupHY8dZy+Z7OqhsIWeag==
X-Google-Smtp-Source: ABdhPJxpVSK/wCZdFiwxSc/jYo2GQZobozCzcsdExTvaG0N3ILT5bOh2mT/poVuSdphe5WV4A2rORA==
X-Received: by 2002:a17:90a:8c84:: with SMTP id b4mr5333915pjo.21.1615410629004;
        Wed, 10 Mar 2021 13:10:29 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:28 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 01/17] remoteproc: Remove useless check in rproc_del()
Date:   Wed, 10 Mar 2021 14:10:09 -0700
Message-Id: <20210310211025.1084636-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether started at probe() time or thereafter from the command
line, a remote processor needs to be shut down before the final
cleanup phases can happen.  Otherwise the system may be left in
an unpredictable state where the remote processor is expecting
the remoteproc core to be providing services when in fact it
no longer exist.

Invariably calling rproc_shutdown() is fine since it will return
immediately if the remote processor has already been switched
off.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index ab150765d124..d2704501b653 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2347,10 +2347,8 @@ int rproc_del(struct rproc *rproc)
 	if (!rproc)
 		return -EINVAL;
 
-	/* if rproc is marked always-on, rproc_add() booted it */
 	/* TODO: make sure this works with rproc->power > 1 */
-	if (rproc->auto_boot)
-		rproc_shutdown(rproc);
+	rproc_shutdown(rproc);
 
 	mutex_lock(&rproc->lock);
 	rproc->state = RPROC_DELETED;
-- 
2.25.1

