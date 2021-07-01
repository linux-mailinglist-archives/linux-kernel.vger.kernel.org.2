Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5783B98D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 01:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhGAXII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbhGAXIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 19:08:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF32C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 16:05:36 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k16so9509806ios.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiNIR6k4gDoDe9HuA7sGuhCI/TkwRDGteUCqF497qiU=;
        b=Ow/9xnEEMDhkeugBMrtf5hTfF6mqrQRonwSEJ26ic5Nt0oKlElmcPATRr2c5IAGV43
         +YErFUWWRqev2mSzxL1QcA0pBctGDwLTYlyrG9oXIo4JNDO5mI25ir4JrRHSKhzLtgd2
         A9HcIj+7wwILa2VC6MzGJcdXM52Fd6mZ4wxbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiNIR6k4gDoDe9HuA7sGuhCI/TkwRDGteUCqF497qiU=;
        b=VjZaUZB4MLXEn8zic0OmfMv2/yJuSC/9XnnOyGPdxpnbn/yf/DJMG8ZnFtTJQpZhxe
         ujGza4EXuRgH6mHZ7KLIjbsH3qIgacNlH3V/V/ExijHw4+UnIZdzOmvt6iz0JgEiSUOE
         HQEU1xJhws5WCUzFNi2YZw5tF/W/9vqnLRJpCmaDrqLeKxVo7ADqZ65Sjthp2stiKr4+
         jpg8APwU1gcOdRQKeTxBItK4QoFyaEb+yQSR1LO3S4AOScr60aBVIwcqtD7fq7rVuOrd
         zYlBj7/OSG8Is7BteIXzEeZZ0lssVNcsoq8xhhaOCovXDetWpH4C8q1uZCJUAWL62Gnt
         o/cw==
X-Gm-Message-State: AOAM5309iy6Z6Sgnyo1gxNnI9MHkBGuNYDKUYfFyr1ZxrWPh7te6Lr79
        cbWZdxUWjMmpBV7+9h0tcGySf1T/m+cx0XUI
X-Google-Smtp-Source: ABdhPJyV/ORrERrOtBvjJAHF751ylsBCDbbt+hnDow2eVaO+lvIHT8povSUCKDT214qlkmttQE246w==
X-Received: by 2002:a5e:8345:: with SMTP id y5mr1297700iom.209.1625180736154;
        Thu, 01 Jul 2021 16:05:36 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id a18sm768745ilc.31.2021.07.01.16.05.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 16:05:34 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id h3so8032959ilc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 16:05:33 -0700 (PDT)
X-Received: by 2002:a92:7b07:: with SMTP id w7mr1261220ilc.308.1625180733446;
 Thu, 01 Jul 2021 16:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210630100432.v1.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <20210701200253.GB983@bug>
In-Reply-To: <20210701200253.GB983@bug>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 1 Jul 2021 16:04:57 -0700
X-Gmail-Original-Message-ID: <CAE=gft6UUesGAcT3cweFuQBOh3xFzN2gCDNGWZRqizNmPT7Rdg@mail.gmail.com>
Message-ID: <CAE=gft6UUesGAcT3cweFuQBOh3xFzN2gCDNGWZRqizNmPT7Rdg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: Enable suspend-only swap spaces
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 1:02 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Currently it's not possible to enable hibernation without also enabling
> > generic swap for a given swap area. These two use cases are not the
> > same. For example there may be users who want to enable hibernation,
> > but whose drives don't have the write endurance for generic swap
> > activities.
> >
> > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > generic swapping to it. This region can still be wired up for use in
> > suspend-to-disk activities, but will never have regular pages swapped to
> > it.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Makes sense to me.
>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>

Thanks!

>
> >  #define SWAP_FLAG_DISCARD_ONCE       0x20000 /* discard swap area at swapon-time */
> >  #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
> > +#define SWAP_FLAG_NOSWAP     0x80000 /* use only for suspend, not swap */
>
> I'd say "only for hibernation". And actually maybe code would be more clear if logic was reverted.

Sure about the rewording. Yes, I also thought about flipping the
polarity. This made more sense to me as an outlier condition, despite
the slight awkwardness of a negative flag. And the usermode flag has
to be written this way, so I might as well carry it through. I think
I'll keep it unless anyone feels strongly.

>
> Aha, and you may want to check... does the hibernation still work for you without the swap?
>
> Because we need half memory free to create swap image and swap is really quite useful for that.

Yes, hibernation still works. You're right that without another swap
space set up, it starts to fail when half of memory is used up. This
flag gives me the control to exclusively steer swap towards one device
and hibernate towards another.
-Evan
