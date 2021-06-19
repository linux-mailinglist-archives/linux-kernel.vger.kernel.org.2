Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF493AD9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhFSLhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:37:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18817C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:34:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t13so10057409pgu.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PxDFQ3I0YJog9pgbJh/SJmwo/SIulZ+XOOwzT95hgRI=;
        b=JCEUHJYya5T1Q1Qm4yidgPbR6DoCK/e1s3YMSHu9YwPL7XanlcDTu0x18rQmElD5Pt
         8SucHreHwpRnYPcNe4VO5S1CwbIaCH+BgGm0CgtuM39boN1Wt1X8/3cyHrqcRpGKzI7M
         /tX1roPGmUW9XWKk/xzERyih4NTXVUbZWXY6kgjEQPkwwEa9Nrdl1KaGh64+h2/4Hekx
         WdSFpVP6w/wySTQAlWvYW1rywBdJqsSRSKX8NQzfQwgirerzOgr2moLNsupTbSfxca0t
         LBiwb5mfo0Z2f2QY3NgTNHRdXe/ZrbYr5ZWIZ2sO+CZ10hkjYyd1GKeJR43dJLKEgGOh
         jPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PxDFQ3I0YJog9pgbJh/SJmwo/SIulZ+XOOwzT95hgRI=;
        b=DIUOJL73HY+D7X/yjfzpHVmgyPtggSgt5frn1uATnP7SfhB98Rb7IUZjVJiGOErxlr
         j0GsQmbXhScBn/RjBGzpeQeHxF3QdJ7Kg/haUrQm5daGVLFNrb2Gqr3QVU+nHpedgc7L
         QuUQOzdyJ5C93g7xAfYCe85bsn4ejKEuFJnAfjExpbiYnjrZ9jjjPpxXY/NOmxCDXiTi
         QQeCaraX3+PqMKAAGFg6ur3yH/VgghN6eqNxT8WVFD35MQTL0eYI3p31QkQyE+te5H3s
         8CIjjLOzwOqyn8hWmr8gCspS1Rk+1sK43gqAFlT7Z0WNv/FGfMlOXs7RNadpq181y1q5
         7IUg==
X-Gm-Message-State: AOAM531qyKynjiP6Dc+EvwFFgZX5HR4MDQQQdxcxv9JXOtkjRUzEp0Y3
        BLzBqaIaRSV4L067HFLuWRM=
X-Google-Smtp-Source: ABdhPJyjbBaZ6iRflKyZAFZkA3uGjZ7yFTU9YjiKzEk2ueC6ocCxhQ2H8r+fJMcBq+8pOIoGE4tv5Q==
X-Received: by 2002:a63:d815:: with SMTP id b21mr14649944pgh.321.1624102488505;
        Sat, 19 Jun 2021 04:34:48 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id oc10sm9585530pjb.44.2021.06.19.04.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:34:48 -0700 (PDT)
Subject: [PATCH 1/5] riscv: __asm_to/copy_from_user: delete existing code
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <1b454390-cee5-a414-509b-3adb25ec0330@gmail.com>
Date:   Sat, 19 Jun 2021 20:34:43 +0900
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


This is to make the diff easier to read, since the diff on
assembler is horrible to read.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index fceaeb18cc64..da9536e1e9cb 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -19,50 +19,10 @@ ENTRY(__asm_copy_from_user)
 	li t6, SR_SUM
 	csrs CSR_STATUS, t6
 
-	add a3, a1, a2
-	/* Use word-oriented copy only if low-order bits match */
-	andi t0, a0, SZREG-1
-	andi t1, a1, SZREG-1
-	bne t0, t1, 2f
-
-	addi t0, a1, SZREG-1
-	andi t1, a3, ~(SZREG-1)
-	andi t0, t0, ~(SZREG-1)
-	/*
-	 * a3: terminal address of source region
-	 * t0: lowest XLEN-aligned address in source
-	 * t1: highest XLEN-aligned address in source
-	 */
-	bgeu t0, t1, 2f
-	bltu a1, t0, 4f
-1:
-	fixup REG_L, t2, (a1), 10f
-	fixup REG_S, t2, (a0), 10f
-	addi a1, a1, SZREG
-	addi a0, a0, SZREG
-	bltu a1, t1, 1b
-2:
-	bltu a1, a3, 5f
-
-3:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
 	li a0, 0
 	ret
-4: /* Edge case: unalignment */
-	fixup lbu, t2, (a1), 10f
-	fixup sb, t2, (a0), 10f
-	addi a1, a1, 1
-	addi a0, a0, 1
-	bltu a1, t0, 4b
-	j 1b
-5: /* Edge case: remainder */
-	fixup lbu, t2, (a1), 10f
-	fixup sb, t2, (a0), 10f
-	addi a1, a1, 1
-	addi a0, a0, 1
-	bltu a1, a3, 5b
-	j 3b
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
 EXPORT_SYMBOL(__asm_copy_to_user)
-- 
2.17.1


