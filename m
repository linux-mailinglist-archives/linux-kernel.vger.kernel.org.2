Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB2319707
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBKXtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBKXra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:47:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDFEC06178C
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so4180176plh.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDRxGrQMToW3Vor3njhDmnUs8pFP7mgJszB9Khz+OuE=;
        b=pZyDs0BtrY8aWl00bxfY7/rUW4h0wlDAGZF0GeV3Qjiz2SqmaEQrAI4QSlfRj8N+9t
         PoVI/WLAZ3NDxNM5hkalhv6HF2k3fvD7jDtXfybSOhTpY4bDRLir4Cf1R2adpqvrhGQy
         5khsgwhoFSfmPZcXdo7/JDewtBmkZAk1IYQdDFq2cTDIxiiUEkd9nye2qvckKooNB/X2
         QJ+5nOWUGzNlS5whigrKloP656FOAc5MvLSt0LX1/X4B2rtoZN04Ktd/b0f5gVc669ws
         TQHICqjLS0U3PlKZMtwHKwDQIusCVq0qcEa4zKMWQwM1hLfrNnCcIOmKkw+mH/c/EZev
         jddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDRxGrQMToW3Vor3njhDmnUs8pFP7mgJszB9Khz+OuE=;
        b=LjEuwCRwlVSaYYdgYT5ke33+60w9fFvrIjwCLKmT20jXqKbwWE1aCmNGw7L0y3n+Ik
         tLVIXD8sC6UF0w7lL5F4u4tv18Zx2yqwbqZZbn25Ejw3+gspO3wpbqFUHaFYPFJ82IPP
         FcJuqvnzo7/VBpjZSbT9wWDej4xwT+KPi5u/YaGoDzirVQEt1VoOg5YnPSNVAcQvJInf
         jvsGWBDOToxigXV5f9cpds6MMaFl7c4VS04nOepfkkgsb1UkNPMnLlVbu8pdtey84pH/
         SqHyGuiGs0zRSgNlVSYF4TYyLoWH8HRNBvU1vfFU1Slr9R3ugR4ptJacjeoFMqT71fIp
         tYDw==
X-Gm-Message-State: AOAM5325/wMNBcQky806MgaC3ucclk1q7gOxbJzAlByTxEj8cbJiCokS
        68LMO6TezUkG8yvA3O9POYE0qQ==
X-Google-Smtp-Source: ABdhPJxLsHBBc4Hj7/zp8fSObveC7Gc5G+rloz07Pb/qyttL9SyyFfR9mw9l7nxeJl8Dn3HHTIye3A==
X-Received: by 2002:a17:90b:945:: with SMTP id dw5mr186517pjb.34.1613087191843;
        Thu, 11 Feb 2021 15:46:31 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id iq6sm5932740pjb.6.2021.02.11.15.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 15:46:31 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        arnaud.pouliquen@st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 03/19] remoteproc: Remove useless check in rproc_del()
Date:   Thu, 11 Feb 2021 16:46:11 -0700
Message-Id: <20210211234627.2669674-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
References: <20210211234627.2669674-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whether started at probe() time or thereafter from the command
line, a remote processor needs to be shutdown before the final
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
index f1c097572e01..86bd66955060 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2350,10 +2350,8 @@ int rproc_del(struct rproc *rproc)
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

