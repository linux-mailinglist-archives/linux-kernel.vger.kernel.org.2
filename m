Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65532445C26
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhKDWih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:38:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:57757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhKDWig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636065357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UM+d1xmhkBoFol+pxoF4XFPfG0JONQhQ1OU8R/8oB+0=;
        b=dbbHoA9fxTYTlVmWqfXRNu8vGreRyONJFeMSjJKAsHVzaaf6hdyFcAhMAKgSXmR0sSCCEA
        +kKEblvTnM7a78Pf4c3kt+3T/ul3qJtvsiB8z3/yb30q52V8zk+Jn2xUmSKQH+ZWAPjeTF
        zkks8Quk+YCTFGeMYfH0cbcICrrWyRA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177--3e8FbyvMwSWe2gLOVAs-g-1; Thu, 04 Nov 2021 18:35:54 -0400
X-MC-Unique: -3e8FbyvMwSWe2gLOVAs-g-1
Received: by mail-qv1-f69.google.com with SMTP id hf12-20020a0562140e8c00b00382cdfe644eso6879545qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UM+d1xmhkBoFol+pxoF4XFPfG0JONQhQ1OU8R/8oB+0=;
        b=DgvAQWDL7CvJEuicB9YQcm0gO+QW7mf+esjJGuFBDav2HThfLyUVoXJAsdNfP+vSmI
         N3QgcFkdC6wJeReG2+ltl3rd9wV5hZ1H9gko09HRmuN9hygJ1Va78OeSovrv0UwQ9Tcv
         4yR4bYBgE1BSTrzNQ0a/zgvnPNeh4JMtbSNz1GSGNq5D2XssHdUQnryzOgBCK2vmbFLV
         mnyX7fYMs1MiScdMj2+tJT1dNJrYrJu6Jepwe5hqQbre+4f3U5sZQkdJd4yAzKKjb0nY
         EmhsMtqfNDweiw9GSPRopTUn8iKllNFqGhHoyt4xDRMkjBBzmi9YSOJI4CoPba51U7Ls
         bilg==
X-Gm-Message-State: AOAM533DmbpYt2zzWnJ2ncUfDxwrAyKKunYObqeXy8Weqj/45Ty3rqsT
        LU23NM0spbRrqzP+4Nn2cVRXiPwuaJ1eYOU2YGfFzfGh98Hg29FrEzhQhaRnskZIF5vA9YEp3Yp
        pGICwUh/Bfe5wUubGtYkt2Eap
X-Received: by 2002:a05:622a:58c:: with SMTP id c12mr20616517qtb.204.1636065354185;
        Thu, 04 Nov 2021 15:35:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDecx4/D6XEVxvGNE1ZPA66qMZZHe2yne2aHy4Ij/wyZZeLrQ2G4irC/cTigs24wuZfMDIbA==
X-Received: by 2002:a05:622a:58c:: with SMTP id c12mr20616492qtb.204.1636065353931;
        Thu, 04 Nov 2021 15:35:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id o8sm4970434qtk.77.2021.11.04.15.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 15:35:53 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:35:50 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 14/22] x86,ftrace: Remove .fixup usage
Message-ID: <20211104223550.aiqewkrwpiastsul@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.348183644@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165525.348183644@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:43PM +0100, Peter Zijlstra wrote:
> Create and use EX_TYPE_ONE_REG to load 1 into the %[faulted] register
> on exception.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/extable_fixup_types.h |    1 +
>  arch/x86/kernel/ftrace.c                   |    9 ++-------
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -37,5 +37,6 @@
>  #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(-EFAULT))
>  #define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(-1))
>  #define	EX_TYPE_ZERO_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(0))
> +#define	EX_TYPE_ONE_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(1))
>  
>  #endif
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -661,13 +661,8 @@ void prepare_ftrace_return(unsigned long
>  		"   movl $0, %[faulted]\n"
>  		"3:\n"
>  
> -		".section .fixup, \"ax\"\n"
> -		"4: movl $1, %[faulted]\n"
> -		"   jmp 3b\n"
> -		".previous\n"
> -
> -		_ASM_EXTABLE(1b, 4b)
> -		_ASM_EXTABLE(2b, 4b)
> +		_ASM_EXTABLE_TYPE_REG(1b, 3b, EX_TYPE_ONE_REG, %[faulted])
> +		_ASM_EXTABLE_TYPE_REG(2b, 3b, EX_TYPE_ONE_REG, %[faulted])
>  
>  		: [old] "=&r" (old), [faulted] "=r" (faulted)
>  		: [parent] "r" (parent), [return_hooker] "r" (return_hooker)

This fixup code seems to no longer exist in the latest.

-- 
Josh

