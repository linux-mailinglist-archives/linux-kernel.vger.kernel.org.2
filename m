Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926CD36EF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhD2SkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbhD2SkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:40:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C3C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:39:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b21so5193061ljf.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcFyf0v1qT/C1YQXGjM2gAonNFAnMg7U0aOFeLZ7M+0=;
        b=u9We45PnGjsIrZhdweakZeaWx4AIe4T2kFARCqBR/dHZGvYqbZY67pb1x4VnQH20V5
         1dDcZKoOqdCZjvTLUBy5ATDyuKYy00UFBdjRcz0uf+MSP5zOryrv1qPDKCkjyQgmf3oW
         CLQTiUP9AkrHVN7duS+5NeEueO4+pz5DIVK5jPjL1JSNYumJmNeNBZZLd5Qlo1Yz/7Ux
         tTsXHi7lkRg1+RWgkwruYcMPuPZRvdpdCZ9Cv8NBEr15pY3J0Wm3lPHayja7d5QXRAyZ
         5YWP1Gbn5JMwZEz/PCTqaMlkpusENf/Pys1EtLikjDWVNftaqFqePVkmnwJ/WpwTH4Be
         2fhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcFyf0v1qT/C1YQXGjM2gAonNFAnMg7U0aOFeLZ7M+0=;
        b=mtfo8LcccPqqVOJS8IAJkNhD9e0SCJWDVxRaQbm8icLin/zoYyI9T/4xtV/nGQU1JF
         DlHiRQg7K/uOmLbyq/ueMYZFwS2pC5CxZcBi0G0dEPNQeqJZEVhOCkKuBq6XerWH/ifM
         g05vgpPmtFW0PpnC5tc3hfoIaaAL4A1bU+8ZsHQRVJURMatcVi/mkjJ1PTzcIoKSiOfD
         mpCQse/OwmaHEX4Dv1Y8sKpHjVIpZwH7MURlyOAdiFmcWZhPtv3VqkWblZg1d4wIs47q
         zQJnlKKLOd/8ujGbROiagM31q9EfVSckYsSY07chRQoTLGL+GDC+gXlnGkma1tge86ie
         tYhg==
X-Gm-Message-State: AOAM5307sYCGPokB2d1cg7lXNAhpQvENjtWyM6bt0M9rv50QkQnd8Yiv
        3E5UuAfjZYMUWGBSsPuyiomK5ui4g1XpDqHCw/t8CQ==
X-Google-Smtp-Source: ABdhPJwURcaOwPoIeI4cChhVTUw5UPqhkC2hqh+bsf8Vy8cYKKABNPAXL6l1YU9a9nG+dCjviRMPgLPQJRhTdHBORPg=
X-Received: by 2002:a2e:b5cd:: with SMTP id g13mr832554ljn.0.1619721554177;
 Thu, 29 Apr 2021 11:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210429150940.3256656-1-arnd@kernel.org> <20210429181716.2409874-1-ndesaulniers@google.com>
 <CAKwvOd=5sLHssCf0Umfh+E__TjSwpxtO9K2MYVcXEhxvVp8okw@mail.gmail.com> <CAK8P3a1S0ct832wN0aM8ZAKbbQ3=w2_vSprhzQ4rLN=Ue=L0JQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1S0ct832wN0aM8ZAKbbQ3=w2_vSprhzQ4rLN=Ue=L0JQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Apr 2021 11:39:03 -0700
Message-ID: <CAKwvOdmEybM=Vij+DP0O8waL4Awi1pip2VzHhcczgNQsryqBoA@mail.gmail.com>
Subject: Re: [PATCH] smp: fix smp_call_function_single_async prototype
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>, Jian Cai <jiancai@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 11:27 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Either way, I'll give it some more time on the randconfig build machine
> before I send out v2.

SGTM and thanks for the fix.  Perhaps worth a note that this isn't
just "a violation of the calling conventions" but straight up
undefined behavior, full stop.

UBSAN folks are working on adding a catch for this as well:
https://reviews.llvm.org/D100037, see the relevant citations from the
standard.
-- 
Thanks,
~Nick Desaulniers
