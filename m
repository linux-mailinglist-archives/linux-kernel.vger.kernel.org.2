Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C79426590
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhJHIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhJHIFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:05:08 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B243CC061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 01:03:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso8385902pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztTPcW2dYiBj1oh0nTuQyiZpD0J35YYcOERqU/sBllc=;
        b=Gb5yoPQr1I/VRE7eotn2sgZrIydkFo4uJcdjFnIgq//J/P5ZJdQggXU+bAWS+6dijS
         evRJUV5a0vB3Mqaqfi1hjqKLNoh1FHEA+HhUCUcnxygtGRcFtlZ3A0IucfsxLmKXxE4I
         yKoqozXNq8D1oW63gPo1YMTZoIjFvlgThw3zF500b6i/jiULVRKM2Zf1h/zjwk3jbESt
         junLR0mM9hrwARjhmrw311i0r0HLzAGcV7axiVclsDV6hE6ocA6R2ABnehL6lc0oCDF+
         dAEDUDN1G5fcK7REwtXZOYoVQxWuu/+ZW2QTNiduXIyVUUv6xvQSA/V1ftCB2txRCSVT
         CR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ztTPcW2dYiBj1oh0nTuQyiZpD0J35YYcOERqU/sBllc=;
        b=WYNNqVPMuU+AsdRXDINj4vsH4wiZBk+Ah56f8mvK2pTCSLnJAj3BMYgn41f4y324fq
         +bT7YJBO9XAnBagMH9aOvenhKRi5LGhqMkXIekah+viOpf4b5LSdJbv6pSDpScHwsgLj
         j+S33vifIg4XchpWHLO/tkl9bYv5jWBRb7F+Ahm3eEPYPfkMj/S3KGm/FokG1F9CuLmY
         iekx9Tv1Mtb/szherTrZHx+0uVLLTmocj74QdF5zmRx/pCXqf8V7v9AA4FEsLN27EJGh
         NVICtaD5O3zWBzZrw6xINfbdFla/bum+5RVLXQblbHG4XcbAOS4XsFieOFJ3ZN/TNH+U
         AB+Q==
X-Gm-Message-State: AOAM531SiXrw+2sdIkgVh5ls02KsGDwLwgaASXwyfpZDypIGGnZ8mFcb
        ddAY2CFymVx9oKQlNBxPEbRJ+w==
X-Google-Smtp-Source: ABdhPJw1lbsvTf27Px1tSDN95M5cxHIx61KKQZYjE0OblKRiFTY3Q0wfaGwQTJn1YeIoVLRWFl3Dhw==
X-Received: by 2002:a17:902:8bc1:b0:13d:e884:125a with SMTP id r1-20020a1709028bc100b0013de884125amr8152201plo.38.1633680193153;
        Fri, 08 Oct 2021 01:03:13 -0700 (PDT)
Received: from FVFC60ZAL416.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id d137sm1706953pfd.72.2021.10.08.01.03.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Oct 2021 01:03:12 -0700 (PDT)
From:   yanghui <yanghui.def@bytedance.com>
To:     John.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        yanghui <yanghui.def@bytedance.com>
Subject: [PATCH] Clocksource: Avoid misjudgment of clocksource
Date:   Fri,  8 Oct 2021 16:03:05 +0800
Message-Id: <20211008080305.13401-1-yanghui.def@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clocksource_watchdog is executed every WATCHDOG_INTERVAL(0.5s) by
Timer. But sometimes system is very busy and the Timer cannot be
executed in 0.5sec. For example,if clocksource_watchdog be executed
after 10sec, the calculated value of abs(cs_nsec - wd_nsec) will
be enlarged. Then the current clocksource will be misjudged as
unstable. So we add conditions to prevent the clocksource from
being misjudged.

Signed-off-by: yanghui <yanghui.def@bytedance.com>
---
 kernel/time/clocksource.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index b8a14d2fb5ba..d535beadcbc8 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -136,8 +136,10 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
 /*
  * Interval: 0.5sec.
+ * MaxInterval: 1s.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
+#define WATCHDOG_MAX_INTERVAL_NS (NSEC_PER_SEC)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -404,7 +406,9 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		/* Check the deviation from the watchdog clocksource. */
 		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
-		if (abs(cs_nsec - wd_nsec) > md) {
+		if ((abs(cs_nsec - wd_nsec) > md) &&
+			cs_nsec < WATCHDOG_MAX_INTERVAL_NS &&
+			wd_nsec < WATCHDOG_MAX_INTERVAL_NS) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_nsec: %lld wd_now: %llx wd_last: %llx mask: %llx\n",
-- 
2.20.1

