Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B04418AB9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhIZTMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhIZTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 15:12:46 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7558C061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:11:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u18so65439876lfd.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S1rRSSfW6TIcSBnkTZCMt9Uay0K2nCNuTxc4diWE0Pw=;
        b=Pm4dKaxkQ9K1fy//ct6W9SPDtGqtFmZ7D0OH0gZxrzq9K/d8CE4wUwiNTa4UitIKON
         G9a3Zm1tDYSzz6QlFqgIXLka2XGqt6DUXoa/DMF0xVNfkvAL2+mN2dF98NTwMMQpdArq
         JMxrlw6M7WoWgBaMK9zKlZbzxP4aFoaHTm2K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S1rRSSfW6TIcSBnkTZCMt9Uay0K2nCNuTxc4diWE0Pw=;
        b=8FadQQfbAamuBwBgjCF/ojWz/11k6RewC2HsuQ5L8BZsqzDR4KsvO3cydGSLZ8OugS
         urStDIxUxk6ORwy29tGybqHJiU5pO3Nnyb9IzI3Yi/yxBOxi/vv43ClDmxbjK3yqHKSu
         Gk5m2IdB2cegiTPPPMLu2FbqnYDKyRXFaUlcZVGPCusAgobgy1laZym6aDQg6lIFk0Tk
         t4wFW4vm2PSUkoH/T7kIiucZEAtrFrPTAQNi3MFvTfqfjpPWnnpUFdW/dD3frnSpUcQC
         y+JfEJQy1WWbOlS/jE6ACSIksFfRiOlAm0ywJRGXEDPZDHk236pF1e4CNw2jwVQ+B/HN
         dXFA==
X-Gm-Message-State: AOAM533V6PlUX36XT/zhyzA41ghplfrkng3BkjAo4gk1vrixzNfMJNkv
        qv+TXqkdHYVEef71fKzFT9O/86UJAiu2xngp
X-Google-Smtp-Source: ABdhPJzJdZcjdZi82nTdc4QaihOvTGM4EZy8d5YgvaWTyCyWuXLmRfRKQIPMDhikoGuNZ9+XGrt/BQ==
X-Received: by 2002:a2e:a367:: with SMTP id i7mr24565047ljn.435.1632683467609;
        Sun, 26 Sep 2021 12:11:07 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y11sm384689ljn.138.2021.09.26.12.11.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Sep 2021 12:11:06 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id b20so67131184lfv.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 12:11:06 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr24876458ljf.191.1632683465932;
 Sun, 26 Sep 2021 12:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <163265189226.178609.9712455554034472888.tglx@xen13>
 <163265189517.178609.6605494600326137493.tglx@xen13> <CAHk-=wj=C2W1VmW1RHU8ErvSjVF2Y=r9uWrnMCiz-U_aa8Dorw@mail.gmail.com>
 <YVC4zz1vCskBMb6I@zn.tnic>
In-Reply-To: <YVC4zz1vCskBMb6I@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Sep 2021 12:10:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
Message-ID: <CAHk-=whJvs+-kCMynbt9YRVfcyM5TL8wwNhdOX9iygC5y--CHw@mail.gmail.com>
Subject: Re: [GIT pull] x86/urgent for v5.15-rc3
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2021 at 11:15 AM Borislav Petkov <bp@alien8.de> wrote:
>
> There's this other rather "theoretical" thing of Intel PT
> decoding being done on any arch but get_unaligned() from
> include/asm-generic/unaligned.h looks as generic and as arch-agnostic as
> they get, to me...

It does now. It used to be a mess where every architecture did their
own thing, including nothing (x86) or lots of inline asm (several).

Arnd cleaned it all up fairly recently.

It turns out doing nothing is wrong - not because of architecture
issues, but because of compiler issues - and doing inline asms is
counter-productive because the compilers will handle the unaligned
case for us.

So every architecture uses that <asm-generic/unaligned.h> and is happy about it.

A couple of architectures still have their own <asm/unaligned.h>, but
that's just because they have some additional stuff for legacy reasons
there. They still use the generic header for the actual unaligned
handling.

               Linus
