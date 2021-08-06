Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD753E26A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbhHFJAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244001AbhHFJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:00:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EFAC061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:59:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b13so10138138wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9oU6Dgh95pI7zAxpQ3mxDGSm81TQBT2TWjy1uK1gD8=;
        b=HPVQnz8/mFLVvNG0M7mL9vGIa62/sTwoRRWGsJ0xBxiVfuBAN+Elr1UNU+7DfGMajc
         WyV2DHrBXnlGkHbX46G3sPCN5477yevOC+V7o6VtdhaxjuFov+2XUqLVM8GKb3BGbyN2
         oFibhZYjNxAyoR2dhiY8R/Bi4nxqGZeeH6d8hiOSfAhh75SJmmt+dHmTNOvkGl67YlnH
         OrN6bbvsGEI6hgLYvwioDjOp/Q+2N1qLLkP29/fgDGm/xAv0Fj1WySVvgKCZc9CQuagx
         mKR2OsBjZ7Fnn69ttRTZaCWFOYdlWJ6K3iv1hIu+EEUM4zIJKIuS9v+4d81qetg1gm0y
         udnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9oU6Dgh95pI7zAxpQ3mxDGSm81TQBT2TWjy1uK1gD8=;
        b=kjQk2AHKa/xL5cq8jDwHJg0zE6g/hX5xWRs98EtEF6RthgyGiIoecB75631ngJ42/y
         Ys/ZENyrIxTzQZNwcHIJ8G601ncFjpDcCu3osYvwX4RMxZNTUX1+mXVCfIKs4RtB6Eu9
         ljG2/fvHCf9N91IblQXUlhwDilny7ATaQM/yN/a0JF//3mb4CLXkLN2DiXube54MoNl9
         SXj2+/lYxz/2HwLcxHJvwTq0+izdtkrq0hdnBCFYY3X0WbTfYCRP7kASxSWNx/o0meU/
         +RfV7qYgPlCvc4G2tcWZHmeJu7/gm0VbYxDtTKK1gM71At6PhrHojORjB9Z2lBrLYYnC
         Ka8g==
X-Gm-Message-State: AOAM530m7z2DlzRb0UhBEr4hPpDDIHP5aZd6ijOUW/egR9vQcHyG0jAW
        BuEWbLxRoEqaI4N3dp15PBGEfw==
X-Google-Smtp-Source: ABdhPJw1S/jC73/oNX9ipRsaFrTxDlAlByiQCOaHg7nkB9K+SI0PhpWRU5c6cF2CApiKjUsgZPcIDA==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr9443594wrq.67.1628240392421;
        Fri, 06 Aug 2021 01:59:52 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x18sm8506144wrw.19.2021.08.06.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:59:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] nvmem: qfprom: Fix up qfprom_disable_fuse_blowing() ordering
Date:   Fri,  6 Aug 2021 09:59:45 +0100
Message-Id: <20210806085947.22682-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
References: <20210806085947.22682-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

qfprom_disable_fuse_blowing() disables a bunch of resources,
and then does a few register writes in the 'conf' address
space.
It works perhaps because the resources are needed only for the
'raw' register space writes, and that the 'conf' space allows
read/writes regardless.
However that makes the code look confusing, so just move the
register writes before turning off the resources in the
function.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 81fbad5e939d..b0ca4c626466 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -139,6 +139,9 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
 {
 	int ret;
 
+	writel(old->timer_val, priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
+	writel(old->accel_val, priv->qfpconf + QFPROM_ACCEL_OFFSET);
+
 	/*
 	 * This may be a shared rail and may be able to run at a lower rate
 	 * when we're not blowing fuses.  At the moment, the regulator framework
@@ -159,9 +162,6 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
 			 "Failed to set clock rate for disable (ignoring)\n");
 
 	clk_disable_unprepare(priv->secclk);
-
-	writel(old->timer_val, priv->qfpconf + QFPROM_BLOW_TIMER_OFFSET);
-	writel(old->accel_val, priv->qfpconf + QFPROM_ACCEL_OFFSET);
 }
 
 /**
-- 
2.21.0

