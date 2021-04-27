Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB136BDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 05:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbhD0DbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 23:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhD0Day (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 23:30:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF160C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 20:30:10 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x19so61136985lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 20:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/f4JVixSDUtfY05Md2NUGmbhN57QIb2bgma7dK5cAU=;
        b=Haegntx8II71fsjo5ukch+sUDr23zEkF/J/qNEpVmmL/ZqvcJAgbctNfGpJt84CeSZ
         s+F+HfGj+q1ifZqOPXfc+7VWk5hLwGqnU8juAJQQfH+Xn5SKE0vNWjJdFF5F1QR2Q/w1
         OyfyMhebqHwHBl5HlBwQEW7CiLECAp9E8DHt1Hzwf0Lo/swVjRdh/XAcGcADCZfF+nsq
         PIbUmWmumb6wh3R4L9iBUBN63IqsRpM/GOmJWWH/YmHgpdzE9nYmZXpAvI4IEc2ps2UZ
         94b2pzL49zWIfq5Mtd9HSyL7gDz9sBK3YyJjVSkvX4lFchmQ3JmTgAHc3iFQnYcWeSE7
         6rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/f4JVixSDUtfY05Md2NUGmbhN57QIb2bgma7dK5cAU=;
        b=ahHU5M+uPotS2DinoYP5NY9bJ5O0OlrPGKox9rMUPpUi+JKiqTpWiDh09GgdAKYbLG
         C/JzIsmnYQvGQ/xIfcvPrtF81MqDcVmpddmtaKq/X0tvTevvPUGW2Tqn7rt+DJbY26tz
         bCOLaqh9r+XO/IrHvkVZYNURyQaG4n68EFyJrRwSCYVlcKeo87x4tXbmrKJ/gu93mten
         M1kOaq5gDtI5k0VbxDx2R0LWaNjegH2hGS3fnZEB3PWpUYCkKtIq4+v2orSvFDqeeOwb
         l1bTHy4Pn1gVVP+IlGtz30MQuHEXoSUZGhwaVCOyH50EisWpygCfWoZariBX32sFHOwR
         kCzQ==
X-Gm-Message-State: AOAM5331HDOqiSQqPoe62morwKCBTaG+IEOYNJF+XcBb0nz4wpPv/wgo
        +hPGZE7zPWLLL7VWwiiN9Q9gquQJy4f0Km8YnlKA8SJn24DVMw==
X-Google-Smtp-Source: ABdhPJwb20u/69HZE27J3wrxf12je+L3qCbCg+Zfj/Sb+4NGCjbGt7tjCcSB/OyfAvpYJdy0V+aO3Y7OdXWGS7TK7Xo=
X-Received: by 2002:a19:f504:: with SMTP id j4mr2105098lfb.307.1619494208480;
 Mon, 26 Apr 2021 20:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <1619491400-1904-1-git-send-email-sxwjean@me.com> <20210427025358.GV235567@casper.infradead.org>
In-Reply-To: <20210427025358.GV235567@casper.infradead.org>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 27 Apr 2021 11:29:32 +0800
Message-ID: <CAEVVKH_wZJvNAgFEF1OxThxN3AC4mopZ+Pu2GC0Hn_-2JOfC5Q@mail.gmail.com>
Subject: Re: [PATCH] mm: append __GFP_COMP flag for trace_malloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Xiongwei Song <sxwjean@me.com>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 10:54 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 27, 2021 at 10:43:20AM +0800, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > When calling kmalloc_order, the flags should include __GFP_COMP here,
> > so that trace_malloc can trace the precise flags.
>
> I suppose that depends on your point of view.
Correct.

Should we report the
> flags used by the caller, or the flags that we used to allocate memory?
> And why does it matter?
When I capture kmem:kmalloc events on my env with perf:
(perf record -p my_pid -e kmem:kmalloc)
I got the result below:
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca0000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca4000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4ca8000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a6f80000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a6f84000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a6f88000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.08%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a6f8c000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC
     0.07%  call_site=ffffffff851d0cb0 ptr=0xffff8c04a4c80000
bytes_req=10176 bytes_alloc=16384
gfp_flags=GFP_ATOMIC|__GFP_NOWARN|__GFP_NOMEMALLOC

The value of gfp_flags made me confused, I spent some time to find out
which trace_malloc
is here. So I think we should append __GFP_COMP.

Regards
