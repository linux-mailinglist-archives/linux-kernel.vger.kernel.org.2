Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE72142AF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbhJLWZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 18:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 18:25:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0DAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 15:23:25 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v20so475615plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 15:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QKwzYDni0F3wcAklZeSIu8/rTCDIaPAKnVK3/F1/DFc=;
        b=Ut4COOT1vdpEj1xSkHhsk7dTZnjnhiOSygvIspayPEEW4wmTRf6TYGw/Im2ZzdrXhY
         10iTJz+ifsMjouFEcoL98ZqCRy6fS1sv6aOVijMoF3RPKY6jSWukIM5je3x+YGVQL1vF
         4Dc3uWAbUuP2wx8wXpsvWgEdZF4n0sjC9POoHwtqSzIzRbD8zA/bvK+ChW/rfXvINRPc
         N5Fh8lc2XAEiz1268Cr2eY/K939HbDQfP+iBZcnpJNsFuZC+U2HkI1tDyRtp2Pwghbr9
         J0NKPRUmhnTBfa7vt2Aefqg5UYfl2NiL57dC3ZqIL3LCCIYLYFwJcp7ddoMApamQYasa
         t8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKwzYDni0F3wcAklZeSIu8/rTCDIaPAKnVK3/F1/DFc=;
        b=nfGt/EkD3beX8v636YWs3BT4BtyiGDQ3G13aCdOfsVZ58CdbTHvn4aBjOserXD48h3
         N45xEsU/ID44jPHRo1t+Mm0uKsxJdcTxg1R+GLb0PiWQ+sBeamVHq9J6QtERkwPW9tW7
         4cT9kTOz8cWAmXzu/OeeV8JoGh//adpq9SVcurldzPtvbbKoyECXpOR8Idq/3d2qYfGx
         cVBdwIJG7BUzOQFrir+jjAPrWvOwoZmI5bvT0kdteROP4guobJrVShWe8LND1mlhOLGu
         RqJrHk8eooj1mvE1HDTOjbnnoRvvhk1uQ3lGD5P9gnfY9aECAcBU0cGRKlZAb1/voxF4
         3R9Q==
X-Gm-Message-State: AOAM531QiNPLmKnY3DdadK7h15jK3VkM3ECB6hglw2XbDcJQtGVofWGp
        lpf5188ZYBW90dP75RApn1qUrg==
X-Google-Smtp-Source: ABdhPJwBfl8fU46Fz8ehwiK7GAgKvoHRZZEq2agDRjs8XedJecfQUvOMql+TK2Mz7VPKF/QjcziAzQ==
X-Received: by 2002:a17:90a:8b82:: with SMTP id z2mr8990902pjn.216.1634077405019;
        Tue, 12 Oct 2021 15:23:25 -0700 (PDT)
Received: from integral.. ([182.2.71.100])
        by smtp.gmail.com with ESMTPSA id 139sm12023453pfz.35.2021.10.12.15.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:23:24 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Wed, 13 Oct 2021 05:23:11 +0700
Message-Id: <20211012222311.578581-1-ammar.faizi@students.amikom.ac.id>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YWXwQ2P0M0uzHo0o@zn.tnic>
References: <YWXwQ2P0M0uzHo0o@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 4:51 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Oct 12, 2021 at 10:29:55PM +0200, Borislav Petkov wrote:
> > On Tue, Oct 12, 2021 at 11:06:38AM +0200, Willy Tarreau wrote:
> > > Let's indeed wait for any of the x86 maintainers to confirm your
> > > analysis.
> >
> > I guess the official doc you guys are looking for is the x86-64 ABI:
> >
> > https://gitlab.com/x86-psABIs/x86-64-ABI/
> >
> > and recent pdfs are here:
> >
> > https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
> >
> > and there you scroll to
> >
> > "A.2 AMD64 Linux Kernel Conventions
> >
> > ...
> >
> > A.2.1 Calling Conventions"
> >
> > and that section explains which regs go where.
>
> Ok, that didn't point to the exact answer - I realize now. I believe
> what you're looking for in that doc is "Figure 3.4: Register Usage"
> which has a column "callee saved" and says that the syscall arg
> registers are all not callee-saved.

No, you were right. A.2.1 was the part we are looking for, thanks for
pointed that. That's the exact answer.

"Figure 3.4: Register Usage" is not the answer, if it were, nolibc.h
would be broken as it is missing "rdi", "rsi", "rdx" in the clobber list.

More info:
I know for a fact that every "syscall" in the libc is wrapped with a
function call, hence those registers are not callee saved, thus clobbered.

However, that is not the case for nolibc.h, because we have a potential
to inline the "syscall" instruction (0f 05) to the user functions. Thus
A.2.1 applies, and "syscall" instruction is not a "call".

All syscalls in the nolibc.h are written as a static function with inline
ASM and are likely always inline if we use optimization flag, so this is
a profit not to have r8, r9 and r10 in the clobber list (currently we 
have them).

------------------------------------------------------------------

According to x86-64 ABI about syscall section A.2 AMD64 Linux Kernel
Conventions, A.2.1 Calling Conventions [1]:

1) User-level applications use as integer registers for passing the
   sequence %rdi, %rsi, %rdx, %rcx, %r8 and %r9. The kernel interface
   uses %rdi, %rsi, %rdx, %r10, %r8 and %r9.

2) A system-call is done via the syscall instruction. The kernel
   destroys registers %rcx and %r11.

3) The number of the syscall has to be passed in register %rax.

4) System-calls are limited to six arguments, no argument is passed
   directly on the stack.

5) Returning from the syscall, register %rax contains the result of
   the system-call. A value in the range between -4095 and -1
   indicates an error, it is -errno.

6) Only values of class INTEGER or class MEMORY are passed to the
   kernel.

From (2), (5) and (6), we can conclude that Linux x86-64 syscall only
clobbers rax, rcx and r11 (and "memory").

  - rax for the return value.
  - rcx to save the return address.
  - r11 to save the rflags.

Other registers are preserved. Right?
Am I missing something?

>
> And I think that table is valid for the kernel too because the link
> to it says "The Linux AMD64 kernel uses internally the same calling
> conventions as user-level applications (see section 3.2.3 for details)."
>
> HTH.
>

-- 
Ammar Faizi
