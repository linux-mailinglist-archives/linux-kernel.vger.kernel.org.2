Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C04533499D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhCJVLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 16:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhCJVKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 16:10:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5784C061765
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:46 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so7942029pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 13:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//t8ceQV9F1IbLzcb1N9QjBaVQNk+K1abKjB3CMSp5E=;
        b=rfkm0nJEZoMdLtilTXPgnGadhHuTtG+vM1fymP6gqGdeCnlKc4F3KB3Uaq/4o3K8Cj
         ZbaN+Ybje2iSv1GM27/q82Hn5SvEDzItHSyb+kYTu3LNsulPhcXzLF8IbMQU6oNEF/iu
         MHnF625jXIXo225Nhk2Sxzxb+v7XZFpIAjZkW0mPrhJJmmdtRblLANQC8+1TlbXuB9QQ
         Gk9OKYl5UgQWNKLC7vouDjdEgoSgeJaWR5hHGu81uIrXlhXaNmaKc9C45M8dT5cnJagu
         qa0+ylB5RwENeF6kWFLCSSgbJeUTBQK2LKrqLl/gwb1h/Xtpx6f1q0SPjmDGDEY5WV7t
         H3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//t8ceQV9F1IbLzcb1N9QjBaVQNk+K1abKjB3CMSp5E=;
        b=OlaDkVgOOESO/Tp97DbDEJDvR/hXobp2FG2ivPw8AvhAZHGhqfVWencbbV7nXUqZPX
         8MDYdZZy/lRqnkdQ5kxsgRR7SLYfyCoynvgILKwbkhVl5s5gvO2HevvpaF/T0ZFYmb8L
         U+xEFVF2i7MbWi0mK11dXnRFbqk0DDrD217zlfOZwu5nwB1LzoqL128SR/0abxtW2DRC
         ljN7+s+J/GckI+GJrPjZpb9FbpvzTxEaisGiMjOMdVX26I9mEujdJmqdE1/4uwU0CquN
         W/GVDhOZkUMxxwefaudvFW+bE6GKaUc5gNfWc3tbTWmhwwrHIHWXX3LBMBMoPNwwnGde
         yzsg==
X-Gm-Message-State: AOAM532wX5GAH2yXpgkC0P6ezby9HMJ4Vm22YnjhwfvCdfJk7aJnhal2
        3kBxYB+IvfhKWftVhUqsUaiqXA==
X-Google-Smtp-Source: ABdhPJztCx1IRaiY8WWUM/s+nmMh+Th74pFv36zfIr1uIduR9+Qdsma6eynemzXDr+wNoGlEZmYNwg==
X-Received: by 2002:a17:90a:86c9:: with SMTP id y9mr5427957pjv.205.1615410646372;
        Wed, 10 Mar 2021 13:10:46 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j21sm371508pfc.114.2021.03.10.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 13:10:45 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 13/17] remoteproc: Properly deal with a kernel panic when attached
Date:   Wed, 10 Mar 2021 14:10:21 -0700
Message-Id: <20210310211025.1084636-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
References: <20210310211025.1084636-1-mathieu.poirier@linaro.org>
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
index c488b1aa6119..f6f0813dade5 100644
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

