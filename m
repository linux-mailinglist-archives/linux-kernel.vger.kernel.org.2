Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5F449A43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbhKHQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240236AbhKHQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636390036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VBtTrX1VRAE94ldVOitb8p4rGOVpisWJ3V9yCsgGTC8=;
        b=KT1PFGNHau71iDT7X1lc1CwbIZTELIXd/uxSm/fySLcfQpG047Gth04Bg6GuE6S8Z4CqTz
        NsABhzxjN3kZ9Gv4IkXpHge3IkrvFAu2nxnToWdFt35By7r8lB0npqil5BbWhBIVg9vLo9
        msqyeeEshf8p+q8asx9E68UbZJHsSjQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-Dtbc9oEJP5ezm_sjh_4NAA-1; Mon, 08 Nov 2021 11:47:15 -0500
X-MC-Unique: Dtbc9oEJP5ezm_sjh_4NAA-1
Received: by mail-oo1-f71.google.com with SMTP id c7-20020a4ae247000000b002b8be729ccdso9211329oot.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 08:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VBtTrX1VRAE94ldVOitb8p4rGOVpisWJ3V9yCsgGTC8=;
        b=0swB00HAxFVjxhLYet32/o/n/p5aCje/ATipGqHvAmLNZNNa366Dv0qaNgHVHZEt9E
         cKR9BQnO8F9k+B9eKTrxUy115rZN/FKTXyFI5+JSFyYW3owtJPA0D++nqAgW7+tucXO4
         y74ylmrKxhDeK8t/dUUfutxcN8haS1FstyRFFIkQ1RO98jdBx8HzC6L53dqxGtDbEZWu
         Wk4yKrYSa2z+Z4gBaVntqEttgejNBtfcGLn7XLtGyV2Je0QgfR+TliWxg8ybjLBBC5TI
         m+1fvbgJsmrHZ19NfLUt8JKCVj2Mq7fyE7LdPuMsXqmEZSYXpJNoOqj52X0qReJlcQxj
         wgDw==
X-Gm-Message-State: AOAM530aFPIxA/OZwkFKSOR8pJnhUJPca6JRQAevXw9tPhT0peNhFa7C
        V9lIA+Dw/eRA0KHrbgTzwSHLF4LnpHcSsgcJvsvtJFuSpVXZWmQ6iNMS9gCyyN4RQron30OvByh
        yXt4EUOZukVxKud6Dco5QIL4T
X-Received: by 2002:a05:6808:171b:: with SMTP id bc27mr38932997oib.21.1636390034539;
        Mon, 08 Nov 2021 08:47:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzB4woX7HHCD4ZlFkFsuJ6Nmoia61mZbdCp3nKxK75dXsV8inPtKrCMRW9sYEcTwf8lbbH0Rg==
X-Received: by 2002:a05:6808:171b:: with SMTP id bc27mr38932980oib.21.1636390034375;
        Mon, 08 Nov 2021 08:47:14 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id f18sm6331244otl.28.2021.11.08.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:47:13 -0800 (PST)
Date:   Mon, 8 Nov 2021 08:47:11 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com, seanjc@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH 20/22] x86,word-at-a-time: Remove .fixup usage
Message-ID: <20211108164711.mr2cqdcvedin2lvx@treble>
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

Clang doesn't approve of this label annotation:

In file included from fs/dcache.c:186:
./arch/x86/include/asm/word-at-a-time.h:99:15: warning: '__cold__' attribute only applies to functions [-Wignored-attributes]
do_exception: __cold;

-- 
Josh

