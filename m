Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F48B33934A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhCLQZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhCLQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:25:11 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D5DC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:10 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j6so12148704plx.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4yyaBEGVAJuF1cE5I5KagCnyr0kxeqqDbz8hFkGXj4=;
        b=wCNDAmgVCqt2qIVMTG/QwQDP3qUWhxwn+eKFtTYBxSagINdG3dJtOLkpPvgRxGwavE
         T0E7P3teqFNvCRACI9e+CDt0fDTXOIiduA7xjT0HCzDTz2gZSR9mlIpPbTUxYLIm0bSW
         vkqy8RFMSVInXsgKXfrzAgaIIXq5Q725TQ5cqpXHnHxao5LxTY4ePygVKyuYSSVTmlE2
         R66Llg+Pf9H0/+/glN2URVQ/31SIcc0M9tQ3Y4gWkCMP8AN0qhTNH3qw7EY4NJv73RpS
         segUMbKSmCxJDuyKydU4mSfBeV4exNmLS7qYtG55gH+nN94d5Fj3nIZ6XPw+fuejh3YY
         VgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4yyaBEGVAJuF1cE5I5KagCnyr0kxeqqDbz8hFkGXj4=;
        b=Tq35jMSCckIDrSY3bCNd/S0A0a2kiux/kQTKhJh77sCCpk0TbYA0L7RNepR8x0HMln
         M8TiRh4f+u9q36APCrYUiAm1YEc80NLIRfJIk9oDiQ+JFxwZEtu2cSPWWEnUHggkkCC9
         QLBhSeeHEx4hGqOY3w8c0mh6C1688/lFXLOe6UjqPvJf6kCVR6dcBfuRBYWvQ/GkHjsL
         hhgp0asL0Gsp3SjIpB24y6HpIdY6cTkVi/2OpnORsLFBCsEwg6is2w9QvWi9TPpgSx9E
         enhFA5Th7eI5Ey9ZcUSVuOaEkdWxPHMqhK0fELa7XMx662kfnON869kPcGNkR51i3jCB
         reEQ==
X-Gm-Message-State: AOAM530FXbLUjpc9FCS3oGlOKL+r6sHbU+f24OxCptnznSnHftFHof4V
        1MlLxfw9uvlcyDax9AWgX+Fq+A==
X-Google-Smtp-Source: ABdhPJxNuWURTnTc59nPIWCjU7CDO/E+RwrjkAMSR1hUaTIxUWU+BEPdBm+lexHx4pqNd0tHS82zFg==
X-Received: by 2002:a17:903:30cd:b029:e4:93b5:3547 with SMTP id s13-20020a17090330cdb02900e493b53547mr13731867plc.53.1615566310435;
        Fri, 12 Mar 2021 08:25:10 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:25:09 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 13/17] remoteproc: Properly deal with a kernel panic when attached
Date:   Fri, 12 Mar 2021 09:24:49 -0700
Message-Id: <20210312162453.1234145-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panic handler operation of registered remote processors
should also be called when remote processors have been
attached to.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 37b3b7d494e5..c00f3f8bdfcc 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2728,7 +2728,11 @@ static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(rproc, &rproc_list, node) {
-		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
+		if (!rproc->ops->panic)
+			continue;
+
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
 			continue;
 
 		d = rproc->ops->panic(rproc);
-- 
2.25.1

