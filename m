Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3CC446AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhKEWdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhKEWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 18:33:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F37DC061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 15:30:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id np3so3961308pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 15:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nkeeh3bIZ7eUI0JV5wn8yP8iIV+uZexYuvXKKN6Umrc=;
        b=K6jVkqmQ+bxHN2Y5yZwm0OzLd1A/eMfOH/QUiho3XIX3RMUe1wXRYrm031BnjC4SLH
         uG5CPBkD+PtPwByHwCRs0+Fx8gZJltr4b+2B1XUydc0ClwGChWmvsKnKrci/7bxFW08m
         eK0OJqtaNv8Czc4is5aceYRCQrRP0Ms5/xJ1YS7IbvJ3wdtFpHDQ7jjQ/SocadDTC/Kk
         xwbezsqDTULf/4PkENhhKdte03BKEfcT+Y3DJtY31e200Ozz7z+oh1K1Z2/JcmOfc49L
         yLCCy/xEstW4ML+yZ7+cG0+LHgRgheAyJMmZnT3f7qkg/dsYvF8RjvRWAHKfhWCF3vI3
         If9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkeeh3bIZ7eUI0JV5wn8yP8iIV+uZexYuvXKKN6Umrc=;
        b=Bb6UKBjrMD1SfV7h6OItJ2ZGysvLlVQRu5lZt0411m7fZFazU7V3QnKs2IjSazGnex
         vI1i19k4B5c1DgW13w7oB5S0GE2o2rMDplHzCAuz7GtahAeGwdCJ2yAcfEzcL4KSJ9Tz
         2yI8PVsjxTAzdOZoYBCVtkriJ6pmlxlLJswVDhyU5cWNLQLRHpWpiCvrkSxz6k5WTjqu
         XkA9G1iveWojQd2yxinxpZY48zK9wAgN2wpLata48R7fig/HfedyLg9+lgctGOpHuA1q
         ugqtmIwYfI7Sa/qdpZUqgI62ESYwMocbByjmxTwMNGUX8lEsEFkm0R8P2zlDbTwNtCTF
         quzw==
X-Gm-Message-State: AOAM532iYmeuQrqdjiTsKZY44Gx6YEqXKr71f4l5Uz2rNtCSY6pJ3i79
        CZ02UGPQzSmJK7q5aTX/th1a/Q==
X-Google-Smtp-Source: ABdhPJzYz43W6vrWAbgxYNiJnUho9UgXTDtqtmdpsE0SiryEj1Gpn1FWqVx/kkabDnk47iOn/hK0nA==
X-Received: by 2002:a17:90b:3511:: with SMTP id ls17mr22743832pjb.81.1636151429943;
        Fri, 05 Nov 2021 15:30:29 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j5sm374660pfg.157.2021.11.05.15.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 15:30:29 -0700 (PDT)
Date:   Fri, 5 Nov 2021 22:30:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <YYWwgbZl3jC2H6xG@google.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <YYVqnr+gql9RpL4C@google.com>
 <20211105184556.GN174703@worktop.programming.kicks-ass.net>
 <YYWDQO3ugarMcKmH@google.com>
 <20211105193229.GP174703@worktop.programming.kicks-ass.net>
 <YYWKSmHkgdMA2euh@google.com>
 <20211105201557.GQ174703@worktop.programming.kicks-ass.net>
 <20211105202608.GI174730@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105202608.GI174730@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 09:15:57PM +0100, Peter Zijlstra wrote:
> 
> > That's really unfortunate that is... 6.4.4.1 item 5 of the C99 spec
> > covers this gem :-( I suppose I'll go stick that (int) cast in the
> > EX_IMM_MASK definition or something.
> 
> --- a/arch/x86/include/asm/extable_fixup_types.h
> +++ b/arch/x86/include/asm/extable_fixup_types.h
> @@ -2,10 +2,15 @@
>  #ifndef _ASM_X86_EXTABLE_FIXUP_TYPES_H
>  #define _ASM_X86_EXTABLE_FIXUP_TYPES_H
>  
> +/*
> + * Our IMM is signed, as such it must live at the top end of the word. Also,
> + * since C99 hex constants are of ambigious type, force cast the mask to 'int'
> + * so that FIELD_GET() will DTRT and sign extend the value when it extracts it.
> + */
>  #define EX_DATA_TYPE_MASK		0x000000FF
>  #define EX_DATA_REG_MASK		0x00000F00
>  #define EX_DATA_FLAG_MASK		0x0000F000
> -#define EX_DATA_IMM_MASK		0xFFFF0000
> +#define EX_DATA_IMM_MASK		((int)0xFFFF0000)
>  
>  #define EX_DATA_REG_SHIFT		8
>  #define EX_DATA_FLAG_SHIFT		12

Works on my end, thanks!
