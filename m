Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB6244D2F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 09:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhKKIP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 03:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhKKIP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:15:57 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7C8C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:13:09 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so4004944pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 00:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kLaJsuTpaA6GbzdzOlqPA5jPocR/+5/lqXTo7jiLw+0=;
        b=o7bFLqdkHyIiRXgV5aj8kVoIEhvrVp4fOTxjP2K3O4Vn9ijpUB8aSfsrbSQfdeVu1V
         WO8KuPSLIfrM+/yhGNd1nDuOSQzkOMEjwnLcmi79NcVyPP//g+CRK47GsdT+OSbtIg8x
         r+RPoP5P1xHeYJW2h6XcuLCkjYRCDR2yW+qnbmsVp1/JuaxeoWveAwf3GTxCL1GhjgLl
         VV+t+GaqFjDfzR81lyTEjOEEOj54t3mrWItY7CFu2nWZqVHUQQzfHhBbgOWjFrWSU5Ab
         D0ovgHMWeKuO7LwgeLcfI4QiAg74W5rtvk9Un6zexZgiW9d7UwO2/GODkg0JXA3Fltzw
         FTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kLaJsuTpaA6GbzdzOlqPA5jPocR/+5/lqXTo7jiLw+0=;
        b=mTRG+3P3Hj1sCKqjYEb1lKro4x3DzFVU/Z0GV3/Rxpq3fDuuMWbfIqq2UXKIUu4vRA
         VvMYxwWt1sBADRA/NDhumkyJdkiP0EGV6y3SIX3ZaPp4oj2/HmDayLRugBYH7g3Z9b7k
         EOjfGuo1uMUCk9LsJxVzZhhAofRVfYBZ2FZF7FeJhA1CpxfIQKpiRHIJZ5t/UEVYK7mn
         oQGjoOdZpDsovkw2M87HZpMlq4HTJVrXAZNaw2P5ELHagSdykYzRw1WQIcZGarL8/3bG
         +jvGrp+gvc8X0+pER9j3kkm5+IUTdAzU772T7Bp4mRtvvSFXtFzOv8t4G/8egAr8W81Q
         EJ+Q==
X-Gm-Message-State: AOAM532ntwY3f9p4SpNhodhYi42Jdp/976rrxH55eiBNUYLFUA/7P1eH
        yHlWk5HunMWpaq+OGDNsFSA=
X-Google-Smtp-Source: ABdhPJySLKMKCrEWqEdAc0zqnwqogKMEhup18KbnmcPbOhSOn0qy9qkvP2D4yL126UA7R6AQGktc4w==
X-Received: by 2002:a17:902:c713:b0:141:bc54:f32c with SMTP id p19-20020a170902c71300b00141bc54f32cmr5807716plp.82.1636618388359;
        Thu, 11 Nov 2021 00:13:08 -0800 (PST)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id me7sm8998550pjb.9.2021.11.11.00.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 00:13:08 -0800 (PST)
Message-ID: <747e611a-2225-0685-b1e6-8b45ef45042d@gmail.com>
Date:   Thu, 11 Nov 2021 17:13:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: [PATCH v2 1/1] riscv: __asm_copy_to-from_user: Improve using word
 copy, if size is < 9*SZREG
Content-Language: en-US
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <6ebbb5e0-c2bc-89ce-2cb8-4f537c5aea13@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
In-Reply-To: <6ebbb5e0-c2bc-89ce-2cb8-4f537c5aea13@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce the number of slow byte_copy being used.

Currently byte_copy is used for all the cases when the size is smaller than
9*SZREG. When the size is in between 2*SZREG to 9*SZREG, use faster
unrolled word_copy.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 63bc691cff91..50013479cb86 100644
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
+	 * Not unrolled word copy with every 1*SZREG iteration
+	 *
+	 * a0 - start of aligned dst
+	 * a1 - start of aligned src
+	 * t0 - end of aligned dst
+	 */
+	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
+	addi	t0, t0, -(SZREG) /* not to over run */
+1:
+	fixup REG_L   a5, 0(a1)
+	addi	a1, a1, SZREG
+	fixup REG_S   a5, 0(a0)
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


