Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6340F44BC52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhKJHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhKJHrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:47:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AAEA611ED;
        Wed, 10 Nov 2021 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636530286;
        bh=X97XRaIFoSbPhsaZ8G8JIdgC+nVfoxiFTaKJeg9rslw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=GfBH2Ud/Sb7sLq7KhkM6T4ur32J7IoNbJnYAu2dPBR3E6pHlqGm19sYa5XRYQXo8f
         sANzoFXJ5K3tm8OHPpJtzZI7RqexKkC9BCnfN9Ej6nFsXOPp9qYPONN9TtfCP+R9d6
         dxmTPDLVwAiLR4xE7V62c32GG4mmtC+x6j4ivgnUvfqVeWx+iPieR0OGxGRWUp4dVY
         Y8o0oPORdsL86DdW3QbiCuXBH0TtNtr+KGsVWHVSKFylBVIGxz5gquCjJJFBxNo4xu
         wnm0UOnPlRgOGDfo0HIJAFzcYqnTcZl3nY318T48WFXOIdrjDmAyxG/KqybjaNjhxz
         8UghztFMdCbVw==
From:   SeongJae Park <sj@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Yihao Han <hanyihao@vivo.com>, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@vivo.com
Subject: Re: [PATCH] mm/damon/vaddr: use swap() to make code cleaner
Date:   Wed, 10 Nov 2021 07:44:40 +0000
Message-Id: <20211110074440.13343-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMZfGtXbSgLQD2MSda0YoXNUioAzVhQmH5YpSsFLZ0vSMiEHUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 12:15:57 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> On Wed, Nov 10, 2021 at 11:32 AM Yihao Han <hanyihao@vivo.com> wrote:
> >
> > Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> > opencoding it.
> >
> > Signed-off-by: Yihao Han <hanyihao@vivo.com>
> > ---
> >  mm/damon/vaddr.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> > index 35fe49080ee9..414d9fb9c827 100644
> > --- a/mm/damon/vaddr.c
> > +++ b/mm/damon/vaddr.c
> > @@ -100,11 +100,7 @@ static unsigned long sz_range(struct damon_addr_range *r)
> >  static void swap_ranges(struct damon_addr_range *r1,
> >                         struct damon_addr_range *r2)
> >  {
> > -       struct damon_addr_range tmp;
> > -
> > -       tmp = *r1;
> > -       *r1 = *r2;
> > -       *r2 = tmp;
> > +       swap(*r1, *r2);
> 
> IMHO, I suggest removing swap_ranges() completely
> since it's only a wrapper of swap() after your changes.
> The caller can invoke swap() directly.

I also agree to Muchun.


Thanks,
SJ

> 
> Thanks.
> 
> >  }
> >
> >  /*
> > --
> > 2.17.1
> >
