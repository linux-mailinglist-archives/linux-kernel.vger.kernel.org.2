Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB7D45EB57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377003AbhKZK1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhKZKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72107C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:38 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id x131so8457008pfc.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=or3jAOB1bNItBPsbmfV4gAOL85INAEE09CRqDlIF7AM=;
        b=VrutOdeit+c8zKehXDuUPeD045PgUMLN26VnaPjrPU5UILnBXR3bRi10QrRkPBtlnh
         VWTB1lG44agXH42F3OriK230FKY9Um1ueGyx+6ViXwgsBSrwaBvr3/f8rvwdSU/nTBNM
         dj2KH+V0hPog5AMgX3hWnrZtrPJ5tkOrUZe/1TRONli7OkVU0MUyjoTEt6yXPQXrLvr/
         /4Os7vpcp9kgIMRhWrtenTt2CuMh7D4nSkGRIBN028/cC0h/H6wumgYIRPYUWXZOjnym
         aiYwL38xINLlI+NijoskI4JVNS0PIB7I50CjCClKRKq5QRBj314Q1Bwtpg8iRd1R+3Zx
         1BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=or3jAOB1bNItBPsbmfV4gAOL85INAEE09CRqDlIF7AM=;
        b=ER4y7+WgQj9OXn9WCWS/LQGR5keAnkl7a0vsd073iI4ay9B1helXvh7wFV5sD48kKy
         hubqO0P6uVj/kchthp9ydTLXnaKG6gHy90SipnZfvveKbXTeRPKII72EWs0EI/pm27yU
         fwOYif3eiF3AYWxPvlaOaNHiz7C7nNyOyhZZhqDcPy7l8Sj+OpiL6aQq7ee/v+C0Y4nv
         dEfbYz6RgKy9xynFHhXmwEh57qHgA3WaCAxznkQPvRv2x8uHKm654n+iMDaXpaknyHX9
         goPgg2B0vdq0pF5WgzDfW34HRV7JYYuNXmYooAu8P5jt5kyT4szg1Eo7jX+dmaOvhigr
         oIHA==
X-Gm-Message-State: AOAM530oSBA8PeeaN7qrCe3gH98wfqv2EK67EtGkHeTt6WYZ64PItKEW
        wr3whBaLiQUji72+PjjahQyGoAfLe2o=
X-Google-Smtp-Source: ABdhPJyJYdVyrhCr81AuRDhPAG1M3NUMmSM/pBI+pP8/clIoCiNPxGiTyNIIgvVZbuL2JOHQWbUXbQ==
X-Received: by 2002:a63:790b:: with SMTP id u11mr20572417pgc.71.1637921617898;
        Fri, 26 Nov 2021 02:13:37 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id d12sm4523340pgf.19.2021.11.26.02.13.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:37 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 16/49] x86/entry: Add C user_entry_swapgs_and_fence()
Date:   Fri, 26 Nov 2021 18:11:36 +0800
Message-Id: <20211126101209.8613-17-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The C user_entry_swapgs_and_fence() implements the ASM code:
        swapgs
        FENCE_SWAPGS_USER_ENTRY

It will be used in the user entry swapgs code path,  doing the swapgs and
lfence to prevent a speculative swapgs when coming from kernel space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index bdc9540f25d3..3db503ea0703 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -49,6 +49,9 @@ static __always_inline void switch_to_kernel_cr3(void) {}
  * fence_swapgs_kernel_entry is used in the kernel entry code path without
  * CR3 write or with conditinal CR3 write only, to prevent the swapgs from
  * getting speculatively skipped when coming from user space.
+ *
+ * user_entry_swapgs_and_fence is a wrapper of swapgs and fence for user entry
+ * code path.
  */
 static __always_inline void fence_swapgs_user_entry(void)
 {
@@ -59,3 +62,9 @@ static __always_inline void fence_swapgs_kernel_entry(void)
 {
 	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
 }
+
+static __always_inline void user_entry_swapgs_and_fence(void)
+{
+	native_swapgs();
+	fence_swapgs_user_entry();
+}
-- 
2.19.1.6.gb485710b

