Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 799F6310B24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhBEMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhBEM3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:29:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70197C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 04:28:49 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z22so4773513qto.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 04:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuzCuraPFhVh5acs3bQJWGrLTwx153p3pnn0Db+JmnA=;
        b=MIrF8jxzGfsGAi2WN7n1PRsuYlURSHun8L+M8DtCRcDbTr+GgATZssox6S/5HtYrLp
         cuwJMPh1HkIC5v2m1bjhfUYkVvRtyjxxvyGyvliKTDbUl1dcE8yT8hq6gnPy/8TnHXrD
         JaATHaO6nXaOs2Tosfsa8v3/MGtr36xKTaRh+ERVid4yzjX8ynR5vh0iA+1zHPPj3j8c
         DHj2fuYR8FkotrvReffuO/qJ7Bvbu90HXBM10Ng2Iw29CbRIUwgNh2M/6UpOymg0H60/
         xAWE8FY9gUrGxC/pG7Q9Oh572i043pIfD4eXgpLVPdastoxSUJ1/wImmpoMAK3AOyMnj
         6O6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YuzCuraPFhVh5acs3bQJWGrLTwx153p3pnn0Db+JmnA=;
        b=Wem7JC2kkBKmtx7gadQCiyrgqx7RtgacT/MaGwPNKCvOmXjaGCRhoGa5qcNa6VGpwv
         0wVOajGM7bL/VfHhNJVH4qd1zIPlonQxUYSAcA36wo2MLG4veH1+vlmhuxEY/jqX9bRd
         x8N2F42NBYytA7rsJl9L2AedH8dsCnDNyeZph4SzpUXmZpEud+1aaN5jWQLbVRpjxvpc
         ev0D16+MSbq+ZjpNh9rAL0mjEabu9+mbT777W/XfE5/YfW13jYSTnuHqQ8a9rOfK9mE/
         6TCBiM2T4JrXOyelr7W/3JnWF9nqfNcInUah7xxkP86S0BnfJMsUz9BPoVgI6AzDJU8Z
         YPbw==
X-Gm-Message-State: AOAM531IZR7npO1AmhKE/6oSPIFZT83zOAqi/zy3wUPi7PHD9QbO0+Da
        4HHISR6Cv5FsJ3y7bYwk+Xk=
X-Google-Smtp-Source: ABdhPJzKUp5CCEOW3QEYRIC8F6Mi2M3sWJwDpnDPPzBBbciGmdSWnmXoz5AA/afGC/gSJdEtOJL8Dg==
X-Received: by 2002:ac8:74cc:: with SMTP id j12mr4065142qtr.46.1612528128700;
        Fri, 05 Feb 2021 04:28:48 -0800 (PST)
Received: from localhost.localdomain ([138.199.10.106])
        by smtp.gmail.com with ESMTPSA id k129sm8866359qkf.108.2021.02.05.04.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 04:28:47 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: irq: Some words replce with better alternatives in the file timings.c
Date:   Fri,  5 Feb 2021 17:58:36 +0530
Message-Id: <20210205122836.1355944-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Some spelling fixes and replace with other similar meaning words.


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/irq/timings.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 773b6105c4ae..72f69e3b1e8d 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -478,21 +478,21 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)

 	/*
 	 * The interval type is u64 in order to deal with the same
-	 * type in our computation, that prevent mindfuck issues with
+	 * type in our computation, that prevent mind blowing issues with
 	 * overflow, sign and division.
 	 */
 	interval = ts - old_ts;

 	/*
 	 * The interrupt triggered more than one second apart, that
-	 * ends the sequence as predictible for our purpose. In this
+	 * ends the sequence as predictable for our purpose. In this
 	 * case, assume we have the beginning of a sequence and the
-	 * timestamp is the first value. As it is impossible to
+	 * timestamps is the first value. As it is impossible to
 	 * predict anything at this point, return.
 	 *
-	 * Note the first timestamp of the sequence will always fall
+	 * Note the first timestamps of the sequence will always fall
 	 * in this test because the old_ts is zero. That is what we
-	 * want as we need another timestamp to compute an interval.
+	 * want as we need another timestamps to compute an interval.
 	 */
 	if (interval >= NSEC_PER_SEC) {
 		irqs->count = 0;
@@ -523,7 +523,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
  * thus the count is reinitialized.
  *
  * The array of values **must** be browsed in the time direction, the
- * timestamp must increase between an element and the next one.
+ * timestamps must increase between an element and the next one.
  *
  * Returns a nanosec time based estimation of the earliest interrupt,
  * U64_MAX otherwise.
@@ -556,7 +556,7 @@ u64 irq_timings_next_event(u64 now)
 	 * type but with the cost of extra computation in the
 	 * interrupt handler hot path. We choose efficiency.
 	 *
-	 * Inject measured irq/timestamp to the pattern prediction
+	 * Inject measured irq/timestamps to the pattern prediction
 	 * model while decrementing the counter because we consume the
 	 * data from our circular buffer.
 	 */
--
2.30.0

