Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB303CF66F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhGTIQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbhGTIKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:10:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D995C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:50:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d9so7781330pfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hyHfreQCGU1n08jflxUm3GD5Es1OvyJ8VlqC19lqeQY=;
        b=FbegROJ90Iif54xm+O2OALn405pyfAJ8145JLRjkETF6hKetoYcN0nnEQ5/AjABZWW
         6rZp7tgx2uBFBfBMrmRllXU0Igs7FKFLMVgxFexiOUiEs9sz3WKjb27K+zfbwjdMw4rI
         kxKq92ERO02d7NXieZ6mDNNe514vyrET7Ju2BJX6rn4v1tsIXVmmB5bA16d0Nzg8ivYQ
         4ijlXfz7a7lIuyF8spDdmsM5QHnnmUm17Rref03RXj6Yopo38nW+pqJdZSBgzyjXK1fH
         O2ut3/96E27HBd4yokYh/917EnXg4GgTG/41FlbesLf+GrLDmLjZV35mSXMpxajqmFFm
         RsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hyHfreQCGU1n08jflxUm3GD5Es1OvyJ8VlqC19lqeQY=;
        b=rwtrbX3A+DBvf5t9kyzx5F3VWhnm8HqdKLf+i5prt2snu4hGKxbIxSrlmCZAZESKce
         sYtx1Sr6MpQORcmKK2k8SLAJDQ/S3HfN/ymNW0n9nIzVQU+8bis/yYrtwKhtz2QnIgNN
         fwM6MBQY+E0Re9CdgqMG6jMpYEr6SXBNm5cGgQhbJQeNyPpsQkWvO6fZPpOHxP1KGBWW
         NozMDSIwTi4mY7HRwi2IR3FU7Q0wI/ZgP3y3JxIzM0Jc4L9zd8qSzuO4WwYdEHOsLrZY
         yZL2hsAFAdgQbyGOIYu8ed+no30Jj594nHbPg4I14oBUFkLdlyUNGIrcMeeIDvXy1YYh
         mgGQ==
X-Gm-Message-State: AOAM530qCsVXJeSGAzwYgx/5uL+Fur2jZal2NdMr8w80zkspknAG/NJI
        0LOfdJL/PGGYuROKA6cPXPlB8vYiJG4=
X-Google-Smtp-Source: ABdhPJxq5NwFbLCn786YXAAZfvZ5Y0RKQPaxTlLcGvNw8E60U5x7oPuMNvXy8Z9gVpdSlWVx0bVXHw==
X-Received: by 2002:a65:5284:: with SMTP id y4mr10889779pgp.19.1626771058139;
        Tue, 20 Jul 2021 01:50:58 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id n5sm22829381pfv.29.2021.07.20.01.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 01:50:57 -0700 (PDT)
Subject: [PATCH 1/4] riscv: __asm_copy_to-from_user: Fix: overrun copy
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <415f9adf-8dd6-2467-8e74-0ed9d5cdfed9@gmail.com>
Date:   Tue, 20 Jul 2021 17:50:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


There were two causes for the overrun memory access.

The threshold size was too small.
The aligning dst require one SZREG and unrolling word copy requires
8*SZREG, total have to be at least 9*SZREG.

Inside the unrolling copy, the subtracting -(8*SZREG-1) would make
iteration happening one extra loop. Proper value is -(8*SZREG).

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index bceb0629e440..8bbeca89a93f 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -35,7 +35,7 @@ ENTRY(__asm_copy_from_user)
 	/*
 	 * Use byte copy only if too small.
 	 */
-	li	a3, 8*SZREG /* size must be larger than size in word_copy */
+	li	a3, 9*SZREG /* size must be larger than size in word_copy */
 	bltu	a2, a3, .Lbyte_copy_tail
 
 	/*
@@ -75,7 +75,7 @@ ENTRY(__asm_copy_from_user)
 	 * a3 - a1 & mask:(SZREG-1)
 	 * t0 - end of aligned dst
 	 */
-	addi	t0, t0, -(8*SZREG-1) /* not to over run */
+	addi	t0, t0, -(8*SZREG) /* not to over run */
 2:
 	fixup REG_L   a4,        0(a1), 10f
 	fixup REG_L   a5,    SZREG(a1), 10f
@@ -97,7 +97,7 @@ ENTRY(__asm_copy_from_user)
 	addi	a1, a1, 8*SZREG
 	bltu	a0, t0, 2b
 
-	addi	t0, t0, 8*SZREG-1 /* revert to original value */
+	addi	t0, t0, 8*SZREG /* revert to original value */
 	j	.Lbyte_copy_tail
 
 .Lshift_copy:
-- 
2.17.1


