Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9511348B72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCYIXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhCYIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:23:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BC6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:23:05 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id o5so1017559qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryXU/JvJvxvsiWpkOac5qluYPHUZahaxaDC54Y2ocmg=;
        b=PLy/5HXTYFgvP6mPgBrbusVkPTLum1fWn0ghYWDZEF3t9UCKXJQcRksZlkIDQ5bKLi
         ZeGpNbnF1KfUa2QU9U2yLQq69OlhHAFgjGAQTg6Ajz9BrvhrXCqMGRlSBalaSjPq8hMh
         dROy9R3hSmptnRfg6284KE6nKM61BHCVqGTQnAsicJNjsZB+BA2R8PtDRA8Vpke5I/Ku
         JX9HX/s4453nUfziZXb/PxEIG0K7smh8Bi8wVO7aX0j4zQkUp1GSy9RFfjDJHU+RCPpH
         CSK5ATfYCPFwDYS/wC2hWoTf+H8cgpjRhzdAiYudWltX962z2TdQTOMmm7gHupD3QjJp
         75Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ryXU/JvJvxvsiWpkOac5qluYPHUZahaxaDC54Y2ocmg=;
        b=eak5hoCKejeIiVyjMDOLLPiqfTCTG7AmXWs3qcKqmlaZ2MddoE6M+chG6WNsz04nrV
         4LySInWSAbsvzwRvrZaGKBB3H9k1s/16RRPq4itAzEw6RJ/MDK5J7/h8myR8b0y+trK0
         gNNwcyOAOxiPRT8kBO+PTSEFJ8uhilbQseHOwieQvbfq1Jj3LwGYVfJg6D5R48E08rbo
         0EIKkcKQUVJIgDxFm4twWdGVqnU+kUXtWCIIIeNwsQBlVPKJ7WZExgQ45hcOK8I5AT9F
         CyyJAc4CsKYAYHOJymM7DnWqxTLJinZ+afMkTJdo7cQZUIaJyx3t1RobEHTkRw7dNc7h
         BQlg==
X-Gm-Message-State: AOAM531egRuUH3kP0bGhdyQVwOR/efJ00HTiwrqTF3UCxkJjSptML5M7
        UJiXDzD7EiGIc2AazuFYEbc=
X-Google-Smtp-Source: ABdhPJyptaZKbfa784jkX0LDEoA1zdKeSZU+s3pH+Fv104T2xZN3CyFa9Go1e6BfPTjp0Mv92v5BVA==
X-Received: by 2002:a37:acd:: with SMTP id 196mr7241949qkk.219.1616660584988;
        Thu, 25 Mar 2021 01:23:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.58.54])
        by smtp.gmail.com with ESMTPSA id f26sm3114342qtq.29.2021.03.25.01.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 01:23:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel/time.c: Mundane typo fixes
Date:   Thu, 25 Mar 2021 13:52:30 +0530
Message-Id: <20210325082231.26879-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/boundries/boundaries/
s/compat/compact/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/time/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 3985b2b32d08..ea6936302d84 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -571,7 +571,7 @@ EXPORT_SYMBOL(__usecs_to_jiffies);
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
- * resolution values don't fall on second boundries.  I.e. the line:
+ * resolution values don't fall on second boundaries.  I.e. the line:
  * nsec -= nsec % TICK_NSEC; is NOT a correct resolution rounding.
  * Note that due to the small error in the multiplier here, this
  * rounding is incorrect for sufficiently large values of tv_nsec, but
@@ -790,7 +790,7 @@ int get_timespec64(struct timespec64 *ts,

 	ts->tv_sec = kts.tv_sec;

-	/* Zero out the padding in compat mode */
+	/* Zero out the padding in compact mode */
 	if (in_compat_syscall())
 		kts.tv_nsec &= 0xFFFFFFFFUL;

--
2.30.1

