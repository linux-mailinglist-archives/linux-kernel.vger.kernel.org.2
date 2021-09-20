Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BD2410F57
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhITFmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbhITFmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:42:13 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42443C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 22:40:47 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id j18so20406270ioj.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DjZAydXYzsdy9pCHIcJ/nHjYhS+wh3B+BCzHPEFxGM=;
        b=ZSy9M462yzXAyhrDLIKaEt0Za7KeqPrfuk/ph5LD12+FSewZB/7FIoeswo83+8z52w
         qjCKQJ4k7Y9yxcCTu8gdzPnsL3R/NYcIi1LZ7j/ZAtpKZfey+/fVVx84zrmTI4T+vvbU
         hdN9mmQYcVh558c7+wVBosHtkoTkKOvFN6HT3IHEn+DUz36B+Q9cQJwF9gPLrzZ18Uyr
         u65fgMEb0khMPuYMbl//p+xY8QnkxSXo0slxqzTCfJR+gNyFOKpCcG33PaytMPf5DslG
         yyqeztn+KE5+jlq+rkmRd1GKt/HmJipePfNlXh+C1feN3BrSiKgqZ0RWu7RXGQjsDnLo
         B0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1DjZAydXYzsdy9pCHIcJ/nHjYhS+wh3B+BCzHPEFxGM=;
        b=Owcm7UFcB7SR40caN2SdDIsIhSCcCYW3kjNm9cb7mi9SPO2Kl5iFDu2+l13etakkNF
         DPCFwC/9P9DUiErwH9FpC3uN/7qGbCd4mkZIR9om/M5Q1jraDMyplef/wMCl5XYjHNE3
         +PdLUOUFlOaLYTK6CPdRRivImecm/wa8oiPB+a5DcdwqyXn+pA0Yni4BWlmTv+GxgJ4M
         nuMqpWA76otAuUaG1THnb0sxQRX4JvW5Sy3WK30x4K1v3nKhUeTbC/55iMBvdv7mXIOG
         eW9PjKm9OELlj/wE18vlHRqb5PYShMMw2/iiKjbZrriHy0foKUbLK+paXz9iRKp9jrbm
         nyxQ==
X-Gm-Message-State: AOAM530tLzaUMefaRJDQ54wKCW/9obzJPwCiy70l6knQpjLgmyRQI2p7
        S7om4gElob95jUCIkCkZoww=
X-Google-Smtp-Source: ABdhPJxPZ6vCimeMk7ljVuGBI7srx/4zIwRD7wymtY1wWKemnznN+vZu3cCKIstW1NsEXDixajeoEw==
X-Received: by 2002:a05:6638:1514:: with SMTP id b20mr17887659jat.47.1632116440409;
        Sun, 19 Sep 2021 22:40:40 -0700 (PDT)
Received: from localhost.localdomain (node-17-161.flex.volo.net. [76.191.17.161])
        by smtp.googlemail.com with ESMTPSA id c11sm8032398ile.22.2021.09.19.22.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 22:40:40 -0700 (PDT)
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     goldstein.w.n@gmail.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] x86/fpu: Remove opmask state from avx512_timestamp check
Date:   Mon, 20 Sep 2021 00:39:53 -0500
Message-Id: <20210920053951.4093668-1-goldstein.w.n@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates a new mask, XFEATURE_MASK_ZMM, to test against
xfeatures for conditionally updating the axx512_timestamp.

Based on the comments, the avx512 state is meant to track when the
state would cause frequencey throttling. The opmasks (k0-k7) do not
cause frequency throttling, so they don't make sense to include.

The current implementation, as well as the old, still does have a
false positive on ymm16-ymm31 and xmm16-31 because
XFEATURE_MASK_Hi16_ZMM includes them.

Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
---
Issue is reproducible with the following code on x86_64:

```
	.global	_start
	.text
_start:
	korq	%k0, %k0, %k0

loop:
	jmp	loop


	movl	$60, %eax
	xorl	%edi, %edi
	syscall
```

Pretending run as executable named "foo":

$> cat /proc/$(pidof foo)/arch_status


This should yield -1 as no frequency changing AVX512 instructions
where used but instead tracks the process.

Note there still is a false positive with ymm16-ymm31 and xmm16-xmm31
but since there is no state to distinguish between there use and
zmm16-31 that seems inevitable.

    
 arch/x86/include/asm/fpu/types.h | 2 ++
 arch/x86/kernel/fpu/core.c       | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index f5a38a5f3ae1..a4816fa7d541 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -141,6 +141,8 @@ enum xfeature {
 #define XFEATURE_MASK_AVX512		(XFEATURE_MASK_OPMASK \
 					 | XFEATURE_MASK_ZMM_Hi256 \
 					 | XFEATURE_MASK_Hi16_ZMM)
+#define XFEATURE_MASK_ZMM		(XFEATURE_MASK_ZMM_Hi256 \
+					 | XFEATURE_MASK_Hi16_ZMM)
 
 #define FIRST_EXTENDED_XFEATURE	XFEATURE_YMM
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 7ada7bd03a32..342620a2e8ef 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -104,8 +104,10 @@ void save_fpregs_to_fpstate(struct fpu *fpu)
 		/*
 		 * AVX512 state is tracked here because its use is
 		 * known to slow the max clock speed of the core.
+		 * Note: This has a false positive on Hi16 ymm and
+		 * xmm registers.
 		 */
-		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_AVX512)
+		if (fpu->state.xsave.header.xfeatures & XFEATURE_MASK_ZMM)
 			fpu->avx512_timestamp = jiffies;
 		return;
 	}
-- 
2.25.1

