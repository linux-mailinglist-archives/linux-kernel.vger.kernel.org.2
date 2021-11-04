Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236BE445B2D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 21:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhKDUmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 16:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58467 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231484AbhKDUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 16:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636058378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uid2a9LMrW9B+45JcYmABYcf/U+z3oWHghPPLRjlNbA=;
        b=TWtcsanMqEe3ZLd3E6E2bfFDqO4jyEpjRDBXDiBSjtt0yRRtEnPGbn8maYGKYIu8M4vIOh
        w2EceiLFWNCrxPy0rpYFwLlAaZxjGcB+nmLssaTFuxVNhSNy92eB5LiWb4MmRQRPPsAOAz
        6G0IjB+0yrK8Jc3BCuuZrB9or1dZ4A8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-cXey0eOSOji3lsYzqnCTTw-1; Thu, 04 Nov 2021 16:39:37 -0400
X-MC-Unique: cXey0eOSOji3lsYzqnCTTw-1
Received: by mail-qk1-f197.google.com with SMTP id v14-20020a05620a0f0e00b0043355ed67d1so5602351qkl.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 13:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uid2a9LMrW9B+45JcYmABYcf/U+z3oWHghPPLRjlNbA=;
        b=rYNP/McKPBq5I/wChfjuXVOifes+wq659s7rzGQbeBxU3NnCkX9Xht3BfFvujLgyBv
         vjrQC5H9Jmn7/yhRmWosCLR8cgKv+fB0L0ZDJwyPDoG5wmRYjMDP8HnIaINtJ3VkJ1v1
         adOl2uRuBlVxTdWmbsIXarY1HL2uY5Rh3Od5pPAdg0t/Xu9aO+q1ygQabOZmgqS5e6O4
         P8OJeGgulH1LrAuyGioi51kktaS750fyct0un8OverGjMYeseBhJ6pqvWHLVZBdJq4bh
         kV6nBjBTty5OivXn1jculyaV04smyKEfTzxccysHCck4c4MskciKQQ0L+hI+zR06wVdR
         DcgQ==
X-Gm-Message-State: AOAM530PrPndj5f7Nuc+Zk/qVsHMOa0Xh9oout9/+7aqHsGFcregNuQ/
        suU+n9OG05z6FB9UWMtMGQxJxzsTaIFe+14Riw9j9RHp2QwWajjmNfK4q8Kayp8DUy0dDZ0HM5W
        dtNrQagmTFWxBT8NmDbJOaCi6
X-Received: by 2002:ac8:53da:: with SMTP id c26mr55450503qtq.402.1636058376618;
        Thu, 04 Nov 2021 13:39:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJbrky/rybEZmPX0Sc92vS4yqcIFALVsKIMoyzqTxPldYU82h21l/JVJEuxJll/OhhLTw2lA==
X-Received: by 2002:ac8:53da:: with SMTP id c26mr55450486qtq.402.1636058376447;
        Thu, 04 Nov 2021 13:39:36 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id g1sm4751934qtb.7.2021.11.04.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 13:39:36 -0700 (PDT)
Date:   Thu, 4 Nov 2021 13:39:33 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 06/22] x86,entry_32: Remove .fixup usage
Message-ID: <20211104203933.jxuilpksf7rtbkve@treble>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.864310295@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211104165524.864310295@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 05:47:35PM +0100, Peter Zijlstra wrote:
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -19,4 +19,6 @@
>  #define	EX_TYPE_DEFAULT_MCE_SAFE	12
>  #define	EX_TYPE_FAULT_MCE_SAFE		13
>  
> +#define EX_TYPE_POP_SEG			14
> +

This looks funky in the patch (but not in the editor), those other ones
have a tab after '#define'.

>  #endif
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -99,6 +99,13 @@ static bool ex_handler_clear_fs(const st
>  	return ex_handler_default(fixup, regs);
>  }
>  
> +static bool ex_handler_pop_seg(const struct exception_table_entry *fixup,
> +			       struct pt_regs *regs)
> +{
> +	*((unsigned int *)regs->sp) = 0;
> +	return ex_handler_default(fixup, regs);
> +}

Clever.  Should be "unsigned long" in case this ever gets used by
64-bit?  Also, I'd suggest a short comment.

-- 
Josh

