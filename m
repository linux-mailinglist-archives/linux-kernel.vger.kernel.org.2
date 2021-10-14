Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A48142D105
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhJNDhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJNDhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B65AC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t11so3194215plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=kEnOGdBXAv2C6tgG0u+vglG+ysLL1K8zITvn+juHBwyLC05jNu/YCUV88evdITwKkF
         3U0ugZdniKczzpkCFsm9AAqG37GZHPipe5shp8ofmRpywch8BjLPIyCNrQd3Lp+1hiQg
         kDDLWNL9mD81uyJQNajFWTt26wCGn6jED9/0VE3+p6eXcQCh0vJF95hCCaD8tF4e52yS
         5M9mv+hkYsbk8xNujn+E2Co+ig/GIo8AurI3APWiT9kzINzATjeWaiiRNMaGJUoVevxl
         uB2mTMsUk1ksrzGD73SxKDm2SM1qmXERp0P2/mTVRga/r43rX+BKCZeWuH7BGrc8K1av
         Ym6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=cI52hBJ9D5eZnk1QI/hrns+QS8Wk/KS7G1U5yX+KyG0N6aNXF1z7IQQ78c0Ysg6gpb
         6xcsJf8hKQsasuqq+nrdhqqW/eaOwN5cKbWLOIm6wj5ht28E3EIa7IO+6Cj/9KkdudYN
         jrmUP2POuELNB61HlQQqXRyMghgM7LNZUcPC8/fIt37i9LBQWa6DDFhB3+kuXJRbv+9X
         nQ3PHmrbOZwACx7v0SKTOZgTGOOxp8Yx6sEvc13dPdViUV8lB0b7MTdDjGmhUmbVG1+A
         5s35YV34PWjNgnHITyRVQgJoevaWlW6EqAeqQd3M2e4fJOxwlpMC0qQsQL7la4eDIQBB
         4Yxg==
X-Gm-Message-State: AOAM531nosOlZHJ2bGmfrY6xoGRw/wS92soe2GLGszQiXvgy/j95WcUF
        WU+5aUlnbptAnBk9naQHBXhEZsPM2yI=
X-Google-Smtp-Source: ABdhPJwNW2Bp5s3LiO9WPSZXwk+pH4PqJQTCPOp7MpwUqGEwZaYHEkISLibWdXwD7lPnxfS6VmB7fA==
X-Received: by 2002:a17:90a:4812:: with SMTP id a18mr17746442pjh.40.1634182533613;
        Wed, 13 Oct 2021 20:35:33 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id l207sm823700pfd.199.2021.10.13.20.35.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:33 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 16/49] x86/traps: Add fence_swapgs_{user,kernel}_entry()
Date:   Thu, 14 Oct 2021 11:33:39 +0800
Message-Id: <20211014033414.16321-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

fence_swapgs_{user,kernel}_entry() in entry64.c are the same as
the ASM macro FENCE_SWAPGS_{USER,KERNEL}_ENTRY.

fence_swapgs_user_entry is used in the user entry swapgs code path,
to prevent a speculative swapgs when coming from kernel space.

fence_swapgs_kernel_entry is used in the kernel entry code path,
to prevent the swapgs from getting speculatively skipped when
coming from user space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 9a5c535b1ddf..bdc9540f25d3 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -38,3 +38,24 @@ static __always_inline void switch_to_kernel_cr3(void)
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 #endif
+
+/*
+ * Mitigate Spectre v1 for conditional swapgs code paths.
+ *
+ * fence_swapgs_user_entry is used in the user entry swapgs code path, to
+ * prevent a speculative swapgs when coming from kernel space.  It must be
+ * used with switch_to_kernel_cr3() in the same path.
+ *
+ * fence_swapgs_kernel_entry is used in the kernel entry code path without
+ * CR3 write or with conditinal CR3 write only, to prevent the swapgs from
+ * getting speculatively skipped when coming from user space.
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
-- 
2.19.1.6.gb485710b

