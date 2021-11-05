Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0091644694A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 20:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbhKETuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 15:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhKETuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 15:50:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1657C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 12:47:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s24so11781606plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nLYaGHii+f6wQjlXxudurMec2HxcCQoui+6+XEPZGiA=;
        b=YHjgMnYujwWd9f7z8nYRQCyismKTVG616aEx3QTNc01/ZZ8cTCk+MMcD2clq2R3PSL
         4qmiLWp+9QcpWm7z8egkOoRudskHmbsgCCIih+Sm6zfpPSGs3zAjd3t8Yop3un6P3NjG
         s5hPr0XZ4T8wjXgyskByzhR20/L78z9oUJNCw+ku2AsgLwyHqCUys1WYTw38jFGAdx4n
         wjtKKMGq5hUHVcxx7eQVYtnlERsccZduC+5velTbj+ohj3kkSrUte+XHTPj0Yq9ygdk1
         rAFpaUeJpYUPpBY23KHUPtiE3Veg0LOJrdDd10KdFwetv3Bn9Xj45T2Gh5o9VTzjsaaa
         34Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLYaGHii+f6wQjlXxudurMec2HxcCQoui+6+XEPZGiA=;
        b=efKQwgaTzk6POA4DGnv+WrN4yii0GPB7k8WMANIa/fu+nbjbQHrhjDqruiRa1MrmZX
         r8LLxltErAFNykCsop0iObkc4FpsXdJpiwJmbZQVnUPdo58+6gPVj4fpmfe5sBm0U4s/
         bIO0OwxTSpd467T/kAQGkV8g62GAXBjgDvlJkvOyqqnULuNHrAlE8Z3u6RWdqaTdmKzx
         s7G/puILk5X1nEyTOeXaEhRMQthTQn0NKNNdBUFR9iBfMz2fR5vm30J6sRRF1QG5vYPm
         8wc1woB1g+kg4R9Ya7QgYb0rVcJU4pvkegs5VQF0uiSUWvfez3n9csiXS8+wsDiQlLMV
         qXDg==
X-Gm-Message-State: AOAM531/sBpiTYMViir/6R9+paFxNwZmWCNypuUwJZE3JVqgbOvODEk4
        x/gIkLd6eG1KKm4uNfHVcMAS5g==
X-Google-Smtp-Source: ABdhPJx+Oj+fYfVJ2OPsTkJ7vciTXif/ws2NUqaMBhTz5SloTJnlk28qy70tdszBY2qTVwP5dmvxoA==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr33166585pjw.16.1636141646967;
        Fri, 05 Nov 2021 12:47:26 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b13sm8295223pfv.186.2021.11.05.12.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:47:26 -0700 (PDT)
Date:   Fri, 5 Nov 2021 19:47:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH 07/22] x86,extable: Extend extable functionality
Message-ID: <YYWKSmHkgdMA2euh@google.com>
References: <20211104164729.226550532@infradead.org>
 <20211104165524.925401847@infradead.org>
 <YYVqnr+gql9RpL4C@google.com>
 <20211105184556.GN174703@worktop.programming.kicks-ass.net>
 <YYWDQO3ugarMcKmH@google.com>
 <20211105193229.GP174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105193229.GP174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021, Peter Zijlstra wrote:
> On Fri, Nov 05, 2021 at 07:17:20PM +0000, Sean Christopherson wrote:
> > On Fri, Nov 05, 2021, Peter Zijlstra wrote:
> > > On Fri, Nov 05, 2021 at 05:32:14PM +0000, Sean Christopherson wrote:
> > > 
> > > > > +#define EX_IMM_MASK	0xFFFF0000
> > > 
> > > > > +	imm  = FIELD_GET(EX_IMM_MASK,  e->type);
> > > > 
> > > > FIELD_GET casts the result based on the type of the mask, but doesn't explicitly
> > > > sign extend the masked field, i.e. there's no intermediate cast to tell the compiler
> > > > that the imm is a 16-bit value that should be sign extended.
> > > > 
> > > > Modifying FIELD_GET to sign extended is probably a bad idea as I'm guessing the
> > > > vast, vast majority of use cases don't want that behavior.  I'm not sure how that
> > > > would even work with masks that are e.g. 5 bits or so.
> > > 
> > > So the way I was reading it was that typeof(_mask) is 'int', e->type is
> > > also 'int', we mask out the top bits, and since it's all 'int' we do an
> > > arith shift right (ie. preserves sign).
> > > 
> > > Where did that reading go wrong?
> > 
> > Hmm, C99 standard says that right shift with a negative value is implementation
> > specific:
> 
> C99 is sodding daft wrt signed values. That's why we force -fwrapv and
> say signed is 2s complement and expect sanity.

FWIW, -fwrapv was supplanted by -fno-strict-overflow back in 2009 by commit
a137802ee839 ("Don't use '-fwrapv' compiler option: it's buggy in gcc-4.1.x").
But I don't think that matters because AFAICT both apply only to "addition,
subtraction and multiplication".

> > gcc-10 generates a bare "shr", i.e. doesn't special case negative values, and "shr"
> > is explicitly defined as an unsigned divide.
> 
> We hard rely on signed shift right to preserve sign all over the place,
> how come it goes sideways here? Lemme go stare at asm...

Huh.  TIL there's actually a use case for this.

Anyways, I think the issue is that EX_IMM_MASK is being interpreted as an unsigned
value by the compiler.  Which I think is legal for a 64-bit kernel?  Because bit 63
is the MSB, not bit 31.  E.g. this

	FIELD_GET((int)EX_IMM_MASK, e->type)

generates SAR instead of SHR.
