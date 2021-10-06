Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB642360B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhJFCpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:45:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237292AbhJFCov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633488179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WUAUXyTr5vnf62A2xBA5BH7uNkswc0Qgd6ouuCQsbIM=;
        b=aioGdBe3lhLsiumZYDbDS10umZgIqR4bspaj2U1iobSbw6HliZRIJW0Sl1g/Q88Ksl32NY
        hF1Jdhp3kdql3QZKZbtxxHqsA6wQIPgrE1CYtI9vTV8eR9rTXdCVOapM0rUrHGBydGZaY6
        SYVwiqUA1InloZlQwCSbM94F7hVApuc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-Mdcz_JoRM4eLJ360aOnQ4w-1; Tue, 05 Oct 2021 22:42:58 -0400
X-MC-Unique: Mdcz_JoRM4eLJ360aOnQ4w-1
Received: by mail-qv1-f69.google.com with SMTP id fv11-20020a056214240b00b00382e9471ed6so1565798qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WUAUXyTr5vnf62A2xBA5BH7uNkswc0Qgd6ouuCQsbIM=;
        b=hxojNCPzLS7Zsex+PiowEARuQqcCsG9MPs2/mETzMnyRHC4gqS7GffpwZDjLJ2jVDf
         YCRAhygm1yGNps3U06zGs4IzVrj61V6lEDD30dAVIFfz6S4+vOw6Ep09QZ76BcUSsuYw
         Lzj2p5K3ur0w+17+YxvP6Fr8Em8YOr2+L4+IvOoTO+7GEYrlDtaLemHwwylVfLnPkk1B
         J+X/4UVs5mxD0vHhWD1decwa8f53wlXoAzFU+6jCPdIRW8sjxS90MmfzgjOSkyAKC2HV
         zrw2x8Z27FCJID+DXC2ZXzS9VfC5x506f2AjAFwLwxOvRV0xubLiLwRoXGnzXYa03gB9
         Tifw==
X-Gm-Message-State: AOAM530XUKh7D4DU42eFCK4dpc7IRdrE+H/QtKoDgI6RyniFBzFmMcUh
        0I00x5l4cmZqqZtCByNZZpaz5C2TKKC+YMT6yDQM8fVHvZBbQg4dsPiM9f5/Bu/vQ/AMKw/eMoF
        ogj0ikYjxCtk1AFgmejtRHzfH
X-Received: by 2002:ac8:7d12:: with SMTP id g18mr24249002qtb.82.1633488178216;
        Tue, 05 Oct 2021 19:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlNFrMpQVPhAy+nSKZsOCb/8cFE1cda7K2580Uqvaqrdc1IH5K+P2YEgxwEyd0o99Qs3g8TQ==
X-Received: by 2002:ac8:7d12:: with SMTP id g18mr24248978qtb.82.1633488177947;
        Tue, 05 Oct 2021 19:42:57 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o23sm11997921qtl.74.2021.10.05.19.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 19:42:57 -0700 (PDT)
Date:   Tue, 5 Oct 2021 19:42:54 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH v4 00/15] x86: Add support for Clang CFI
Message-ID: <20211006024254.l3mrl2zrdvzpskmd@treble>
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20211005203655.cvjfxmjvgx2knkuk@treble>
 <CABCJKucbbFKHRnisu_yLiHkTfcm9Z+haP0CBNg-pLeO6iFxivg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABCJKucbbFKHRnisu_yLiHkTfcm9Z+haP0CBNg-pLeO6iFxivg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 02:52:46PM -0700, Sami Tolvanen wrote:
> On Tue, Oct 5, 2021 at 1:37 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, Sep 30, 2021 at 11:05:16AM -0700, Sami Tolvanen wrote:
> > > This series adds support for Clang's Control-Flow Integrity (CFI)
> > > checking to x86_64. With CFI, the compiler injects a runtime
> > > check before each indirect function call to ensure the target is
> > > a valid function with the correct static type. This restricts
> > > possible call targets and makes it more difficult for an attacker
> > > to exploit bugs that allow the modification of stored function
> > > pointers. For more details, see:
> > >
> > >   https://clang.llvm.org/docs/ControlFlowIntegrity.html
> > >
> > > Note that v4 is based on tip/master. The first two patches contain
> > > objtool support for CFI, the remaining patches change function
> > > declarations to use opaque types, fix type mismatch issues that
> > > confuse the compiler, and disable CFI where it can't be used.
> > >
> > > You can also pull this series from
> > >
> > >   https://github.com/samitolvanen/linux.git x86-cfi-v4
> >
> > Does this work for indirect calls made from alternatives?
> 
> It works in the sense that indirect calls made from alternatives won't
> trip CFI. The compiler doesn't instrument inline assembly.
> 
> > I'm also wondering whether this works on CONFIG_RETPOLINE systems which
> > disable retpolines at runtime, combined with Peter's patch to use
> > objtool to replace retpoline thunk calls with indirect branches:
> >
> >   9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
> >
> > Since presumably objtool runs after the CFI stuff is inserted.
> 
> The indirect call checking is before the retpoline thunk call, so
> replacing the call with an indirect call isn't a problem.

Ah right.  I managed to forget how this worked and was thinking this
intercepted the indirect call rather than the function pointer.

-- 
Josh

