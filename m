Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB5C3DCAE4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 11:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhHAJYn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Aug 2021 05:24:43 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39213 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhHAJYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 05:24:41 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MOhx9-1mWtUF2haB-00Q8gW for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021
 11:24:32 +0200
Received: by mail-wm1-f49.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso10013936wms.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 02:24:32 -0700 (PDT)
X-Gm-Message-State: AOAM531CZBj79FSTPL6irFMiiilUTodZKf/GLi+TARpPLiC0DbI2vtSf
        1kLA/MT6IDvjG13ARlNwiwl7nkig2p/SFNjz5C4=
X-Google-Smtp-Source: ABdhPJzm+d+GUJq55lf66fORA7zJHnwG96B/E2RUvkJawwTVMsCLwoBqiUjM0EJRl1uPz7IdzGuPR7PXCL0i1oa8StU=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr2673903wmq.43.1627809872298;
 Sun, 01 Aug 2021 02:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210801051627.78999-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210801051627.78999-1-xianting.tian@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 1 Aug 2021 11:24:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2_ip1zGMe=EeAA7Xpkvi8iQGWw6=0sGvLqv02Mj4LrmA@mail.gmail.com>
Message-ID: <CAK8P3a2_ip1zGMe=EeAA7Xpkvi8iQGWw6=0sGvLqv02Mj4LrmA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:n4+rvkXBd/PVKg1Ijf2fREdOms5QtVaA5VPpnY+9GgAsTJkSocD
 JTYni+qfirNeApEJ8geQkd9/iQyLudAhviTTEWcosvW+zSUP8abZUEn6evJRwpbZfNqnR2Y
 6imSe+9Twi8jG3/qV4Iay8shpihqtSI1BhvSu1DzvVH+bxNQmTejQLy6NzPAu4ZywiBvReq
 7qm/kFcEwA/M7qog3LGnA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g4N/qZKZTKE=:dqEOS15OX6WNtBCecGWzIb
 Q1pFI7wKSj/lIpm8Ja5Y/dZ1kntOgeXTWa/rsO2MMbUNW+VVnHZ/qCh53lFD2qTpxbzqojwSp
 2ytWIkyJ2ySjj8gzUVf/AnMpsbkW4nPjFj8xAlmSQmwone+y9cqRuNKRNd8T301sBd/O2r3Ji
 5SMtvDyqAORh/SJSQPa+PR1rr8WSJcOMZTXH955prKZUKE+oOBtmoT0hOLqf5F5BcO6zqGgjn
 ewLNCz8jkhkYemjqT2PcvQvRVSVO8qOU/R6Fem66B0AGMe5PY4NkMzHU4pJZ9kEBI513VyLh/
 9KEOP1RzSwE/OKLHuMjKNjDtuwXCuiwslDcRaSBNCW/yuzMDwgRVT7TZ1G/6gZ7KU6bs07nR6
 OsjrEBN3CufYXbfFVxdiPOFbFhT/qIGif5xIsOFdEJa+zfGJovN72M6QG41VXzouq+syFMlkb
 9swSjHcoPqONX34PuiGofuJlWbqM2DnidpAImJbyiFcTn8/Rtl50l2x3caue3Kw3SyeFIs9G3
 nOpqpE105qR7nqdqfubhKMcXUSKYQDF8AtXJis8XWmYLn+s9PDXSZalP31xa0jyRLYcliuuPr
 RVRHhaFFzNwSClf7+uByzesozZHBO6ER6WNnQ+aMcOC3VckytjwxdWQiKJDGIluAl1VqxTGhe
 3eW2VBfZqHVCPA+NWM5ghmhVtraJFJSU4l9ZegQHXXInTVf2pXGoMaP/XY4icrGghjVkENMax
 df5SAp5gIWqilzdNElMn1SUS6W6yEMMe5jjSMXIv1VoZk+lfix6jZI1Y2Cx7Kccl9gLiDuKg0
 DGkpuxQRzgVcYXAxWvlmcogtzPfwy4raOrSx92SL50qzyVQ28GnjW6xMN4ncFZR39+PcaQEa4
 ZQYSLZxoISTORp4+a3E9Ch9FrsEPTf1Dqjsbs9Zlep7a2v8B15m4+rEG/es6EtOewyv3DyApj
 Y140smnio5btiatnAh4URWpcxpBS9pcf3C/pu2P/wMieuIE77KXF0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021 at 7:16 AM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:

> Considering lock competition of hp->outbuf and the complicated logic in
> hvc_console_print(), I didn’t use hp->outbuf, just allocate additional
> memory(length N_OUTBUF) and append it to hp->outbuf.
> For the issue in hvc_poll_put_char(), I use a static char to replace
> the char in stack.

While this may work, it sounds rather obscure to me, I don't think
it's a good idea
to append the buffer at the back.

If you need a separate field besides hp->outbuf, I would make that part of the
structure itself, and give it the correct alignment constraints to ensure it is
in a cache line by itself. The size of this field is a compile-time
constant, so I
don't see a need to play tricks with pointer arithmetic.

I'm not sure about the locking either: Is it possible for two CPUs to enter
hvc_console_print() at the same time, or is there locking at a higher level
already? It would be good to document this in the structure definition next
to the field.

> @@ -878,6 +885,7 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
>         struct tty_struct *tty = driver->ttys[0];
>         struct hvc_struct *hp = tty->driver_data;
>         int n;
> +       static char ch = ch;
>
>         do {
>                 n = hp->ops->put_chars(hp->vtermno, &ch, 1);

This does not compile, and it's neither thread-safe nor dma safe if you get it
to build by renaming the variable.

        Arnd
