Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA883674BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 23:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243999AbhDUVRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 17:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbhDUVRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 17:17:49 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 14:17:15 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id k73so42535219ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlc9Tv/D2ysgWWhvGsMGrJsw0e3hrEy5mirf5jB9mBY=;
        b=V5pyH5ReSKB9rU4npbd87vXwXwWWTH7h8UU8TR/Suv2TxNRmTuGl/fqPL98NhNUkC/
         +ajkW8eNKaYWfImX0Gh5l4WOzc3luCRq2kyEqbW4+L1bDJhVN2t+K2UFKSFMK615+p1W
         fokRZFe+EWqx9mrTpXAe9g0IWKG4gjMP9EsJ/TfhEcWAEX5ocwJiL74Jv/D599AHIHzW
         Ep9qeWMGCEKoTlYw4pwVueK3m7PX67tGmd05/woT8t/ugFcCPEkyJvtL05lptwKIzgNs
         cpj8rlRK9v1YgCn2JqZIvOd4+pP31q5VTcAXlPsqsi8ibxSw0iD1AvNJIbT34j0cCo1S
         wBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlc9Tv/D2ysgWWhvGsMGrJsw0e3hrEy5mirf5jB9mBY=;
        b=PJX2XNLH+ntl1z0U/bwPEFqrMD9OJKGv0+AFi1khbw9aW9TdahdlG2Yl0XEejCHa1J
         CLHkyC5FrtZktrHE0caPjNhOMkdeIGydu9bNEyzQ525P534Plr0zOtFzZvcUxHRswh09
         x6S42mCEPx3qdThXRRyRv9ZxznuOJHhqBG/RfBXHQuhz1KGnuloyv5YRH0s9X2qlggTT
         cNR2gfLeCmeX5+g3isPvUcQ6N3vocqBINDcG9kSaICwczRADQPmnMZMu22a7lWQWZyWL
         pwjWWceat/YAP9dQlGlqEB/KOuChjv2LFycDTjoLwVt/Ffgb/pvJA4ngw/wqBPTOZ+AV
         IuLQ==
X-Gm-Message-State: AOAM5338XoJiPErfD0EgTIEbQUJ30hZW5EXwTBCx6GkkS2sSi48npik6
        8KB7jcenP24Q3/+MjVu0PIExsVAJ0oz7M1tM5V6UQQ==
X-Google-Smtp-Source: ABdhPJx9NSSUybICVuqEWTq7PFGgymOWoKgffW9fXIc5e2mTk0rp20YW7U+2zmaBzMXbxSkf7njCL/TYePsPyEga0YE=
X-Received: by 2002:a25:c801:: with SMTP id y1mr24045ybf.250.1619039834767;
 Wed, 21 Apr 2021 14:17:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com> <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
 <c7d580fe-e467-4f08-a11d-6b8ceaf41e8f@suse.cz> <CAHk-=wiQCrpxGL4o5piCSqJF0jahUUYW=9R=oGATiiPnkaGY0g@mail.gmail.com>
 <CAJuCfpFgHMMWZgch5gfjHj936gmpDztb8ZT-vJn6G0-r5BvceA@mail.gmail.com>
 <CAHk-=wj0JH6PnG7dW51Sr5ZqhomqSaSLTQV7z4Si2dLeSVcO_g@mail.gmail.com>
 <alpine.LRH.2.02.2104071432420.31819@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHk-=whUKYdWbKfFzXXnK8n04oCMwEgSnG8Y3tgE=YZUjiDvbA@mail.gmail.com>
 <CAJuCfpHa+eydE_voX38V-jtv5J_RnyT=eY12-VmcLbVG_u2dyA@mail.gmail.com>
 <CAJuCfpHJjtv_=jLULge8D4EK_AK2yGLMcWKcGSaknzuWm0DFtA@mail.gmail.com> <20210421210517.GA6404@xz-x1>
In-Reply-To: <20210421210517.GA6404@xz-x1>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Apr 2021 14:17:03 -0700
Message-ID: <CAJuCfpFfRq8TYs78BvXWriVNm4hf1+o_rX7OUGF=5Hdjcpg30g@mail.gmail.com>
Subject: Re: [PATCH 0/5] 4.14 backports of fixes for "CoW after fork() issue"
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, Shaohua Li <shli@fb.com>,
        Nadav Amit <namit@vmware.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 2:05 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Suren,
>
> On Wed, Apr 21, 2021 at 01:01:34PM -0700, Suren Baghdasaryan wrote:
> > Peter, you mentioned https://lkml.org/lkml/2020/8/10/439 patch to
> > distinguish real writes vs enforced COW read requests, however I also
> > see that you had a later version of this patch here:
> > https://lore.kernel.org/patchwork/patch/1286506/. Which one should I
> > backport? Or is it not needed in the absence of uffd-wp support in the
> > earlier kernels?
>
> Sorry I have no ability to evaluate the rest... but according to Linus's
> previous reply, my understanding is that it is not needed, not to mention it's
> not upstreamed too.

Thanks! Then I'll send the backports for 17839856fd58 alone and if
more backports are needed I'll post followup patches.
Cheers,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
