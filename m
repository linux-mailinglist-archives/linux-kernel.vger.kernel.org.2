Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9344F5AC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 23:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhKMXB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 18:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhKMXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 18:01:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB70EC061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 14:58:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b15so53292428edd.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LEuGHgv8xqOKZW64ode+/vIb5U7iTdOdXwRrwQBNLu4=;
        b=XkNBzfN4fLGPsauuvfdIlysef4k2lXPjy/brVO3fQbIUkP4un5NBNuJbYRg+jTD39F
         Fa536miQLexXz4qYGv/+wUPcCm6GoksWxHM9XB4iT85385bzP6gvIXODjl0BQAhW/B+L
         TKzWHwI0YFNCHzXLzbJMul6gXWx7lWoYG9tMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LEuGHgv8xqOKZW64ode+/vIb5U7iTdOdXwRrwQBNLu4=;
        b=a2k+rhiN7BtHzcIe7/ZFbcDoshB4xv9fHi+1qiAJCYRKNDzfMEzPpp7jg0jRYcJ6u7
         MaPPcbUP7Vjj3b+YVnKaVjkw8aKS8dL5SvBJ4r0XtoCdptPufOymDFiKEeTwlBWhIgWf
         g4GiBxJPLNSjfkVMPJBGkj0VMlNm+v8WuSj0ckS3rvfA0C/BeJwlKKQNCoqNlDAcfH5V
         /37lhM4uaJXKIzQ2w0IxKog+77vxUzJBhNMWY1MbygCL7UQ2r59liUrwlxIvHW57LdBm
         8v9Spw4EWTai4l6ktwhxxxUd+mv+IJZ1urupV4qB9usm1HMgQ6Y40yDtH4JKetqDvi0V
         MfqQ==
X-Gm-Message-State: AOAM531kY7aNxhLtrbpwSjPA95oTHVAPXct3p2PRhKPjr29ClOIo6HYy
        qjuhHeHpJpUaH2W8qpEfzpMo6mrCCtKkvL+qJ4o=
X-Google-Smtp-Source: ABdhPJxllkZ9bOZvX65ECqtzm6kQD/ywG595jVuYWdE7BuYNMxPew2jaI9TCtRiUFciFaCfLV1I+WQ==
X-Received: by 2002:a05:6402:339:: with SMTP id q25mr3797892edw.251.1636844311553;
        Sat, 13 Nov 2021 14:58:31 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id u16sm4946767edr.43.2021.11.13.14.58.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Nov 2021 14:58:30 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id t30so22356759wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 14:58:30 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr32224185wrm.229.1636844310120;
 Sat, 13 Nov 2021 14:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20211111084617.6746-1-ajaygargnsit@gmail.com> <CAHP4M8V2WEQ0LgHp7PHdBMYFp+_frn=7GLQVF7=faqapojQ+2g@mail.gmail.com>
 <628a49dc-f6f7-5aa4-8a4d-4f2ed19b7f3f@kernel.dk> <e87601bd-21c4-00b0-9500-054bca8abced@kernel.dk>
 <CAHk-=wjgZVY-skWP1vW2Cw+His+3eESATM_+QDYp=wFEsVv=qw@mail.gmail.com>
 <CAHk-=wh2fa20a-qe+8q8no3_2MD-DokXvKNDhDC6qMJyCTvnPw@mail.gmail.com> <CAHbLzkp_SGYbjK27-TPajxbKYJDCv==8Oj4TzP6MdTNoBtve0A@mail.gmail.com>
In-Reply-To: <CAHbLzkp_SGYbjK27-TPajxbKYJDCv==8Oj4TzP6MdTNoBtve0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Nov 2021 14:58:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEG9pOPmVEYw+_uruxgHZLh6ewc7MmZXGBWjuBOwFB+Q@mail.gmail.com>
Message-ID: <CAHk-=whEG9pOPmVEYw+_uruxgHZLh6ewc7MmZXGBWjuBOwFB+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: do not call PageHWPoison on a ERR-page
To:     Yang Shi <shy828301@gmail.com>
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

On Sat, Nov 13, 2021 at 2:30 PM Yang Shi <shy828301@gmail.com> wrote:
>
> The above snippet is actually ok since if *pagep returned via
> shmem_getpage()'s parameter is not NULL, then ret is 0.

That's a random implementation detail, and is not ok to rely on.

It may or may not be true, and is not part of the rules of error handling.

If a function returns an error, you shouldn't be looking at the other
stuff it returned.

Here's a very recent example of the same kind of problem:

    https://lore.kernel.org/lkml/163663333331.414.639840290224641315.tip-bot2@tip-bot2/

where people didn't actually look properly at the return value of the
function, and instead looked at the page pointers that the function
filled in.

See? EXACT same logic. And completely buggy.

> When  shmem_getpage() returns error code, *pagep is NULL IIUC.

No.

When a function returns an error code, you check for the error code,
and don't rely on weather the function then filled in other data (or
left it alone, or whatever).

So the code should

 (a) check and handle error returns properly

 (b) be legible

That (b) basically means that if it's not entirely trivial (and none
of this was entirely trivial), then when you get an error, you just
deal with it right away. You return early, and undo anything you need
to undo.

You don't do "oh, let's keep that error, and then do something else
that maybe also generates an error".

That "don't handle the error directly" was why
shmem_read_mapping_page_gfp() was buggy and would cause an oops.

And while the shmem_write_begin() code migth not cause an oops, it had
the same fundamental bad pattern.

Error handling is where 99% of all problems occur. But that also means
that you should do the obvious thing wrt error handling, and not have
some crazy "if function X returned an error, it will have left the
return array untouched" which may or may not be true.

When a function returns an error code, you do error handling based on
that code. Not on some random other state.

                Linus
