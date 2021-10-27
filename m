Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148D843CC41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbhJ0OcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbhJ0OcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:32:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6EBC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:29:49 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so2216369pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RW1b2/4mo8FTI01e31IQmQwZ/AoF06MQcurQiMVorGY=;
        b=K28YQ1lSCemZBapcOWd/+OPu6IBPr+UFgQglsFuDApNP4+PaQPsd5Y65FOKcQLjqlY
         L3QiknmdjCSMltuAeQUK3Ctu4kGhN7vJP7fmLaPOW9agbl7Li2GkKZnMLX1bVW1pyJBN
         /VlvBKTLc2qNcWQVikDTQuMDlTRHvc/vZ8uJ+7LCZ92MuY3wypM+Uh2LKtkl4UUUesXD
         anHZh+rHpmL7p5kb1mvY3JE23fjS+Anxpku7yzMctQcSvXVV0uxmPz7FcmXyxE4nNFLh
         VbK8IJxzJ/5J2Vq3jIkgTJ894/BrzS8hmGdwMJA1FrtwlG4QU+gM51gjDtvJQClOibVR
         okYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RW1b2/4mo8FTI01e31IQmQwZ/AoF06MQcurQiMVorGY=;
        b=cYYK6hpsuMfQEQi/KY2Xh68HzI/O1meQC3CvMUlEEldqpB0FYOvnGU1LZpgFB1+n2a
         n+WwNgYRd75kV4xpsTdv34y3XaFxSDUiJn4kZasuKWtP6bxb99R1BMpMUjKrD59JPyu2
         G6IyJBWIMZSv2BQdIGq31Wp4uta/ji3YTlF7jbtPsHw3NzAR/4xuY+S0pKovOUgAvnix
         UvUkn2Ek22eKlS4dY75Dabo3GYsDVlE3SZQS+ye68HfngvyL7x7LFVSQg6Ec+nVrAidn
         gJV9yijcQ95+3kvljYgbi2fmI8oXv6g0EKqDOu3BLpk31ZGQnWLjmNS9dYRFTwQQr5Fd
         gQOw==
X-Gm-Message-State: AOAM533+hkLFdUwHgWZHQcUxehVGZZfTLu3SJjdx14QdnhHJBJC6vBJc
        BGj51ZzrHd0dZXUcys6H9WM=
X-Google-Smtp-Source: ABdhPJxc9zsPDKRWq8oJvD/1l+BVvhN6i+YnM9DLTHiQD3n8zvAoxMCtBQ8VmDp5Ah7SlCyM2cmODg==
X-Received: by 2002:a17:90a:af93:: with SMTP id w19mr6326392pjq.10.1635344989266;
        Wed, 27 Oct 2021 07:29:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a12sm4548028pjq.16.2021.10.27.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:29:48 -0700 (PDT)
From:   Lv Ruyi <cgel.zte@gmail.com>
X-Google-Original-From: Lv Ruyi <lv.ruyi@zte.com.cn>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/unwind/orc: use swap() to make code cleaner
Date:   Wed, 27 Oct 2021 14:29:40 +0000
Message-Id: <20211027142941.4401-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Using swap() make it more readable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 arch/x86/kernel/unwind_orc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 2de3c8c5eba9..4ea86f1f4054 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -196,7 +196,6 @@ static struct orc_entry *cur_orc_table = __start_orc_unwind;
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
-	struct orc_entry orc_tmp;
 	int *a = _a, *b = _b, tmp;
 	int delta = _b - _a;
 
@@ -208,9 +207,7 @@ static void orc_sort_swap(void *_a, void *_b, int size)
 	/* Swap the corresponding .orc_unwind entries: */
 	orc_a = cur_orc_table + (a - cur_orc_ip_table);
 	orc_b = cur_orc_table + (b - cur_orc_ip_table);
-	orc_tmp = *orc_a;
-	*orc_a = *orc_b;
-	*orc_b = orc_tmp;
+	swap(*orc_a, *orc_b);
 }
 
 static int orc_sort_cmp(const void *_a, const void *_b)
-- 
2.30.2

