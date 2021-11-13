Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2FC44F543
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 21:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbhKMU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 15:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhKMU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 15:26:42 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F314C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:23:49 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so52755698edd.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=178hx9F5MIkKas8jxF7m2J6CCeDHC5D9gwDjuYnUjsU=;
        b=Dg6Nx3R+R0mIAvyO7OOrykmw6ojUJn1COLGmLMGOqfzuxo7DEHwN+Z+leZ0NszG0nc
         o+lyomDhJPq4T54+0Qzg3Yt1XLCru+KlaARRjB0kC5SKc/ISrLy23TOipzmc3sXIskl+
         5vNIODFl76GCD3exQLRf3DEXpiy7qa0vu7d7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=178hx9F5MIkKas8jxF7m2J6CCeDHC5D9gwDjuYnUjsU=;
        b=eu3i55DTq05VEwOfgWeFZbLBKL+TRB0nrjRLzA21Ln4GdiLHQ09ZIA5OARWTeTsfdO
         /xwGjls/ytFF72HVWU9O2mbh+pird+Xzalw99nbIsZfnLdbJh5ylQbxT79RQrJMd6tSt
         7oaMULJLRk9h34jNEUoWEM9km3ZEzVwxuawEKwjdMb1W2dGBWPk9ueBKKTEGNkqdf40p
         Qq+3Q9bNo/GHNJ1vSMDSb1g2BiRoj8/qZlXcxJahObNHZ1+sWfltCpxjojVm9UN+cwRB
         5XCbP26gXHt0huv7eEr6Iz/xaWTfHzVGp7EyeB/BJTueQHB4VMylRsWiQJU44hx/MwPm
         T84A==
X-Gm-Message-State: AOAM531YYEXaZI9s0fvAU6xnJYGrgDwguPD5vOvlu1J/KXWDsnbIoSXt
        gYYjDWIJtDUZcV04nwyXJo0EtrNZ+UUGC2XRmR0=
X-Google-Smtp-Source: ABdhPJxWFLLvR+n2voENR3/6hbXJFPGHq7vGr1aurhJPW6/hEeHbsAn7MjHpwdf0CwUsgnAHFMn0/Q==
X-Received: by 2002:a17:906:c301:: with SMTP id s1mr32001404ejz.56.1636835027841;
        Sat, 13 Nov 2021 12:23:47 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id u14sm4869737edj.74.2021.11.13.12.23.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 12:23:47 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id p18so1188790wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:23:47 -0800 (PST)
X-Received: by 2002:a05:600c:4e07:: with SMTP id b7mr42940110wmq.8.1636835026807;
 Sat, 13 Nov 2021 12:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk> <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
 <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
In-Reply-To: <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 12:23:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2fa20a-qe+8q8no3_2MD-DokXvKNDhDC6qMJyCTvnPw@mail.gmail.com>
Message-ID: <CAHk-=wh2fa20a-qe+8q8no3_2MD-DokXvKNDhDC6qMJyCTvnPw@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Yang Shi <shy828301@gmail.com>
Cc:     Ajay Garg <ajaygargnsit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 13, 2021 at 12:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Neither of the fixes were sent to me, and honestly, I think the real
> issue is that the original commit is just too broken for words.

Side note: the one you pointed to (by Ajay), had the comment that it
could be done differently as an optimization.

And I very much agree with that, although I think it would be a lot
more than an optimization: just doing

        if (error)
                return ERR_PTR(error);

earlier in the function would have avoided the issue entirely, and
would have made the code a lot easier to read too.

But what made me decide to just revert it entirely was that the
original commit that caused this all also had stuff like this:

-       return shmem_getpage(inode, index, pagep, SGP_WRITE);
+       ret = shmem_getpage(inode, index, pagep, SGP_WRITE);
+
+       if (*pagep && PageHWPoison(*pagep)) {
+               unlock_page(*pagep);
+               put_page(*pagep);
+               ret = -EIO;
+       }
+
+       return ret;

which is another example of exactly the same issue: ignoring errors,
and then acting on other information and creating new errors.

Again, that code should have checked and handled errors first, and
then - if there wasn't an error - added that new HWpoison handling.

So that just made me go "this is not worth fixing up, this just needs
re-doing", and thus I just went for the revert instead.

                   Linus
