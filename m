Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7533450E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 21:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhCVUgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhCVUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 16:35:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D09C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:35:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id bx7so20965859edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KU4nfRvbfNbUHO2h9TXLz9JlUbED5OGOV5WQblopDQo=;
        b=bSS/BFvjqUh4ve7QgLOGNgSV7lHkbjP/3jU+f0FgTH8iN5jHMtDVAh3degFW0znI3p
         dOahxo2ijK3WL05Zq8M8HaTJCN4nUR+Z99+MmedHZzg+b4bsJb6Ql+rTVtuNS31ZuQVh
         u0evnJF+rQj5c76/e0GaZQIOnoeuUTKFNdf1mSx5GPHVlGBRz1UA2YN83njqyT8fvoBT
         v/6T2jOpjbpG/tfN3MbAt+v6qaEfcIxBZUo8vrveX1qS4QGgK5ch07lGHwsbjZRGwDSf
         T3GvQO6lx9YC83pFn14hwVdPY98JCLVdUKKbBL/HyxwrHY2wMY48EyeTdMyVwIvlOPUK
         t12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=KU4nfRvbfNbUHO2h9TXLz9JlUbED5OGOV5WQblopDQo=;
        b=HlB39UbxzqrXRMTr9tMXH1hukV8rKpqDS0N4kuYItOwvUk2jRSGgKHykoiyErKJeKX
         R8NVaoen3gjY/YLbKIL3h4E8A14ps4usUEWRQPxBHlKi77xfNQoVk5KC8ENd2ObMtMVg
         HikNDtKQxO4EApZe+XpdpCdW1L/cG7J92QD/ce7CxwyaLPtJQVghl5oFUu7NsqxIBoNo
         QH/OI8Lxe+hH5UaqIzhZtvkLaLJexegK0oSf6M8rewj+2s5PSDqOKP1xmpyfc9HtoAlf
         dZHZ8K4X6MQSSmWSJb4oX4BhyeP0AHTAM6g//5jcSQBEAe/sOovgWw6P6/YejVC6TmvB
         8K/w==
X-Gm-Message-State: AOAM533fjsqjnCBlJ8yYfVjbnR1jMGCQPmAVp5JeT16MgpNTp+mgAr3m
        AQGgNtFp0TkEOHAfwaG5w85fCt84QzQ=
X-Google-Smtp-Source: ABdhPJz9HKNxk90KYQN/7EX0UqXQeXg4rdNg+q5uDAh4XwlSqT3XDEWUdZHamCupqp948j8yNVDwqw==
X-Received: by 2002:aa7:c4d1:: with SMTP id p17mr1381110edr.387.1616445328908;
        Mon, 22 Mar 2021 13:35:28 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p24sm11880965edt.5.2021.03.22.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 13:35:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 22 Mar 2021 21:35:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: math-emu: Fix function cast warning
Message-ID: <20210322203526.GB1955909@gmail.com>
References: <20210322170610.1823153-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210322170610.1823153-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with 'make W=1', gcc points out that casting between
> incompatible function types can be dangerous:
> 
> arch/x86/math-emu/fpu_trig.c:1638:60: error: cast between incompatible function types from ‘int (*)(FPU_REG *, u_char)’ {aka ‘int (*)(struct fpu__reg *, unsigned char)’} to ‘void (*)(FPU_REG *, u_char)’ {aka ‘void (*)(struct fpu__reg *, unsigned char)’} [-Werror=cast-function-type]
>  1638 |         fprem, fyl2xp1, fsqrt_, fsincos, frndint_, fscale, (FUNC_ST0) fsin, fcos
>       |                                                            ^
> 
> This one seems harmless, but it is easy enough to work around it by
> adding an intermediate function that adjusts the return type.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/math-emu/fpu_trig.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/math-emu/fpu_trig.c b/arch/x86/math-emu/fpu_trig.c
> index 4a9887851ad8..aebfdb244cb4 100644
> --- a/arch/x86/math-emu/fpu_trig.c
> +++ b/arch/x86/math-emu/fpu_trig.c
> @@ -547,7 +547,7 @@ static void frndint_(FPU_REG *st0_ptr, u_char st0_tag)
>  		single_arg_error(st0_ptr, st0_tag);
>  }
>  
> -static int fsin(FPU_REG *st0_ptr, u_char tag)
> +static int do_fsin(FPU_REG *st0_ptr, u_char tag)
>  {
>  	u_char arg_sign = getsign(st0_ptr);
>  
> @@ -608,6 +608,11 @@ static int fsin(FPU_REG *st0_ptr, u_char tag)
>  	}
>  }
>  
> +static void fsin(FPU_REG *st0_ptr, u_char tag)
> +{
> +	fsin(st0_ptr, tag);
> +}
> +
>  static int f_cos(FPU_REG *st0_ptr, u_char tag)
>  {
>  	u_char st0_sign;

The existing nomenclature in that code is:

  static int f_cos(FPU_REG *st0_ptr, u_char tag)
  static void fcos(FPU_REG *st0_ptr, u_char st0_tag)

So I'd suggest naming the variant with a return value f_sin().

Thanks,

	Ingo
