Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA67331D6B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 04:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCIDVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 22:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCIDVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 22:21:23 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361AFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:21:13 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id l4so11744466qkl.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 19:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z16WDXE67iIqm41Rng3wniiStsJjjQQ4aKs0GYyXmUw=;
        b=lFIwPsSve1GdH5z+2oIrBVqkLopXi4LKpfanGCKTqMCfnTf9WVHpXXTKljsCRKu1QM
         +rxqLGiWL7TjNJ9C7jeD9MU3VMV+PGAb0Zu837GObxnfj5HS4qR1qnG8AdrE97SH5Xq8
         iZMlpB4G14ytsqrLsIoIR+eZ6Hj9PHsNyh4jtRbN98l8htcAOR0Dish1HFb+eBoGcWt4
         NgMTqNk3xVILW4hmiYy4ty/6u/nZZFTHoxhfpcpJw8GdQLkkF5Tc9kG3W5cSqUUUQ6L/
         oVc8x547XNyyfQh7kJJXTbjb47dvzmGibEZfB/tcdNFFHwtcmGvvZJ8bn+5OrXnTvwGC
         nm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z16WDXE67iIqm41Rng3wniiStsJjjQQ4aKs0GYyXmUw=;
        b=jsYjriSm7BAv+7giwQEdWSOQM68d9aSwDKF4MKycr/YTv1ZxUc43EN24NVRq4aymcl
         psDEsHibcXdeeBXgr5cY91dXzpWz4mquXl0NG1+f3wp8DRheR4nt1RyqNSq1+/Okq5M9
         LhlEQMw8ZHWvYRfoQ4olPK99VNRW0GE85x8EB8MDzgnMDfiLruL41dpPGOJxw/gnG//0
         nqbyGyvfLnFFfCOR+dVPR5JkDM0CQXmmPE5lb/1vOaxDYg8b7Od0EaZFV32q9hJR/COD
         yNQ/3R6h4j78t23ehI1aw13OQ7q1BWosF+Qu/Aa0ihGoKt4F18WjZ12qeLQWYe61kqC2
         NEVQ==
X-Gm-Message-State: AOAM532y9PzaqYbDob+Z5dZ6YI7TlZKkDyJcdeyWGqsUioDmGAG4CdSv
        tOnLLLHWDRfYXm7Ous2SWbc=
X-Google-Smtp-Source: ABdhPJwlUZ0+s5i/gDuWYrBVEFoDbfHdPbYAFvT0Hy7oFBSRanA5x+uclo8nVg2zuF7Z8nRVVFkBJg==
X-Received: by 2002:a05:620a:1369:: with SMTP id d9mr24265928qkl.378.1615260072337;
        Mon, 08 Mar 2021 19:21:12 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.204])
        by smtp.gmail.com with ESMTPSA id e190sm9251006qkd.122.2021.03.08.19.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 19:21:11 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, nivedita@alum.mit.edu, keescook@chromium.org,
        jroedel@suse.de, ardb@kernel.org, unixbhaskar@gmail.com,
        ubizjak@gmail.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] arch: x86: boot: compressed: Fix a typo in the file head_64.S
Date:   Tue,  9 Mar 2021 08:50:38 +0530
Message-Id: <20210309032038.3182206-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/performend/performed/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index e94874f4bbc1..a8c4095ee115 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -231,7 +231,7 @@ SYM_FUNC_START(startup_32)
 	/*
 	 * Setup for the jump to 64bit mode
 	 *
-	 * When the jump is performend we will be in long mode but
+	 * When the jump is performed we will be in long mode but
 	 * in 32bit compatibility mode with EFER.LME = 1, CS.L = 0, CS.D = 1
 	 * (and in turn EFER.LMA = 1).	To jump into 64bit mode we use
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
--
2.30.1

