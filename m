Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832BD42D118
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhJNDjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNDjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:39:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44296C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:37:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x4so3209261pln.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B16tY7PuFF7Zm74VoSoWo/jNNqRFXvl1Nh2CZ9twwtY=;
        b=h2xvD/DEc05yGuIHksDrSHl3o1Def6S2KQ1m9KVVYPtpmGuKpxLLujVf+gWqgj5+oh
         Rnlt2d3xHaOrcKMafvg/ECdtG8JHfzuha9gCxNqmGUwJuJWPxZMG1TPyEM7ycWlkwjO4
         ukxAhmC0TH3gFwz79c3OlyA8Ht2W2LqbUcpWPRYmLVzpCP+AXfb6r/eRInhNpTPeRkDj
         QBkchvCyRmOVbvK81MF9C3sOkAP/Lra37OgvFKca1z+yETQkq9XNSRkjZpp7joAowk7d
         LNem0UpOid7vZQ9hX5ak+Eav7gab8oLH89PgExI4Lkqa/2snaNF4fo5QpdZC871luCNU
         bWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B16tY7PuFF7Zm74VoSoWo/jNNqRFXvl1Nh2CZ9twwtY=;
        b=LOUrRHzSSkd8GFvhHiHQi0zV+veFBkMQfoRFuMZGz5fwYG2aaFggqsZc/1gqDV4Hmb
         etErun+ZKa7qXO+Do14tCG2MZ74PA3u42RXtXVfgXc06lRD7Dmv/fTx6pdLm/fgoQMmY
         pgdrK5HX9iUJAqWZjqZzSODmuVnYmrfKLz29ApFEY7a10zCEDVa0NCTEzMCTQbCHbSwu
         rwuzy69dm15XlhySaIlKJc8P4YaLTtgsVfNhTN8ZuIrmnb8bPf9SBZ8Mjb63l2y92wBq
         q60RnlauSoT4CwfOYkBREIjURBernOttK6ZZuEG5DwPHbIW0pXoBoSBVkp5SQfJWilBD
         Qn0w==
X-Gm-Message-State: AOAM530S+jEjAzfn8VGuxhUJ2kx3qzOdCnCXbysPRWhUD3DKuVp+nZG/
        z95CncObOHC78iaIorIiNV52K4vOxbI=
X-Google-Smtp-Source: ABdhPJz0CoZQDanlPew+XA5LLzTJ+wJt09bG/1IvuI5As+9e9D1HURnZk/vO5bf+LkjYNfcm56kO4Q==
X-Received: by 2002:a17:902:f683:b0:13f:a79:52de with SMTP id l3-20020a170902f68300b0013f0a7952demr2894353plg.43.1634182627735;
        Wed, 13 Oct 2021 20:37:07 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id 73sm827792pfv.125.2021.10.13.20.37.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:37:07 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 31/49] x86/entry: Add the C version ist_switch_to_kernel_cr3()
Date:   Thu, 14 Oct 2021 11:33:54 +0800
Message-Id: <20211014033414.16321-26-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It switches the CR3 to kernel CR3 and returns the original CR3, and
the caller should save the return value.

It is the C version of SAVE_AND_SWITCH_TO_KERNEL_CR3.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index c8ede8b088a6..7e6c1b8a93d1 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -35,8 +35,23 @@ static __always_inline void switch_to_kernel_cr3(void)
 	if (static_cpu_has(X86_FEATURE_PTI))
 		pti_switch_to_kernel_cr3(__native_read_cr3());
 }
+
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3 = 0;
+
+	if (static_cpu_has(X86_FEATURE_PTI)) {
+		cr3 = __native_read_cr3();
+
+		if (cr3 & PTI_USER_PGTABLE_MASK)
+			pti_switch_to_kernel_cr3(cr3);
+	}
+
+	return cr3;
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

