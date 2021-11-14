Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A488144F930
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 17:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhKNQ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKNQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 11:57:44 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF3FC061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:54:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w1so60974784edd.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 08:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4mTkMaJLBp4mSDJvC547VxkTQcqH8W2cpJ2J7gpbKs=;
        b=ZM48247MOH5DIfBDrKDqGsm6HKJAxRGMnc8RsyJf8mTgsiUmX0T422ZwyXnlddCOzy
         nbNuZhs9mxSNLUr5HG8kiyx/sXiMDUk5MuiTITOfDI96ZzrC+4/XcNBK924GzZi3FwB2
         0a+0SPcQChaDN+TQxM3YZCZ38+Zyjil1ESoucM/8eHYr0vPVUX5szL8Ynryx3BH6aqbO
         KNB7B4F8zkPfyCFMi3T1IXIn7YeF9Z3QCxdn+X84K+EjhpbNnVAwr7xbYvldA7GpxRzW
         LJ1vcYcyVMEcsUK/otAwnRYDrvO9b2Y6iGNgqDiy1DxKCZ//Q3nrYcwo/deO+KaSsUw/
         hwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4mTkMaJLBp4mSDJvC547VxkTQcqH8W2cpJ2J7gpbKs=;
        b=DAW4rN9Y8ww1uEy18908ZzIhHkUORT+F7JSoE36a75x0haid4TlSwGt8VdD8piWTx9
         +cvE+wHmMnQHORtzpY5oHDXSqd5clX2TPo35zHsRxRYimzJHvwfZEMfkDXHrdV/Jf/Y+
         2SDY3TNQ6Ligk2X9jxgfkH0rh/E7mhwIt4pGRaiY1Ud5/Y1fgy5Snw8yJIjPydHh26Ht
         tXlfmWV5+Et4AweRkETNw2vmk3hiyrg/xN2Z9I9zdt50iqAtNg0053wwoPQCllaF6qdX
         MnTyLme+EnSONPSJs9pHxZp2BU1JD7YuG2zup51cDtJp0rc5ZtM4Rtse7ec1OKUzzZwO
         XoNw==
X-Gm-Message-State: AOAM533nwh7eLjmFGltYDy05asXEtanrM/UmFDhFdSq9Sn5D0vDrg2qY
        Um7eCeOl8MBMZAVDo7ROkJCrltjYAcHC6ekuQiQ=
X-Google-Smtp-Source: ABdhPJz8Ve8GJIT3h/LX8SDO4o5mA9nsOg4+4AtZAoqIPF7GABCFN4uv5Yv/mZMwIyzME0u1NBgOIhHnuHGI4qRnEVo=
X-Received: by 2002:a17:906:d20c:: with SMTP id w12mr40179562ejz.521.1636908888207;
 Sun, 14 Nov 2021 08:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20211114053221.315753-1-shy828301@gmail.com> <YZErCLzSixIwTr6C@casper.infradead.org>
In-Reply-To: <YZErCLzSixIwTr6C@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Sun, 14 Nov 2021 08:54:36 -0800
Message-ID: <CAHbLzkoMycvjVO_438JKB-Z7vW3UNmDKxaA3Hpj-zYX7MKkc0g@mail.gmail.com>
Subject: Re: [UPDATE PATCH] mm: shmem: don't truncate page if memory failure happens
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2021 at 7:28 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Nov 13, 2021 at 09:32:21PM -0800, Yang Shi wrote:
> > @@ -2466,7 +2467,18 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> >                       return -EPERM;
> >       }
> >
> > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (*pagep && PageHWPoison(*pagep)) {
> > +             unlock_page(*pagep);
> > +             put_page(*pagep);
> > +             ret = -EIO;
>
> You definitely need to add:
>
>                 *pagep = NULL;

Thanks, will do it.

>
> I'm not entirely convinced that you need the conditional on '*pagep'.
> If we returned 0, there had better be a page at pagep!

For SGP_WRITE, yes, it has a page at pagep if ret is 0, but
shmem_getpage() could return 0 with NULL page at pagep for SGP_READ.

In the other thread that Linus elaborated why this commit was reverted
and needed some rework, the discussion about not relying on
implementation detail for error handling taught me it may be not a
robust implementation to assume it is never NULL.

We might refactor shmem_getpage() code in the future to make sure when
it returns success there must be a valid pagep so that we just need to
care about the return value for error handling.

>
> I also think this would be clearer if written as:
>
>         if (PageHWPoison(*pagep)) {
>                 unlock_page(*pagep);
>                 put_page(*pagep);
>                 *pagep = NULL;
>                 return -EIO;
>         }
>
>         return 0;
>
> instead of re-using ret.  Sometimes that can make the code flow clearer,
> but here, I don't think it does.

Sure.

>
> > @@ -4168,9 +4201,12 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> >       error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
> >                                 gfp, NULL, NULL, NULL);
> >       if (error)
> > -             page = ERR_PTR(error);
> > -     else
> > -             unlock_page(page);
> > +             return ERR_PTR(error);
> > +
> > +     unlock_page(page);
> > +     if (PageHWPoison(page))
> > +             return ERR_PTR(-EIO);
>
> Do we need to put_page() the page in this error case?

Aha, yes. Sorry for missing this. I was fooled by shmem_pin_map() in
i915 driver which does put page, but I realized it just puts the valid
pages pinned *before* meeting error page by second look
.
>
