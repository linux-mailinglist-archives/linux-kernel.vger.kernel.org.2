Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B2C44F64D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 04:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhKNDNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 22:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbhKNDNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 22:13:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BA9C061746
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 19:10:42 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id r12so55042413edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2F7Q0/8HUDfOf3xlyKhCBtDnVOrxRnjR5LDyBDPovQ=;
        b=gf43TvW0tZqiIMYlXaM61JHO8QMFQaZG885oMn77nEnpLN6DsAGZSA2QwABlMRp2gI
         +sXpPQi13kcfCTZN9zHJU0v4V0QHnsH2Qb7InvdxUsQ1M6DaJavp3l+hJD6SI+hPCDi7
         TapgLMHOoV5S3JOhnCo+aScRERVgSwe4MO4Ozn7Kvd4z6KlGSiNTG+M+GvqQKzet5UHX
         /eusgz/JBBNsm/al3mIokGzcrkbYNuKyF1aRjMgR6RzRwySMFdP96H4Z0jnFepNQox5y
         23/N3g2LOAvGgkbE8vH/AHulNCoeU9/kCUTCn6Xw5/mGGyBIhPl4z4GkU/KAhnLp3tar
         +Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2F7Q0/8HUDfOf3xlyKhCBtDnVOrxRnjR5LDyBDPovQ=;
        b=DgIoQWqibhuTSJC0EtctuXOU9+Ms/Yd/FkSAyK0qtpiKnXKDpHXmULJZZsulUDFLFK
         dIExXi1dKvWp6IZaeaoUQj90xUKTdYsFx6wFxb0un0jK+v1vATFlAU8qEOIFed6fJtUe
         h0ucBHYiKqBnlBQa41jUVh6X/JQmzVK0CDwgV6HbGsyjYVeMxb6eRqkHw43NNTXuZB1f
         3lA6DwXH+GOLgNJn8lN+t8d5WVlIIFkq5/liJ4koYPdBKqPgjqEGlddOl70SeGJMkuWw
         lvIH6jupjZI/9n1VvOw7oMFHLKgu4KUxSxFKkdpJcWWN8dSy9k6Sa0ab1+5Uvb6RzvrS
         JiiQ==
X-Gm-Message-State: AOAM533XUNLEulKjhtLh0osz625ghSb2V/o/KM9w/7hsqCHbgbr7KKCa
        s2Kche9uNXeNzIYB1nWIsTKISSdJiXu8WTp2qyw=
X-Google-Smtp-Source: ABdhPJyA8C5dSjxUYjyiZqRfiAMNK4XF/oYMDNef/P58tgOFk+Rv3qUPYpepYz7d6n/V3uiS9SM6ueaYpELXo2HS5yo=
X-Received: by 2002:a17:907:1dd5:: with SMTP id og21mr36527409ejc.233.1636859440463;
 Sat, 13 Nov 2021 19:10:40 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk> <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
 <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
 <CAHk-=wh2fa20a-qe+8q8no3_2MD-DokXvKNDhDC6qMJyCTvnPw@mail.gmail.com>
 <CAHbLzkp_SGYbjK27-TPajxbKYJDCv==8Oj4TzP6MdTNoBtve0A@mail.gmail.com> <CAHk-=whEG9pOPmVEYw+_uruxgHZLh6ewc7MmZXGBWjuBOwFB+Q@mail.gmail.com>
In-Reply-To: <CAHk-=whEG9pOPmVEYw+_uruxgHZLh6ewc7MmZXGBWjuBOwFB+Q@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Sat, 13 Nov 2021 19:10:28 -0800
Message-ID: <CAHbLzkpSHTL=3ditbtS11sfhPe1GirK+eGML0=gidh2PcgzSgg@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 2:58 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Nov 13, 2021 at 2:30 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > The above snippet is actually ok since if *pagep returned via
> > shmem_getpage()'s parameter is not NULL, then ret is 0.
>
> That's a random implementation detail, and is not ok to rely on.
>
> It may or may not be true, and is not part of the rules of error handling.
>
> If a function returns an error, you shouldn't be looking at the other
> stuff it returned.
>
> Here's a very recent example of the same kind of problem:
>
>     https://lore.kernel.org/lkml/163663333331.414.639840290224641315.tip-bot2@tip-bot2/
>
> where people didn't actually look properly at the return value of the
> function, and instead looked at the page pointers that the function
> filled in.
>
> See? EXACT same logic. And completely buggy.

Yes, I agree it is too fragile to rely on.

>
> > When  shmem_getpage() returns error code, *pagep is NULL IIUC.
>
> No.
>
> When a function returns an error code, you check for the error code,
> and don't rely on weather the function then filled in other data (or
> left it alone, or whatever).
>
> So the code should
>
>  (a) check and handle error returns properly
>
>  (b) be legible
>
> That (b) basically means that if it's not entirely trivial (and none
> of this was entirely trivial), then when you get an error, you just
> deal with it right away. You return early, and undo anything you need
> to undo.
>
> You don't do "oh, let's keep that error, and then do something else
> that maybe also generates an error".
>
> That "don't handle the error directly" was why
> shmem_read_mapping_page_gfp() was buggy and would cause an oops.
>
> And while the shmem_write_begin() code migth not cause an oops, it had
> the same fundamental bad pattern.
>
> Error handling is where 99% of all problems occur. But that also means
> that you should do the obvious thing wrt error handling, and not have
> some crazy "if function X returned an error, it will have left the
> return array untouched" which may or may not be true.
>
> When a function returns an error code, you do error handling based on
> that code. Not on some random other state.

Thanks a lot for the thorough explanation. Preparing a new patch.

>
>                 Linus
