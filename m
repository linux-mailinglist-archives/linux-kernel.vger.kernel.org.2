Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2239030BF57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhBBN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhBBN06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:26:58 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC45C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 05:26:17 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y5so19001998ilg.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 05:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jVgE0oIK3fGiGsKx3cUd5LP7xU0dIQnIublrKDLp/XU=;
        b=FwXTZ6emWDbVtItD8pjLw2SyPwMYDtXR8ZZ1KCWZoSrgIRTU97iZhu6kc2CVbPhkyd
         WyEovOI4kY8C0ZdOAkObMHwKTZz5tkhwuOaM5BBUvpQceagIpBj46flPzLXPE7A1nFEb
         lVaO1SL69qpHltqbL8Pdi4nHSdFRSLSCFKUW1pG4/pjwUf/esFtPAiX5dUUT8B3JNe8B
         Ecvad9lnEQ7tcPzU5Ra5uqy8hDCzow0eEW+wxIrNMX7cPfVkeTECMR6i8b1mFHRPC7wh
         Rw73pJWu88JGUajuNuYP1UykCcwEZSf7d10Feb4SUJjcEJFMm9nATRGNG5xboyIDaC1s
         354w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jVgE0oIK3fGiGsKx3cUd5LP7xU0dIQnIublrKDLp/XU=;
        b=rhF4iu3rc3A9+UupMSgbFBgAjykDa4BOqwX8Z9EKkKg0HleGzD42cxI6qZyfjDls2y
         JProl0n2wmHMAaKs9abEBV7nrSQHxw85T5D9qStDiODHy7QR+Id3uBruCig9reUEGNUJ
         98LA3uLJwwsZp7nZaBPAgjNRaSuALHKQzxwbKwB2MYrpk952xr/LsYr7tYdwJWUv8aNQ
         hbk7shpcteUKYeIBakGf6I2VhmWz5CBvuYgzdonarhPfz1hO3xV0LcjYBP2FSAs0teJk
         IG0zEkZ2GyWlfBF6rHYdXJgIv5l5jg86CO9SNhoA4BRX9xD3LUfIvAcBk7PNKNOJvZmp
         6e/g==
X-Gm-Message-State: AOAM5305XcrA15fW5Mzgb3Udu/S8EsUSfa29vLZ1hpKdrqrvwLYviu2v
        t0zymzJgQgpcXn4vHf9p8+K57GmqeESM4bgjscQ=
X-Google-Smtp-Source: ABdhPJxC9kN49h4YfGAR9SY0r7v9MOd81AJGZIapGVgfxzk7T4kMTqrwKXkpp3ZKGQ15vU1N0qxSr5zlm9Z0xipHMXs=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr17134271ilh.137.1612272376936;
 Tue, 02 Feb 2021 05:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20210201115610.87808-1-laoar.shao@gmail.com> <20210201115610.87808-4-laoar.shao@gmail.com>
 <YBgBxaFSy8P/nrcH@smile.fi.intel.com> <CALOAHbAUPCUfZp_58QbVzvbP2UqoPqHAzzsgk1UTZ95v1rtqTw@mail.gmail.com>
 <YBgpavcZD4VXZri6@smile.fi.intel.com>
In-Reply-To: <YBgpavcZD4VXZri6@smile.fi.intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 2 Feb 2021 21:25:40 +0800
Message-ID: <CALOAHbDNH52U1dn+TVe23bUbND9mgLezYWNEcCh7hZyUJdcFiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] vsprintf: dump full information of page flags in pGp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 12:16 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 01, 2021 at 09:49:59PM +0800, Yafang Shao wrote:
> > On Mon, Feb 1, 2021 at 9:27 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Feb 01, 2021 at 07:56:10PM +0800, Yafang Shao wrote:
>
> ...
>
> > > > - Before the patch,
> > > > [ 6343.396602] Slab 0x000000004382e02b objects=33 used=3 fp=0x000000009ae06ffc flags=0x17ffffc0010200(slab|head)
> > > >
> > > > - After the patch,
> > > > [ 6871.296131] Slab 0x00000000c0e19a37 objects=33 used=3 fp=0x00000000c4902159 flags=0x17ffffc0010200(Node 0,Zone 2,Lastcpupid 0x1fffff,slab|head)
> > > >
> > > > The Documentation and test cases are also updated.
> > >
> > > Thanks for an update, my comments below.
> > >
> > > ...
> > >
> > > > -     %pGp    referenced|uptodate|lru|active|private
> > > > +     %pGp    Node 0,Zone 2,referenced|uptodate|lru|active|private
> > >
> > > Since of the nature of printf() buffer, I wonder if these should be at the end.
> > > I.o.w. the question is is the added material more important to user to see than
> > > the existed one?
> > >
> >
> > The existing one should be more important than the added one.
> > But the order of output will not match with the value for page->flags.
> > E.g.
> >     flags=0x17ffffc0010200(slab|head,Node 0,Zone 2,Lastcpupid 0x1fffff)
> > It may be strange to compare the value with the string.
>
> More I'm looking at it, more I'm thinking it should have different specifiers
> for each group of desired flags to be printed.
>
> So, you leave %pGp as is and then add another letter to add more details, so
> user will choose what and in which order they want.
>
> For example, let's assume %pGp == %pGpf and P is a new specifier for what you
> are initially adding here:
>
>   %pGpfP => referenced|uptodate|lru|active|private,Node 0,Zone 2
>   %pGpPf => Node 0,Zone 2,referenced|uptodate|lru|active|private
>
> and so on.

Thanks for your suggestion. I will think about it.

-- 
Thanks
Yafang
