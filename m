Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CC83BAE95
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhGDTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 15:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhGDTHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 15:07:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD41C061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 12:04:49 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n14so28389675lfu.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB3iPjvsLmzaoRWILKBeqEhsvipX4wObhsZWf88uyy8=;
        b=Sm3IX5+2C7aHnIadADgPZjCpqw07tS7g18KL91fj6GX289o6lpGvmu4mOQiuanLJ7g
         mz+MTyQ1gPuk168IjXBPr9xLekkyOzzEy3IxpzwBxRPtXO29lukvWotEzmD0fnODCRD6
         w1GGbI0C/NuEdSu+9pjjamzxTVkluVG5+xCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB3iPjvsLmzaoRWILKBeqEhsvipX4wObhsZWf88uyy8=;
        b=DnphAGW53zN1vYauZqit90MZlivW7+Eh9XTZicaTwvddUoGJFbtCwhtOUJfQkCbRRX
         VvFYIW3BCt5v5L8O3RzFcMXSg5sItpN6UncNV5gBMjwSHybbsRTzr5tvk4RhpKpaZgcE
         ZUuvRlaMnMYpDQX3qZyLF9uuHdDbQxWhlQ8OFdlh5OAaFEL3/YsE1EOeqmfZCrvIFJqn
         8O4On32jxztg+ujYzXO9X4mumom6s2cbQiy595U1IjGTWgmRjPJ27mbmMvepeBLvd8lX
         m0QSyYKZP2N6EbO92ZKy1I+E6dTJt3g6kd3SszzNYFlNMoA33GnSYC2dk/dkXxYRU6Db
         H6HQ==
X-Gm-Message-State: AOAM532Vuo1S4TryXBKwQmNShvWYjNA4cGjcycGpWH8hRGnUC5zFce6B
        R8fXNK368w+FHSZvaXW+f2+7NtkQkOF0cQ7sI04=
X-Google-Smtp-Source: ABdhPJwVAQDgOt15Muwl+JMFUPhN1qB4U3um1rc9FpxIdUZdcH4UTxY1iJwX7vkFrRjSAU0EkT9SzA==
X-Received: by 2002:a05:6512:310e:: with SMTP id n14mr4920595lfb.358.1625425487385;
        Sun, 04 Jul 2021 12:04:47 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id e22sm232816ljb.61.2021.07.04.12.04.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 12:04:46 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c28so4949496lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 12:04:45 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr7491282lfc.201.1625425485251;
 Sun, 04 Jul 2021 12:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210704172948.GA1730187@roeck-us.net> <CAHk-=wheBFiejruhRqByt0ey1J8eU=ZUo9XBbm-ct8_xE_+B9A@mail.gmail.com>
 <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
In-Reply-To: <676ae33e-4e46-870f-5e22-462fc97959ed@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Jul 2021 12:04:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
Message-ID: <CAHk-=wj_AROgVZQ1=8mmYCXyu9JujGbNbxp+emGr5i3FagDayw@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: separate direction from flavour
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 4, 2021 at 11:54 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> No, I still see the same warning, with the same traceback. I did make sure
> that the code is executed by adding a printk in front of it.

And that printk() hits before the WARN_ON_ONCE() hits?

Funky. That sounds to me like something is then doing
set_fs(KERNEL_DS) again later, but it's also possible that I've been
dropped on my head a few too many times as a young child, and am
missing something completely obvious.

Can somebody put me out of my misery and say "Oh, Linus, please take
your meds - you're missing xyz..."

                 Linus
