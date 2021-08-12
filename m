Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8863EA5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 15:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhHLNmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbhHLNmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 09:42:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942BC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:41:48 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t35so10340152oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w8ByNvmcER+djVrwXEK9pUfCYkOH6rFbdfIhJ/tSBvA=;
        b=MNipbIQlWMXcHHMJ/+LhWIi2OgJ76yGlWDEmKM/0Bjhpqrf2ZfrIV/O3VG1gs20c4o
         0EYw/Tnt/Q4Lg1N6gTrwRaJsOsvzgPOD6e6Eq5BtewSI1ZZyWF9JqjskwJUjqXK2bHvg
         B3hJGt4+1R1Un8lVAHbXDIQ4XQCJxsbOMKWdPR98mTKJZTCIP/Faj5t+h1vQepdd2qgV
         oVRNCnpRl4SzwP0WctbMN8MytglLzukvw5/g6CbEGp8RdK2HnlnqHOkpJ0PT4TwFa/v9
         H5E7pAeX/h/QR3y7F62jTyKc4Sj6idE4suFcsW1HMpnSVEYwixuntgwctDS3LatpU9kW
         geJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w8ByNvmcER+djVrwXEK9pUfCYkOH6rFbdfIhJ/tSBvA=;
        b=JnnkjfZqk363trYBh3/Ptxm8JJWlkjr8CNAH134o/kSXCcFfPq84h1MMHEJP0ctud7
         16l5GyxFQPJ6AOLBe/+wh6symy0De4ZKehKSqInwyiMPXTAegKkmNaUe0PTPhgPwQWeT
         kI9tOGO4H0It1fROSnXwFrs9NV92TMY+44XSisC6dIxpAW94+QshEkUG9irWZrz9e+MM
         vnszEWb52bgcJdCKuk2XFxF10YU1rFCmuYtZ2fDQcFRrW3SdnbDyirQlohid3S0Ba9dE
         moXQzyUnEB9w8ADyzaU57ccvcAwrcZZnSya1vr/WU0sVNeD9S0WAYRp6I0cMfp0w4QR2
         i4ig==
X-Gm-Message-State: AOAM532hikd0QjxwbC1dLCPEiCxYP4eD6xHIDDecRGVWdlgI1Szs+kC5
        yTMQGyoICTen3PO7jRCKfaM=
X-Google-Smtp-Source: ABdhPJxtwTGZdGVnSxCjpIEUVaQED8UOsBJIekT5sFbgESHHxcYCdesYT3483WIUoZCvGvi50HCaGw==
X-Received: by 2002:a05:6808:144e:: with SMTP id x14mr3316950oiv.28.1628775707346;
        Thu, 12 Aug 2021 06:41:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z21sm613612oto.46.2021.08.12.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:41:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 12 Aug 2021 06:41:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Akira Tsukamoto <akira.tsukamoto@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] riscv: __asm_copy_to-from_user: Improve using word
 copy if size < 9*SZREG
Message-ID: <20210812134145.GA4132779@roeck-us.net>
References: <65f08f01-d4ce-75c2-030b-f8759003e061@gmail.com>
 <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e9fb3a-40b1-50f3-23cc-50bfa53baa8d@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 10:52:44PM +0900, Akira Tsukamoto wrote:
> Reduce the number of slow byte_copy when the size is in between
> 2*SZREG to 9*SZREG by using none unrolled word_copy.
> 
> Without it any size smaller than 9*SZREG will be using slow byte_copy
> instead of none unrolled word_copy.
> 
> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/riscv/lib/uaccess.S | 46 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
> index 63bc691cff91..6a80d5517afc 100644
> --- a/arch/riscv/lib/uaccess.S
> +++ b/arch/riscv/lib/uaccess.S
> @@ -34,8 +34,10 @@ ENTRY(__asm_copy_from_user)
>  	/*
>  	 * Use byte copy only if too small.
>  	 * SZREG holds 4 for RV32 and 8 for RV64
> +	 * a3 - 2*SZREG is minimum size for word_copy
> +	 *      1*SZREG for aligning dst + 1*SZREG for word_copy
>  	 */
> -	li	a3, 9*SZREG /* size must be larger than size in word_copy */
> +	li	a3, 2*SZREG
>  	bltu	a2, a3, .Lbyte_copy_tail
>  
>  	/*
> @@ -66,9 +68,40 @@ ENTRY(__asm_copy_from_user)
>  	andi	a3, a1, SZREG-1
>  	bnez	a3, .Lshift_copy
>  
> +.Lcheck_size_bulk:
> +	/*
> +	 * Evaluate the size if possible to use unrolled.
> +	 * The word_copy_unlrolled requires larger than 8*SZREG
> +	 */
> +	li	a3, 8*SZREG
> +	add	a4, a0, a3
> +	bltu	a4, t0, .Lword_copy_unlrolled
> +
>  .Lword_copy:
> -        /*
> -	 * Both src and dst are aligned, unrolled word copy
> +	/*
> +	 * Both src and dst are aligned
> +	 * None unrolled word copy with every 1*SZREG iteration
> +	 *
> +	 * a0 - start of aligned dst
> +	 * a1 - start of aligned src
> +	 * t0 - end of aligned dst
> +	 */
> +	bgeu	a0, t0, .Lbyte_copy_tail /* check if end of copy */
> +	addi	t0, t0, -(SZREG) /* not to over run */
> +1:
> +	REG_L	a5, 0(a1)
> +	addi	a1, a1, SZREG
> +	REG_S	a5, 0(a0)
> +	addi	a0, a0, SZREG
> +	bltu	a0, t0, 1b
> +
> +	addi	t0, t0, SZREG /* revert to original value */
> +	j	.Lbyte_copy_tail
> +
> +.Lword_copy_unlrolled:
> +	/*
> +	 * Both src and dst are aligned
> +	 * Unrolled word copy with every 8*SZREG iteration
>  	 *
>  	 * a0 - start of aligned dst
>  	 * a1 - start of aligned src
> @@ -97,7 +130,12 @@ ENTRY(__asm_copy_from_user)
>  	bltu	a0, t0, 2b
>  
>  	addi	t0, t0, 8*SZREG /* revert to original value */
> -	j	.Lbyte_copy_tail
> +
> +	/*
> +	 * Remaining might large enough for word_copy to reduce slow byte
> +	 * copy
> +	 */
> +	j	.Lcheck_size_bulk
>  
>  .Lshift_copy:
>  
