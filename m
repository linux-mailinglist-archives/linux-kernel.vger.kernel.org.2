Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D335729F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354509AbhDGRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242968AbhDGRFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:05:17 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E55DC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 10:05:07 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s17so21564931ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+88jxDCU+SNdWXTN3z3TZI8sQwpTFP6rVmjQ1IvMUp0=;
        b=NEqJedWWmmdhqwXjNwjktue2V23wNTRtBfoImIIAzQVurOySj5Javl6oNqSxLuGk/6
         H5db28mPuPm8ZICBA974Hz2HSIUZgFYCpQjj7wNrm2YortKw0r9rkQz6xqx2G3ohOwJL
         KBqlJrRjasxTbcKYfFCNzd5whuFSFbHBux824=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+88jxDCU+SNdWXTN3z3TZI8sQwpTFP6rVmjQ1IvMUp0=;
        b=e4TwyX7+nX9TC43e/gy5nKCL33PNJ/rsg4zKSFjOBO7/bjjd7XDQYYh790LuQzg9bK
         otVdmjQx1MywgEHqirBA4Q8cKZOCfnRKPfOin3EpRTItYn6FsBPCfsqYTFajmtqi0nps
         axdH/+Z9Yrn736wKNARXt/WLm7quZxzcs+KU7G1iCoiameKPS3+HmiTCSVz0KR/oApAq
         UYNY/RG+32qoo3A0khjj2Rj1pcz77cSzB58xXRajsENyFWPrzE14uL3+NvXkPBwJofXH
         U26d9MrcmXNQMNuqJRz1iWP0HPMR+a4zjcJOx5K5Q/fby+lD4F6SHZ9OnexsxM81yfUl
         3vhw==
X-Gm-Message-State: AOAM532A/aazcR2lENacT5YqoJyUn4Td/oVT15Nacmo6qzqaxGHbfPUG
        XC9IpPvY+zRcxwA4ODvD3samOitu0Nk/XKx7
X-Google-Smtp-Source: ABdhPJwZVlH8xY/iPok7pYoPHJal6Fk3yGtQn/XW3wvcTEWd477mxQDikcJtiNyieNWEEqyPijQ7Ug==
X-Received: by 2002:a2e:9151:: with SMTP id q17mr2660497ljg.107.1617815106082;
        Wed, 07 Apr 2021 10:05:06 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v20sm2513611ljh.105.2021.04.07.10.05.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:05:06 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u20so21525222lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 10:05:05 -0700 (PDT)
X-Received: by 2002:a2e:9acf:: with SMTP id p15mr2701576ljj.61.1617815105311;
 Wed, 07 Apr 2021 10:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com> <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
 <c7d580fe-e467-4f08-a11d-6b8ceaf41e8f@suse.cz> <CAHk-=wiQCrpxGL4o5piCSqJF0jahUUYW=9R=oGATiiPnkaGY0g@mail.gmail.com>
 <CAJuCfpFgHMMWZgch5gfjHj936gmpDztb8ZT-vJn6G0-r5BvceA@mail.gmail.com>
In-Reply-To: <CAJuCfpFgHMMWZgch5gfjHj936gmpDztb8ZT-vJn6G0-r5BvceA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Apr 2021 10:04:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0JH6PnG7dW51Sr5ZqhomqSaSLTQV7z4Si2dLeSVcO_g@mail.gmail.com>
Message-ID: <CAHk-=wj0JH6PnG7dW51Sr5ZqhomqSaSLTQV7z4Si2dLeSVcO_g@mail.gmail.com>
Subject: Re: [PATCH 0/5] 4.14 backports of fixes for "CoW after fork() issue"
To:     Suren Baghdasaryan <surenb@google.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
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

On Wed, Apr 7, 2021 at 9:33 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Trying my hand at backporting the patchsets Peter mentioned proved
> this to be far from easy with many dependencies. Let me look into
> Vlastimil's suggestion to backport only 17839856fd58 and it sounds
> like 5.4 already followed that path.

Well, in many ways 17839856fd58 was the "simple and obvious" fix, and
I do think it's easily backportable.

But it *did* cause problems too. Those problems may not be issues on
those old kernels, though.

In particular, commit 17839856fd58 caused uffd-wp to stop working
right, and it caused some issues with debugging (I forget the exact
details, but I think it was strace accessing PROT_NONE or write-only
pages or something like that, and COW failed).

But yes, in many ways that commit is a much simpler and more
straightforward one (which is why I tried it once - we ended up with
the much more subtle and far-reaching fixes after the UFFD issues
crept up).

The issues that 17839856fd58 caused may be entire non-events in old
kernels. In fact, the uffd writeprotect API was added fairly recently
(see commit 63b2d4174c4a that made it into v5.7), so the uffd-wp issue
that was triggered probably cannot happen in the old kernels.

The strace issue might not be relevant either, but I forget what the
details were. Mikilas should know.

See

  https://lore.kernel.org/lkml/alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com/

for Mikulas report. I never looked into it in detail, because by then
the uffd-wp issue had already come up, so it was juat another nail in
the coffin for that simpler approach.

Mikulas, do you remember?

            Linus
