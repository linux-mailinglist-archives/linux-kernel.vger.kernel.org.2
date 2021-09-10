Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54053407403
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 01:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhIJXmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 19:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhIJXm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 19:42:29 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C3C0613DF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:15 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h9-20020a05621413a900b0037a2d3eaf8fso40096445qvz.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YEmwi7Tj0kCjh6V7g9aN0YraW8uzMWFmrARhRhvny3I=;
        b=RPBIg95u6Anq/SGueX445eP7TczY5dK74ouUzISfoUl7PMfpwk74LbgNA84ioOq7dL
         dbrOusRGKsifFAvO9rS2ey3c/4djphfaL5Fb5kQah4ToMLID/Cp/fKirCeW8kYuyXo+r
         9NX6Ee9afYRreiLl9ZFEIwwz0FbdfWn12xI/OlSaLrQgDq41Bz9B2G6nNn3c4N9TViW/
         GauEsd0xyhfJmGttXPEzz4bzipacXmT3rGcqGu1ISsEhm/mZHct0RC0jj7FSMBvsw8aQ
         mJA6JXxA2XsrHwfm3L0lp2YCKamjDcr7v2SZ6Zmsdt4uudq71AwIac24meZBC/BC0CPI
         YJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YEmwi7Tj0kCjh6V7g9aN0YraW8uzMWFmrARhRhvny3I=;
        b=KOUCbjHpe2NPU8qeHsfi4hUrwtNf5/zJTShfi3WqyKedxd9tjiYzV+jd0QbTARprS0
         jLqgfsCPS7Cy2TdiAklENc3LDb6b9w9VSq6pl8naQrZvGA+OoB362RtdbotpwhbXsWFc
         uLOxjW//1/+982cDCkHgfwtZFGALAwyPaXeK+bx7L9EOP+WK+bfL3Zd0BN9qY+k7qK78
         Ee6jfwaXmb5O3g47OPTbdHq9SQGAncafNcoBIfJf2EkyrtFe0O5wTn8veKHN9yKCGF+h
         bx6pjwITnVJY602tDUedynCIFQR2ib/Z6775tk+BrS/jMJju93LGltUwycMbKigirNm5
         tZRw==
X-Gm-Message-State: AOAM532r+8WhKdOzbqE3c2S7A6BBoAWHRgwsn/ha8tGXq130fr50nycv
        FZeTdnwddrVlgDIQYA/A4/fH3mHYMBVCwCfPHEM=
X-Google-Smtp-Source: ABdhPJwAvYOSR2O8xm1EsycpD3M3UheO+Uw5/QhtUMB9XjozM/U8NcKbCquOrf1ej0cyOrQhl25lUCvoJNBOPjt58R4=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:2b76:71d3:b5fb:3734])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1324:: with SMTP id
 c4mr43709qvv.61.1631317274899; Fri, 10 Sep 2021 16:41:14 -0700 (PDT)
Date:   Fri, 10 Sep 2021 16:40:47 -0700
In-Reply-To: <20210910234047.1019925-1-ndesaulniers@google.com>
Message-Id: <20210910234047.1019925-11-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210910234047.1019925-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH 10/10] vmlinux.lds.h: remove old check for GCC 4.9
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that GCC 5.1 is the minimally supported version of GCC, we can
effectively revert

commit 85c2ce9104eb ("sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to
64 bytes for GCC-4.9")

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/asm-generic/vmlinux.lds.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index aa50bf2959fe..f2984af2b85b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -116,11 +116,7 @@
  * GCC 4.5 and later have a 32 bytes section alignment for structures.
  * Except GCC 4.9, that feels the need to align on 64 bytes.
  */
-#if __GNUC__ == 4 && __GNUC_MINOR__ == 9
-#define STRUCT_ALIGNMENT 64
-#else
 #define STRUCT_ALIGNMENT 32
-#endif
 #define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
 
 /*
-- 
2.33.0.309.g3052b89438-goog

