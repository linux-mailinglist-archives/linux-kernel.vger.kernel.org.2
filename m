Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB3445C23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbhKDWeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhKDWef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636065116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fkj5ynysBloUATF+wHHBpCyo6hQRRWlJFmLSZyuJQmE=;
        b=b11q21XMgUOK6mjT+l3u/IoAwASluUj+RVkgwj6rPy9OFgkvffkuU/EKrIRDJv8o8VJ7S+
        vkcpIhByMsNGOSFJ9PzEZ59IOKg1dyBSFkBYF3BdUTwCPl+rXCQRyZacjT+HqbyD5E/q7V
        X1+aHxsXHgeteA4GvBaiiiULbjDKlTM=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-gyP8Qvq1M-u3gJ16YIgGLg-1; Thu, 04 Nov 2021 18:31:55 -0400
X-MC-Unique: gyP8Qvq1M-u3gJ16YIgGLg-1
Received: by mail-oo1-f72.google.com with SMTP id v24-20020a4ae058000000b002bd111beaedso2604665oos.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkj5ynysBloUATF+wHHBpCyo6hQRRWlJFmLSZyuJQmE=;
        b=4dwnV4WGjtb3LQm+FeIai+QCvPg70MNo5CC6wFLiM8SiKjQ0xbhgtqtLb4kxrG83lL
         AXVKJ2zaZI6sdtPbl2jWOBOou/sW2Tq8HFBKGC+h3jR8JQ7iyztId0UtjGJF0g9iCUGd
         K4sG8VbEX1WchXrbwqKeKVU97UP3x3f+0Muobc0swDOEfhJKS9RLnQx/ghlTXPjnVipT
         CvOeYkH/TQb+ijKYYtLRrx+e+l2f565wkApvhleI7Mjs0346UNnjwIXvbxXcCBsFOxsp
         QUAOZRnWmvD3qP5DfhqLyvOz88BzL/w1g8SCdTehvAY4uSYCtXwnwEOeGX4XzE+vvPxT
         TZ8w==
X-Gm-Message-State: AOAM531/VQRQHZx8O7Da7J+Y0D+j5DgaJJwzT21nsJfmGIGZlUN/6s4p
        lgh6VxwlS5No8HZ0TbXpN38F5BaV2R9GFCs8RYQ8Ai11dKZnrQBZeiquVJpk3TioEarZ8mpSR0Q
        Bg7AO/l3AjtgTHFBMwBdiqQ3x
X-Received: by 2002:a05:6830:1aee:: with SMTP id c14mr12762290otd.25.1636065114906;
        Thu, 04 Nov 2021 15:31:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMdEfko4u6TGyxGjoomxTw8QU2KfVlNy+pWYXBAZTUBZ+aLiKgV7fM+MY5rvl/uVdUfSyD7w==
X-Received: by 2002:a05:6830:1aee:: with SMTP id c14mr12762267otd.25.1636065114699;
        Thu, 04 Nov 2021 15:31:54 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id r24sm1258712otc.12.2021.11.04.15.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 15:31:54 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:31:51 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 11/22] x86,xen: Remove .fixup usage
Message-ID: <20211104223151.k553ng4cx6nbke4z@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.168368031@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165525.168368031@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:40PM +0100, Peter Zijlstra wrote:
> Employ the fancy new EX_TYPE_IMM_REG to create EX_TYPE_NEG_REG to
> store '-1' into the designated register and use this to remove some
> Xen .fixup usage.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/extable_fixup_types.h |    1 +
>  arch/x86/include/asm/xen/page.h            |   12 ++----------
>  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -35,5 +35,6 @@
>  
>  #define	EX_TYPE_IMM_REG			17 /* reg := (long)imm */
>  #define	EX_TYPE_EFAULT_REG		(EX_TYPE_IMM_REG | EX_TYPE_IMM(-EFAULT))
> +#define	EX_TYPE_NEG_REG			(EX_TYPE_IMM_REG | EX_TYPE_IMM(-1))
>  
>  #endif
> --- a/arch/x86/include/asm/xen/page.h
> +++ b/arch/x86/include/asm/xen/page.h
> @@ -96,11 +96,7 @@ static inline int xen_safe_write_ulong(u
>  
>  	asm volatile("1: mov %[val], %[ptr]\n"
>  		     "2:\n"
> -		     ".section .fixup, \"ax\"\n"
> -		     "3: sub $1, %[ret]\n"
> -		     "   jmp 2b\n"
> -		     ".previous\n"
> -		     _ASM_EXTABLE(1b, 3b)
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[ret])
>  		     : [ret] "+r" (ret), [ptr] "=m" (*addr)
>  		     : [val] "r" (val));
>  
> @@ -115,11 +111,7 @@ static inline int xen_safe_read_ulong(co
>  
>  	asm volatile("1: mov %[ptr], %[rval]\n"
>  		     "2:\n"
> -		     ".section .fixup, \"ax\"\n"
> -		     "3: sub $1, %[ret]\n"
> -		     "   jmp 2b\n"
> -		     ".previous\n"
> -		     _ASM_EXTABLE(1b, 3b)
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_NEG_REG, %[ret])
>  		     : [ret] "+r" (ret), [rval] "+r" (rval)
>  		     : [ptr] "m" (*addr));
>  	*val = rval;

-EFAULT is also negative, and presumably more appropriate than -1.

Could we just use EX_TYPE_EFAULT_REG?

-- 
Josh

