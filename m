Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56304189BD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhIZPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbhIZPLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6363FC061740
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so11319927pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BO5PiqDJYvzBl23hUDS9RR5Uds/bZ0R6MkZ46+3NKDo=;
        b=pqUw4XBG8TXpuQUYvqsg9Th8g7ghhf4jYR3R54PjUSQJlceMYrNV9DkzJpRLZXlCuc
         VVTCxjnXqbNGY2SOH5mto67ZKFldoSMCzxL6RPeLASxFRC2+ivzj7YfE2EcGdITTUhwC
         +lmWKeFuFCQex5sR8ayh/San2b9Qc4mqkYy7K6/Wj8b6C/uJbCi5xKVJhanB7JtS8BCP
         F44AgpxWJXHaSW9UwylC+azOvS86sxaRZq9JlEIhAghA5o0td7uY0bCwV/0B0c5ESE/O
         A9QoAUUYGgkUcBx0V4b0UPz/Z/djFNzjgYtDTKJZiw2YeZV1LXEakcQfIfHovIywwVla
         IK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BO5PiqDJYvzBl23hUDS9RR5Uds/bZ0R6MkZ46+3NKDo=;
        b=JQOPI+92+0OH/Tf7Wu3TsONkuaxsJFdFj5v6vs77SmXVkOXTnO6JgAaYc2VTBGTR3d
         DVhpVPEfW5TH2M1QswrLlOZnJIefVleQ8Owyoh17Vi04oM9ELgDRiKSfBrnRoKUrNha2
         qX8wvJish0lXq7WBLoUgWhmfgWcOYFkJbSl08kirAmjlosl9vR5VUUAW5c4bHxitTCjd
         Ab+204/PdcZQQVZWQotn5moZIvGIxf5NEhGIHDa8t/Bd624UiueUSHEZbFYjKdKaVcmA
         BdcDh69/gxRFojK3APWboiLKWkq0XXPhk7JJAxrOgLZTR26wviNU+StO3aoTmiPM0weo
         RhRg==
X-Gm-Message-State: AOAM532VxszrjApNHTvszI6D1h4WhvHhPsuJ5TYBsj5Jo/Ur8eTUkGv5
        NXcd5aKJrJ8zkg+0jRoxcDcpj7EbUyngJw==
X-Google-Smtp-Source: ABdhPJwf2Jsxri8ZGGclDwMiiQqDtnJ+opfYH4tfrcZXTT8TnCw/zrmcm80cZACR69XlXjSaXh6qmA==
X-Received: by 2002:a17:90b:3ca:: with SMTP id go10mr24867pjb.37.1632668992768;
        Sun, 26 Sep 2021 08:09:52 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id k22sm14662115pfi.149.2021.09.26.08.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:52 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 11/41] x86/entry: Add C user_entry_swapgs_and_fence() and kernel_entry_fence_no_swapgs()
Date:   Sun, 26 Sep 2021 23:08:08 +0800
Message-Id: <20210926150838.197719-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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

The C kernel_entry_fence_no_swapgs() implements the ASM code:
	FENCE_SWAPGS_KERNEL_ENTRY

It will be used in the kernel entry non-swapgs code path to prevent the
swapgs from getting speculatively skipped when coming from user space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 77838e19f1ac..dafae60d31f9 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -35,3 +35,24 @@ static __always_inline void switch_to_kernel_cr3(void)
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 #endif
+
+/*
+ * Mitigate Spectre v1 for conditional swapgs code paths.
+ *
+ * user_entry_swapgs_and_fence is used in the user entry swapgs code path,
+ * to prevent a speculative swapgs when coming from kernel space.
+ *
+ * kernel_entry_fence_no_swapgs is used in the kernel entry non-swapgs code
+ * path, to prevent the swapgs from getting speculatively skipped when coming
+ * from user space.
+ */
+static __always_inline void user_entry_swapgs_and_fence(void)
+{
+	native_swapgs();
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_USER);
+}
+
+static __always_inline void kernel_entry_fence_no_swapgs(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
+}
-- 
2.19.1.6.gb485710b

