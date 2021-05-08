Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6752A377061
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhEHH0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:26:38 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A13C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 00:25:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id m190so9052346pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 00:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=my7qVjyAkMmsKyUn2FqTYuvpy0+oGhnb7EbIWSwB92c=;
        b=Y0XvevzDserptugXb7msiV4Wr9XBFbPc3KIsUG0O4I8nSDIg6aeABz0euF9eysqeSh
         4u9j8ukBcsHVfOJtt8K1pEH6lhRpmUp3ARiPKct9CiO812tRstFzBtzl0QnOiIZC03hy
         g7jfnoJ2rYraA3oKZFv0pGL8BlrRXsxzSh2KuhEjWf3y9X/aSWwF6+CKmn8kB07zKxIm
         yl4KU+5TyokbTHZoGhGgt8yQyDkgTDrZ6MZ0xHKO9sTSUEzd+JiTAFa7EUmqm91oDQXH
         SUzXy8jzYbyREh9W3VWDK0col7M5IOleEVQe5Ui6UCOUMiSkKlcrLOZlHiJwtLYoeE8g
         qCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=my7qVjyAkMmsKyUn2FqTYuvpy0+oGhnb7EbIWSwB92c=;
        b=W6FcKyu/2tSptu1aQYoUita0iSc7jrfBGwhjlQT3wtD6n+3E8vzl+oGlSHcO9danHc
         Ntq6e9+U7mWExvFLV6hewUK0gcNYPyCprE74O2/zveH9Nc55Hs9ytaLFtsrKOV/TxpJR
         m6u1rHP9nYhLrJAU9QSQBzMvj32wsBFDORS128ApotxXy5bJWc9hs31VOU00WaylcHCx
         xnr2t8x0uSidhpY93/K7M8tPfyLRtu4vE2eq3+UKfYIdEWE7AEfMYYnMBc9Myioxiold
         wTB/fqQsAuvvi3F5syBV8RloxqySiJJQCKM5uxxPcPigTILAC8Mjn0teR7dzSAYPJ3Vp
         rs0w==
X-Gm-Message-State: AOAM532q6K906vQXKjjxUTMzRkJT6DldIyEFr0Fg752H6d3Wft2znXbh
        zYHGSdW/FsPXwhfQCcnouZ0=
X-Google-Smtp-Source: ABdhPJzrkrcrwwI7jsUeixy9F4AAlMJjV+kTttf6kl9EKaq0s8SIjh4tt80JJt80IPpuQ9WJKGG/pw==
X-Received: by 2002:a63:1b55:: with SMTP id b21mr14595841pgm.160.1620458736206;
        Sat, 08 May 2021 00:25:36 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([45.67.53.159])
        by smtp.gmail.com with ESMTPSA id o12sm5959751pjr.43.2021.05.08.00.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 May 2021 00:25:35 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     peterz@infradead.org, tglx@linutronix.de, bristot@redhat.com,
        valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH] lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed
Date:   Sat,  8 May 2021 15:25:22 +0800
Message-Id: <1620458722-13026-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_percpu_thread() instead of 'current->nr_cpus_allowed == 1',
is_percpu_thread() is includes boths SMP and SP. It also more readable.
The comments are no needed.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 lib/smp_processor_id.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/smp_processor_id.c b/lib/smp_processor_id.c
index 1c1dbd3..046ac62 100644
--- a/lib/smp_processor_id.c
+++ b/lib/smp_processor_id.c
@@ -19,11 +19,7 @@ unsigned int check_preemption_disabled(const char *what1, const char *what2)
 	if (irqs_disabled())
 		goto out;
 
-	/*
-	 * Kernel threads bound to a single CPU can safely use
-	 * smp_processor_id():
-	 */
-	if (current->nr_cpus_allowed == 1)
+	if (is_percpu_thread())
 		goto out;
 
 #ifdef CONFIG_SMP
-- 
2.7.4

