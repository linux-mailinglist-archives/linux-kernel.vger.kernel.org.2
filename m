Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83134E630
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhC3LOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbhC3LNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 07:13:41 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u21so24164266ejo.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 04:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNpCOyMNkiM7RskYD5YI8LnEayyJ3ldLmYUYfKZgwsA=;
        b=puQENMnFSg14jWOc+XjDm+0Afloj8o5+AMGjZJDGAkrYynhSQRB7OCkDzXvuP+FSuN
         +C/irA2t+7Dibqc0l/mbdWuxFedtokqDd9YabkyzN8idQUp6KXlvpyuzrc7KrS6yI7c3
         mt0FdlV/LtbYPPGbVN1XcZlR6iZruXzNcWp7F9vrmTYG+onIwSfqA/iNW9BZox5PjYzj
         5A46RvZuCfM12zvvEGmn/z9GXj+u4lVhwZjnfKnq04ITnvilXVZSOQaIHDwtLtetnlip
         v8p4M+PnSMddo8hDP7EFbfMeJyI3+ytv/xeKnCxd0ANKD8XZSrc5dBWorNioggL76/GU
         I6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNpCOyMNkiM7RskYD5YI8LnEayyJ3ldLmYUYfKZgwsA=;
        b=OQvBfkNeHh3CB14DkY4AdG/hMpVijIKrT4TJtX0GogGn2STdIhUt1xRwJpiyC8Ls2F
         qgKPKKn+BcNrJzKHOPXxdMUT96Lp0kBqiSZzvjIoNUaXX/XD74DD6LCLXJ2Ns07QBfBo
         qEUfEN2uv6DbZNPB+Vm/SJHMmgL5VUl37TIhhSWHcD1CdBE+VUqImwLxt4pdGlVu1DKm
         t+YTkcnv2tniPQRKbKt+LdIDsLK8optMivo0aOoUPrNFzmG5h8RVlpmnbJTkodahEA10
         m0YtyUu7fQ7I4rVoLgdOuZqoeC+jsP/qP5YMpIAwi8oeg2gGzSCrrLWG5EelRmfPYj/h
         QMqA==
X-Gm-Message-State: AOAM530Lq4OYkIs0HJK7PheM87QCFNrGpmfA3Cr+PUbr7lgxjqOKxafd
        C3EVnTA8UoPJQVdOdtgEyODGrg==
X-Google-Smtp-Source: ABdhPJyxSO6KxBWlQP/h81pmaiaZNpf4qXP9nnxVebPRrCQbu3jIPS4XZXt2bbJ3W4JhuNo0BuuDgg==
X-Received: by 2002:a17:906:32d1:: with SMTP id k17mr32807663ejk.94.1617102819865;
        Tue, 30 Mar 2021 04:13:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id r19sm10961308edp.52.2021.03.30.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 04:13:39 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/10] drivers: nvmem: Fix voltage settings for QTI qfprom-efuse
Date:   Tue, 30 Mar 2021 12:12:34 +0100
Message-Id: <20210330111241.19401-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
References: <20210330111241.19401-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Kumar Bokka <rbokka@codeaurora.org>

QFPROM controller hardware requires 1.8V min for fuse blowing.
So, this change sets the voltage to 1.8V, required to blow the fuse
for qfprom-efuse controller.

To disable fuse blowing, we set the voltage to 0V since this may
be a shared rail and may be able to run at a lower rate when we're
not blowing fuses.

Fixes: 93b4e49f8c86 ("nvmem: qfprom: Add fuse blowing support")
Reported-by: Douglas Anderson <dianders@chromium.org>
Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index 6cace24dfbf7..100d69d8f2e1 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -127,6 +127,16 @@ static void qfprom_disable_fuse_blowing(const struct qfprom_priv *priv,
 {
 	int ret;
 
+	/*
+	 * This may be a shared rail and may be able to run at a lower rate
+	 * when we're not blowing fuses.  At the moment, the regulator framework
+	 * applies voltage constraints even on disabled rails, so remove our
+	 * constraints and allow the rail to be adjusted by other users.
+	 */
+	ret = regulator_set_voltage(priv->vcc, 0, INT_MAX);
+	if (ret)
+		dev_warn(priv->dev, "Failed to set 0 voltage (ignoring)\n");
+
 	ret = regulator_disable(priv->vcc);
 	if (ret)
 		dev_warn(priv->dev, "Failed to disable regulator (ignoring)\n");
@@ -172,6 +182,17 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 		goto err_clk_prepared;
 	}
 
+	/*
+	 * Hardware requires 1.8V min for fuse blowing; this may be
+	 * a rail shared do don't specify a max--regulator constraints
+	 * will handle.
+	 */
+	ret = regulator_set_voltage(priv->vcc, 1800000, INT_MAX);
+	if (ret) {
+		dev_err(priv->dev, "Failed to set 1.8 voltage\n");
+		goto err_clk_rate_set;
+	}
+
 	ret = regulator_enable(priv->vcc);
 	if (ret) {
 		dev_err(priv->dev, "Failed to enable regulator\n");
-- 
2.21.0

