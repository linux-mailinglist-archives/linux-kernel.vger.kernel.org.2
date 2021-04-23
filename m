Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AF5368F51
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbhDWJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhDWJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:27:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7BC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:27:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sd23so64275168ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sx864cJ9nz1GjChrLeVjiJWOVBxDhckrfyU12rLCtIM=;
        b=RVLGPUq/2uXKHX3VBqekN2rBvE6xjWWfHpG1V+dMk2KoZ3JMVvNdULeRLPPHdv0v+W
         c+sWQ0H6V+Izrh1Iod17fOG7mthcwptwZwCkaksW+6/eThf/Ov743lju8KJQy3CPQ7II
         Bi8SCS2eQndZKRRyyhd+CHa97zDl/sLiK7w2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sx864cJ9nz1GjChrLeVjiJWOVBxDhckrfyU12rLCtIM=;
        b=IVzRtXAd6AjeAa45nSQ61pkmsa/bHlI5Sb1ePfi6E1gJgkA/RMykxC8KDi9+1WxyCz
         ISoBlEUprooPuaVZOamweKvyokJwOKw0svxRykxboTit5rd5pVF3E6a05XWAQDm979iu
         0NXpxvAEBIwiSypF83qFc7xdfA9hZzRVxDKvdji/0P2MWQ7wXQ+tUzung7OMneknzNFW
         OJ+D4swfl2zsZsaB1KtiOW97rBuL6rOuWQ0BTFwmxDqOAYsCTSiL9N5db+AgH+AIwqu2
         mqYEGRBYmnxURva6dIiBi3itSAH/FKgTbwR8MXvrDed/iO9G+g0tpvBb+9gmv/yrRVVr
         Tg+Q==
X-Gm-Message-State: AOAM533hxevjZZH9mPbIbnioapDVULvyvYcFyLTs0kxNyq3gs5NTkXga
        wPlPXDy2mC6MHaDohtl6n1I88PsG3k6BybRT
X-Google-Smtp-Source: ABdhPJxkXQb5uiylmDY2V93WELe9Zadfag5FXoXKd0c2vGX77x04oLiMnKfVyynFHYyi0MCkYBLJmA==
X-Received: by 2002:a17:906:7257:: with SMTP id n23mr3255833ejk.412.1619170022630;
        Fri, 23 Apr 2021 02:27:02 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id x7sm4208167eds.67.2021.04.23.02.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:27:02 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] bpf: Implement formatted output helpers with
 bstr_printf
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
References: <20210423011517.4069221-1-revest@chromium.org>
 <20210423011517.4069221-3-revest@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ebe46a2a-92f8-8235-ecd8-566a46e41ed5@rasmusvillemoes.dk>
Date:   Fri, 23 Apr 2021 11:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423011517.4069221-3-revest@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 03.15, Florent Revest wrote:
> BPF has three formatted output helpers: bpf_trace_printk, bpf_seq_printf
> and bpf_snprintf. Their signatures specifies that arguments are always
> provided from the BPF world as u64s (in an array or as registers). All
> of these helpers are currently implemented by calling functions such as
> snprintf() whose signatures take arguments as a va_list.

It's nitpicking, but I'd prefer to keep the details accurate as this has
already caused enough confusion. snprintf() does not take a va_list, it
takes a variable number of arguments.

> To convert args from u64s to a va_list 

No, the args are not converted from u64 to a va_list, they are passed to
said variadic function (possibly after zeroing the top half via an
interim cast to u32) as 64-bit arguments.

"d9c9e4db bpf: Factorize
> bpf_trace_printk and bpf_seq_printf" introduced a bpf_printf_prepare
> function that fills an array of arguments and an array of modifiers.
> The BPF_CAST_FMT_ARG macro was supposed to consume these arrays and cast
> each argument to the right size. However, the C promotion rules implies
> that every argument is stored as a u64 in the va_list.

"that every argument is passed as a u64".

> 
> To comply with the format expected by bstr_printf, certain format
> specifiers also need to be pre-formatted: %pB and %pi6/%pi4/%pI4/%pI6.
> Because vsnprintf subroutines for these specifiers are hard to expose,

Indeed, as lib/vsnprintf.c reviewer I would very likely NAK that.

> we pre-format these arguments with calls to snprintf().

Nothing to do with this patch, but wouldn't it be better if one just
stored the 4 or 16 bytes of ip address in the buffer, and let
bstr_printf do the formatting?

The derefencing of the pointer must be done at "prepare" time, but I
don't see the point of actually doing the textual formatting at that
time, when the point of BINARY_PRINT is to get out of the way as fast as
possible and punt the decimal conversion slowness to a later time.

I also don't see why '%pB' needs to be handled specially, other than the
fact that bin_printf doesn't handle it currently; AFAICT it should be
just as safe as 'S' and 's' to just save the pointer and act on the
pointer value later.

Rasmus
