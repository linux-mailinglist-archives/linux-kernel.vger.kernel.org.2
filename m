Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71C5423316
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhJEVzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJEVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:55:28 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BEDC061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:53:37 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id r1so852296ybo.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlN4jfg0gX2LZZN2w0PrP6x9vQI3f2fSsuMkV8Sa4Xg=;
        b=WxlCMf9yLZ3Uuf2DfAUeuTFIC8NL1nt/7BhNpeBIFVemwl6QReya/4bK0JXGKlCZQR
         3V4RPzA4g7R8Rm2RZjCgCJpQ9wA5YtXHHrs6b/CmzpZMhUO4hb/aXoiL0r5IRTN1FUnc
         2j0rfYw88yjBpXBsUrQgWIe8T3gz2J3MYPz7g8kJa/RxAUY9EMEIcHSGtLgLUDSw5Sl4
         8c1i0A/6foxCPPQupeAx8D4qb+q4lwKMAEnXcdFE2um+MCXJ4rv9VTXgQhdl/Qy8Sp7f
         dm0j5wwFq/sYhKnjktk5j204LvMn5dm5C/Uj4WbWLe7CD4wsOkLiVPyevXIwx+9VstpG
         PwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlN4jfg0gX2LZZN2w0PrP6x9vQI3f2fSsuMkV8Sa4Xg=;
        b=40G2BOvyGT0dFaxMFZ4p+T/U6KOgOpl4LsZTf7fHWVRZunxQOITk3z1Ue5vPc8VNWA
         cl6CJPrELXXDnmicoeN2wHh9O0IPHtuBxkndG4RaDlqZfIXsWOrH/ROB7N7TgKcw8r7z
         NmvhRLaA/EgQvePCVqPToGaQIL40scFd20rUgm0J5sKg7vCILaG9T4q4R1lpEunWCr9C
         9+6F5ohTVjAG7A4EgnUz/yBcOps5cwH7pdOZoiKqid6kh0YsiP92n62HJZADoa4c74+m
         d5pd8KK3x8c7uuu9vF7XxzAQZluX/2wbK3wS9FI2dKtKx0iZi9+6ry9OJor6aFux3CzV
         e82w==
X-Gm-Message-State: AOAM531jR0wsBTSBfbujEgnylKn9NdxgQbwYZ6WJHp4rds7REgl6cc78
        YgylHF9hKP8+jTsM4ijvj+PfaAHyVmmJSBop+qYWiw==
X-Google-Smtp-Source: ABdhPJxeqlTZhXqga9k43BtCRV6P3IjRNNoQSEkCNn/i7ChYlIrPyZgPSI8OyeePFw8yqlBWHMU6Cd301mHXo+IlWb4=
X-Received: by 2002:a25:cf8f:: with SMTP id f137mr26586961ybg.338.1633470816214;
 Tue, 05 Oct 2021 14:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
 <20210930180531.1190642-5-samitolvanen@google.com> <YVsGoJ+NN6wRFi22@hirez.programming.kicks-ass.net>
 <CABCJKudBrHfwR=gQc=9=cfBjR9p5jm65ovSNwzLLEpDUdo6ZPQ@mail.gmail.com>
 <20211005065923.GH4323@worktop.programming.kicks-ass.net> <CABCJKud1Gm0ouROKLAw9t03qbs+_EASky053=SqijPJahqogng@mail.gmail.com>
 <20211005205612.GF174703@worktop.programming.kicks-ass.net>
In-Reply-To: <20211005205612.GF174703@worktop.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 5 Oct 2021 14:53:25 -0700
Message-ID: <CABCJKufUZxDdQziUFG5YzUDjChvy9XOHPxBjUG4GXUw4LCGpkA@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] cfi: Add DEFINE_CFI_IMMEDIATE_RETURN_STUB
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 1:58 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Oct 05, 2021 at 01:29:02PM -0700, Sami Tolvanen wrote:
> > On Mon, Oct 4, 2021 at 11:59 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > For x86_64 it should indeed never get called, however if you plan on
> > > supporting i386 then you need the annotation. Also, it might get called
> > > on arm64 which is about to grow basic HAVE_STATIC_CALL support.
> >
> > Good point. I read through the latest arm64 static call proposal and
> > while it can fall back to an indirect call, it doesn't look like that
> > would cause issues with CFI.
>
> Because that call is outside of compiler control?

Correct.

> Same will be true for
> any HAVE_STATIC_CALL implementation I suppose. The trampoline will be
> outside of compiler control.

True, so it shouldn't be a problem.

Sami
