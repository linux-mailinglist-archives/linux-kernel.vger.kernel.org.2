Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD06308118
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhA1W3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhA1W3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58CAB64D9E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611872899;
        bh=GPi14VrJeAzqYhzhT3Tfxjisys1fOMTUT3KKTU1Vla0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fFGk3PqaD/7fT9hRNDTh2u+oxTThZlf1QW5cICLNfXqHrR02qTQhall3P5HpgE8oV
         591Y4d2iqaNQc68MTTwFfZrxzyzmvau5l4Q5l2puajGGrYHtDHyhuw9q2ASfKsHiOS
         RSHU8pOwbEWPKUVAXvoe3CMe1FGsybmwVfXvZK1oSy+GSZVMM31Gd03fO7os+k2YjQ
         7tXRBhWbpRXD4fcAkJO8ofyPAE9KsALBOhY6EZAbvKoGsnG3Bbn0+7xqhbdY9SbNQX
         X65AWlAMP6WsLbfNFdW2nalXRGFa9Xi+6b4lnoH4Tw4tinrezk5XsKyO3m3niLbKKV
         w7GHrhPmm46fQ==
Received: by mail-ot1-f53.google.com with SMTP id i30so6806494ota.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 14:28:19 -0800 (PST)
X-Gm-Message-State: AOAM532BafvWq/gKLuXlXci72IhsXBJcHk7iN6tI7VrpQjDtiSvo2nG2
        CnRRC2DJufTgJxYoSpvYPGfurIeyt1GwBe6WBZ4=
X-Google-Smtp-Source: ABdhPJxYmGrm7otLD0c+gI8B2YyRsHnwQc/hNHXYNta5PFke+nYH+2+OxjgAasMsiuBl4O84Cd82qnNzeyqFK83CDBs=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr1078337otq.305.1611872898629;
 Thu, 28 Jan 2021 14:28:18 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0MbxMC9iLe0NGR0ttLY7sZDjsrgKvfRZOXVJLjzDNKmA@mail.gmail.com>
 <20210128193422.241155-1-ndesaulniers@google.com> <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
In-Reply-To: <CAMj1kXE5uw4+zV3JVpfA2drOD5TZVMs5a_E5wrrnzjEYc=E_fA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 28 Jan 2021 23:28:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0CTUh=4h=U6S5A_tqHxYEyO52HTropAV9mKh2hwJvi0g@mail.gmail.com>
Message-ID: <CAK8P3a0CTUh=4h=U6S5A_tqHxYEyO52HTropAV9mKh2hwJvi0g@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: kprobes: rewrite test-[arm|thumb].c in UAL
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 10:03 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Thu, 28 Jan 2021 at 20:34, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > @@ -468,15 +468,15 @@ void kprobe_thumb32_test_cases(void)
> >
> >         TEST_UNSUPPORTED("strexb        r0, r1, [r2]")
> >         TEST_UNSUPPORTED("strexh        r0, r1, [r2]")
> > -       TEST_UNSUPPORTED("strexd        r0, r1, [r2]")
> > +       TEST_UNSUPPORTED("strexd        r0, r1, r2, [r2]")
> >         TEST_UNSUPPORTED("ldrexb        r0, [r1]")
> >         TEST_UNSUPPORTED("ldrexh        r0, [r1]")
> > -       TEST_UNSUPPORTED("ldrexd        r0, [r1]")
> > +       TEST_UNSUPPORTED("ldrexd        r0, r1, [r1]")
> >
> >         TEST_GROUP("Data-processing (shifted register) and (modified immediate)")
> >
> >  #define _DATA_PROCESSING32_DNM(op,s,val)                                       \
> > -       TEST_RR(op s".w r0,  r",1, VAL1,", r",2, val, "")                       \
> > +       TEST_RR(op s"   r0,  r",1, VAL1,", r",2, val, "")                       \
>
> What is wrong with these .w suffixes? Shouldn't the assembler accept
> these even on instructions that only exist in a wide encoding?

I don't know if that is a bug in the integrated assembler or
intentional behavior, but it may be easier to just change the
kernel than the compiler in this case, as it also makes it work
for older versions.

