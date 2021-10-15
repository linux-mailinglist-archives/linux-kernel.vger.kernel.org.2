Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8842F52E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240244AbhJOO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:26:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhJOO0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:26:17 -0400
Received: from zn.tnic (p200300ec2f0cfb008d2f1a8e7c2e2a2a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:fb00:8d2f:1a8e:7c2e:2a2a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9A9C21EC04CB;
        Fri, 15 Oct 2021 16:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634307849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Lc1E4iwrSHe8PO+0SCS5cjv2ePeUMjBU1jpHzVgu7bg=;
        b=UQi/PrugAflCt9Wu9DUym807iOA77Uai/CZRTsYoda6lXjoacNoke+X8C/8sBprIrr5BgJ
        CPUkNZnfvCbYGNmvAW/iYPXVqyxhMt7QW3V2j5lreUvYkwBspv/Sg8Hz1M2arwUpC8PDdl
        TkxMB1jNO+qAVS26b1+FS+i3LbpbW1M=
Date:   Fri, 15 Oct 2021 16:24:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YWmPCF+g+sF4+ieh@zn.tnic>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123645.002402102@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:21PM +0200, Peter Zijlstra wrote:
> +static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
> +{
> +	void (*target)(void);
> +	int reg, i = 0;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE))
> +		return -1;
> +
> +	target = addr + insn->length + insn->immediate.value;
> +	reg = (target - &__x86_indirect_thunk_rax) /
> +	      (&__x86_indirect_thunk_rcx - &__x86_indirect_thunk_rax);

I guess you should compute those values once so that it doesn't have to
do them for each function invocation. And it does them here when I look
at the asm it generates.

> +
> +	if (WARN_ON_ONCE(reg & ~0xf))
> +		return -1;

Sanity-checking the alignment of those thunks?

> +
> +	i = emit_indirect(insn->opcode.bytes[0], reg, bytes);
> +	if (i < 0)
> +		return i;
> +
> +	for (; i < insn->length;)
> +		bytes[i++] = BYTES_NOP1;

Why not:

        nop_len = insn->length - i;
        if (nop_len) {
                memcpy(&bytes[i], x86_nops[nop_len], nop_len);
                i += nop_len;
        }

and then you save yourself the optimize_nops() call because it'll take
the right-sized NOP directly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
