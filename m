Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5485C3AD9DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhFSLp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhFSLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:45:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D1EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:43:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id i34so4473332pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OgpqTQ8TRc+evfamjKBsHRPlfB6iAzq8hyJY+nFPML4=;
        b=prFuScye+Kf39AgSxdKfHdVrPldWc7GbN49YMICgpbe6UvkMdZvX4dfPKyI6NMAg3X
         U88AY3CbsGqFET6OTfoCKwLy1NOF0ruLiLVcKFzUqeNwUfXuV2fUEscciFv6ZkLievX7
         L8K19EcBbfh5NVmBui30qHIR8CH2qx8No5v4OIJSHsZPjuQGodqZjE2yEToft3CIzR0A
         3egG60yLsv+AwcaNExycHzFw9lE1iBJItU1IGeEaiGgZ2OhDlMDbNfT+Sfk23EwUr9jd
         yQHdumfCXhAdgws+Ycs0ijY2yD/356LnTCzn1693OGttfQLPfa8gX40LixYcn+HPWTKi
         PGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OgpqTQ8TRc+evfamjKBsHRPlfB6iAzq8hyJY+nFPML4=;
        b=DSPRjHlIOM6AZJg8iK8m88MGHXO1guEmpn6i1vl770XvJSgcgj10QTtLZrWcaoPrrn
         +QAavASIFrhz3HhUQ4+T4+Jwwxg5PIFBmMS2uWl9HHZWFw8QcR7o+YHnUH4tb0cvAuiU
         aexa8JXh59jsFsZo/AOjLH/eUowa1/0wx0kUC5O5UfWrw+MGKMJKnd9mugm0Am1yRtTU
         Hl9VwZUcK/JJM8YmZgy0Wdac7LQW8NDU1nRQ59M9W9Lh614Lj9krvUO9dvHwYKzC0Sme
         W2uW+rQF7XWzXJJyvwnfi+VJ6V5ZpGK2Lt19LvSI3ONvgUttvoCj9tvcZeb1IgtyI2Vr
         3aSQ==
X-Gm-Message-State: AOAM532tCFZpqmqEx8abyESkXch0yqo7DES9oTM7Bq3R+unJkwDnCnM3
        YDlVSAZSppG60CdP+SJyV3w=
X-Google-Smtp-Source: ABdhPJzX5hLzSu58HgsENCBFDIdHp/AgPEgHWVxVqjft49bZ5+oO01jOZTN9Fqc5OuYGQs/tuODEnA==
X-Received: by 2002:a63:308:: with SMTP id 8mr10453545pgd.194.1624102991565;
        Sat, 19 Jun 2021 04:43:11 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id l201sm10806599pfd.183.2021.06.19.04.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:43:11 -0700 (PDT)
Subject: [PATCH 5/5] riscv: __asm_to/copy_from_user: Bulk copy when both src,
 dst are aligned
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <4637f0f2-2da9-1056-37bf-17c0861b6bff@gmail.com>
Date:   Sat, 19 Jun 2021 20:43:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the lucky situation that the both source and destination address are on
the aligned boundary, perform load and store with register size to copy the
data.

Without the unrolling, it will reduce the speed since the next store
instruction for the same register using from the load will stall the
pipeline.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index e2e57551fc76..bceb0629e440 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -67,6 +67,39 @@ ENTRY(__asm_copy_from_user)
 	bnez	a3, .Lshift_copy
 
 .Lword_copy:
+        /*
+	 * Both src and dst are aligned, unrolled word copy
+	 *
+	 * a0 - start of aligned dst
+	 * a1 - start of aligned src
+	 * a3 - a1 & mask:(SZREG-1)
+	 * t0 - end of aligned dst
+	 */
+	addi	t0, t0, -(8*SZREG-1) /* not to over run */
+2:
+	fixup REG_L   a4,        0(a1), 10f
+	fixup REG_L   a5,    SZREG(a1), 10f
+	fixup REG_L   a6,  2*SZREG(a1), 10f
+	fixup REG_L   a7,  3*SZREG(a1), 10f
+	fixup REG_L   t1,  4*SZREG(a1), 10f
+	fixup REG_L   t2,  5*SZREG(a1), 10f
+	fixup REG_L   t3,  6*SZREG(a1), 10f
+	fixup REG_L   t4,  7*SZREG(a1), 10f
+	fixup REG_S   a4,        0(a0), 10f
+	fixup REG_S   a5,    SZREG(a0), 10f
+	fixup REG_S   a6,  2*SZREG(a0), 10f
+	fixup REG_S   a7,  3*SZREG(a0), 10f
+	fixup REG_S   t1,  4*SZREG(a0), 10f
+	fixup REG_S   t2,  5*SZREG(a0), 10f
+	fixup REG_S   t3,  6*SZREG(a0), 10f
+	fixup REG_S   t4,  7*SZREG(a0), 10f
+	addi	a0, a0, 8*SZREG
+	addi	a1, a1, 8*SZREG
+	bltu	a0, t0, 2b
+
+	addi	t0, t0, 8*SZREG-1 /* revert to original value */
+	j	.Lbyte_copy_tail
+
 .Lshift_copy:
 
 	/*
-- 
2.17.1


