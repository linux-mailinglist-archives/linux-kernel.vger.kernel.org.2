Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D217234323D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 13:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCUMHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 08:07:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52726 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhCUMGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 08:06:53 -0400
Received: from zn.tnic (p200300ec2f265800f8a4683d42ea24f8.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:5800:f8a4:683d:42ea:24f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1E07E1EC04DD;
        Sun, 21 Mar 2021 13:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1616328408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mJFzd82Qd3y6zN9GnntW3Ut8/96jarz7Ao8i4a5pC04=;
        b=fNp2eqvY4THAJagpz0ExsO2gSlsSbtuGbIhNw0+3T6x+bBuZb86PLhsY+1g3hiTurAAnaP
        DQbaIOkVhy/2N/ROYwBfxzQKY6ujTMNlAOGh5IK/ZOzDjvDt5jn3BSM5MwjJoT9VcgauY0
        5k0V2ceN4ai0jdE1jkvKnEVNNIjvaG8=
Date:   Sun, 21 Mar 2021 13:06:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jgross@suse.com,
        mbenes@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] x86/alternatives: Optimize optimize_nops()
Message-ID: <20210321120647.GB14446@zn.tnic>
References: <20210318171103.577093939@infradead.org>
 <20210318171919.520075106@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171919.520075106@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:05PM +0100, Peter Zijlstra wrote:
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -345,19 +345,39 @@ recompute_jump(struct alt_instr *a, u8 *
>  static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
>  {
>  	unsigned long flags;
> -	int i;
> +	int nops = 0, i = 0;
> +	struct insn insn;
> +	u8 *nop = NULL;
>  
> -	for (i = 0; i < a->padlen; i++) {
> -		if (instr[i] != 0x90)
> +	do {
> +		if (insn_decode_kernel(&insn, &instr[i]))
>  			return;
> -	}
>  
> -	local_irq_save(flags);
> -	add_nops(instr + (a->instrlen - a->padlen), a->padlen);
> -	local_irq_restore(flags);
> +		if (insn.length == 1 && insn.opcode.bytes[0] == 0x90) {
> +			if (!nop) {
> +				nop = &instr[i];
> +				nops = 1;
> +			} else {
> +				nops++;
> +			}
> +		}
> +		i += insn.length;
> +
> +		if ((insn.length != 1 || i == a->instrlen) && nop) {
> +
> +			local_irq_save(flags);
> +			add_nops(nop, nops);
> +			local_irq_restore(flags);
> +
> +			DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
> +				   instr, (int)(unsigned long)(nop-instr), nops);
> +
> +			nop = NULL;
> +		}
>  
> -	DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
> -		   instr, a->instrlen - a->padlen, a->padlen);
> +	} while (i < a->instrlen);
> +
> +	WARN_ON_ONCE(nop);
>  }

I think I've made this simpler; pasting the whole function and not the
diff because former is easier to read:

/*
 * "noinline" to cause control flow change and thus invalidate I$ and
 * cause refetch after modification.
 *
 * Jump over the non-NOP insns, the remaining bytes must be single-byte NOPs,
 * optimize them.
 */
static void __init_or_module noinline optimize_nops(struct alt_instr *a, u8 *instr)
{
        unsigned long flags;
        struct insn insn;
        int i = 0, j;

        /* Skip preceding non-NOP instructions. */
        do {
                if (insn_decode_kernel(&insn, &instr[i]))
                        return;

                if (insn.length == 1 && insn.opcode.bytes[0] == 0x90)
                        break;

                i += insn.length;

        } while (i < a->instrlen);

        if (i >= a->instrlen - 1)
                return;

        /* Verify rest is NOPs - should not fire(tm) */
        for (j = i; j < a->instrlen - 1; j++) {
                if (WARN(instr[j] != 0x90, "Wrong insn byte 0x%hx at 0x%px\n",
                         instr[j], &instr[j]))
                        return;
        }

        local_irq_save(flags);
        add_nops(&instr[i], a->instrlen - i);
        local_irq_restore(flags);

        DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
                   instr, i, a->instrlen);
}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
