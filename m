Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB30141ACD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhI1KVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbhI1KVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:21:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09BC061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:19:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so2414575pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=307zo98Pf9/K51+TuRR4FuJM+VSLAW6UcJ7YHyiqNoA=;
        b=RFbbOFTawsd9lgpA9ERboTArp1HQt2P2jVb4if0BsJKv8rX9kW94LbBeLEHMmR8Nyx
         CQvZ9hWzzBk3rV5b71H1TOy8NcyETyzg27iqDMwUD7+AVZfecavtk8vnRcZh083UJw8L
         fWFrADLlAvn4dk5dh3UxIJQJpVWcWLgo9kgnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=307zo98Pf9/K51+TuRR4FuJM+VSLAW6UcJ7YHyiqNoA=;
        b=kOlfopkM7506uOB+mKOj8Dla4nUdw8iNyZEiyWaLE6Hs3apZroOaeneY6rHax0v1N2
         lnMp7/PH5ZWIm2TwflTxsIUCXiWuZV9TOd9CO04Ri8ldY3IaDPKBNRJevOonAEHKBE1N
         y0QDp+5VM3GV5kyJCFzBukjCv0Ccubo092/7HzMyjzF3wi2yh3q+KOKegM4ePdSga0wW
         9tEDQrZqDwITuW1TB0weTMlBP9RYl86xWwKpoulOitlWCBl3DARihJN+UJhnRbI1sYNx
         plYyLr2u8uHtYeKi5crGwM0E0+twE3JIL3LAItwKqyfRWcLD4wDgQfP4tSjHnWvos4vT
         tDTw==
X-Gm-Message-State: AOAM532grQx6ICam0SrLd0GZJF1nm+/zl4bnGVYcEZVitODn+kCB79p8
        doVpqTM7nm5Ty7JWlFaMrLXnOGhJT8q7Gg==
X-Google-Smtp-Source: ABdhPJyoxPlfbOYXh3NzbhLLJ498qVz0nfRmNl86nClaS8S5opBmfskVD8/FZDvTt+1XtRFiplaeVg==
X-Received: by 2002:a17:902:8494:b0:13b:9365:6f12 with SMTP id c20-20020a170902849400b0013b93656f12mr4409023plo.19.1632824396338;
        Tue, 28 Sep 2021 03:19:56 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:f6d8:1ad1:cc75:70fb])
        by smtp.gmail.com with ESMTPSA id z9sm19734576pfr.124.2021.09.28.03.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:19:56 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 1/3] platform/x86: intel_scu_ipc: Fix busy loop expiry time
Date:   Tue, 28 Sep 2021 03:19:30 -0700
Message-Id: <20210928101932.2543937-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928101932.2543937-1-pmalani@chromium.org>
References: <20210928101932.2543937-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro IPC_TIMEOUT is already in jiffies (it is also used like that
elsewhere in the file when calling wait_for_completion_timeout()). Don’t
convert it using helper functions for the purposes of calculating the
busy loop expiry time.

Fixes: e7b7ab3847c9 (“platform/x86: intel_scu_ipc: Sleeping is fine when polling”)
Signed-off-by: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index bfa0cc20750d..cfb249da2a7b 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -232,7 +232,7 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 /* Wait till scu status is busy */
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
-	unsigned long end = jiffies + msecs_to_jiffies(IPC_TIMEOUT);
+	unsigned long end = jiffies + IPC_TIMEOUT;
 
 	do {
 		u32 status;
-- 
2.33.0.685.g46640cef36-goog

