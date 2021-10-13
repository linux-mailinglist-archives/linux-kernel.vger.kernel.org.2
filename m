Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A18D42CC81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 23:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhJMVIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 17:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40077 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230032AbhJMVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634159170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJLynXNeULEYCNL28Q+VFJbvl9s5sWRsmG/vIk/nja8=;
        b=ZIoec2Jms2CcYWU/0L0abwm1fg8tpS4oB5Wde8Cg/Gb+6WdjhzSzeKFszRePsCpwa1djUd
        LVXXCzb4bWA+uH2A2VVWwLyO51VxNCBBDrDaN6LHhKeh0WsGWuN4W9fX9FakFXrW7HTJ+D
        WnhTEHJrKMjJLEiy3HnLSx8eY6wE0+w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-L-3U05ThPVOvOJWChcAT0A-1; Wed, 13 Oct 2021 17:06:09 -0400
X-MC-Unique: L-3U05ThPVOvOJWChcAT0A-1
Received: by mail-qv1-f69.google.com with SMTP id fq15-20020a056214258f00b003831673b6bfso3760145qvb.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 14:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uJLynXNeULEYCNL28Q+VFJbvl9s5sWRsmG/vIk/nja8=;
        b=zyhb++Nqqicwf53IGeRjycDbNQjDD3sBhBI24Gxpu3bPB+6O32JDS15PuIEDuoIg1t
         rdORWkfp1zK7yr4rOzuFryRT2CxR8tz7Nk2Ik1ZpoTTpRlc9IV5q9EMETZKt6JHDgwW5
         xWzs5hhTeaKjNi91ATmyjD1MWjUnKE2KD7A36eme0LHNoPweWbfvKlzO4K2Say+Ohvm2
         lPmxJtnSKWTYBasXUD0YfQXOw8LuMno5tRP4qxf3xG3AGwGeK61J2wEClIPFLxa0xmUG
         gFGBVoEInPVvm/CxbRIWlDZtQASngjIuFKTuLSaYyQyHESQqK3FgNLW4JJT6XnpVKwRm
         9DQg==
X-Gm-Message-State: AOAM532U9n/lNE4a9bVpfiqZVPJcLPL4pmUR6WyPNP54fMF7ADRrVKKj
        lo0prYJV2wwpzaEDtiZpXv+aQ94yfQI1rUiDXZLv9zCjVxB3kYtPbQdqvkgAMXjvFATbnWR5sa2
        zt82Uy8fcSBcByH5NEZJ0vTF2
X-Received: by 2002:a05:620a:d88:: with SMTP id q8mr1411700qkl.496.1634159168763;
        Wed, 13 Oct 2021 14:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGRAauqs1LepDKiRBXJyIdLpPQMxW0lKWmOTw8gAJctUM+Fn16czFyeltXuTfoodUsQCnA+Q==
X-Received: by 2002:a05:620a:d88:: with SMTP id q8mr1411682qkl.496.1634159168561;
        Wed, 13 Oct 2021 14:06:08 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id n123sm371223qke.36.2021.10.13.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 14:06:07 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:06:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 9/9] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211013210605.bz6l7o5xzik5ckga@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.706163435@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123645.706163435@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:26PM +0200, Peter Zijlstra wrote:
> Current BPF codegen doesn't respect X86_FEATURE_RETPOLINE* flags and
> unconditionally emits a thunk call, this is sub-optimal and doesn't
> match the regular, compiler generated, code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/net/bpf_jit_comp.c |   18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2123,14 +2123,18 @@ static int emit_fallback_jump(u8 **pprog
>  	int err = 0;
>  
>  #ifdef CONFIG_RETPOLINE
> -	/* Note that this assumes the the compiler uses external
> -	 * thunks for indirect calls. Both clang and GCC use the same
> -	 * naming convention for external thunks.
> -	 */
> -	err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
> -#else
> -	EMIT2(0xFF, 0xE2);	/* jmp rdx */
> +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> +		if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
> +			/* The AMD retpoline can be easily emitted inline. */
> +			EMIT3(0x0F, 0xAE, 0xE8);	/* lfence */
> +			EMIT2(0xFF, 0xE2);		/* jmp rdx */
> +		} else {
> +			/* Call the retpoline thunk */
> +			err = emit_jump(&prog, __x86_indirect_thunk_rdx, prog);
> +		}
> +	} else
>  #endif
> +	EMIT2(0xFF, 0xE2);	/* jmp rdx */

But the rest of eBPF JIT just emits retpolines unconditionally
regardless of feature, for example see RETPOLINE_RCX_BPF_JIT().  So I'm
thinking this should probably be consistent with that (or that with
this).

-- 
Josh

