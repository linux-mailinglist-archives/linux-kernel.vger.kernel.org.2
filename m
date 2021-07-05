Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9F3BBC1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhGEL0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhGEL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:26:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5162AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:23:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x12so23255099eds.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 04:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mdfkoj1lAbFutKa5lBXnsN9adsQUOWmNA/ZLqwOPGpk=;
        b=mWQhQjCBOWSXySjEfeb+vg4svQ/XwhAXPPEo50VHAEZRasrSO+6ohY4TfpRzrtkqlH
         r+7J2MKKBUvUrzkp89xszDBMBhn12q8RcynhlOASlSD84qAWtBY6a9kpkXAfwLn7BfYr
         KhOPY4RbDkPocGy4p8F8GREaZcXanMXSZJRyTdRjf8wfAvcEnnXx45RPYn4YYeL6eZe4
         p5kw5DTy8ehyG9HLBvM5rWQJXkXsZ+2ghsYU95lf2XOcIodK4a9HVXWOUY2rv5vvv4vS
         9D40H0/Qx+omS2SLjW0jfE9HKBJgS40somM3aAmiRd0rh1u+MU1eA7awdQpFxNeACyBv
         yMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mdfkoj1lAbFutKa5lBXnsN9adsQUOWmNA/ZLqwOPGpk=;
        b=Qauycy7180jwPsyuCQoxv/JQPB04b0uSjWep/sONbYhK3w2uDIqn5Fp+pK+0j7ycj8
         b165WKRY9Oo7xPV19y1M/mbFFvsVu36DCNrHHGQB04okr/N+VOLkuWgMhJM4JW6F5/Ne
         v5DbYiUKX3Nzw5qkqtBvFzKO9+4QjwQaIcWldv2yfkwMal1embnL46thIwD3WGVHB5hN
         GsuSnHmHdSzj9y5RsgNpYnprBTsxMpsg2Udnsl7AkRbaYd2fcfmTObAQSeiWXYuBFSQ5
         K7/Q+053/F6ICcjUX7T2MDiSMRylTlFprCBRL3B2WyxjJGIDaUgxTYcV9KpAC2r7xS+R
         13/A==
X-Gm-Message-State: AOAM530VS1iukMsitRbidugv1NeEh3yEf9xA7wMa8CcRb1agctOBA1A1
        pkGHhImabURGxnMap5jC9jKhlHmPBxSRwtCnUbg=
X-Google-Smtp-Source: ABdhPJwGH0p/imAnekqZjXgvncy4w5jEtjNHUlH1jV4COzYm+dvF06JV51V2eJSLAgxDFSYriStliogFD/cCFmOocbI=
X-Received: by 2002:a05:6402:5c9:: with SMTP id n9mr3126699edx.30.1625484207801;
 Mon, 05 Jul 2021 04:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210705103229.8505-1-yee.lee@mediatek.com> <20210705103229.8505-3-yee.lee@mediatek.com>
 <CA+fCnZdhrjo4RMBcj94MO7Huf_BVzaF5S_E97xS1vXGHoQdu5A@mail.gmail.com> <CANpmjNNXbszUL4M+-swi7k28h=zuY-KTfw+6W90hk2mgxr8hRQ@mail.gmail.com>
In-Reply-To: <CANpmjNNXbszUL4M+-swi7k28h=zuY-KTfw+6W90hk2mgxr8hRQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 5 Jul 2021 13:23:17 +0200
Message-ID: <CA+fCnZfKAZuy9oyDpTgNUTcNz5gnfHpJK5WN-yBNDV5VF8cq0g@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] kasan: Add memzero int for unaligned size at DEBUG
To:     Marco Elver <elver@google.com>
Cc:     yee.lee@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
        nicholas.tang@mediatek.com,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        chinwen.chang@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 1:18 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 5 Jul 2021 at 13:12, Andrey Konovalov <andreyknvl@gmail.com> wrote:
> [...]
> > > +       /*
> > > +        * Explicitly initialize the memory with the precise object size to
> > > +        * avoid overwriting the SLAB redzone. This disables initialization in
> > > +        * the arch code and may thus lead to performance penalty. The penalty
> > > +        * is accepted since SLAB redzones aren't enabled in production builds.
> > > +        */
> > > +       if (__slub_debug_enabled() &&
> >
> > What happened to slub_debug_enabled_unlikely()? Was it renamed? Why? I
> > didn't receive patch #1 of v6 (nor of v5).
>
> Somebody had the same idea with the helper:
> https://lkml.kernel.org/r/YOKsC75kJfCZwySD@elver.google.com
> and Matthew didn't like the _unlikely() prefix.
>
> Which meant we should just move the existing helper introduced in the
> merge window.
>
> Patch 1/2: https://lkml.kernel.org/r/20210705103229.8505-2-yee.lee@mediatek.com

Got it. Thank you, Marco!
