Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6230C430505
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244674AbhJPVTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 17:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244668AbhJPVS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 17:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634419008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vuVl/Lm9y3LUoPVRoQC3DsmftxQZFqWY4bGxbzZzkc4=;
        b=TbW86SeJjgsy+a/B84MVI1g6wxQPkUA4wXtUdvkFhNaO2x+wK3YNz1O3c8YEJotkA3bokR
        b8XnvloadmFKUREaMLxa/z1dwS1E58zkWBDQIt6BqA4rKMy5eR3GgSwHt0wQaa7WbB+QAR
        /3+lBRQvi/O/dw2nFIjoH/eimLzmm4M=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-Wa4hEdeJNua0YTuF7EbtcQ-1; Sat, 16 Oct 2021 17:16:47 -0400
X-MC-Unique: Wa4hEdeJNua0YTuF7EbtcQ-1
Received: by mail-ot1-f71.google.com with SMTP id b27-20020a9d60db000000b0055036944426so7930452otk.9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vuVl/Lm9y3LUoPVRoQC3DsmftxQZFqWY4bGxbzZzkc4=;
        b=4fCJYxnBrgfpdnRGHr/Sg+xkNrtBXDTbNoMNEJ2f1qg1UP1w5HD7uENYJHIEckul0A
         gvNAAtlfPLYCk36AW4A348aK9dpFXva6Otg0osbnB++GxwZZ5O54Q1ijHtlpLpo14mMW
         7d/tDlH0OD+pO0asgn3tkng9sST/eBVPZCVobJ2OJYLqLVl1mq/fZXa+P6MeH1mrYBOo
         +CmrhRFS+7RPEePAkrlJooBe9KdZC+7aGyuJ00ojOxBqOflhUD/jG4W1vZcF+8fJqhjn
         rem9Y6ubpTz7PS/u2ZaWI0SRUtfyRGMieq769rcCoaefTqHe/ngmNBQi/tWe49gzwj0Z
         MDQg==
X-Gm-Message-State: AOAM533F8ZA6d7BtyKgMDaIC1LE/DonjoSM1cVcviyzStvQkq5FWT366
        Rid+AMJ8lyGuLFTwUWv9Gbzcyx2eeDkyz/oM79gzRaFQDKrjTp0X+9InmVpD1VO2QcpOU7QTRyU
        WJ+w2Y4NkpkQSLO24+U+HlWtB
X-Received: by 2002:aca:60c5:: with SMTP id u188mr17386273oib.87.1634419006554;
        Sat, 16 Oct 2021 14:16:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBX20oEuac4tZkLH0fjEqXPtWWEkbBGKJ/9HICffJyOCrhjoT616RBoDQWmMMJitU2vuhYxg==
X-Received: by 2002:aca:60c5:: with SMTP id u188mr17386265oib.87.1634419006377;
        Sat, 16 Oct 2021 14:16:46 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id f8sm2040834otp.63.2021.10.16.14.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 14:16:45 -0700 (PDT)
Date:   Sat, 16 Oct 2021 14:16:43 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Subject: Re: [PATCH v5 03/15] linkage: Add DECLARE_NOT_CALLED_FROM_C
Message-ID: <20211016211643.h5ylg3hlhnzbee2u@treble>
References: <20211013181658.1020262-1-samitolvanen@google.com>
 <20211013181658.1020262-4-samitolvanen@google.com>
 <7377e6b9-7130-4c20-a0c8-16de4620c995@www.fastmail.com>
 <8735p25llh.ffs@tglx>
 <87zgra41dh.ffs@tglx>
 <CABCJKuc+mN4vw_sanZQKcb1=SyfT4h3JK2wpBuaB2qZH3Croxg@mail.gmail.com>
 <87wnme3pbv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnme3pbv.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 12:17:40AM +0200, Thomas Gleixner wrote:
> For actually callable functions, by some definition of callable,
> e.g. the clear_page_*() variants a proper attribute would be definitely
> preferred.

See my last email, clear_page_*() has nothing to do with CFI in the
first place.

> That attribute should tell the compiler that the function is using the
> register arguments correctly but is not suitable for direct invocation
> because it clobbers registers.
> 
> So the compiler can just refuse to call such a function if used directly
> without an inline asm wrapper which describes the clobbers, right?
> 
> But thinking more about clobbers. The only "annotation" of clobbers we
> have today are the clobbers in the inline asm, which is fragile too.
> 
> Something like
> 
>  __attribute__ ((clobbers ("rcx", "rax")))
> 
> might be useful by itself because it allows validation of the clobbers
> in the inline asm wrappers and also allows a analysis tool to look at
> the ASM code and check whether the above list is correct.
> 
> Hmm?

Functions are allowed to clobber rcx and rax anyway.

The clear_page_*() functions follow the C ABI, like (almost) every other
asm function in the kernel.  I think there's a misunderstanding here, as
most of this doesn't have anything to do with CFI anyway.

-- 
Josh

