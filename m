Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF913CF670
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhGTIQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhGTILM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:11:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F3C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:51:51 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u3so11100564plf.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aTo/UaN/uIwO2OnmcLf1Lt/oTHeOCsH/C4eq+JFYMqI=;
        b=FdF6KxfXqg4yzB+3kblIIryje5mWoAjr5ZUjta4Ib2MBg2eJbhNJzUfoY+9kQT9F1V
         nXlVx7lzes9NycArJ/ycbBVl2h7sGllfG4rCV3pJTyCWQdWtnlRANLZhsTDRi9ZFSOpg
         AppXUyVUO9bQXnVzpW5lIFX/1KwHLvb2V6beq6CQDrfXHq2gQOOa/aSZkywOJOC2Ukvj
         DOfnZsUrjx2u/uXyrZuxpyK8cXXeFeHanEKztIajUbZUHJVTj4Ic10Vqgq6uLICy2NTx
         bNJiEaT+Lh/JSlCXNDoOp9sbz6yIOqOBnzHb7BaYtbSyybGBxF+hxGXUH1+WzwMdZLFD
         dfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aTo/UaN/uIwO2OnmcLf1Lt/oTHeOCsH/C4eq+JFYMqI=;
        b=cMKgfcBKKIikL7P8J0UuBBcwx+wqS6q1nTrKdxEPGp79GSjWpOKCU+rtRh+sMP3l6p
         43L9ufBHUPcQLngUB4ECQYMFMykTCs0OjdB/dOyaPnJIaEbG30E1d82gYYOX3oT0K1UI
         Jm07+W6pbXe/Ipo8ZWp6k1Ie4hurwX3+4cC5OnW3O1hOWoW809XO3c26j1L8zVyZkEhy
         QUk/+Bs8tHyXOCVpnjarLf0eCBYZQxOWb6nPKIV+w3fs6Tv1K1CWRlDyhcHZ8DHpFiDA
         HIxzgGd+Q4Lpl3T5E/KL/zBz0mo5IBZHdgx1V9L1LyrQcXwOOQ91mS3dUzmlT+frMwmL
         eAWA==
X-Gm-Message-State: AOAM530LyxV6Endtqup2lOJEbb3AEKIMQQhatfTCfOCHIOSE+C6iledQ
        2l6dYfvg08X69J7exTYp7BDwC5mt0Og=
X-Google-Smtp-Source: ABdhPJxzkHbKv6A4saCiIqD0Ek9+anWOZa0lmykmowFKmIYPEIifzYM70dRvTR2asELYuBGgEXurqg==
X-Received: by 2002:a17:902:b418:b029:12a:edee:a7ff with SMTP id x24-20020a170902b418b029012aedeea7ffmr22916098plr.59.1626771110340;
        Tue, 20 Jul 2021 01:51:50 -0700 (PDT)
Received: from [192.168.1.153] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id b184sm18479456pfg.72.2021.07.20.01.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 01:51:49 -0700 (PDT)
Subject: [PATCH 2/4] riscv: __asm_copy_to-from_user: Fix: fail on RV32
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <37097718-c472-025a-2058-55667badc5b9@gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <93a6ae3b-3271-5edb-0a1b-260ba789f3f1@gmail.com>
Date:   Tue, 20 Jul 2021 17:51:45 +0900
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


Had a bug when converting bytes to bits when the cpu was rv32.

The a3 contains the number of bytes and multiple of 8
would be the bits. The LGREG is holding 2 for RV32 and 3 for
RV32, so to achieve multiple of 8 it must always be constant 3.
The 2 was mistakenly used for rv32.

Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
---
 arch/riscv/lib/uaccess.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index 8bbeca89a93f..279876821969 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -125,7 +125,7 @@ ENTRY(__asm_copy_from_user)
 	 * t3 - prev shift
 	 * t4 - current shift
 	 */
-	slli	t3, a3, LGREG
+	slli	t3, a3, 3 /* converting bytes in a3 to bits */
 	li	a5, SZREG*8
 	sub	t4, a5, t3
 
-- 
2.17.1


