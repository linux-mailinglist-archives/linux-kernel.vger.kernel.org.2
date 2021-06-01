Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D438F34B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhEXSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhEXSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:52:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA969C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:51:20 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q67so4536131pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DYhGzoCLydoQC9np+Qc6RmKIKm+MNO34z2K8vwu8xf4=;
        b=dXgwIRb5SvhKcl5kt27uGYyi2v8bnA6P/8PYjDrTrsuiXCuRtluVsJWE1uT7UPNKEd
         NNOWAIf+w9Ad0X+qgShJueKQ56dr54u5XGzQFkGMUUZ1I25JrgwWP3fYNe6aGjbc2n7O
         yx5CvyyTEdQKjl3v4yXo5kDLjfVW49xMRcH4H2EudTL0OI9mY1DeyhUVMQzNLbzizHU+
         u3uDMSlYW69VUPfv7rvSgB5Dzm8TZ5cRAemuwtp4JAvv+00fasZEt5eMxsw6HAodlSnh
         S3sAyyvHQl5dAtU96VqUqBlM0g3EVcZ30xIF9J/dZKSp2JytgejFmJf6w1zoolb9io40
         vaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYhGzoCLydoQC9np+Qc6RmKIKm+MNO34z2K8vwu8xf4=;
        b=XNM/ThXVCIOoVA1WaRZzENmOSqMOFEEVNw1LyqySDjyz7r6C7jYJrm3esq98fUU9BW
         yGLpoO581UoiC4xuSJht4ohaNeU1OwLP8arQug1tiCHSZOLAK5owu1LffElXUEq5yC7T
         AgxRITuP4z2tKplOZ2SbA12lhVfZmuMfh1bc0F3bv3aZP4gcNS3Vh1FoDlN3az2VzEir
         LxRgjGJ0PWqV1sbOk5g08lUYg4yIhruudiK4N++CAcNzq4wJ5qozsRZdtTSIY05E38BO
         TKhEKjCetrJuIEosJhh3fqY2BUNqRjaRxgLwRnkt1qEZf4k0dwNNyJcczMV83oliYOgU
         LAbA==
X-Gm-Message-State: AOAM533DsevJwW8TNH1LugKmMIIvcHgufXQ815iCukY0JeBO5pnqhf0V
        SMD5i9VpyaOrrph8J/duA6hGxA==
X-Google-Smtp-Source: ABdhPJzzPvak6IZs9Er3fOpe/vBYnXweqCWn6tBN6i0rHLcG33/VrRmNNZ/5UwCZQSAWIuLg+0ow5A==
X-Received: by 2002:a63:5d19:: with SMTP id r25mr14647985pgb.317.1621882279927;
        Mon, 24 May 2021 11:51:19 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w197sm11402472pfc.5.2021.05.24.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:51:19 -0700 (PDT)
Date:   Mon, 24 May 2021 18:51:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v24 9/9] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
Message-ID: <YKv1o9XCMrLzZ5xW@google.com>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
 <20210401221403.32253-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221403.32253-10-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021, Yu-cheng Yu wrote:
> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
> component of CET.  IBT prevents attacks by ensuring that (most) indirect
> branches and function calls may only land at ENDBR instructions.  Branches
> that don't follow the rules will result in control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually.
> 
> Add ENDBR to __vdso_sgx_enter_enclave() branch targets.
                                          ^
                                          |- indirect

After reading the changelog, I was expecting ENDBR on every label.

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/entry/vdso/vsgx.S | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
> index 86a0e94f68df..c63eafa54abd 100644
> --- a/arch/x86/entry/vdso/vsgx.S
> +++ b/arch/x86/entry/vdso/vsgx.S
> @@ -4,6 +4,7 @@
>  #include <asm/export.h>
>  #include <asm/errno.h>
>  #include <asm/enclu.h>
> +#include <asm/vdso.h>
>  
>  #include "extable.h"
>  
> @@ -27,6 +28,7 @@
>  SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  	/* Prolog */
>  	.cfi_startproc
> +	ENDBR
>  	push	%rbp
>  	.cfi_adjust_cfa_offset	8
>  	.cfi_rel_offset		%rbp, 0
> @@ -62,6 +64,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  .Lasync_exit_pointer:
>  .Lenclu_eenter_eresume:
>  	enclu
> +	ENDBR

It would be better to move this below the comment about EEXIT.  As is, it looks
like a misplaced annotation on the AEP.  The AEP doesn't need ENDBR, it's the
EEXIT target that needs ENDBR because EEXIT is treated as an indirect branch.

Might also be helpful for future readers to explicitly state in the changelog
that EEXIT is considered an indirect branch.

I.e.

>  	/* EEXIT jumps here unless the enclave is doing something fancy. */
	ENDBR
>  	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
> @@ -91,6 +94,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
>  	jmp	.Lout
>  
>  .Lhandle_exception:
> +	ENDBR
>  	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
>  
>  	/* Set the exception info. */
> -- 
> 2.21.0
> 
