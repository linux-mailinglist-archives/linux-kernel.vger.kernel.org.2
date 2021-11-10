Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4944C077
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhKJMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhKJMB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B7C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso1476546pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=qnNEYedn9RQHJNPkfLIxbTrL2w4CNf8aAGgJ8yw3jmyWIAVCNEsyjULVmr+a0UAsyH
         2r1AQdqQYMV6kwJXMt2blqwJGbadjcCwqmSECd79WSD1zwWI3SgG+2UdHsY3Wtk95F8/
         rD3iklkl0TPbRCdrh069bO5IM3WfLa6YbIKSuza3qYn8WOLiIIP/QlYGLWY0CivcWx48
         uGc7eE1jT5M+jWEdpWxqlP154zf9Kx9fKl8l6+HeOo4cjZwtkdWDBXseRqxarc33xW+v
         uZkew95YOMCj3oPdHAVj0mhyvkeaIIBJ9zetupnNAdXv7fpHbRzLGcqlN6/LSEFPNhDc
         hBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=joeHlgNLIvnjoSO6/Xq1jigbzN3Q3YH/DFcUStZqgz7bOTjQ4joygDabyb9FT0EWGv
         InpiE2LtnyUj28gfeY8vEKOWx5cN0Gf/s1xg8QbyZ43lugxT1W2C0rOHgDYDw+891HVx
         yf/CZc0AlRAAwvCnlbFQul4l9bwyACcfJyqxEI3vz2oFQyYhTSIQ0i4Tv35FDo/P2iNW
         YvsSw+WD6CKF66h9BqOUiqW6/nrbcNeTa789+xNYvbCrJfH77D3EdzMXIV0ZDajdRtrs
         iANvatLYe/gAd9dczrdWwiSU8nJk6IjgHtTAF9K1yMOMXqqKIcLEL0hNA2jJz1jy4hUZ
         RPOA==
X-Gm-Message-State: AOAM532RF/t/9dE54S8fuEeU9bJ3s2vhQ460lL/yXBFLXm24XHowIkWc
        0P1qTsz4W8ATtQ5SZtQi4DE1YYX75xA=
X-Google-Smtp-Source: ABdhPJycJ8XwQ/V8Forp78uhh5ZrHbSx8yyrjl64lu1dRHUiU097mQbCfy6CzTKV02ZteJXo8bZK5A==
X-Received: by 2002:a17:903:1207:b0:13d:b9b1:ead7 with SMTP id l7-20020a170903120700b0013db9b1ead7mr15153150plh.63.1636545549625;
        Wed, 10 Nov 2021 03:59:09 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id s3sm5718767pjk.41.2021.11.10.03.59.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:09 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 16/50] x86/traps: Add fence_swapgs_{user,kernel}_entry()
Date:   Wed, 10 Nov 2021 19:57:02 +0800
Message-Id: <20211110115736.3776-17-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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

