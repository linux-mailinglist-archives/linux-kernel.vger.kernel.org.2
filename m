Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F093E9964
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhHKUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKUJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:09:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDF7C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:09:09 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so4845231otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exnctuowc9qHgxEWsNBVGITBkzW8bW+Co5aongFhmAI=;
        b=FK4OreJMdkR6kTtJ0JmareP37fetUzQ5umI6C/3lMblqr9kIPrEZBY3KMEILpEdKLW
         mI/CkNDlhYoTGzYXe+TVI/Jl8IIHmnlukn0t4ak+A7nuvFgpAkdGWAJVLnnAXJCPb5Do
         TBWOLKscfWQ2eRWSBuNQTRduzOKoY1FHdI77cgcrkU8Ao8LDQ5JxKB2XfbWxxLMYJLL4
         lQzMsCaIXBCT2K1szk7xRk60Vym7WRoA/QwqgA+Hf8wLe4elh11DtX+Ozd3iVZaEKL1z
         IIRG+G16E0yLX9FqwFhwUjEAFGBZQMRLlmJhaCt5FffKw7rUwl9dn3vuPiEzydqA/qtW
         IPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exnctuowc9qHgxEWsNBVGITBkzW8bW+Co5aongFhmAI=;
        b=gbsVtiAC+PcBFfumCJ6pgp3+pDRIRTMtgq/ctQbTiK0aTUbp6SLy8UN6LBQ51+2r8v
         XARpt84Ea/A1OZOPE0nh0h+FvXseIe9FPDsozDqKYv+Yg973a2PTlYROJbDBECsNOf62
         8jXjVH6w9fQEfZu/EcV3r90L3wtcfXcLVbCBNwf53GWXjATDteNPiWF9ah3xij/+SvAk
         yXini/4zDJG/q3tVRRr8RwaT9kOI9XxS5+pFWAcGLvaRK9BCC0bGtuIJK6Mm9KIUz5Se
         +DsTWJs4Jsg/vCDx2SVXXh2f/HnhBUDFPHIoCZ/cBwjs/cebfbW7BP69Pm0wUp+M/Wlp
         E2ng==
X-Gm-Message-State: AOAM5330SROAQM7z0+mYeoM3v+nRzRcGeOz8X0xTIX0Xo2mU5DPBU2NW
        x1GtR5aV/UF6JrdMwCIkbL0raNCYKPqJwdyjRib/tw==
X-Google-Smtp-Source: ABdhPJyGzHkP5yGOf0XbQ+khYPVoNTw0E4ktw0WVSnzDCbFO5o6M+eqavMNCSiukXRr/v+PPLinHY+tk8T4RC+P5R/c=
X-Received: by 2002:a9d:4104:: with SMTP id o4mr543878ote.139.1628712548945;
 Wed, 11 Aug 2021 13:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210811175647.3851629-1-ndesaulniers@google.com> <cf568688-01a3-849e-2bcc-1cbe6845c9f8@kernel.org>
