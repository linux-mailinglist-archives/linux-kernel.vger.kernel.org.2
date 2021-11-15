Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCBB451D93
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345775AbhKPAbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345731AbhKOT3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 14:29:11 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54BC04647E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:00:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r11so12548566edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwLQHMmFmuP03jMUUSLt12XkSF61jo0RZ+1g/X4/n9M=;
        b=NBjTki6BTMMgzxBFuWfZdS2zYmMKk0DpcLFBLGVfks4AiXDnAfMLo23STs70WZRP5Y
         LuDqerTJfSMiYMX04ySgAZ4BMCttk8Vli/mr9cVJ5e/ZnRz6FiR5QfNBQMZuLqTx5WEA
         iwkb3jppnLBpR2IPue/rqUcJQGtFpEB+WRy0XNTtTGB3/dGOOUxRKMC6/Ki/TxKxlEgt
         BFQYEbe+ek87rWalVCm0ayMOvU/XJJsqXMzK4jUVixs+q0F/Qi+KdJt2T0d7nlREoErM
         wi2RUT3JAFhlvdnYtLsfRU0stkvBmeJ/OP0/68Rvc7QgEEmPFTnAlmyhe6w5HrhIHHVw
         Obxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwLQHMmFmuP03jMUUSLt12XkSF61jo0RZ+1g/X4/n9M=;
        b=IljyU6hUV74VPq3RAcociofdTr9SQmCPGfwVn4Jc/wJbgpne+74aEYMo9XGRK1MdFb
         tzoZhFmUDy2l76WnRKL9wBwdteKiUDkIo/jYOqcXl7ie36ZTTBmMXdnPT372iNrw9ico
         4CqFBt4/ImeKTCe70n303s/GTyNsxq6apFIZV5VEYlin2reon0Txz0eMPW+i407ia4dn
         LATZ7BnK9lTjXVu7z07GQoWvPIQPTIZbi8ELTaCkv484NSvmzDklPWwEtkx7goWuuwwV
         AHeDPE7lQOEE+/K/3QYGNix2PHJ7mHa6NrfALySku1+CEIqYzjPsUIX8QYrFeUQDwrND
         bG3g==
X-Gm-Message-State: AOAM5313xPfSUqpIVRZaCYPVJKuLY98jY/ZKIQE++uKpX3f6gtirON7Q
        ZI/YvFwBALUftrWiGDhrcuvy5Oq/aavUD+ouZlg=
X-Google-Smtp-Source: ABdhPJwpVxDVTuDP13LzNiAc04YtdxIig0Ri6JJdLgLNowjyvRFTNYpN1R+lp+3cR29YrKZdh5ZJ826u4VyrXCGvvd0=
X-Received: by 2002:a17:907:1dd5:: with SMTP id og21mr1569907ejc.233.1637002834857;
 Mon, 15 Nov 2021 11:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20211114053221.315753-1-shy828301@gmail.com> <YZErCLzSixIwTr6C@casper.infradead.org>
 <CAHbLzkoMycvjVO_438JKB-Z7vW3UNmDKxaA3Hpj-zYX7MKkc0g@mail.gmail.com>
In-Reply-To: <CAHbLzkoMycvjVO_438JKB-Z7vW3UNmDKxaA3Hpj-zYX7MKkc0g@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 15 Nov 2021 11:00:22 -0800
Message-ID: <CAHbLzkqi84Et_LGuLjv3E73zc-sFULw23vBoAUHsY+s5TW0ytg@mail.gmail.com>
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

On Sun, Nov 14, 2021 at 8:54 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Sun, Nov 14, 2021 at 7:28 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Nov 13, 2021 at 09:32:21PM -0800, Yang Shi wrote:
> > > @@ -2466,7 +2467,18 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
> > >                       return -EPERM;
> > >       }
> > >
> > > -     return shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > +     ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> > > +
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (*pagep && PageHWPoison(*pagep)) {
> > > +             unlock_page(*pagep);
> > > +             put_page(*pagep);
> > > +             ret = -EIO;
> >
> > You definitely need to add:
> >
> >                 *pagep = NULL;
>
> Thanks, will do it.
>
> >
> > I'm not entirely convinced that you need the conditional on '*pagep'.
> > If we returned 0, there had better be a page at pagep!
>
> For SGP_WRITE, yes, it has a page at pagep if ret is 0, but
> shmem_getpage() could return 0 with NULL page at pagep for SGP_READ.
>
> In the other thread that Linus elaborated why this commit was reverted
> and needed some rework, the discussion about not relying on
> implementation detail for error handling taught me it may be not a
> robust implementation to assume it is never NULL.
>
> We might refactor shmem_getpage() code in the future to make sure when
> it returns success there must be a valid pagep so that we just need to
> care about the return value for error handling.
>
> >
> > I also think this would be clearer if written as:
> >
> >         if (PageHWPoison(*pagep)) {
> >                 unlock_page(*pagep);
> >                 put_page(*pagep);
> >                 *pagep = NULL;
> >                 return -EIO;
> >         }
> >
> >         return 0;

By rethinking the code, I do prefer the above. "if (*pagep &&
PageHWPoison(*pagep))"  does give extra protection from NULL pointer
dereference for the future, but on the opposite side it seems
confusing to *not* have error handling for NULL page. I bet it may
incur more confusion than the protection for future, anyway it can't
be NULL if ret == 0 and !SGP_READ.

shmem_read_mapping_page_gfp() doesn't check page pointer either. IIUC
only SGP_READ case has NULL page pointer checked in shmem code, so I'd
like to follow the convention in this patch. If we think it is not
good, we could refactor the code (for example, guarantee page have
valid page as long as ret value is not error) in a perarate patch.

> >
> > instead of re-using ret.  Sometimes that can make the code flow clearer,
> > but here, I don't think it does.
>
> Sure.
>
> >
> > > @@ -4168,9 +4201,12 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> > >       error = shmem_getpage_gfp(inode, index, &page, SGP_CACHE,
> > >                                 gfp, NULL, NULL, NULL);
> > >       if (error)
> > > -             page = ERR_PTR(error);
> > > -     else
> > > -             unlock_page(page);
> > > +             return ERR_PTR(error);
> > > +
> > > +     unlock_page(page);
> > > +     if (PageHWPoison(page))
> > > +             return ERR_PTR(-EIO);
> >
> > Do we need to put_page() the page in this error case?
>
> Aha, yes. Sorry for missing this. I was fooled by shmem_pin_map() in
> i915 driver which does put page, but I realized it just puts the valid
> pages pinned *before* meeting error page by second look
> .
> >
