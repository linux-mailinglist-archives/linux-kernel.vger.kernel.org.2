Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AB43D75F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhG0NUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:20:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40589 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbhG0NTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:19:16 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M7sQ6-1mDKnR0XZK-0053Bl for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021
 15:19:15 +0200
Received: by mail-wr1-f41.google.com with SMTP id p5so10082339wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:19:14 -0700 (PDT)
X-Gm-Message-State: AOAM531Z7EUiU0TQGQrUecmcrok0DzxM7tXDXNV80oFr5d3eERQhnPgQ
        HpOO1l87V06FuHAYHtxuAgWNvRjvZzKxwyl/NBE=
X-Google-Smtp-Source: ABdhPJxSjFEFKBXvzBbAwzE3BP7gX5Ofvzrlecx6hytkypeX0c/MmtPXgXi1JiY9YwFd9jpsqplnmEB57dA6G5o6dNA=
X-Received: by 2002:adf:fd90:: with SMTP id d16mr1019269wrr.105.1627391954517;
 Tue, 27 Jul 2021 06:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Jul 2021 15:18:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
Message-ID: <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:fW0HIAarY8/5pkrHgnmFSbRh9fVNfWVz1vyisShk6N7fed82h/q
 Im8l3vkODkjQtBWnlDMciN9yrCS4GMzgcFwaReeJ7qLW/fegMlKRAbM5bMvCWAfl1G6wP1w
 Ft3j4/2QorisUqkQguN04LiVsHNySqlHyw72KfirFMDyTkvdorOq0NuSaR6sWPY/ERZYJKA
 IItknZalX+zPdSdsLJAIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hwKtD4Sl7YQ=:vhH3v1s4IBOGF9jeoo+jot
 WbIOmJGPxzdq43wlTJpJRUF/YhXdTSLZA70vUXmP2exzOGCqSOImxmqV3c0dAUpvPpDJqp+Ar
 jHT8Yiq2NoGWxgbRG42+Xm0VzCFXHwcxBBc1/cnmbTr3LszJfLVgG0NgDw4FV630StuJaAZek
 WrFYUco6Cpcec8dD44PSNr8SDVfuBV5K5r9gMZ+S+TJ8dwod+qMzWm+XKYvExn0cgNb+jeLAW
 XdRylw1NXs0oEMyRxca9E2SwX7+Cpl0eZ0A7t4KA5tjp0+mOy8a7BwTmLEYqzz0hlRN8gMDx4
 N9RLMIJLTzl3RHeRaGjSfmMtTzcWVP8KOdDTHkvdsaIqxPYfwhdO8iqEwgpUQVjlPWp9lzwF/
 a6i//GEax+qdpbx4oxZLkQe8JW/pszuI6/1ipTfMpj14FFCgzQLJMXmdQr7Qz599N+bcQ0qds
 84nr/b6ytMgKcmzbMwthq0m2fNKYfZoSzCPLL2r+JKGudO7M1Gxt2D+WJVGC+AXVSp/Bescac
 6ijL2MblxbBaQQLWmk1ZauXx3bpHaqyJe88IbNC6TwPRVu0XAIvL84/JQUVoztYVTvb9Vqq8w
 yT4b4fLhG3BrFnpdMSRuzXf4NFJYsQK9kYBTu/wuvTwZ5ty+ZjgLRyyPHU0MwQPa+pCOvJ0kk
 cNwzIz0oY1MkIRRjtncxejh93BE/EH5TVcLtRvapR91umGpuIqTRMsZ/ceP/GlpWfljvJA5gE
 xr5lmvI+WUwzVnlcIByHL2U5Bewf805oSh0ls5zt35XUZcz5Jpho4Qc9A4m0d0RRP6R5CIJUk
 KdGchLFoJUtpqrAXquVBNta/VT5HnNswZyoigbxDg8XrBbKfXSJOK3lee9oQSuMf6104OuscS
 n/urvYCtwkylkkz4xiVpJ391XGkiNtRWPeHQ8rou8WLFzOZoGAwoaM7/RH4D3hR7hpvBj3Zdw
 LWylqg9sx2+haJWVDfYhDxqu7+0R7HvTAKCx9ViBVZQQ5NMZs+zU2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 3:13 PM Xianting Tian
<xianting.tian@linux.alibaba.com> wrote:
> @@ -1127,13 +1128,18 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>         if (!port)
>                 return -EPIPE;
>
> -       data = kmemdup(buf, count, GFP_ATOMIC);
> -       if (!data)
> -               return -ENOMEM;
> +       if (is_vmalloc_addr(buf)) {
> +               data = kmemdup(buf, count, GFP_ATOMIC);

What about buffers in .data? If those are in a loadable module, I guess you have
the same problem as with vmalloc() and vmap().

is_vmalloc_or_module_addr() would take care of both, not sure if there are
other examples that don't work. In theory it could be ioremap(), kmap_atomic()
or fixmap as well, but those seem less likely to matter here.

        Arnd
