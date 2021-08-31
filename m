Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E093FCC96
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbhHaRwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240595AbhHaRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215AAC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so71879pjz.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yoxDkwSPPxsmyf7mXCynO1q5gaWrFpb5i/hujqYhsBs=;
        b=O2pODWoqqsNj/p4WTUJbV4lar0JcXGfgwDTHEUGL2RU4L+GBcOYTLBxson/5XwfsrW
         wRzGoX8V2rWLPNNTzqVpxok+shflkU7KTu2z3pWOeTcM6I9VymQZ2p8Y4PQhe1pGDYVT
         k5UyS/skvNOOZ/pjChjwaF00EVqJmmtt7aq6vpaHeb3odgVvrRpJlWnobNEhM3bmI+j/
         ZPQ8HndQm2Lava2GYqe3M8IqCN+G4+HzogYck6plsEkUbF9/DbIQ3nn256vv60uCZOHw
         Zm6GwkEtJ5J7UH+l10d5iHOlIBewN8S7OLnFip6IumGr6hTfzj/BoeEW7gpM8FehVrhQ
         kxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yoxDkwSPPxsmyf7mXCynO1q5gaWrFpb5i/hujqYhsBs=;
        b=L1nPjBaetxmZM/GSmCgptc55mbJniLw7dwdckUZ+SNszbiM/QPXQ0Tt1R/ykz7WAf9
         5ccWz83pQch9+Bx73A6pxvltrq+ALnrDyGggRtsXBr85sTt3DiRoB4razGMdZcyWBLtN
         flhw2ieNbZ9JIupo14bIOz/Me2L8vDXHV26u7a3RwoYAVcWkafg5rXWpHvuJqNNL3GDv
         6oPR/lVdOeXJBwpxzrPWKgx4owSED5MSApVDm5aWLdYUv4xSELYhajFprQ1bqVCtXVXC
         dJRPUaAZvHD/XCzVZTlCpxHZ2wts+pX/x/22g3cgh9sAC4q8E1qkXXUZhUep59tbcyAW
         SwsA==
X-Gm-Message-State: AOAM530KeDerqWLd0jtBVn978Ldx2Ige/UVeNJAOvwZq7Q02Ukwqnw+T
        Q/TcoHC2KlcxF3HYUzaei7tq9z+iEgA=
X-Google-Smtp-Source: ABdhPJwbhTA06xJ8OAnPIPu+0XDzcPM1eonU67t39Za5YQAnQViWJcJ2UF7fR4aeT1PfgNavEIe5YQ==
X-Received: by 2002:a17:902:968a:b0:133:e2c5:4908 with SMTP id n10-20020a170902968a00b00133e2c54908mr5831904plp.2.1630432283480;
        Tue, 31 Aug 2021 10:51:23 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id c9sm21280505pgq.58.2021.08.31.10.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:23 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 09/24] x86/traps: Add fence_swapgs_{user,kernel}_entry()
Date:   Wed,  1 Sep 2021 01:50:10 +0800
Message-Id: <20210831175025.27570-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

fence_swapgs_{user,kernel}_entry() in traps.c are the same as
the ASM macro FENCE_SWAPGS_{USER,KERNEL}_ENTRY.

fence_swapgs_user_entry is used in the user entry swapgs code path,
to prevent a speculative swapgs when coming from kernel space.

fence_swapgs_kernel_entry is used in the kernel entry non-swapgs code
path, to prevent the swapgs from getting speculatively skipped when
coming from user space.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/traps.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index 9b7d0f15402e..efec3b4eaa5f 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -789,6 +789,26 @@ static __always_inline void switch_to_kernel_cr3(void)
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 #endif
+
+/*
+ * Mitigate Spectre v1 for conditional swapgs code paths.
+ *
+ * fence_swapgs_user_entry is used in the user entry swapgs code path, to
+ * prevent a speculative swapgs when coming from kernel space.
+ *
+ * fence_swapgs_kernel_entry is used in the kernel entry non-swapgs code path,
+ * to prevent the swapgs from getting speculatively skipped when coming from
+ * user space.
+ */
+static __always_inline void fence_swapgs_user_entry(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_USER);
+}
+
+static __always_inline void fence_swapgs_kernel_entry(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
+}
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
-- 
2.19.1.6.gb485710b

