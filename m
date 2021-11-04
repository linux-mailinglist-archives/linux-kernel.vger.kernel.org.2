Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22470445C21
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 23:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhKDWbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 18:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229587AbhKDWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 18:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636064909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BBUCmnZZOWE/jDTqU1ME8sp8ZxzHFTRDA93jrM3MF8o=;
        b=hxovmBenKE7Ft5JeNFePn+k7PBS3HU6b6ZnQkFEYB8ZzFYskINCARAMLgkQZhZMfR6zIH/
        8cYBICVRIZ6H6zekEN+eEa2gu4nZ+0cZL8upz+OTexIUbHIQlZCHMyKHNlwmuxgJHE44o8
        8WRL6ZLpZeoMxUCbzgMSsTsJSBbf7Qg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-p9HpsNfvNYOAe6MvgnEqZA-1; Thu, 04 Nov 2021 18:28:28 -0400
X-MC-Unique: p9HpsNfvNYOAe6MvgnEqZA-1
Received: by mail-ot1-f70.google.com with SMTP id c94-20020a9d27e7000000b0055addf8efc1so2875640otb.15
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 15:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BBUCmnZZOWE/jDTqU1ME8sp8ZxzHFTRDA93jrM3MF8o=;
        b=U6NqLXi076Tt8FaXi2mq2cvclb5VCFhaEr3NoZbFOaBgBm0/5nSlt7PplC7+qKn6v7
         JGIxQSYDLS9DzIxygbMVaiUj+h+LNdtPGyDp42/P6W9Nmy9P0DsoHUyAD0R9JcZEpMLG
         Ubnkzzsg6di5Xinw0/ZOlQNlgP7p0cDzb/ZxdNkoBABWkGQ7L28SUtdvSajZ2OYcs6KM
         fYlWYG9vyTmS05Vi1plxYYdmyNEmtI+TM21iZ96XFFEFesxTu8/NgIl/5lv2lhKKcKAc
         vawLS7OpVE9YXe6u+FR0Akoq5Y0KF5LtVYmXZFpKvcTfUccdMEEOL5Ctb2p5/IuO+XLU
         qS3Q==
X-Gm-Message-State: AOAM533kYXUIr7/a4/+mHMXxqh6sLRh5euSnn6TUwGIv6AQPoS0pBTIz
        WeRjdDTxoAfLO10z1VowaFBVJUHcOqqmC9ZYIs2nSpSMcFKuQX+iBwqY5YS7KRgGPWj/+/gegW8
        y4jQ6SZdsgqi5jmarz/CHn7Kc
X-Received: by 2002:a05:6808:20a6:: with SMTP id s38mr14434477oiw.152.1636064907262;
        Thu, 04 Nov 2021 15:28:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ58Bb3s1g6cUckMhPPxeyJ11sCdryZpkF2c2XfnbTE7r1BbvMXQZBNMr45RR+4q0xKqzpBQ==
X-Received: by 2002:a05:6808:20a6:: with SMTP id s38mr14434461oiw.152.1636064907044;
        Thu, 04 Nov 2021 15:28:27 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id n23sm652953oop.32.2021.11.04.15.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 15:28:26 -0700 (PDT)
Date:   Thu, 4 Nov 2021 15:28:23 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 10/22] x86,uaccess: Remove .fixup usage
Message-ID: <20211104222823.wbhdhuuhu7vmiyv2@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.107322937@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165525.107322937@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:39PM +0100, Peter Zijlstra wrote:
>  #define __get_user_asm_u64(x, ptr, retval) \
> -	 __get_user_asm(x, ptr, retval, "q", "=r")
> +	 __get_user_asm(x, ptr, retval, "q", "=a")
>  #endif
>  
>  #define __get_user_size(x, ptr, size, retval)				\
> @@ -379,14 +377,14 @@ do {									\
>  	__chk_user_ptr(ptr);						\
>  	switch (size) {							\
>  	case 1:								\
> -		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
> +		__get_user_asm(x_u8__, ptr, retval, "b", "=a");		\
>  		(x) = x_u8__;						\
>  		break;							\
>  	case 2:								\
> -		__get_user_asm(x, ptr, retval, "w", "=r");		\
> +		__get_user_asm(x, ptr, retval, "w", "=a");		\
>  		break;							\
>  	case 4:								\
> -		__get_user_asm(x, ptr, retval, "l", "=r");		\
> +		__get_user_asm(x, ptr, retval, "l", "=a");		\
>  		break;							\
>  	case 8:								\
>  		__get_user_asm_u64(x, ptr, retval);			\
> @@ -400,16 +398,13 @@ do {									\
>  	asm volatile("\n"						\
>  		     "1:	mov"itype" %[umem],%[output]\n"		\
>  		     "2:\n"						\
> -		     ".section .fixup,\"ax\"\n"				\
> -		     "3:	mov %[efault],%[errout]\n"		\
> -		     "	xorl %k[output],%k[output]\n"			\
> -		     "	jmp 2b\n"					\
> -		     ".previous\n"					\
> -		     _ASM_EXTABLE_UA(1b, 3b)				\
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG | \
> +					   EX_FLAG_CLR_AX,		\
> +					   %[errout])			\
>  		     : [errout] "=r" (err),				\
>  		       [output] ltype(x)				\
>  		     : [umem] "m" (__m(addr)),				\
> -		       [efault] "i" (-EFAULT), "0" (err))
> +		       "0" (err))

Since this legacy __get_user_asm() now has a hard dependency on "=a",
might as well just make that explicit by hard-coding the constraint here
and removing the 'ltype' arg.

-- 
Josh

