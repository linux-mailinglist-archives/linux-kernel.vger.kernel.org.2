Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81D644F5A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 23:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhKMWdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 17:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhKMWc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 17:32:58 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D20C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 14:30:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id e3so16959335edu.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 14:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/8BrQDY4QMPS2nacboOjM/lCVglZ4d38pfjPWfMGuM=;
        b=hRjv9mmmDbyoeVA0CMPq5xGs+wSrdWBsg0EdyTC7L4UHamhN+U905uFl9m9eU7xE4V
         13854VR2dwJZXLtuUsGJglkXqe7TAY3ixO5TImJDWuQJpNizD68bzfAVDF5AWAao2wTD
         hVZshSaSZ+y31GFTuProMSv2mpvAgl95tNnLDbwqMifZS8luwe7WxFE0SuPpD7dIDXmv
         Zy0IlEXxWdIrGVywmeokT/mjF6RqIbg3tYoWsYl9vKKTcjYVCM1PUCwg/8uBVJby605l
         STMKw2kEh81zbOV7OlAwhWW6geZNJho8z8NDOHHkZLMaM/tldFppntaBYjkgEDkCGoWx
         Rp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/8BrQDY4QMPS2nacboOjM/lCVglZ4d38pfjPWfMGuM=;
        b=T3t7oHRX3bdcxcAlLRW9b4uCJWJgFiilYiV9thotnFx6sGMGl/IdLg2v6D8XW0frX3
         ltrJmvLQmjm/UC99U0D7q9cGrFxUg9viM1X6xjDg3QX2F4pshL/vfWsFbJ0u8GW2FWaB
         iUAlTgMX66bxLpk9Vnk94oddK9OEOzQhcvfHyOmhdTsSjdG4Tp7zUomy4C9QfUuSl70j
         Q9h7tli2ryEzOzI3bIBajxUjN75UVQ6+rbW7jQdVnt1hJU+U73aYfs9Y8vf4mQXvON6z
         YXw4HWD5ZIBuyhsxHEoxjwIFhsAaLlBrg5JM4MCus6bix1H0b32C6+5cFlrqTaw+8+Wy
         6xmQ==
X-Gm-Message-State: AOAM5309iEP1lnIgtDH8z98wGR5KbgbLoJWYy5MYUHOX0ifmsELHAc85
        3shLSDet0Xmy6NJ+pk8Q8sLDZJwZk/0v5bqJTC1v6vliXbg=
X-Google-Smtp-Source: ABdhPJyvx1/28UPunkTlxeYgNt5OytWgywAl/h+fgA7lZGzRxdW80lotD3MlVdRcykABhWG9zIukrCu8dBJ2egLaPf8=
X-Received: by 2002:a17:907:dab:: with SMTP id go43mr30941491ejc.537.1636842604012;
 Sat, 13 Nov 2021 14:30:04 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk> <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
 <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com> <CAHk-=wh2fa20a-qe+8q8no3_2MD-DokXvKNDhDC6qMJyCTvnPw@mail.gmail.com>
In-Reply-To: <CAHk-=wh2fa20a-qe+8q8no3_2MD-DokXvKNDhDC6qMJyCTvnPw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Sat, 13 Nov 2021 14:29:52 -0800
Message-ID: <CAHbLzkp_SGYbjK27-TPajxbKYJDCv==8Oj4TzP6MdTNoBtve0A@mail.gmail.com>
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

On Sat, Nov 13, 2021 at 12:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Nov 13, 2021 at 12:16 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Neither of the fixes were sent to me, and honestly, I think the real
> > issue is that the original commit is just too broken for words.
>
> Side note: the one you pointed to (by Ajay), had the comment that it
> could be done differently as an optimization.
>
> And I very much agree with that, although I think it would be a lot
> more than an optimization: just doing
>
>         if (error)
>                 return ERR_PTR(error);
>
> earlier in the function would have avoided the issue entirely, and
> would have made the code a lot easier to read too.
>
> But what made me decide to just revert it entirely was that the
> original commit that caused this all also had stuff like this:
>
> -       return shmem_getpage(inode, index, pagep, SGP_WRITE);
> +       ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
> +
> +       if (*pagep && PageHWPoison(*pagep)) {
> +               unlock_page(*pagep);
> +               put_page(*pagep);
> +               ret = -EIO;
> +       }
> +
> +       return ret;
>
> which is another example of exactly the same issue: ignoring errors,
> and then acting on other information and creating new errors.
>
> Again, that code should have checked and handled errors first, and
> then - if there wasn't an error - added that new HWpoison handling.
>
> So that just made me go "this is not worth fixing up, this just needs
> re-doing", and thus I just went for the revert instead.

I'm so sorry for the inconvenience.

The above snippet is actually ok since if *pagep returned via
shmem_getpage()'s parameter is not NULL, then ret is 0. When
shmem_getpage() returns error code, *pagep is NULL IIUC. So it
actually doesn't ignore errors then create and return new error.

But I do agree it seems tricky for someone who is not familiar with
shmem code. And if shmem code is changed in the future it may be error
prone. I could rewrite it to:

if (ret < 0)
    goto out;

 if (*pagep && PageHWPoison(*pagep)) {
               unlock_page(*pagep);
              put_page(*pagep);
              ret = -EIO;
}

out:
    return ret;

And fold in Ajay's fix (will take Muchun's version which returns error
earlier). Hopefully it still can make -rc1. Of course rc2 is fine
either.

>
>                    Linus
