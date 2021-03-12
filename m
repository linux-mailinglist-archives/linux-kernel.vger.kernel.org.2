Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D48533932C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhCLQZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhCLQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:24:57 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA41C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:56 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n10so16192854pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KkXz7Q+zlIq4fjTeJz23Qytt+RMPnrKFr7q6Kz46gw=;
        b=goU7+hhY1A+/8UPZ/6wfKNvo1Wd5VQk5jmBUyB4029x3LFD06OY4N/dUHCx+6JCMXN
         4Gv604F1GGYcYScSB4t+ihHzgM2x8Ch7DVxgVNjczyeVTttmuU3DBliaoapfQk5O23Kg
         hiUyz5WqO+6GDpVzqB9HytOAgr9LMdDGgQLfcjzobhPwF9/CjmUhEgtIiKPMMsEH6CLp
         2tpDMCtV8g1mZzaQ5Rocm2jwTzFqtBEpB8iKUmpUpHVZo1zXml1JKLnFf+I3Op6D5iHv
         sRNaLOOxIOXudYl7cgQogN2Pwugrii5UcRF2dH4UnCTzdcZcTQYoKD2wXsIGLdA0udHI
         IPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KkXz7Q+zlIq4fjTeJz23Qytt+RMPnrKFr7q6Kz46gw=;
        b=gMYndKM+Dmv5bTjG/ek3f1Wbh9qAfjHnA733tUj+YCf1u0e3yT4QJO99aw7b8JaXhg
         EQS9vC0uLMn70webeLBOlJZgNSpDMyUcVf1HB2RXBGl5MmtmBM4tiY21ziTwFewZn6Th
         DhO91odYYzZp66wzfiuS7zL66KUC56G2X95lbMcZFrswFXENAu9VYo4rrn9BjBe54YQF
         KZ9sdYaNXD4V+xiewJ4HNaOhibB9ejDRjmWpOEWTdam03Y/GZxQSerQnx7rOUn9FSXS9
         Cqdv43S4a7XJDgV6+CdQE0oqM1IUWGwzE+5kZhgE5j4MuCNuqA3iTJhX3aS2WQZTBsHn
         IIwQ==
X-Gm-Message-State: AOAM5313wWyDRfkYn4+5upTPUxeXovF5KSD4mF9qEi2WJ+JSopFD417r
        USS3imYw4LX7Y9DiD/vINJv3lw==
X-Google-Smtp-Source: ABdhPJykxgaKFWIUgas1xT2OFrRSUDk0+gKUmLvfAEZ0CH1C6V+Xud5HnYNRHhvdgH1YX++ceZwngA==
X-Received: by 2002:a63:ea01:: with SMTP id c1mr4449870pgi.236.1615566296467;
        Fri, 12 Mar 2021 08:24:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e8sm5899599pgb.35.2021.03.12.08.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:24:56 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 01/17] remoteproc: Remove useless check in rproc_del()
Date:   Fri, 12 Mar 2021 09:24:37 -0700
Message-Id: <20210312162453.1234145-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
References: <20210312162453.1234145-1-mathieu.poirier@linaro.org>
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

