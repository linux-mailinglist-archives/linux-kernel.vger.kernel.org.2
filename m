Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7309A3574E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355617AbhDGTXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDGTXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:23:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E25C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 12:23:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a1so22079318ljp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 12:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hq3OhgeTuQUA0PjJz23JVz00wO7dXBNObsytreflNCg=;
        b=eCs1MmuZhzl6TlzwYJCrgdonogfEDf++9zDPp5n3yN7O6rr/XUokUy1nBpm2iClbZ+
         PLgL+MdamCMbDAvFj1z1GiONnaysf9/lwlgcTxtWwHPs3i4zNzTzb5LZqTrt4IxO4MUd
         jfIJ/FVa6bfd8eLTSkso09lvbZXO2sZM/MBKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hq3OhgeTuQUA0PjJz23JVz00wO7dXBNObsytreflNCg=;
        b=piK7pAlfX2ARs37UoF3Y3sc/F+NN0OLLfllKWiEVQyo8FArzf7GMFqNX4d9PxPZkcs
         /MQxTj0iNpqTXRK/zP8zzAEt+awGio3SqQoqRrYYyfILAmWX8WQE9AEeWSIL4YBZ7IK3
         qU86o1htFFNm7f+paj5h0oaklmJZy+GCaN/7HSTlf00gh7nIMzQ5sMGl+/m/WOKxMgy9
         hJ+hfKdPEvJbO6vHpltQ+XbOGK1st4dKBhuEs5isocEoL+KEl7N5zJ6sJkw3E/RazILC
         AzBCyPvnI20ozbH6/BqIuiMi6X5+6hc+AkKrM0aQeYdPhzehkbL0DWDNAQ9iQg9JaZKZ
         QBfQ==
X-Gm-Message-State: AOAM532RsBkJwQ7fm/j76x9vWFXfTGIuPZEY6Ch3k2uRay0L2Lm37SUf
        0AsNbB+ugYAD8nglsRnxhDWoxLDJDTZFzHcK
X-Google-Smtp-Source: ABdhPJx8Vu/8aoiJpGLvOZJGuIr8/pXd6rLhz5RNwwZOGiX570TJh0eyNqBpLjVQMvrQqZFXdYYbxA==
X-Received: by 2002:a2e:b053:: with SMTP id d19mr3125329ljl.82.1617823378875;
        Wed, 07 Apr 2021 12:22:58 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id p26sm664433lfo.127.2021.04.07.12.22.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 12:22:58 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id z8so22017148ljm.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 12:22:58 -0700 (PDT)
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr2990148ljo.411.1617823377841;
 Wed, 07 Apr 2021 12:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210401181741.168763-1-surenb@google.com> <CAHk-=wg8MDMLi8x+u-dee-ai0KiAavm6+JceV00gRXQRFG=Cgw@mail.gmail.com>
 <c7d580fe-e467-4f08-a11d-6b8ceaf41e8f@suse.cz> <CAHk-=wiQCrpxGL4o5piCSqJF0jahUUYW=9R=oGATiiPnkaGY0g@mail.gmail.com>
 <CAJuCfpFgHMMWZgch5gfjHj936gmpDztb8ZT-vJn6G0-r5BvceA@mail.gmail.com>
 <CAHk-=wj0JH6PnG7dW51Sr5ZqhomqSaSLTQV7z4Si2dLeSVcO_g@mail.gmail.com> <alpine.LRH.2.02.2104071432420.31819@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2104071432420.31819@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Apr 2021 12:22:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUKYdWbKfFzXXnK8n04oCMwEgSnG8Y3tgE=YZUjiDvbA@mail.gmail.com>
Message-ID: <CAHk-=whUKYdWbKfFzXXnK8n04oCMwEgSnG8Y3tgE=YZUjiDvbA@mail.gmail.com>
Subject: Re: [PATCH 0/5] 4.14 backports of fixes for "CoW after fork() issue"
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
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

On Wed, Apr 7, 2021 at 11:47 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> So, we fixed it, but we don't know why.
>
> Peter Xu's patchset that fixed it is here:
> https://lore.kernel.org/lkml/20200821234958.7896-1-peterx@redhat.com/

Yeah, that's the part that ends up being really painful to backport
(with all the subsequent fixes too), so the 4.14 people would prefer
to avoid it.

But I think that if it's a "requires dax pmem and ptrace on top", it
may simply be a non-issue for those users. Although who knows - maybe
that ends up being a real issue on Android..

            Linus
