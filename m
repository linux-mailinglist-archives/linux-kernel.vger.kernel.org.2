Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46369445CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 00:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhKDXf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 19:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229725AbhKDXfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 19:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636068796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqhHBz59/iwQuP4BMAGmYoEMMES572wzwwy/Ee8c8WQ=;
        b=PNR8dk3BLxr9+3t8ywc32J8GxiP7u/Pge18otmDNP6FabBN/4sMZQORgiBQkichZkHxIrf
        mtBtNYQLQAFiy3x05eWyTqYy0Jm8gwUPQ1UCx7cG29PxEQ9ycjTAAqgD9DBqsOMbNPDy5P
        CGx4Vg3XK7mZlUNuxmV8Wjpf+l7K/NM=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-ET6_OTcwNzC2HcYomKtYGA-1; Thu, 04 Nov 2021 19:33:14 -0400
X-MC-Unique: ET6_OTcwNzC2HcYomKtYGA-1
Received: by mail-ot1-f71.google.com with SMTP id o24-20020a9d5c18000000b0055bd38a039eso969511otk.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 16:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqhHBz59/iwQuP4BMAGmYoEMMES572wzwwy/Ee8c8WQ=;
        b=JOGDaG+lMMzy19Fv2dCSpttPaSfycmhey6H6iEanatzHr8+aeT8DfIp+uxPPaPhWQa
         5EtgNi45sEtEuNZvQhxlqTHKWnuTnraZ2apUBwAtRGiYpbUmJjsvkBoMZQVJ0aFCgo9W
         br/RqhdUe0MJq0KUo1B/VhmoIdzXvK8LyzCbZzFOu68BV3gaprFDreerZIHLmxAgqtzw
         M2oPKAENv+SFaP3zG+Z0Z3ncXFUp73KKUCjFKCHyFN7udSVY/k2htVWBUPcWJPoxhP1W
         QTzMRU0IT6XdQizoRAgvHONefqc0iwyfUMJldZa43MZp8K0qb/v+Nj2RYNkf6FHqB2ZI
         wyrg==
X-Gm-Message-State: AOAM530bmxcEnwTHLmgYl4CAqh0lld0eZ52wPes68uIFMOq/cD//2A68
        jlTG5j5cqbTFVQabLnmv3aN3fIYVVCFmdK258SRJcMZCXvKFfn2hrRMs+906pzcYFjpyW3WUSkE
        FJzPYKV4z+kg9crVRluuvjp/l
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr7198257otn.128.1636068793840;
        Thu, 04 Nov 2021 16:33:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4pJxBap7rL5RdB+K2YoiSlZclZZRDIU6cnDR6Kr+jxWhHiI2qcJYxYqGLfE/FxPJQEb3dow==
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr7198235otn.128.1636068793669;
        Thu, 04 Nov 2021 16:33:13 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id l2sm1796868otl.61.2021.11.04.16.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 16:33:12 -0700 (PDT)
Date:   Thu, 4 Nov 2021 16:33:10 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 21/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211104233310.2dg2gilae27l75a3@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165525.767986267@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165525.767986267@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:50PM +0100, Peter Zijlstra wrote:
> XXX: I'm not really happy with this patch
>
>  static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
> -	unsigned long ret, dummy;
> +	unsigned long ret;
> +
> +	asm("1:\tmov (%0),%0\n"
> +	    "2:\n"
> +	    _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_LOAD_UNALIGNED, %0)
> +	    : "=&r" (ret)
> +	    : "0" ((unsigned long)addr));
>  
> -	asm(
> -		"1:\tmov %2,%0\n"
> -		"2:\n"
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
>  	return ret;
>  }

Yeah, it hurts code generation and I guess it's a hot path.

Maybe put the fixup code in the function.  In case of
CONFIG_CC_HAS_ASM_GOTO_OUTPUT, it could be at a label at the end of the
function.  Otherwise it'd have to be inline.

-- 
Josh

