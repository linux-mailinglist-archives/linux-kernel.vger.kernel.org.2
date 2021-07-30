Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357073DB9A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 15:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhG3Nw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhG3Nw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 09:52:57 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E5C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:52:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q2so11149774plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9jaR2rmX/3dC2lW1w3ahiNAnSoQAbHd0csMaeJZR0hU=;
        b=FcyR6kZNKGmJN9ZVh1OuJWghpYEzqbh0B3Dq9cY4PwdF4MgHJKKgEaiQqYM4yUM3+l
         LhZw6RYcaJfPpZWpDf+9axNLSOj5VhsfmkriITvXK7xcsauPhR5zrug6BPdizHBPtnUT
         9fFjKILH+g+yiNlaM3VhJ9+BcxnaufFcPN5cQGeBlELg0yN/7YTgg46vIZcouyUY/7dS
         iXoFJqAz4O3H8XwcfFpvEhfue/oriROfKJzf8Byr5B0isBYTgj5X1BVtmc9x4lcS562M
         B+30SLXW2eQhwkJQkLELaCNNgLFzl6ZxMdQI47JXxdzfq8Kb4CbW93gcRy6ClAfCSPRH
         2dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jaR2rmX/3dC2lW1w3ahiNAnSoQAbHd0csMaeJZR0hU=;
        b=VHKjspuqQ9pAc7faRMfi/JotmCQXkQMIAS5leRIcVTWfSezRH64mYIPT6ePzZnxc4y
         2anjKKfU9PsNXRVkQDN5FbbH32OC0gVtH4QgNI29DbgSMq4NDgBuLovlDEQjqlVhtb2/
         NlY/Vgoykg2UwFazjgTsNDciQs5eHGuUUeB1RQM/LklIcyMCkj9B9rz59bpqNgx7prKp
         fOfgOqLfRFsS2yLly5rYwGCecNjrS+8Wse6ri5MRW7XD8ZzoUlXjhp+I1PlcZ1VnTqhl
         cQ678MiZXpqF989x7nlHXDg2+LpvmkY0J72eZ1ZiXh84r+f8ITz5JNzIJMstXphDvN1K
         lwcg==
X-Gm-Message-State: AOAM530SPhi/TNLZQlBnd+oiaaPFxwvU/1PM+Rj/uoYQI3GdPzSXFzk6
        /rZN7R/mkcczd2W30LLUo+Se3L//PblsnA==
X-Google-Smtp-Source: ABdhPJwXBqF8MeVB/0tvzqUQZ7D8xt5lt36DIcY+nYPnFJjM3xrJ64/EDsbMiw2Es9izMZs/wfslEA==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr3279539pjh.217.1627653170600;
        Fri, 30 Jul 2021 06:52:50 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id m2sm2314432pja.52.2021.07.30.06.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 06:52:50 -0700 (PDT)
Subject: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word copy
 if size < 9*SZREG
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
Date:   Fri, 30 Jul 2021 22:52:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the number of slow byte_copy when the size is in between
2*SZREG to 9*SZREG by using none unrolled word_copy.

Without it any size smaller than 9*SZREG will be using slow byte_copy
instead of none unrolled word_copy.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 63bc691cff91..6a80d5517afc 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -34,8 +34,10 @@ ENTRY(__asm_copy_from_user)
 	/*
 	 * Use byte copy only if too small.
 	 * SZREG holds 4 for RV32 and 8 for RV64
+	 * a3 - 2*SZREG is minimum size for word_copy
+	 *      1*SZREG for aligning dst + 1*SZREG for word_copy
 	 */
-	li	a3, 9*SZREG /* size must be larger than size in word_copy */
+	li	a3, 2*SZREG
 	bltu	a2, a3, .Lbyte_copy_tail
 
 	/*
@@ -66,9 +68,40 @@ ENTRY(__asm_copy_from_user)
 	andi	a3, a1, SZREG-1
 	bnez	a3, .Lshift_copy
 
+.Lcheck_size_bulk:
+	/*
+	 * Evaluate the size if possible to use unrolled.
+	 * The word_copy_unlrolled requires larger than 8*SZREG
+	 */
+	li	a3, 8*SZREG
+	add	a4, a0, a3
+	bltu	a4, t0, .Lword_copy_unlrolled
+
 .Lword_copy:
-        /*
-	 * Both src and dst are aligned, unrolled word copy
+	/*
+	 * Both src and dst are aligned
+	 * None unrolled word copy with every 1*SZREG iteration
+	 *
+	 * a0 - start of aligned dst
+	 * a1 - start of aligned src
+	 * t0 - end of aligned dst
+	 */
+	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
+	addi	t0, t0, -(SZREG) /* not to over run */
+1:
+	REG_L	a5, 0(a1)
+	addi	a1, a1, SZREG
+	REG_S	a5, 0(a0)
+	addi	a0, a0, SZREG
+	bltu	a0, t0, 1b
+
+	addi	t0, t0, SZREG /* revert to original value */
+	j	.Lbyte_copy_tail
+
+.Lword_copy_unlrolled:
+	/*
+	 * Both src and dst are aligned
+	 * Unrolled word copy with every 8*SZREG iteration
 	 *
 	 * a0 - start of aligned dst
 	 * a1 - start of aligned src
@@ -97,7 +130,12 @@ ENTRY(__asm_copy_from_user)
 	bltu	a0, t0, 2b
 
 	addi	t0, t0, 8*SZREG /* revert to original value */
-	j	.Lbyte_copy_tail
+
+	/*
+	 * Remaining might large enough for word_copy to reduce slow byte
+	 * copy
+	 */
+	j	.Lcheck_size_bulk
 
 .Lshift_copy:
 
-- 
2.17.1

