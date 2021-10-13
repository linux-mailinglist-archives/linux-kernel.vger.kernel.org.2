Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9942CAC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhJMUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231654AbhJMUSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634156163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+zpM57tek64fM0J8Kk21GMnK3D9CQVRBLWrNmjTLBk=;
        b=Tsp8DZiBjBJRpJ/QOtPk2n1a+2UNLkhxisZpIGaVQU6TX6yDSblKnXJtRKJJx7mONYxO3l
        nbHtWaxLqDA4VTVRpi0jsp3G3dpvPvaW0G9mHzAQfDAFfX64Vu8p4bLjKS4Qn3MMtC9yrb
        VfoagieMOZ3J1n/AP96iZLIdR5eoO3U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-d1qu7EByOZ2to8GrksjByA-1; Wed, 13 Oct 2021 16:16:02 -0400
X-MC-Unique: d1qu7EByOZ2to8GrksjByA-1
Received: by mail-qk1-f199.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so2753302qkp.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A+zpM57tek64fM0J8Kk21GMnK3D9CQVRBLWrNmjTLBk=;
        b=BC8legzgtxGvcNQIhTM63jTEzJ2MdyhmmLSEg1uOFeum+c5VtBiPMl2eahEbsST2qc
         6//MIHhmb1KLhsLZf+jgFy1t3HEJP2wxAA/7iMP/0mHH7Y7Q9NQF/tHjeAIIyEDVJDnD
         C34A0R7yO+ZWwt/ylQTQDeq2YYPw7fVnenFxqg0GzifGLUwntC6L/C6Qcovgt7FT2Gxh
         /K+lTFTqbbDD6BzDURJ9jyLHL5Q7VeS77Q8TenJ1T4kmbiPxvZQgAUX8l8bH6ZuVHexd
         aH1r5AQp+r4/60WJb9dtWoqNLFmvFNH3JjyWs2CnT+7DLxBJrUWTKxsOJYftqrXb/a7k
         37pQ==
X-Gm-Message-State: AOAM533A5s+7mI2Ww/6MlIEhRag4RV/HCTOja8si5RNs3sbYt/xPR8X2
        cpYzp5GFu/bKMID3qJRFDi5re39R6/FGH5yB7Djd2xFltmOU9D3+dSWIwWIs4rzBtvR5QBqxCAb
        Cpe++HRp6+L5iisM/fWhxMAYL
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr1211820qke.198.1634156161612;
        Wed, 13 Oct 2021 13:16:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy74jjRoajSLKzNqUdfBxS05mC89jBZk/pRT2d3PNPU6Fs6A8FRejmJ8RMTMfQ+lsyO79ahHA==
X-Received: by 2002:a37:aa8f:: with SMTP id t137mr1211803qke.198.1634156161390;
        Wed, 13 Oct 2021 13:16:01 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id d129sm294866qkf.136.2021.10.13.13.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:16:01 -0700 (PDT)
Date:   Wed, 13 Oct 2021 13:15:58 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 3/9] x86/asm: Fix register order
Message-ID: <20211013201558.xwvsisgnrirbbckf@treble>
References: <20211013122217.304265366@infradead.org>
 <20211013123644.882036544@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211013123644.882036544@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 02:22:20PM +0200, Peter Zijlstra wrote:
> Ensure the register order is correct; this allows for easy translation
> between register number and trampoline and vice-versa.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

It would be wise to add a comment saying the register order is critical
to the functioning of the system and shouldn't be changed.

> ---
>  arch/x86/include/asm/GEN-for-each-reg.h |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> --- a/arch/x86/include/asm/GEN-for-each-reg.h
> +++ b/arch/x86/include/asm/GEN-for-each-reg.h
> @@ -1,11 +1,12 @@
>  #ifdef CONFIG_64BIT
>  GEN(rax)
> -GEN(rbx)
>  GEN(rcx)
>  GEN(rdx)
> +GEN(rbx)
> +GEN(rsp)
> +GEN(rbp)
>  GEN(rsi)
>  GEN(rdi)
> -GEN(rbp)
>  GEN(r8)
>  GEN(r9)
>  GEN(r10)
> @@ -16,10 +17,11 @@ GEN(r14)
>  GEN(r15)
>  #else
>  GEN(eax)
> -GEN(ebx)
>  GEN(ecx)
>  GEN(edx)
> +GEN(ebx)
> +GEN(esp)
> +GEN(ebp)
>  GEN(esi)
>  GEN(edi)
> -GEN(ebp)
>  #endif

-- 
Josh

