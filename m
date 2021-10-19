Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0ED432D17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhJSFUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbhJSFT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:19:56 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62605C06176A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id t184so15743403pfd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpwCKGAFnfbpOd/zcaH7F5Z8Yc6ZS7hw+lYXR70Y9ss=;
        b=kdTEPQkPgM261o3kgoIkw0xy2Evj9ADnF1vPIqq4tzrerJtKHZo6pePeBWaDGDbiPo
         8NItS3DgCNXXMj3KhAy8gfp3iyxBoXdCSaWx0aus4y54hLNJ4YPkSFh+IAf0S/oX6zMc
         qIpJ5ZmAyFw3d3NvgVEnjplN0nn8a9R/bRseVV0t5mfZSDp+BM2ku0S718vYKJ3rGrOD
         No0LRoM1qsWkPjrlhHM8VdL7DETueXAelw4FvQc0s6lmYTOHBP1CZj1vFRb23xpkJUB0
         8sInYMlsA+43y3iTOUK38tyMsZ1c5fy9zg2779MPSUsz7mnMK3lEve+DcLXWj1EsK2F/
         ZtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpwCKGAFnfbpOd/zcaH7F5Z8Yc6ZS7hw+lYXR70Y9ss=;
        b=bEfAt0DBXUPnZCaLOutV/KYtz9GP8LZ05wL4/fF/VK7leuFnld97znxEdYh/zRQ4U4
         gIJFX+PLlLGnzO8rQwPAz/+H0iB5itzCTDcSn3qGHmZjg4ODrNdU8XfAhXWckUk9wJnz
         WLM++EQVeYSgoL1+wU7eqP2HnGhaDQQJl8ptYHx+pB6BnUoHjuPmQgmQFGh+CnW+zgB6
         2WzXXIiW4nCt+vHFj9yVjLfptkb2Ynh65HyNOyJ/MYmPSbnTzrCoXJCvnqCIJAYiN1Hx
         4pZU1Dit0+z+7lhklRChkax80WPw/0xsX+6DmdUc40FBW3Vdtx1gEE/UMIayXEFtXh9Q
         1w/w==
X-Gm-Message-State: AOAM530BEqKpwEMlPUrSAsap4phGUegEK5xNDDwMRfYmPZp9wfhrydno
        KOw73KKcDQwEioHK6nlp/jYJsQEwIpw=
X-Google-Smtp-Source: ABdhPJxD4BHzRimsrlVACluvuGVgkEqlriTtYoQI1iLf9lkBJR/7FSs/mUZmBfCVjyT6bbhHimSyzA==
X-Received: by 2002:aa7:8246:0:b0:44b:4870:1b09 with SMTP id e6-20020aa78246000000b0044b48701b09mr33993824pfn.82.1634620663974;
        Mon, 18 Oct 2021 22:17:43 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:4171:83c2:8384:24c5])
        by smtp.gmail.com with ESMTPSA id me12sm1168844pjb.27.2021.10.18.22.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 22:17:43 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 07/10] xtensa: use register window specific opcodes only when present
Date:   Mon, 18 Oct 2021 22:17:13 -0700
Message-Id: <20211019051716.4173-8-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211019051716.4173-1-jcmvbkbc@gmail.com>
References: <20211019051716.4173-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa core may be configured without register windows support, don't
use register window specific opcodes in that case. Use window register
specific opcodes to initialize hardware or reset core to a known state
regardless of the chosen ABI.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/boot/boot-elf/bootstrap.S     | 2 ++
 arch/xtensa/boot/boot-redboot/bootstrap.S | 4 ++--
 arch/xtensa/kernel/align.S                | 2 ++
 arch/xtensa/kernel/entry.S                | 2 ++
 arch/xtensa/kernel/head.S                 | 2 ++
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/boot/boot-elf/bootstrap.S b/arch/xtensa/boot/boot-elf/bootstrap.S
index 99e98c9bae41..2dd28931d699 100644
--- a/arch/xtensa/boot/boot-elf/bootstrap.S
+++ b/arch/xtensa/boot/boot-elf/bootstrap.S
@@ -42,12 +42,14 @@ _bootparam:
 
 	.align  4
 _SetupMMU:
+#if XCHAL_HAVE_WINDOWED
 	movi	a0, 0
 	wsr	a0, windowbase
 	rsync
 	movi	a0, 1
 	wsr	a0, windowstart
 	rsync
+#endif
 	movi	a0, 0x1F
 	wsr	a0, ps
 	rsync
diff --git a/arch/xtensa/boot/boot-redboot/bootstrap.S b/arch/xtensa/boot/boot-redboot/bootstrap.S
index 51e8f3b88e82..3ed94ad35000 100644
--- a/arch/xtensa/boot/boot-redboot/bootstrap.S
+++ b/arch/xtensa/boot/boot-redboot/bootstrap.S
@@ -56,13 +56,13 @@ _start:
 	movi	a4, 1
 	wsr	a4, ps
 	rsync
-
+#if XCHAL_HAVE_WINDOWED
 	rsr	a5, windowbase
 	ssl	a5
 	sll	a4, a4
 	wsr	a4, windowstart
 	rsync
-
+#endif
 	movi	a4, KERNEL_PS_WOE_MASK
 	wsr	a4, ps
 	rsync
diff --git a/arch/xtensa/kernel/align.S b/arch/xtensa/kernel/align.S
index 9301452e521e..d062c732ef18 100644
--- a/arch/xtensa/kernel/align.S
+++ b/arch/xtensa/kernel/align.S
@@ -58,7 +58,9 @@
  *  BE  shift left / mask 0 0 X X
  */
 
+#if XCHAL_HAVE_WINDOWED
 #define UNALIGNED_USER_EXCEPTION
+#endif
 
 #if XCHAL_HAVE_BE
 
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index a144b467c3fd..8029ce24af92 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -940,12 +940,14 @@ unrecoverable_text:
 
 ENTRY(unrecoverable_exception)
 
+#if XCHAL_HAVE_WINDOWED
 	movi	a0, 1
 	movi	a1, 0
 
 	wsr	a0, windowstart
 	wsr	a1, windowbase
 	rsync
+#endif
 
 	movi	a1, KERNEL_PS_WOE_MASK | LOCKLEVEL
 	wsr	a1, ps
diff --git a/arch/xtensa/kernel/head.S b/arch/xtensa/kernel/head.S
index 8972d64e0b86..8484294bc623 100644
--- a/arch/xtensa/kernel/head.S
+++ b/arch/xtensa/kernel/head.S
@@ -67,11 +67,13 @@ _SetupOCD:
 	 * xt-gdb to single step via DEBUG exceptions received directly
 	 * by ocd.
 	 */
+#if XCHAL_HAVE_WINDOWED
 	movi	a1, 1
 	movi	a0, 0
 	wsr	a1, windowstart
 	wsr	a0, windowbase
 	rsync
+#endif
 
 	movi	a1, LOCKLEVEL
 	wsr	a1, ps
-- 
2.20.1