FWIW, I needed a related change in a couple of other files:

diff --git a/arch/arm/lib/copy_from_user.S b/arch/arm/lib/copy_from_user.S
index 6acdfde56849..3ced01d9afe4 100644
--- a/arch/arm/lib/copy_from_user.S
+++ b/arch/arm/lib/copy_from_user.S
@@ -60,7 +60,7 @@
 #define LDR1W_SHIFT 0

  .macro ldr1w ptr reg abort
- USERL(\abort, W(ldr) \reg, [\ptr], #4)
+ USERL(\abort, ldr \reg, [\ptr], #4)
  .endm

  .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
@@ -80,7 +80,7 @@
 #define STR1W_SHIFT 0

  .macro str1w ptr reg abort
- W(str) \reg, [\ptr], #4
+ str \reg, [\ptr], #4
  .endm

  .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index 485fa3cffdbe..a6a96f814720 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -34,7 +34,7 @@
 #define LDR1W_SHIFT 0

  .macro ldr1w ptr reg abort
- W(ldr) \reg, [\ptr], #4
+ ldr \reg, [\ptr], #4
  .endm

  .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
@@ -77,7 +77,7 @@
 #define STR1W_SHIFT 0

  .macro str1w ptr reg abort
- USERL(\abort, W(str) \reg, [\ptr], #4)
+ USERL(\abort, str \reg, [\ptr], #4)
  .endm

  .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
diff --git a/arch/arm/lib/memcpy.S b/arch/arm/lib/memcpy.S
index e4caf48c089f..7b980a1a4227 100644
--- a/arch/arm/lib/memcpy.S
+++ b/arch/arm/lib/memcpy.S
@@ -15,7 +15,7 @@
 #define STR1W_SHIFT 0

  .macro ldr1w ptr reg abort
- W(ldr) \reg, [\ptr], #4
+ ldr \reg, [\ptr], #4
  .endm

  .macro ldr4w ptr reg1 reg2 reg3 reg4 abort
@@ -31,7 +31,7 @@
  .endm

  .macro str1w ptr reg abort
- W(str) \reg, [\ptr], #4
+ str \reg, [\ptr], #4
  .endm

  .macro str8w ptr reg1 reg2 reg3 reg4 reg5 reg6 reg7 reg8 abort
diff --git a/arch/arm/lib/memmove.S b/arch/arm/lib/memmove.S
index 6fecc12a1f51..35c5c06b7588 100644
--- a/arch/arm/lib/memmove.S
+++ b/arch/arm/lib/memmove.S
@@ -84,24 +84,24 @@ WEAK(memmove)
  addne pc, pc, ip @ C is always clear here
  b 7f
 6: W(nop)
- W(ldr) r3, [r1, #-4]!
- W(ldr) r4, [r1, #-4]!
- W(ldr) r5, [r1, #-4]!
- W(ldr) r6, [r1, #-4]!
- W(ldr) r7, [r1, #-4]!
- W(ldr) r8, [r1, #-4]!
- W(ldr) lr, [r1, #-4]!
+ ldr r3, [r1, #-4]!
+ ldr r4, [r1, #-4]!
+ ldr r5, [r1, #-4]!
+ ldr r6, [r1, #-4]!
+ ldr r7, [r1, #-4]!
+ ldr r8, [r1, #-4]!
+ ldr lr, [r1, #-4]!

  add pc, pc, ip
  nop
  W(nop)
- W(str) r3, [r0, #-4]!
- W(str) r4, [r0, #-4]!
- W(str) r5, [r0, #-4]!
- W(str) r6, [r0, #-4]!
- W(str) r7, [r0, #-4]!
- W(str) r8, [r0, #-4]!
- W(str) lr, [r0, #-4]!
+ str r3, [r0, #-4]!
+ str r4, [r0, #-4]!
+ str r5, [r0, #-4]!
+ str r6, [r0, #-4]!
+ str r7, [r0, #-4]!
+ str r8, [r0, #-4]!
+ str lr, [r0, #-4]!

  CALGN( bcs 2b )