In-Reply-To: <cf568688-01a3-849e-2bcc-1cbe6845c9f8@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Aug 2021 13:08:57 -0700
Message-ID: <CAKwvOd=2kCSewy+LvdhB=mrwfE4-bjiPE44O-nX1jVa76pbw+g@mail.gmail.com>
Subject: Re: [PATCH] x86/build: remove stale cc-option checks
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:22 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 8/11/2021 10:56 AM, Nick Desaulniers wrote:
> > cc-option, __cc-option, cc-option-yn, and cc-disable-warning all invoke
> > the compiler during build time, and can slow down the build when these
> > checks become stale for our supported compilers, whose minimally
> > supported versions increases over time. See
> > Documentation/process/changes.rst for the current supported minimal
> > versions (GCC 4.9+, clang 10.0.1+). Compiler version support for these
> > flags may be verified on godbolt.org.
> >
> > The following flags are supported by all supported versions of GCC and
> > Clang. Remove their cc-option, __cc-option, and cc-option-yn tests.
> > * -Wno-address-of-packed-member
> > * -mno-avx
> > * -m32
> > * -mno-80387
> > * -march=k8
> > * -march=nocona
> > * -march=core2
> > * -march=atom
> > * -mtune=generic
> > * -mfentry
> >
> > -mpreferred-stack-boundary= is specific to GCC, while
> > -mstack-alignment= is specific to Clang. Rather than test for this three
> > times via cc-option and __cc-option, rely on CONFIG_CC_IS_* from
> > Kconfig.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1436
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> A few comments below.
>
> > ---
> >   arch/x86/Makefile | 51 +++++++++++++++++------------------------------
> >   1 file changed, 18 insertions(+), 33 deletions(-)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 0fa7dc73b5d8..6de2985ba1a5 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -14,10 +14,13 @@ endif
> >
> >   # For gcc stack alignment is specified with -mpreferred-stack-boundary,
> >   # clang has the option -mstack-alignment for that purpose.
> > +ifdef CONFIG_CC_IS_GCC
> >   ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
>
> Is this cc-option call still needed? It looks like it was added by
> commit d77698df39a5 ("x86/build: Specify stack alignment for clang"),
> which at the time claimed to support back to gcc 3.2, but that flag
> appears to be supported at least back to gcc 4.1.2 according to godbolt.

Yes!
https://godbolt.org/z/1nWbrGTb3

While the test is for a value of 4, the actual flags used are 2 and 3;
values less than 4 were only supported in GCC 7+!
So the test is wrong and should have been for a value less than 4; it
didn't fail because of the additional cc-option/__cc-option below that
I removed.

So I should send a v2 that changes that particular test to test
support for the value 3 (or 2) rather than 4.  Let me know off thread
if you'd like me to carry forward your RB tag for that.

>
> >         cc_stack_align4 := -mpreferred-stack-boundary=2
> >         cc_stack_align8 := -mpreferred-stack-boundary=3
> > -else ifneq ($(call cc-option, -mstack-alignment=16),)
> > +endif
> > +endif
> > +ifdef CONFIG_CC_IS_CLANG
> >         cc_stack_align4 := -mstack-alignment=4
> >         cc_stack_align8 := -mstack-alignment=8
> >   endif
> > @@ -31,8 +34,8 @@ REALMODE_CFLAGS     := -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
> >
> >   REALMODE_CFLAGS += -ffreestanding
> >   REALMODE_CFLAGS += -fno-stack-protector
> > -REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
> > -REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
> > +REALMODE_CFLAGS += -Wno-address-of-packed-member
> > +REALMODE_CFLAGS += $(cc_stack_align4)
> >   REALMODE_CFLAGS += $(CLANG_FLAGS)
> >   export REALMODE_CFLAGS
> >
> > @@ -48,8 +51,7 @@ export BITS
> >   #
> >   #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
> >   #
> > -KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
> > -KBUILD_CFLAGS += $(call cc-option,-mno-avx,)
> > +KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> >
> >   # Intel CET isn't enabled in the kernel
> >   KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
> > @@ -59,9 +61,8 @@ ifeq ($(CONFIG_X86_32),y)
> >           UTS_MACHINE := i386
> >           CHECKFLAGS += -D__i386__
> >
> > -        biarch := $(call cc-option,-m32)
> > -        KBUILD_AFLAGS += $(biarch)
> > -        KBUILD_CFLAGS += $(biarch)
> > +        KBUILD_AFLAGS += -m32
> > +        KBUILD_CFLAGS += -m32
> >
> >           KBUILD_CFLAGS += -msoft-float -mregparm=3 -freg-struct-return
> >
> > @@ -72,7 +73,7 @@ ifeq ($(CONFIG_X86_32),y)
> >           # Align the stack to the register width instead of using the default
> >           # alignment of 16 bytes. This reduces stack usage and the number of
> >           # alignment instructions.
> > -        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
> > +        KBUILD_CFLAGS += $(cc_stack_align4)
> >
> >           # CPU-specific tuning. Anything which can be shared with UML should go here.
> >           include $(srctree)/arch/x86/Makefile_32.cpu
>
> What tree were you intending to target with this? If it is -tip, this is
> going to cause it to fail to apply because the '$(srctree)' comes from
> Masahiro:
>
> https://git.kernel.org/masahiroy/linux-kbuild/c/d8285639550578a1bf2d102391d1a9e08e0586ca

