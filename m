Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBA3DA79B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbhG2P3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237585AbhG2P3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:29:12 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C19C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:29:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id go31so11361025ejc.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7nsIADi+sxoiZLJPC40+M5/oMBfnY6udDOOdTLFLRas=;
        b=MOq7VxDzHCWF+DEkCKE/JHDF7wXpbTmcRF2lNFfyvSFRNYSAT9UtBFAMkxLoBx24R0
         ioN75n1wacN7UDkP9ZXlTngAdPAXGf+LpblBQBH9I3n/ST3WuD0x5tbIdoEcau6wSF7V
         E7jL/Wp9s3PjK+SuImnK7vHrRwAlW/mKOZkOSSU2CYAAbnZmoRN5aQv23kuu2MCpfJ2G
         slxznXTndFu6y+fsRsxpn6Arn2Mv5rgmolH385g3Glx04xnIdL6hmCbStTlLmeBNyftC
         Efjv/NIgQBUyjjIU35W8sBrK482GhiUYKxwn88g8h68iLk1HVqB22mhd8MkXHE6LHexi
         xzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7nsIADi+sxoiZLJPC40+M5/oMBfnY6udDOOdTLFLRas=;
        b=R9ASghR3Ken6A+Jvc/cQ2g7X87a5tTYpNDEnsht/IhQP8UM4ZCmuivXek3i/biFfXo
         Ul+5nOis1igp2Y3XGn9WSUbhhpUBXIbip/j1XSFY4CL93TThDufakW0Kxl34BbkPX4zP
         s3v+heIvXohGScsl8okEkMuTLC1r+lGqroaGPyU+vdLhquHkAq/Gtado9ssjWGxilamt
         wbADS5ZF3QyNQ1LDApxaEwP7mz3+HNoebO6bcHClcwXf17MW/EwVsElCN7rvj3fGnUzX
         aAUF3/Hu5XbubssyT7ezIz990DfOYReJqcVILPY6jk0Bqg5BrEKqahuFxOWuI77h1/tu
         s8Kg==
X-Gm-Message-State: AOAM533lgUw9jEKF0hVBhXPn3Cfhzhqg4NAMjWRUDdV/EqowQk8M8XZ5
        Wj0icA0LfeukPGSRTcPxslY=
X-Google-Smtp-Source: ABdhPJwNqSvzywaN4xV9es4IPbIc5ZSi6+hxOam92yn06cJIGHl/JQc09lJ2uQiHSygOf8JRFy2IdA==
X-Received: by 2002:a17:906:3983:: with SMTP id h3mr4974895eje.249.1627572546272;
        Thu, 29 Jul 2021 08:29:06 -0700 (PDT)
Received: from pswork ([62.96.250.75])
        by smtp.gmail.com with ESMTPSA id c22sm1365176eds.1.2021.07.29.08.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 08:29:05 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:29:04 +0200
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] kallsyms: strip ThinLTO postfix ".cfi_jt"
Message-ID: <20210729152904.GA14619@pswork>
References: <20210727131853.GA18032@pswork>
 <20210727140618.19130-1-treasure4paddy@gmail.com>
 <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKudYRiK0KcMHGHeBFcr+Smwa9EM+NFeBpMo_ePqK+zHz0w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:57:21PM -0700, Sami Tolvanen wrote:
> Hi,
> 
> On Tue, Jul 27, 2021 at 7:07 AM Padmanabha Srinivasaiah
> <treasure4paddy@gmail.com> wrote:
> >
> > Clang ThinLTO adds a postfix ".cfi_jt" to a symbols of extern functions.
> 
> These symbols are added with CONFIG_CFI_CLANG no matter which LTO mode
> is selected, so talking about ThinLTO here isn't quite correct.
>
Yes, checked irrespective of the LTO mode choosen ".cfi_jt" postfix
is added with CONFIG_CFI_CLANG flag. Thanks for correcting out,
will make neccessary changes.

> > For example this breaks syscall tracer that doesn't expect such postfix,
> > so strip out the postfix from the output.
> >
> > Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> > ---
> > Change in v2:
> >   - Use existing routine in kallsyms to strip postfix ".cfi_jt" from
> >     extern function name.
> >   - Modified the commit message accordingly
> >
> >  kernel/kallsyms.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 0ba87982d017..e9148626ae6c 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -166,16 +166,20 @@ static unsigned long kallsyms_sym_address(int idx)
> >
> >  #if defined(CONFIG_CFI_CLANG) && defined(CONFIG_LTO_CLANG_THIN)
> >  /*
> > - * LLVM appends a hash to static function names when ThinLTO and CFI are
> > - * both enabled, i.e. foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> > - * This causes confusion and potentially breaks user space tools, so we
> > - * strip the suffix from expanded symbol names.
> > + * LLVM appends a hash to static function names and just ".cfi_jt" postfix
> > + * for non-static functions when both ThinLTO and CFI are enabled,
> 
> Functions aren't technically speaking renamed to add a .cfi_jt
> postfix. Instead, these are separate symbols that point to the CFI
> jump table. Perhaps the comment should just say that we want to strip
> .cfi_jt from CFI jump table symbols?
> 

Agree, in jest modified existing comment. Will address same.

> > + * i.e. for example foo() becomes foo$707af9a22804d33c81801f27dcfe489b.
> > + * This causes confusion and potentially breaks user space tools and
> > + * built-in components, so we strip the suffix from expanded symbol names.
> >   */
> >  static inline bool cleanup_symbol_name(char *s)
> >  {
> >         char *res;
> >
> >         res = strrchr(s, '$');
> > +       if (!res)
> > +               res = strstr(s, ".cfi_jt");
> > +
> >         if (res)
> >                 *res = '\0';
> 
> This looks otherwise fine to me, but it's going to conflict with
> Nick's earlier patch:
> 
> https://lore.kernel.org/lkml/20210707181814.365496-1-ndesaulniers@google.com/
> 
> Could you please rebase this on top of that, and take into account
> that we should do this when CONFIG_LTO_CLANG is enabled, not only with
> LTO_CLANG_THIN?
>

Thanks Sami for pointing out the link, will rebase and refactor the change.

> Sami
