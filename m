Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0053DDDEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhHBQsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 12:48:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38283 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhHBQsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 12:48:53 -0400
X-Greylist: delayed 1964 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Aug 2021 12:48:53 EDT
Received: from [127.0.0.1] (c-e16b225c.02-49-7673741.bbcust.telenor.se [92.34.107.225])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 172GFBDp971795
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 2 Aug 2021 09:15:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 172GFBDp971795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021073001; t=1627920916;
        bh=3LR2/7+zPSDFiX252Fsh1owYDsAu29LC6jDMzmcF9xU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ESHAy3M6u/XeqiF3JMAXK+kqxO8Jc/vSJ14aNNBhgilDLKfopsfpZdA9VcCF1GX/X
         lAYGQWDIiNDSh9aAXxyGhowz7+WGXBVmFsaYXc2u5UyO9XEEQzRpcyzBhDqwx5Cx0m
         J1Y1/Kh5D7gcHi5jczXSmW3fty5UjsaGhmQLYHOinzVlkkBJdbb8ChjJjdG28ylg86
         6hb0CpMNR4zxleZVkjobag3Zg0AEGkEMinW7cVTEtmZFsmGL5oBbnQeEG5JHZnoYr0
         RI+KkXfDTx1KUcXON8kXFC1GKpgT6xy+uiIuwdX1X/z6nsO4Nbc8Je8IY3Dao8fJZb
         zD+tndGeCe4RQ==
Date:   Mon, 02 Aug 2021 18:15:00 +0200
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
CC:     Arnd Bergmann <arnd@arndb.de>, Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/asm: fix gcc-5 enqcmds() build failure
User-Agent: K-9 Mail for Android
In-Reply-To: <20210802145356.1154321-1-arnd@kernel.org>
References: <20210802145356.1154321-1-arnd@kernel.org>
Message-ID: <70BD5ED0-BA08-438E-BF14-C49827617C90@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK=2E

The type of arguments to condition code arguments should be bool=2E

On August 2, 2021 4:53:42 PM GMT+02:00, Arnd Bergmann <arnd@kernel=2Eorg> =
wrote:
>From: Arnd Bergmann <arnd@arndb=2Ede>
>
>Building drivers/dma/idxd/submit=2Eo with gcc-5=2E5 results in a cryptic
>error messages:
>
>arch/x86/include/asm/special_insns=2Eh: Assembler messages:
>arch/x86/include/asm/special_insns=2Eh:286: Error: operand size mismatch =
for `setz'
>make[5]: *** [scripts/Makefile=2Ebuild:272: drivers/dma/idxd/submit=2Eo] =
Error 1
>
>It seems that this happens for 32-bit arguments when the instruction
>expects an 8-bit argument=2E Change the type of the local variable
>accordingly to get a clean build=2E
>
>Fixes: 7f5933f81bd8 ("x86/asm: Add an enqcmds() wrapper for the ENQCMDS i=
nstruction")
>Fixes: 8e50d392652f ("dmaengine: idxd: Add shared workqueue support") # g=
uessed
>Signed-off-by: Arnd Bergmann <arnd@arndb=2Ede>
>---
> arch/x86/include/asm/special_insns=2Eh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/include/asm/special_insns=2Eh b/arch/x86/include/as=
m/special_insns=2Eh
>index f3fbb84ff8a7=2E=2E33264839f99e 100644
>--- a/arch/x86/include/asm/special_insns=2Eh
>+++ b/arch/x86/include/asm/special_insns=2Eh
>@@ -275,7 +275,7 @@ static inline int enqcmds(void __iomem *dst, const vo=
id *src)
> {
> 	const struct { char _[64]; } *__src =3D src;
> 	struct { char _[64]; } __iomem *__dst =3D dst;
>-	int zf;
>+	u8 zf;
>=20
> 	/*
> 	 * ENQCMDS %(rdx), rax

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