I can regen v2 against tip.

>
> > @@ -93,7 +94,6 @@ else
> >           UTS_MACHINE := x86_64
> >           CHECKFLAGS += -D__x86_64__
> >
> > -        biarch := -m64
> >           KBUILD_AFLAGS += -m64
> >           KBUILD_CFLAGS += -m64
> >
> > @@ -104,7 +104,7 @@ else
> >           KBUILD_CFLAGS += $(call cc-option,-falign-loops=1)
> >
> >           # Don't autogenerate traditional x87 instructions
> > -        KBUILD_CFLAGS += $(call cc-option,-mno-80387)
> > +        KBUILD_CFLAGS += -mno-80387
> >           KBUILD_CFLAGS += $(call cc-option,-mno-fp-ret-in-387)
> >
> >           # By default gcc and clang use a stack alignment of 16 bytes for x86.
> > @@ -114,20 +114,17 @@ else
> >           # default alignment which keep the stack *mis*aligned.
> >           # Furthermore an alignment to the register width reduces stack usage
> >           # and the number of alignment instructions.
> > -        KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align8))
> > +        KBUILD_CFLAGS += $(cc_stack_align8)
> >
> >       # Use -mskip-rax-setup if supported.
> >       KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
> >
> >           # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
> > -        cflags-$(CONFIG_MK8) += $(call cc-option,-march=k8)
> > -        cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
> > -
> > -        cflags-$(CONFIG_MCORE2) += \
> > -                $(call cc-option,-march=core2,$(call cc-option,-mtune=generic))
> > -     cflags-$(CONFIG_MATOM) += $(call cc-option,-march=atom) \
> > -             $(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
> > -        cflags-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=generic)
> > +        cflags-$(CONFIG_MK8)         += -march=k8
> > +        cflags-$(CONFIG_MPSC)                += -march=nocona
> > +        cflags-$(CONFIG_MCORE2)              += -march=core2
> > +        cflags-$(CONFIG_MATOM)               += -march=atom
> > +        cflags-$(CONFIG_GENERIC_CPU) += -mtune=generic
> >           KBUILD_CFLAGS += $(cflags-y)
> >
> >           KBUILD_CFLAGS += -mno-red-zone
> > @@ -158,18 +155,6 @@ export CONFIG_X86_X32_ABI
> >   ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >     ifndef CONFIG_HAVE_FENTRY
> >       ACCUMULATE_OUTGOING_ARGS := 1
> > -  else
> > -    ifeq ($(call cc-option-yn, -mfentry), n)
> > -     ACCUMULATE_OUTGOING_ARGS := 1
> > -
> > -     # GCC ignores '-maccumulate-outgoing-args' when used with '-Os'.
> > -     # If '-Os' is enabled, disable it and print a warning.
> > -        ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
> > -          undefine CONFIG_CC_OPTIMIZE_FOR_SIZE
> > -          $(warning Disabling CONFIG_CC_OPTIMIZE_FOR_SIZE.  Your compiler does not have -mfentry so you cannot optimize for size with CONFIG_FUNCTION_GRAPH_TRACER.)
> > -        endif
> > -
> > -    endif
> >     endif
> >   endif
> >
> > @@ -193,7 +178,7 @@ ifdef CONFIG_RETPOLINE
> >     # only been fixed starting from gcc stable version 8.4.0 and
> >     # onwards, but not for older ones. See gcc bug #86952.
> >     ifndef CONFIG_CC_IS_CLANG
> > -    KBUILD_CFLAGS += $(call cc-option,-fno-jump-tables)
> > +    KBUILD_CFLAGS += -fno-jump-tables
> >     endif
> >   endif
> >
> >
>
> --

-- 
Thanks,
~Nick Desaulniers
