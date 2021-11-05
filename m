Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9244683C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 19:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhKESFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 14:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231689AbhKESFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 14:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636135340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAIOATAtg7S/5QdcjsIeXtk0TxOFUbQvA2ViOYkKT0k=;
        b=OjKc+wCGOFpw3hamqf7BMwzX2td2952ssu6FRKuwCJYL+D4Tyv7ECsPeR8OBb/7jHn0XrM
        pg0g0Kvo187iO5/7GjgsnU0/cVG/jl3kEtpD8W4befbkj4Q4aeekAbVuWD4GA/CVVw0/ft
        YLikUqrkroipcWIeONenMYEWcP5UfF4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-rHnaNGS2OcirRhPJL-vljA-1; Fri, 05 Nov 2021 14:02:19 -0400
X-MC-Unique: rHnaNGS2OcirRhPJL-vljA-1
Received: by mail-qk1-f200.google.com with SMTP id h2-20020a05620a10a200b00462c87635cdso7660374qkk.15
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 11:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YAIOATAtg7S/5QdcjsIeXtk0TxOFUbQvA2ViOYkKT0k=;
        b=5f48jE/jjVGDPmlqQX8pS/hgtULz1xwsU7fAK0pAetk+BotUT8Iuf+MZF+2z/zTEnw
         SZHxpDipi3+tsZNUNCnEKqxXABGjDpEDT5vk3KKzvkcRThA5a2t8yyek9dCePa+CnV2y
         JUAREA+P97iEeVpbCz+IdyLFwvHA+qY+SEmv8Ad+yoitclHSldvyadgm7Zl6c9xG/mXG
         q75ecLjg4wr7/ETSawKbTE5H2TuzyhH9H2397WERVp0edmoz3Y1F4UEqNVlxHPz7P7j1
         8G8UGJUTsw9yIzOCN0TmKpVWsbk0g+u1HdhE1iXjuVM3ZzylgZUl+MJaBV8kk4cFu6zI
         sKow==
X-Gm-Message-State: AOAM530IBPD5zqgm7e9yeNwvclWJhp7/wyC0V8m66hNXmagGHQK8QLYO
        7T28DvhTUBRyvGp90rnULZTFXPThkvtAZ8BBplEnN+c0NceUwxx5acGBEQnN2YrUMBE2NI19+Z7
        f0nnbs+P5sNgivJEsfBz9gDFW
X-Received: by 2002:ad4:5c6c:: with SMTP id i12mr32753041qvh.42.1636135338795;
        Fri, 05 Nov 2021 11:02:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoJlrWeeXAA9E4RVT0sdHxUWx5aU/GxeHJMPr563FntFFktlUcFjKjmgn+CK19161PSGLP3g==
X-Received: by 2002:ad4:5c6c:: with SMTP id i12mr32753016qvh.42.1636135338575;
        Fri, 05 Nov 2021 11:02:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id j13sm6061456qkp.111.2021.11.05.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 11:02:18 -0700 (PDT)
Date:   Fri, 5 Nov 2021 11:01:52 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211105180152.oi7h3p6fb6c5pjkf@treble>
References: <20211105171023.989862879@infradead.org>
 <20211105171821.654356149@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105171821.654356149@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 06:10:43PM +0100, Peter Zijlstra wrote:
> +#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> +
> +static inline unsigned long load_unaligned_zeropad(const void *addr)
> +{
> +	unsigned long offset, data;
> +	unsigned long ret;
> +
> +	asm_volatile_goto(
> +		"1:	mov %[mem], %[ret]\n"
> +
> +		_ASM_EXTABLE(1b, %l[do_exception])
> +
> +		: [ret] "=&r" (ret)
> +		: [mem] "m" (*(unsigned long *)addr)
> +		: : do_exception);
> +
> +out:
> +	return ret;
> +
> +do_exception: __cold;
> +
> +	offset = (unsigned long)addr & (sizeof(long) - 1);
> +	addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
> +	data = *(unsigned long *)addr;
> +	ret = data >> offset * 8;
> +	goto out;

Superfluous goto, can just return here?

>  static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
> -	unsigned long ret, dummy;
> +	unsigned long offset, data;
> +	unsigned long ret, err = 0;
>  
> -	asm(
> -		"1:\tmov %2,%0\n"
> +	asm(	"1:	mov %[mem], %[ret]\n"
>  		"2:\n"
> -		".section .fixup,\"ax\"\n"
> -		"3:\t"
> -		"lea %2,%1\n\t"
> -		"and %3,%1\n\t"
> -		"mov (%1),%0\n\t"
> -		"leal %2,%%ecx\n\t"
> -		"andl %4,%%ecx\n\t"
> -		"shll $3,%%ecx\n\t"
> -		"shr %%cl,%0\n\t"
> -		"jmp 2b\n"
> -		".previous\n"
> -		_ASM_EXTABLE(1b, 3b)
> -		:"=&r" (ret),"=&c" (dummy)
> -		:"m" (*(unsigned long *)addr),
> -		 "i" (-sizeof(unsigned long)),
> -		 "i" (sizeof(unsigned long)-1));
> +
> +		_ASM_EXTABLE_FAULT(1b, 2b)
> +
> +		: [ret] "=&r" (ret), "+a" (err)
> +		: [mem] "m" (*(unsigned long *)addr));
> +
> +	if (unlikely(err)) {
> +		offset = (unsigned long)addr & (sizeof(long) - 1);
> +		addr = (void *)((unsigned long)addr & ~(sizeof(long) - 1));
> +		data = *(unsigned long *)addr;
> +		ret = data >> offset * 8;
> +	}
> +
>  	return ret;

This adds a (normally not taken) conditional jump, would a straight jmp
over the fixup not be better?

i.e.

	1: mov %[mem], %[ret]
	jmp 2
	... fixup code ...
	2:

-- 
Josh

