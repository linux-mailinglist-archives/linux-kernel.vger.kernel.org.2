Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2703AD9D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhFSLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:37:55 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A25C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:35:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x22so4485076pll.11
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wa9WYCmkHZzaHb+kJYIYFh7H1ZMev+84Ux7Wa9pyeNg=;
        b=TJBsklKGaYkX1f/McIdSy1IF3SIo35dUxuNO7swhZTvyZof36F8W01SA8kRnDXecKN
         HkMTrtXpR2HO7f3Qzrk0xvXmIvrUtnuFB1xGZNIATyq6IYG8U/m+vgTWvj8lWZQB51f8
         8TD29wasl+lyHj7cbWBcElmKxhU3bGPkI3VlvDNqq+97koi1Pa0xernpGaZu4uLFj/a0
         bq37rnz6DEulxlLZd6K+AAR5kD7kMs9Tq5S1a1TjN163pg4fCgqpKkcZNHSTqovkA9b2
         u07axWAWlkepuJX7ueNSde4imkwkyeRNCcH4wNjyIJZfKXFR10S+e2mXKxCSZDdcFfyE
         fWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wa9WYCmkHZzaHb+kJYIYFh7H1ZMev+84Ux7Wa9pyeNg=;
        b=SFJ+Ua9IGZts7rfapeQMT0F4O7DjAP3XiBjfJkL9RaG2sFGpDh2kmqQxKIUMyxs848
         g0hc1AjCXfcDV8jO/uoLJIzYgnszgmYsi0CgCpbQwdtN3JFtMkM5KzWCKBaYRi2dhtL9
         qKrFKqaYmUHGQVgWF0nl7pZUlcPOvnjq8iHCPMas2+YIxhCA/uQ23Z3M0mT834XmMnlB
         O2VbIV9NKxzB0VJHOB3P/RlW4MvD0xiTshEoG2tO/LIFKyrb4Cnj0gHJFEg8vGhBo3cD
         cf8GnRmq6igQRnw/q1k5b/aleRQchilK4ndh2X2x3kK/Qbg2cR7NRkSojW1Oa29CPiFI
         7RxA==
X-Gm-Message-State: AOAM532G2Jb1DGOoqQdi1yz0TtC7Ral4z5woB9+9T5ERfdV6mRlPSXU4
        PcHBLRfkuyhbleg2A7KUh4A=
X-Google-Smtp-Source: ABdhPJwxj/8EC0yVjHOiWLUTU5TkRA/v04eM3BFH5QLYC5JPAJ4o72KhVR7pXhkcoyt3Zhwk4Js/sQ==
X-Received: by 2002:a17:90a:4cc2:: with SMTP id k60mr4411538pjh.83.1624102544292;
        Sat, 19 Jun 2021 04:35:44 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id p6sm11481026pjh.24.2021.06.19.04.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:35:43 -0700 (PDT)
Subject: [PATCH 2/5] riscv: __asm_to/copy_from_user: Adding byte copy first
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <98088fde-cdb2-6410-8d11-7c8ca984d3c3@gmail.com>
Date:   Sat, 19 Jun 2021 20:35:39 +0900
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


Typical load and store loop.
It is used for mainly copying the remainder in one byte at a time.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index da9536e1e9cb..be1810077f9a 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -19,9 +19,39 @@ ENTRY(__asm_copy_from_user)
 	li t6, SR_SUM
 	csrs CSR_STATUS, t6
 
+	/* Save for return value */
+	mv	t5, a2
+
+	/*
+	 * Register allocation for code below:
+	 * a0 - start of uncopied dst
+	 * a1 - start of uncopied src
+	 * a2 - size
+	 * t0 - end of uncopied dst
+	 */
+	add	t0, a0, a2
+	bgtu	a0, t0, 5f
+
+.Lbyte_copy_tail:
+	/*
+	 * Byte copy anything left.
+	 *
+	 * a0 - start of remaining dst
+	 * a1 - start of remaining src
+	 * t0 - end of remaining dst
+	 */
+	bgeu	a0, t0, 5f
+4:
+	fixup lb      a5, 0(a1), 10f
+	addi	a1, a1, 1	/* src */
+	fixup sb      a5, 0(a0), 10f
+	addi	a0, a0, 1	/* dst */
+	bltu	a0, t0, 4b	/* t0 - end of dst */
+
+5:
 	/* Disable access to user memory */
 	csrc CSR_STATUS, t6
-	li a0, 0
+	li	a0, 0
 	ret
 ENDPROC(__asm_copy_to_user)
 ENDPROC(__asm_copy_from_user)
@@ -77,7 +107,7 @@ EXPORT_SYMBOL(__clear_user)
 10:
 	/* Disable access to user memory */
 	csrs CSR_STATUS, t6
-	mv a0, a2
+	mv a0, t5
 	ret
 11:
 	csrs CSR_STATUS, t6
-- 
2.17.1


