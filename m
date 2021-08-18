Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639663F0A73
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhHRRp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:45:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EE2C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:45:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lo4so6682210ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 10:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Uovgw6HtB8nCaHLgQeNwVXL7QPb2LFvG/OTd/4a5ak=;
        b=kTrFTfdZwBdHy76qEQOosd/JNgO9DHO3/3Fa6bHn+fmmaof5wf4BiiE3mRbELN9JIj
         4fT93V+hTpd62/0WNVZVC2KfwrD0dn8pDlRKcalsElL9l/zMVygVutUk9REdxVBHnrPT
         bkoJxO8dxOc45W+t+4hWLhcb6dMDeuYNBAEg3bFhrVsTxV+1V3CE49MlLw6l6jRLmnDv
         9bMa4KzJ9UbwU+nlyvRrUsWH4pNDA1ZfDZI7OELxYJd+BOIsvINbiH9KngvUK4Xk+IjT
         YrJvXsl4bczMww3m38J9zQULzv5YhXVwBkD2Y6HEp0HxEguTMVg2QSQwPXJ2X4VpCWCt
         GlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Uovgw6HtB8nCaHLgQeNwVXL7QPb2LFvG/OTd/4a5ak=;
        b=Mxl65QwReVsc5QgPG5cc3LgZYfO/pgE2nvqjWmxp4t74ASDGuidaXX1QhZGw6Mz35g
         OWYM9zE+qmjJI9wkNT4FCaZ/xuf0pIsbmYv+pkkeG1FEj2VZrNwBpe7A98Fw3jzd+Jq5
         vA47zy+82BAD9cXg1pzm6CDvOOaniEWRB9/Xja9GORelIKxvfNjHRBUf40k8TW/b/puv
         3UTYK07Yye6bKwDyDMKDKsB9XG8s+T3OMzcu3XV8dAhi7W+3AqapzGZx7eqZjgDAWyW8
         PJsbthzW0yUY1pKGFJ3ZFGamh43hd1osP3Vjv8PlngJufIkhrln7f48EkSwoGcRDPqDX
         WIBA==
X-Gm-Message-State: AOAM531lksJ5cD64AVtgVyZk1hErFMe9j37gxfVB17fitgKCeOnZROPV
        Er2wSvpO5j7WdSG9yobyOeFfJdd48ODYyXBYQv4=
X-Google-Smtp-Source: ABdhPJy0mPtO0GH+4nza/OV3TXTnQCCdo0FpbI2ezsp730DZJi7NV1LcxjxadMNfe40MGAgUIi8Pw2NTyQ0D8ZD+bpo=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr11135731ejq.25.1629308720854;
 Wed, 18 Aug 2021 10:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210816180909.3603-1-shy828301@gmail.com> <YRq+kCOW4zb4vfxA@casper.infradead.org>
 <CAHbLzkoE6h9dmRp6zfaKdLjq2y24+PV-yBUv6RMXtzKvPFdBkw@mail.gmail.com> <20210818050239.GA496938@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210818050239.GA496938@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 18 Aug 2021 10:45:08 -0700
Message-ID: <CAHbLzkqHJ6imN_T2UwgJErj6eBuMx-mLY7=e_dU0cL-7hNkirg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        "tdmackey@twitter.com" <tdmackey@twitter.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:02 PM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=
=80=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Mon, Aug 16, 2021 at 01:24:25PM -0700, Yang Shi wrote:
> > On Mon, Aug 16, 2021 at 12:38 PM Matthew Wilcox <willy@infradead.org> w=
rote:
> > >
> > > On Mon, Aug 16, 2021 at 11:09:08AM -0700, Yang Shi wrote:
> > > > But the most disappointing thing is all the effort doesn't make the=
 page
> > > > offline, it just returns:
> > > >
> > > > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 (=
)
> > >
> > > It's a shame it doesn't call dump_page().  There might be more
> > > interesting information somewhere in struct page that would help us
> > > figure out what kind of page it was in your environment.  For example=
,
> > > it might be a page table page or a page allocated for vmalloc(), and
> > > in both those cases, there are things we might be able to do (we'd
> > > certainly be able to figure out that it isn't worth shrinking slab!)
> >
> > Yes,  dump_page() could provide more information to us. I could add a
> > new patch or just update this patch to call dump_page() if offline is
> > failed if the hwpoison maintainer agrees to this as well.
>
> I agree with showing more information in failure case. Thanks for the inp=
ut.

By reading the code, it seems get_any_page() is called to shake the
page for both soft offline and memory_failure(), so it seems like a
good place to call dump_page() if -EIO is going to be returned, which
hwpoison can't handle the page, otherwise we may need call dump_page()
in a couple of different places.

Although dump_page() will be called with pcp disabled and holding
memory hotplug lock if it is called by get_any_page(), but I'm
supposed it should be not a big deal.

>
> - Naoya Horiguchi
