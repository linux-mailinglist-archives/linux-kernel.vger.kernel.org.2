Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275C450508
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhKONMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKONMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:12:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32988C061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:09:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b40so43416770lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g5lYCRdztAJ/tNA9EHXetSNsC/jaC9qtFRqYEhiyLhc=;
        b=O+chpzPjiP8XKcxY8+0Fu68ASM4imghDVHWGNyZtJ5+gPrZ4tK7cz0jW+x4UdbS2Ja
         oKdJlQfwHRgriJGGd144tvhtOzhec/bLVuS8h5weXjr925N/lX+ZFu7YAc+diEDi5zTy
         REvQN3syJPiNbAmhBkuUg+yf/o8HtJdg+R2ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5lYCRdztAJ/tNA9EHXetSNsC/jaC9qtFRqYEhiyLhc=;
        b=VNEQ+gANkVdtaaJytrGTbzGvKY4DnUyjJFJmA1BzkSGFxn+hi/NADuUhEshRCgMMlf
         Zo0tlg3BNmkDdttUuOkMZstMNIPzDzahZxWPk3Bm5W94WV0WpNKTLjHljSqhGf0/62yU
         81vOdjxPn2r2j7DjH/FlZCV7DngCTTh/TDhmeLTWG2J/Ds0f5X1+i+IklYYQo3mE7u/0
         RoDBuXysL5IOeHhN6CH+7odc73yzJki2qstTmrYFGZLi2Ic9LSbGimjih37zrDXpE3b9
         /X0CijfaahX0VJSvO0FqEVlsNRbQVzh+c+M7mHNTXrWWklSaZh5HOLddwMT5UjKjVz4S
         vTtA==
X-Gm-Message-State: AOAM5328GaDRupbOpAvwudKpMswYG3fkG5XtOgxwr9SudCjAkM0AbBya
        NU4Ngm4ZKbPp4bwmQIbG+utRiw==
X-Google-Smtp-Source: ABdhPJwoLHLUq1UBckpkf1rqac8FXosa8RN7DMRBASeZDBEsIZQtkRNrhdZgHcUG1w3gXbQIWM6LtQ==
X-Received: by 2002:a05:6512:39d3:: with SMTP id k19mr27702195lfu.81.1636981764529;
        Mon, 15 Nov 2021 05:09:24 -0800 (PST)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id k15sm1495966ljh.98.2021.11.15.05.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 05:09:23 -0800 (PST)
Subject: Re: [PATCH] static_call,x86: Robustify trampoline patching
To:     Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, joao@overdrivepizza.com
References: <20211027120515.GC54628@C02TD0UTHF1T.local>
 <CAMj1kXEx10gC8eH7rV-GbZZj2M3uDue6HYsKb+A5J01zOxm_FA@mail.gmail.com>
 <20211027124852.GK174703@worktop.programming.kicks-ass.net>
 <YXlOd1lyKZKAcJfA@hirez.programming.kicks-ass.net>
 <CAMj1kXHKh7wv6JqusVnoiQDMm7ApFq2ujzbfWmM9AzLKFehhAA@mail.gmail.com>
 <YXlcMluaysPBF92J@hirez.programming.kicks-ass.net>
 <CAMj1kXECTdDLVMk2JduU5mV2TR0Cv=hZ9QOpYRsRM1jfvvNikw@mail.gmail.com>
 <CABCJKufpS4jJxHqk8=bd1JCNbKfmLDKBbjbhjrar2+YQJFiprg@mail.gmail.com>
 <20211029200324.GR174703@worktop.programming.kicks-ass.net>
 <20211030074758.GT174703@worktop.programming.kicks-ass.net>
 <20211030081631.GF174730@worktop.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <554c64df-14ca-2019-a54c-cdc4d84e71f8@rasmusvillemoes.dk>
Date:   Mon, 15 Nov 2021 14:09:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211030081631.GF174730@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2021 10.16, Peter Zijlstra wrote:
> On Sat, Oct 30, 2021 at 09:47:58AM +0200, Peter Zijlstra wrote:

> So fundamentally I think the whole notion that the address of a function
> is something different than 'the address of that function' is an *utter*
> fail.

Agreed. IMHO, commits like 0a5b412891df, 981731129e0f should have been a
big red flag saying "ok, perhaps we shall not mess with the semantics of
function pointer comparisons". Yes yes, the commit log in cf68fffb66d6
did dutifully say "This may break code that relies on comparing
addresses passed from other components.".

But it did not spell out that that for example means that i2c bus
recovery now doesn't result in recovering the bus but instead in a NULL
pointer deref and kernel panic: Some i2c drivers set ->recover_bus =
i2c_generic_scl_recovery and provide ->sda_gpiod, ->scl_gpiod, then rely on

if (bri->scl_gpiod && bri->recover_bus == i2c_generic_scl_recovery)

in i2c-core-base.c causing ->get_scl/->set_scl to be filled in. That's
of course broken with ->recover_bus pointing to the module's jump table,
so when ->recover_bus is actually called, the bri->set_scl() call in
i2c_generic_scl_recovery() is a NULL pointer deref. [I've tested that
this actually happens on an imx8mp_evk board.]

And who knows how much other code happens to rely on function pointer
comparison working as specified in the C standard for correctness.

Rasmus
