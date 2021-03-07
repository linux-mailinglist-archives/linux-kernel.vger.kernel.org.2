Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A6330209
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCGOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 09:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhCGOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 09:24:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9AC06174A;
        Sun,  7 Mar 2021 06:24:24 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p5so3642967plo.4;
        Sun, 07 Mar 2021 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B2+RZVdJEIGjYvBplx65Ssevyg8xALCta0oPDumrCXQ=;
        b=Kxw27O2Ia52HybpYuESfaEP6QG9+MlcxmOOkoEUhoLcvjjUOSPDD6kvb4jtd85zbr4
         Eh2EI+0YUth5sLuA888oN4fbk+aFNVtdaKFZVeHpB4havhI9jxREYVqGYncmqUuRFED4
         fJ2TkRjr5gh30b9/98UiCuc6zIbqLj6NR5nPx4vtFGdzTe3AsF/Dn+6SOS2TewWmHBUG
         AcG6v1RnObc9nzMGMauu2o8GQ7mMUZjJSMvQb5gPaNoB/qT5fLn7rLvhtCz2dxtNycHT
         Bpe5kRKVwKMNtHnrQ2DvYXK9OrCd67QKN5k8ad6NxxFl/rfMGpIZzYKSKZIUqhpmNQdy
         DtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B2+RZVdJEIGjYvBplx65Ssevyg8xALCta0oPDumrCXQ=;
        b=dnUFOT9gFLYCzE0gw7hM2wvqAEpMr6b3lzB8aCY2fYaxxFyOCsXS3yCOtu2uBbq34U
         6emm1AQw5qC6DCK98S3RraA6YA8GXY6T0xZdBGBiGU9I+TjtTVTyez6XnZG6PY7tvGfF
         i3f6sQ7pCM52/H1uGHsDH01XHd3/Of1V/WefIytqmBjfBtC1XDAG4jIZ4XWZX7t1No7Q
         0tban53o4wfRer8Z54wkgyosvwEg/CNcYfH/JQJ04LagnmyU99uNwDOvHdCEu7R71cC1
         rl5y538ZgunO0aWEO9srhpt67Vo+wB/q2jvveGxLjWZE7NYcR1CtRmV/Sw+Buc7BK4rl
         ENRA==
X-Gm-Message-State: AOAM532oY0lP3jmOzhhx+QLzn6/OyAvt+GMasJykn/w5Wmc6oEtYzDoR
        OGAIfJIgasl3RfjLAsVRzUE=
X-Google-Smtp-Source: ABdhPJyTRsjZBJi/VXtYo4IZA0ygGV0lZDPTZ6OCy2TjQKAjTxErBO1H1s5yKM9vZfh+WU2YwXkp9w==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr20559717pjb.158.1615127063574;
        Sun, 07 Mar 2021 06:24:23 -0800 (PST)
Received: from AHUANG12-1LT7M0.lenovo.com (1-174-52-149.dynamic-ip.hinet.net. [1.174.52.149])
        by smtp.gmail.com with ESMTPSA id t6sm2626600pjs.26.2021.03.07.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 06:24:23 -0800 (PST)
From:   Adrian Huang <adrianhuang0701@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Adrian Huang <ahuang12@lenovo.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 1/1] Documentation/x86/boot: Correct algorithm for runtime start address
Date:   Sun,  7 Mar 2021 22:22:51 +0800
Message-Id: <20210307142251.797-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Huang <ahuang12@lenovo.com>

Commit 8ab3820fd5b2 ("x86, kaslr: Return location from decompress_kernel")
enforces CONFIG_PHYSICAL_START as the minimum relocation address when
the kernel option CONFIG_RELOCATABLE is enabled. This change should be
included accordingly.

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Cc: Kees Cook <keescook@chromium.org>
---
 Documentation/x86/boot.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index fc844913dece..808ea181ca40 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -894,10 +894,16 @@ Offset/size:	0x260/4
 
   The kernel runtime start address is determined by the following algorithm::
 
-	if (relocatable_kernel)
-	runtime_start = align_up(load_address, kernel_alignment)
-	else
-	runtime_start = pref_address
+	if (relocatable_kernel) {
+		runtime_start = align_up(load_address, kernel_alignment);
+
+		/* pref_address is the minimum relocation address */
+		if (runtime_start < pref_address)
+			runtime_start = pref_address;
+	} else {
+		/* Adhere to the statement describing in field 'pref_address' */
+		runtime_start = pref_address;
+	}
 
 ============	===============
 Field name:	handover_offset
-- 
2.17.1

