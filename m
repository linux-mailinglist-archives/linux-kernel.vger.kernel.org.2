Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DD640B34B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhINPmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhINPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:42:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:41:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so24775840lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgZDRvewpIcHvEl+aClDgx6dxTBkhTg+5FlC2P6kQVc=;
        b=BpcuMcoHH1B5L3A9rysqIc0UNfq5noiLE14zKeR1TSa0gFC85lOw2Beo8dO5honWby
         rYyCHFnHkKNi7MCpw7JrIjMcXxBeTw1cz/rDSABmNfOTKR6Ymn6YfZNGpWuykLc9dauc
         iTDBkLKWwlR9RhIlCft6lceQmUvWAku/ar3t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgZDRvewpIcHvEl+aClDgx6dxTBkhTg+5FlC2P6kQVc=;
        b=Wy+d4ay4dVoQffr09pRGZ3sB/W1QA6GdMYMAruL0unEYHo96LuXXfoYk6j0Gab8Sat
         HflqESjlADV/iNvhpIt/woGlCZALVsvnI/6GP2QmUUsUJJXUvCdmrblJqPP6K7At1t9U
         FFjs8ViH62w0cb9wceZnnrZThv9ChRugMjTt87s4k4l4coFZjgxjBLxNaM37qNaPStYB
         HXszvKPiXek0N1a6BkdPF67ZwfHcf9Fe+3FLAQGSqTFep9MMqwQQ//jcef03p3CQytRJ
         rrNsNqeZ7WLhR7oEeG+JANBsrKal1BaUzNcfh1T6rgE1wB5gGDuPXrGAwdASYx3/AkUf
         qwRw==
X-Gm-Message-State: AOAM530d3fjthqwsUcVoFy88xyffj+lZZFG42bokACT34q4FlNzYRLHO
        IIE+vIx/rQgNPVzQfQ0W1sXnkFENnMKC/tIlAfQ=
X-Google-Smtp-Source: ABdhPJxOE9d4t4G2YyxXcbIq0vpA6tHO5ggPDX3jZSUwpsGtTe3CiUfsJ/IlIpMG/4efxByiCsWIaw==
X-Received: by 2002:a2e:97cb:: with SMTP id m11mr16267031ljj.240.1631634091876;
        Tue, 14 Sep 2021 08:41:31 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d7sm878420lfn.27.2021.09.14.08.41.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:41:30 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id r3so24760310ljc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:41:29 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr15637818ljp.494.1631634089537;
 Tue, 14 Sep 2021 08:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-2-ardb@kernel.org>
In-Reply-To: <20210914121036.3975026-2-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 08:41:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkCzP-wyZ08r9RDJRx9cbANVHy-jy=vJAGTkSbXm50iA@mail.gmail.com>
Message-ID: <CAHk-=whkCzP-wyZ08r9RDJRx9cbANVHy-jy=vJAGTkSbXm50iA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/8] arm64: add CPU field to struct thread_info
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 5:10 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> The CPU field will be moved back into thread_info even when
> THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
> struct thread_info.

The series looks sane to me, but it strikes me that it's inconsistent
- here for arm64, you make it unconditional, but for the other
architectures you end up putting it inside a #ifdef CONFIG_SMP.

Was there some reason for this odd behavior?

           Linus
