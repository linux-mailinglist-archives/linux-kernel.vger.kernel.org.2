Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A514362C14
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhDPX4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhDPX4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:56:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDFEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:56:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u11so11180605pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ROwS2iwVkP5MLz3ud+/DGta/Lb7M4iHXAMw79DXVDA=;
        b=fzHg1spcg5c2yJ5/awvsTeGX+0ipxgNor9tMeFhKpmHv9bbYnlPAXKnoePE+89qO/A
         jBBkn5ZcHA18CxySucKy9HDUtI0as+MKoK9ZsL79IjPpBPYxd22ckwKQjD4BDUEg1s++
         JV0SdWSIbiLW7iXcoubFU0ID57jjaDFUwV5xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ROwS2iwVkP5MLz3ud+/DGta/Lb7M4iHXAMw79DXVDA=;
        b=IpXqCGsH8GkqnqxVo9sX1CKpH8fslIufc0HFm2sFrj0KmcPHkPe6wvWNHCGbb8uRCg
         ooafYdP4itKt4Fe3N/d2KKsoinVTLsnY09nCW469ne6QHgJRd58IR8NPpLcP69L6Q21k
         0g3cM+1qBhVFyzRcqCTMZXad7qCRLAqHXtjxGzx//sfJwI1VJx62/VJUqyBEMuI9vF1M
         llCvWn82utbiLslgINLQTQL1xcsWERjnzwNwA2zTSzV7ylk67BvXj/RpJ0qG0vKO6O80
         plwKjfdnzFCNvUEn3IJLlRMg9xJa4Keko24kurqkSyF3Cq3u3vp1iqTGBfQSGTg41e6p
         VvuA==
X-Gm-Message-State: AOAM530+r1CL9ZWWybARuozW0A0w8rarb1sRplKlY5WBJKU2REgZ/Mf7
        DrsUTcErtZuARvVoP5CFrZ6bKQ==
X-Google-Smtp-Source: ABdhPJxMWqoZd2RU37trLX1Sf29ygHNOyE0ZJyAgzWAIzGU4uEdZ0v2zXS70qOT88GFkvC4X+c0mtw==
X-Received: by 2002:a17:902:e5d1:b029:eb:7ec2:648e with SMTP id u17-20020a170902e5d1b02900eb7ec2648emr10275443plf.30.1618617379040;
        Fri, 16 Apr 2021 16:56:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j26sm5588829pfn.47.2021.04.16.16.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 16:56:18 -0700 (PDT)
Date:   Fri, 16 Apr 2021 16:56:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 06/15] x86: Avoid CFI jump tables in IDT and entry points
Message-ID: <202104161642.B72BD68@keescook>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-7-samitolvanen@google.com>
 <87im4luaq7.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im4luaq7.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:26:56AM +0200, Thomas Gleixner wrote:
> On Fri, Apr 16 2021 at 13:38, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function addresses in C
> > code with jump table addresses.
> 
> Fine.
> 
> > To avoid referring to jump tables in entry code with PTI,
> 
> What has this to do with PTI?

Short answer: in earlier development of this series, entry routines
were attempting to jump to the (unmapped) jump tables, and IDT code had
similar issues. But yes, the commit message can be improved; I'll let
Sami explain the details.

> > disable CFI for IDT and paravirt code, and use function_nocfi() to
> > prevent jump table addresses from being added to the IDT or system
> > call entry points.
> 
> How does this changelog make sense for anyone not familiar with the
> matter at hand?
> 
> Where is the analysis why excluding 
> 
> > +CFLAGS_REMOVE_idt.o		:= $(CC_FLAGS_CFI)
> > +CFLAGS_REMOVE_paravirt.o	:= $(CC_FLAGS_CFI)
> 
> all of idt.c and paravirt.c is correct and how that is going to be
> correct in the future?
> 
> These files are excluded from CFI, so I can add whatever I want to them
> and circumvent the purpose of CFI, right?
> 
> Brilliant plan that. But I know, sekurity ...

*sigh* we're on the same side. :P I will choose to understand your
comments here as:

"How will enforcement of CFI policy be correctly maintained here if
the justification for disabling it for whole compilation units is not
clearly understandable by other developers not familiar with the nuances
of its application?"

This is a completely justified position to take. Thank you for calling
it out; we'll make it better.

-- 
Kees Cook
