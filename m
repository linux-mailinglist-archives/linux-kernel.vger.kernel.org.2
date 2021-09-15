Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3F40BF9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhIOG0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOG0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:26:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAB0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:24:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c4so989470pls.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 23:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vuCBzZ9zBNkDaxH2jJ5BbxSUdPvdCFa3DgGVw8Quh9c=;
        b=IpmZwGI6942DHOxFv4kJ7/ue70Xwg9Fxnip6YLfFQPIuFyzEmqBIOrejRsyoBdc3T3
         7izvZK7izFkZvO5GMB4G91KuvPLwBiJz9HEJFir1sAUOXbUiVwLvlk4Mfi1XNyR8KGhm
         8/xUEOOiVMFrofVh9igVKLlLMjqdtqdE8GUsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vuCBzZ9zBNkDaxH2jJ5BbxSUdPvdCFa3DgGVw8Quh9c=;
        b=vcI+c534ASBZzSQqRENY/C34XjDUZqHP3c1L62xL0OVnvIXjpDHBD+vpkMMmP3B66J
         dbUKLQbABQfKUinuMuupLVs/7UaP92APkuK1CCorfcl+CrbrWyLNrhWen29YCArI/pdW
         8jWSnWfxzmc3Kr2QriiPqrjALmKkKL0c7Fkk+0jTArExh+u4NvMIEV6iqdbyE/56Z5ff
         lcKXSCnGWfsDDe2UO3XH6R3q+GzbeM/zLinzxrNO0a8Cbgp7WV0o/BB187XvWaU/rntF
         4QFApnGTFmBhNVcci8u3+LuEODbMhvMeBSAR/5QOU8DoaWPwpJU6In5D9xAoShMshvwc
         qLQg==
X-Gm-Message-State: AOAM533p5w9aiDpSMehTKFvf6M9+vYVpAR2P6Ja3PMVmslz+YEFkevyU
        wOTBQYx4XAVJJxBFiB69zFG3Pg==
X-Google-Smtp-Source: ABdhPJyqrx7hBPKHGCo043/ShbjXHrI4bHbybJD44p09EnDBCs7/tS6xWCcaVY6oVAmwcLuJuE8VTQ==
X-Received: by 2002:a17:90b:1e06:: with SMTP id pg6mr6657056pjb.238.1631687093555;
        Tue, 14 Sep 2021 23:24:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u21sm13559568pgk.57.2021.09.14.23.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 23:24:52 -0700 (PDT)
Date:   Tue, 14 Sep 2021 23:24:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>, X86 ML <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
Message-ID: <202109142257.7BAE8074@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-12-samitolvanen@google.com>
 <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
 <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
 <CAKwvOd=q1xhn9OEyowWyMeDW8CbWW4=nRmdE1tHggjCZKr7xrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=q1xhn9OEyowWyMeDW8CbWW4=nRmdE1tHggjCZKr7xrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 03:31:14PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 14, 2021 at 1:30 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > On Tue, Sep 14, 2021 at 1:02 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> > > >
> > > > Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> > > >
> > > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > >
> > > I kind of prefer the existing convention that has explicit guards on
> > > specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
> > > CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
> > > which configs may introduce which flags that are problematic. This
> > > patch is ok as is, but it kind of makes this Makefile more
> > > inconsistent.  I would prefer we had the explicit checks.

Can you explain your reasoning a bit more? It seems like redundant
open-coded logic to me, but I do see this idiom repeated in the kernel.
And/or maybe I've misunderstood you?

It seems like it's better to have a single variable (like in the proposed
patch: CC_FLAGS_CFI) that has all the details internal -- no tests needed.

i.e.: instead of this in many places:

ifdef CONFIG_FEATURE
PURGATORY_CFLAGS_REMOVE	+= -feature-flag
endif

do this once:

CC_FEATURE_CFLAGS	:= -feature-flag
...
KBUILD_CFLAGS		+= $(CC_FEATURE_CFLAGS)

and only repeat a single line in for targets:

CFLAGS_REMOVE_target.o	+= $(CC_FEATURE_CFLAGS)

> >
> > The Makefile does already use DISABLE_STACKLEAK_PLUGIN in a similar
> > way, but I don't have a strong preference here.
> 
> mmm...DISABLE_STACKLEAK_PLUGIN adds to PURGATORY_CFLAGS. This patch
> adds to PURGATORY_CFLAGS_REMOVE.

CFI is "simple" in that regard; its options can just be left off. This
isn't true for some weirder stuff. Stack protector is a good one, in
that just removing the options may not disable it depending on distro
patches (which may turn it on by default), so both target_CFLAGS and
target_REMOVE are needed there.

(In the case of the plugins, yes, I think they could be rearranged to
use the target_REMOVE method, but I have a memory of REMOVE not working
there for some weird thing? Hmm.)

-- 
Kees Cook
