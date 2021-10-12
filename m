Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5942A00A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhJLIjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235033AbhJLIjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:39:52 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A0C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:37:50 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 133so13260255pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f/ZhX2W4azA+P47mIglzjsvBY9azZVWhdYC/JQwaSAQ=;
        b=fAtQe1MXK2H07NOhTSYMa7CPIDLmFSJ1h25ENose0aTY1bThY5ZQ9I04De8T+4MzUc
         fegCEelb2V5w0ENG6hIRSJJSLrHCS1y03GsD0vTaE+OtwPzkn4JWIFEAzyyzVFdRLtRK
         IT+T2N6NRB+K2dPAhR3Sp+dIOgQgW0iSe6Xs0oQpTQ/xAvGHl24szAHljDpR77+xiZoX
         0PVQ/CizuXGsyKt3juxJpkSx3FMoEt7g1jhexTmeVxVMRK+5JNQRsiBEg074STyEIgCM
         I6Wo9/z2yiy9nYhDJwQTPlosKzM3pmCvowT+GlsVH6sn4GG2yB4Y6A83AHhYZfSZufe3
         PdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f/ZhX2W4azA+P47mIglzjsvBY9azZVWhdYC/JQwaSAQ=;
        b=WenvbH5ZxCO/XdOPSWMjkrCL0GdwuwJ8kGxBZgQJ/+c+tecIoRp1xru0CuGTG3VCKA
         Dgmpaqy8EOTmZv/75SWJeUHoQof+Jy5ErWlWeWSMCZkfM4429kmQLPmidlDcvO8pgC2Y
         8+oELBOgAXkTHcTFkjTrbXIRZRFm1IgXxqJL+PcL3nUHHxk6gsQMQGlxO2C6xVm7hge7
         e2IleEbikDwECF40OwUbbjQPwn1rAMNUJ52MwHiDwCmDOChrAhP6PHExsaXma6DGlfBj
         dhnQvX+BQvamOCTtDcdQlWj5bjFS0fjjt9LbmeMESd4JwKzQ4v+UiP8dOl1qbuIeWula
         ikgg==
X-Gm-Message-State: AOAM532LMsyNIasA/2eCMt1tdiM7w7hYwGTOHfoAv0aeifYE2cxbkO0X
        mzycw4R4EbFF7d8bfqC3mohNpQ==
X-Google-Smtp-Source: ABdhPJximNfbQbEmlUNDyF5q+VsH0DtgA62kCTkP1sSqCMX8//OmgaoSvyreCxKC0v/TSrz4wweXeQ==
X-Received: by 2002:a05:6a00:10c1:b0:44d:20e5:b4d6 with SMTP id d1-20020a056a0010c100b0044d20e5b4d6mr10415582pfu.25.1634027870087;
        Tue, 12 Oct 2021 01:37:50 -0700 (PDT)
Received: from integral.. ([182.2.71.100])
        by smtp.gmail.com with ESMTPSA id a28sm10420076pfg.33.2021.10.12.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 01:37:49 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
X-Google-Original-From: Ammar Faizi <ammarfaizi2@gmail.com>
To:     Willy Tarreau <w@1wt.eu>, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
Date:   Tue, 12 Oct 2021 15:36:44 +0700
Message-Id: <20211012083644.543775-1-ammarfaizi2@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012052822.GA28951@1wt.eu>
References: <20211012052822.GA28951@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 12:28 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Hello Ammar,
>
> First, thanks for your patch. I have a few questions below.
>
> On Mon, Oct 11, 2021 at 11:03:44AM +0700, Ammar Faizi wrote:
> > Linux x86-64 syscall only clobbers rax, rcx and r11 (and "memory").
> >
> >   - rax for the return value.
> >   - rcx to save the return address.
> >   - r11 to save the rflags.
> >
> > Other registers are preserved.
> >
> > Having r8, r9 and r10 in the syscall clobber list is harmless, but this
> > results in a missed-optimization.
> >
> > As the syscall doesn't clobber r8-r10, GCC should be allowed to reuse
> > their value after the syscall returns to userspace. But since they are
> > in the clobber list, GCC will always miss this opportunity.
>
> I agree with your conclusion about this but need to be perfectly sure
> about the exact clobber list since I got a different impression when
> implementing the calls. I got the impression that these ones were
> clobbered by reading entry_64.S below:
>
>  * Registers on entry:
>  * rax  system call number
>  * rcx  return address
>  * r11  saved rflags (note: r11 is callee-clobbered register in C ABI)
>  * rdi  arg0
>  * rsi  arg1
>  * rdx  arg2
>  * r10  arg3 (needs to be moved to rcx to conform to C ABI)
>  * r8   arg4
>  * r9   arg5
>  * (note: r12-r15, rbp, rbx are callee-preserved in C ABI)
>
> See this last note ? Indicating that r12-15, rbp and rbx are preserved
> made me think it's not the case for the other ones, but that might of
> course be a misunderstanding.
>
> And calling.h says this:
>
>  x86 function call convention, 64-bit:
>  -------------------------------------
>   arguments           |  callee-saved      | extra caller-saved | return
>  [callee-clobbered]   |                    | [callee-clobbered] |
>  ---------------------------------------------------------------------------
>  rdi rsi rdx rcx r8-9 | rbx rbp [*] r12-15 | r10-11             | rax, rdx [**]
>
> Note that it's indicated "function call convention", not "syscall",
> leaving it open to have extra restrictions on syscalls. Later by
> reading the POP_REGS macro called with pop_rdi=0 and skipr11rcx=1
> on syscall leave, it seems to restore everything but r11, rcx, rax
> and rdi (which is restored last with rsp).
>
> As such, could you please add in your commit message a link to the
> location where you found that authoritative information above it there
> is a better place (i.e. one that doesn't require to read all the macros)?
> This would significantly help anyone facing the same doubts about this
> in the future.

Hi Willy,

I have tried to search for the documentation about this one, but I
couldn't find any. Checking at `Documentation/x86/entry_64.rst`, but
it doesn't tell anything relevant.

Background story, I browsed the nolibc.h file and found extra clobbers
for Linux x86-64 syscall which I think they are unneccesary (r8, r9
and r10).

This finding had me worried a bit, because I have written syscall in
inline ASM, based on my understanding the required clobbers are "rcx",
"r11" and "memory". So in my mind was "Is my app safe?".

So I opened a discussion on Stack Overflow, yesterday:
https://stackoverflow.com/questions/69515893/when-does-linux-x86-64-syscall-clobber-r8-r9-and-r10

While waiting for answers on Stack Overflow, I also checked "entry_64.S"
and "calling.h". Now I strongly believe syscall only clobbers 3
registers, they are rax, rcx and r11. The answer and comments on SO
support it as well.

These two macros do the job:

	// saves all GPRs and zero some of them
	PUSH_AND_CLEAR_REGS

	// restore all GPRs, except rdi, r11, rcx
	POP_REGS pop_rdi=0 skip_r11rcx=1

	// later rdi is also restored.

My stance comes from SO, Telegram group discussion, and reading source
code. Therefore, I don't think I can attach the link to it as
"authoritative information". Or can I?

When I sent this patch, I also added entry_64.S's maintainers to CC
list. In hope they can help to at least acknowledge it. Mainly because
I can't find the documentation from Linux that tells about this.

Andy, Thomas, Ingo, Borislav, H. Peter.

Could one of you shed some light so that I can attach the link to your
message in the commit message?

Thanks,

-- 
Ammar Faizi
