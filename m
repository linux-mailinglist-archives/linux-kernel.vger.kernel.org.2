Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E741ACD4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhI1KWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbhI1KWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:22:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B335C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:20:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m21so20637258pgu.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuSs/ib19QbHGtXBHlGySgf9ofW10LCByQaBGGoV3kU=;
        b=ZBIHdNR6WRdahMMs7iY2gY8u3399vXljRvMfnIohv+VndCaVUksCHDgGG1KUioWHmp
         SqrIXNOkLUTDPrFgDa7I1fGHQwWNFEmVHzVxosLlOzr9lbv9FxggG3bhr18jfL7yegYU
         M3WdHjdbh1OmjU2tQh8VUAoUJkOj1q+VLLAp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuSs/ib19QbHGtXBHlGySgf9ofW10LCByQaBGGoV3kU=;
        b=vG0e7MsjlvwpBpPlevfAlXSgrjHCPuhutStLgaIymuCpf1uISq59vvo/GhA4/5Xnu3
         vij+EC3Pqy/T8qzdQZk6pnpeNPaHF9S55a4vfqB0IqqJCqRWAtR3xbUpiIPz/2QN+i/e
         AeDIR75LSsFIHfsNOHD1E2sx3qPPfvoojYVYuBS4u7yAHI7A5KNzCFw7CCBdCE45jHnI
         f19dVZy9HE02EXOE+N8bohSG0mXzB1LXwXddMep0dU1R3jKB01cIFVjoFQgmgqoAxMbz
         GBC11ohlkC/VwNU/1OVLjDn6SpZnbJTUYt0jzoJ91u31JBNB96qyitInJBjFsiSJXhcw
         HWGw==
X-Gm-Message-State: AOAM530BjxxhEhAytXSva2TVIw9pV71hUZ6TOrBCyZfTnIKl2LnEt/mu
        7GffVQHo6EK2ROz5CCyIHmx5/3pHhAP4LA==
X-Google-Smtp-Source: ABdhPJwnlIf7Dv/oRueMSkuPEkejdDhbUSuTPNKiglgGErWUK5pSX5ncHwaUCsu7cHNlZebHjeYObw==
X-Received: by 2002:a62:31c5:0:b0:447:b30c:9a79 with SMTP id x188-20020a6231c5000000b00447b30c9a79mr4478831pfx.67.1632824428889;
        Tue, 28 Sep 2021 03:20:28 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:f6d8:1ad1:cc75:70fb])
        by smtp.gmail.com with ESMTPSA id z9sm19734576pfr.124.2021.09.28.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:20:28 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS)
Subject: [PATCH 3/3] platform/x86: intel_scu_ipc: Update timeout value in comment
Date:   Tue, 28 Sep 2021 03:19:34 -0700
Message-Id: <20210928101932.2543937-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210928101932.2543937-1-pmalani@chromium.org>
References: <20210928101932.2543937-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment decribing the IPC timeout hadn't been updated when the
actual timeout was changed from 3 to 5 seconds in
commit a7d53dbbc70a ("platform/x86: intel_scu_ipc: Increase virtual
timeout from 3 to 5 seconds") .

Since the value is anyway updated to 10s now, take this opportunity to
update the value in the comment too.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index d71a1dce781c..7cc9089d1e14 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -247,7 +247,7 @@ static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 	return -ETIMEDOUT;
 }
 
-/* Wait till ipc ioc interrupt is received or timeout in 3 HZ */
+/* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
 static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
-- 
2.33.0.685.g46640cef36-goog

