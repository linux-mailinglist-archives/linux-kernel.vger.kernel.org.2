Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D693F44C09B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhKJMDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhKJMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:30 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F2C06120C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:42 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so1481445pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKlZG5hv1azdNYq9hzIYBOf+NCPmaY3hsLMxbKrVWuU=;
        b=PgG3JeC7EG/C4MN9YrgTSom6r/suGvWlmuK2njsNwClud5e3YCRiPhr4V0YrLC/bER
         Chd3FUZlcbcECDRYZJhv0k+u9w1I+vC5sWj+sCen4c89Nmoj0Z22n9zmn8HNbxh975W/
         6Zz82Iu4ig0s1+YXW9qKTZRK1wMuu+8jqqhA3pE2FoGvmzTO9U+a6gYKfpPPBXJE9fgs
         m8+avBNdXfnhoqnvnjtptDAh7qyEX1IbJnDcH2I00ZC7KMblTFEqFH4OOAHpxujk0v6+
         5OW3Sw6tta7oqtq64pRyIxEw+gfJh8ayAEY0FT3Oz6IxLcbnljXu7PxtgwIm+iOy0hXM
         cUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKlZG5hv1azdNYq9hzIYBOf+NCPmaY3hsLMxbKrVWuU=;
        b=AJtZDPiakUp9ijPXmmBtfnvZcudmxe2k7Bsa+ZShufOBSmg2LAd+4wk/zmitocf0di
         xRHhfOEbmVQoo08Jq4dcvC6DON4ypJOqbW/c7oSLnA//SZf/SnQ0j1t9cleR62N6MdSg
         cMvt/WlW/EbqIyB8RU/zItT3EP03qnyZ7sh0rKtApRy8e4Rg7p1neHCiWld2VM7f2Qs8
         wsIc3lrzwE14ezIJaETmwTt7EX/urruzW3A4GOOaQXXs3sIRDY4WQUyqWV+gfwuvUWbW
         0WpA2BhxEFxTVwb0PU8t7vhKAxYRhLniuKKc0bbRBVvjEc4RUF4Wya0/bt1enHpY2deg
         AWLw==
X-Gm-Message-State: AOAM531tGeth97DvEssfela6XXqN5yAJ+0DnOd5pz8QXzlzmjdo4XdBV
        W10U1vnWo+eOs9ffhUZsnaY4gQgxnd8=
X-Google-Smtp-Source: ABdhPJwFMC4SbihjwAE6pg9BbC9kfONEunHLOxwQUNftP1wbw7Ihgt8izSswxT+M35yWhjM+HPVmqw==
X-Received: by 2002:a17:903:228c:b0:141:f600:c161 with SMTP id b12-20020a170903228c00b00141f600c161mr15244935plh.10.1636545642029;
        Wed, 10 Nov 2021 04:00:42 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id o185sm16875831pfg.113.2021.11.10.04.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:41 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 31/50] x86/entry: Add the C version ist_switch_to_kernel_cr3()
Date:   Wed, 10 Nov 2021 19:57:17 +0800
Message-Id: <20211110115736.3776-32-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 0dc63ae8153a..283bd685a275 100644
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

