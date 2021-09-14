Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92A340B94C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbhINUcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbhINUcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:32:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B36DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:30:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id v10so790803ybq.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9szN+UFlw1GIeZx0sVo7UxtVCzmXzz7h/G+9wB5zgds=;
        b=cyqojXb+1eFD4ixGqPc3jaLiKl5OPJm3FzipodDOoi6lg5iwnrf2a/0qJ7IeAfr+3Y
         mXjHeXAFwSRsItGNBpG7qId+PxMtkHkCiVvi4zoQRD2XKugX9B9rq36YWaEjhsSwOd5g
         KC0aK88VaNGa48WyMGJ70O3GrcMBC+sdaMRfthFhjyCkUgIxiGyrud9XA0cZh/wuc/cp
         Yj5VVCzVBMSZSqi8x5lBl/G730iq9f17fzl8oID3AhCOUx2e1sBvmkyqLCN9xiYCp5fh
         k/+fGF2lufL27puzFU+edsD3oLQdW5/qmsPGUCrxc8dMvUzQuIWO2s4c+ksTh2WDfECt
         u45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9szN+UFlw1GIeZx0sVo7UxtVCzmXzz7h/G+9wB5zgds=;
        b=UsOTua9fhEfp2CrDJTTZZylI+P4piOraAOdaolv44TvWNBP4ZVTzlwQ8Z3EtnoSMQo
         rNxF0WL2IHNurYw1cok73ea+O2nsQ63JSOTAcVFSCLTbnOtMvSqE35/AmhIuSIUBTer9
         /IGlSv+su6/TzFenW/0kkWQMmx8iodVdyqUAptXnpmSFpm92FX40pzsNZUIGKn5QR2T9
         gbkl4D7KYCcQZb2JYg/SzjW9QpBWE6CJ3GC9HJcKan1QpFYp4j/I8iZ4zO8zEZ0DrTjm
         Ui+NRMAtrK8S7FJcAToPMfRcsaWOEpv2xYzTfYxUYxoAlY7yUy3TFvhMVw2gGkfwRjrO
         tgig==
X-Gm-Message-State: AOAM531ypvvDi7W9z3i7l+8oehmutAGXrzHerw6QPutvSx+fbkyONGAX
        QJHtTqH80+p13Kpaznyx81PwCXpovta1dVeq4od3VA==
X-Google-Smtp-Source: ABdhPJxwVQHHC2WSmxPsE4hUgfKToYHhnryc6Vbvs74/iZrsmlv3/47pVqyYw1HTGfhT038nd/ODGJ4nEc5QY07M7jI=
X-Received: by 2002:a25:fc02:: with SMTP id v2mr1420442ybd.444.1631651457419;
 Tue, 14 Sep 2021 13:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-12-samitolvanen@google.com> <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
In-Reply-To: <CAKwvOd=OvR8iZogXhMxkbt5qT7jbhaARgk5NsCzhpkjoZ7yy5Q@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 14 Sep 2021 13:30:46 -0700
Message-ID: <CABCJKudRDcwfkSK205Pb__hzLWQPUFhbjUtFPbctdPAycSOKQw@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] x86/purgatory: Disable CFI
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     X86 ML <x86@kernel.org>, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 1:02 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 14, 2021 at 12:11 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > Disable CONFIG_CFI_CLANG for the stand-alone purgatory.ro.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> I kind of prefer the existing convention that has explicit guards on
> specific configs (ie. CONFIG_FUNCTION_TRACER, CONFIG_STACKPROTECTOR,
> CONFIG_STACKPROTECTOR_STRONG, CONFIG_RETPOLINE); it's more obvious
> which configs may introduce which flags that are problematic. This
> patch is ok as is, but it kind of makes this Makefile more
> inconsistent.  I would prefer we had the explicit checks.

The Makefile does already use DISABLE_STACKLEAK_PLUGIN in a similar
way, but I don't have a strong preference here. I can move this into
an ifdef if it makes things cleaner.

> Does CFI actually do any instrumentation in these object files? I
> guess issues in purgatory cause silent/hard to debug kexec failures?

The compiler shouldn't add any actual CFI instrumentation here right
now, but I would prefer to avoid issues in future.

Sami
