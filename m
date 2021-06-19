Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2F3AD9DA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhFSLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 07:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhFSLjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 07:39:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F93C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:36:55 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l11so2882035pji.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tWMnQuK+9BIZ4cUDgnnI5UsvvwctYskK0oxgmeF7wt8=;
        b=coJxx5qMalRKncnE5J452fL+slVPFJmTv7X1W8/2E+ZIh9VGPK+NTvs8E4FwnCU6vd
         KQnTqW7h7hU3ExBYdrgu+Sm37nhSuDMdsPPVqHEQbAf/FBFGQ7bJRNPeoQVDmvKwib50
         HoGQW8mVLNy5sVg40UvRa+q17iIKRDtDwwkoaY8fUk+MGFoMszhv1uT1goaTFT2U1BIp
         XZpuTf4QaoURvGZLS1rr5Kpbg4bG5FhccQnfA/5Mq6vIEDAJ/YXJgwmUV5yLflYSCNFu
         tMY43h1Ewkjt9gfS4Wfi6DQ2y47CP8H/dkQHQN2RYdjYpF3BJXU9JBcKcdLe669ntX5S
         t4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tWMnQuK+9BIZ4cUDgnnI5UsvvwctYskK0oxgmeF7wt8=;
        b=Ng2xx3wH59ZdP0Xorsk7nycb4JzsPlRqaKznaUEfzkyz4ne2L4fFM8Xu/7UC+JhnCc
         1SLS2mDbARN3PKZ3gderLljzwb5bYmeJRVwgrcckWcl8h2axQBM07gxxPdh4BlnO4GbB
         n6lQ6kVoNqdfja8L2sye0S0MoKzOxnu5j1SISr35mahkpSxWt7CIkIooZw94ro5WCh07
         wQ0empo76ErdwZveIA/6Zrv5ypknFhysV+cf8+pL7uPB2vSwGbkHZjA+ByShcSjpuG/q
         Tr176yO8yISzt6F5NmpY4O+0X4O05IZZTK0e3FRhUq7CWKx3luJZrdQ013eamp+06J8a
         47+Q==
X-Gm-Message-State: AOAM532/TRCEdZ14RVMGq+NVzKR2w+BlPKPS62CjQOsDH4WKHb5oPYLm
        z/ZgDAWp+IYo3zXG+fM1spA=
X-Google-Smtp-Source: ABdhPJyvEGPpuyqfanHruuFDbzULMZeI2N4HC4CNwz2NULTWpGj39RawbBaqLAMjOnRjtnFdZ6o6aQ==
X-Received: by 2002:a17:90b:503:: with SMTP id r3mr16224862pjz.195.1624102614543;
        Sat, 19 Jun 2021 04:36:54 -0700 (PDT)
Received: from [192.168.1.153] (87.19.178.217.shared.user.transix.jp. [217.178.19.87])
        by smtp.gmail.com with ESMTPSA id o16sm10411752pfk.129.2021.06.19.04.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jun 2021 04:36:54 -0700 (PDT)
Subject: [PATCH 3/5] riscv: __asm_to/copy_from_user: Copy until dst is aligned
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <5a5c07ac-8c11-79d3-46a3-a255d4148f76@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <d2efdd2e-c094-0475-d030-08eaa7efe917@gmail.com>
Date:   Sat, 19 Jun 2021 20:36:49 +0900
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


First copy in bytes until reaches the first word aligned boundary in
destination memory address.

For speeding up the copy, trying to avoid both the unaligned memory access
and byte access are the key. This is the preparation before the bulk
aligned word copy.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index be1810077f9a..4906b5ca91c3 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -32,6 +32,34 @@ ENTRY(__asm_copy_from_user)
 	add	t0, a0, a2
 	bgtu	a0, t0, 5f
 
+	/*
+	 * Use byte copy only if too small.
+	 */
+	li	a3, 8*SZREG /* size must be larger than size in word_copy */
+	bltu	a2, a3, .Lbyte_copy_tail
+
+	/*
+	 * Copy first bytes until dst is align to word boundary.
+	 * a0 - start of dst
+	 * t1 - start of aligned dst
+	 */
+	addi	t1, a0, SZREG-1
+	andi	t1, t1, ~(SZREG-1)
+	/* dst is already aligned, skip */
+	beq	a0, t1, .Lskip_first_bytes
+1:
+	/* a5 - one byte for copying data */
+	fixup lb      a5, 0(a1), 10f
+	addi	a1, a1, 1	/* src */
+	fixup sb      a5, 0(a0), 10f
+	addi	a0, a0, 1	/* dst */
+	bltu	a0, t1, 1b	/* t1 - start of aligned dst */
+
+.Lskip_first_bytes:
+
+.Lword_copy:
+.Lshift_copy:
+
 .Lbyte_copy_tail:
 	/*
 	 * Byte copy anything left.
-- 
2.17.1


