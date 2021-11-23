Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4612645998B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 02:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbhKWBSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 20:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 20:18:31 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:15:24 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id s9so13742568qvk.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9il6o1C53lVI46Iic479A44GN6K/KwqDAEYzeZGyl6E=;
        b=h3Ptld1YXyMbh0d00BmHeSrABj//RXZrl2K/vG614+n/M6mMDhbK5DOdeRM5DT4Igw
         hzWiN7qDi9Zw8ojrmJoa9y1dxYQVm0+ue/i8QKDMN+zd6VIgnLeAcxpp8efaQgf7NOFs
         BrAYqn4nZdhbv5V730BOS9+QpWp21xOiCdVFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9il6o1C53lVI46Iic479A44GN6K/KwqDAEYzeZGyl6E=;
        b=GzyHRAVfubsBPayanDrVaeY3g9A+V4zk3CEQysvDk/tHloCEgw3LXKbygomZDZaQPR
         yKL3ju/H2lDEchrMApjzNOn1lSmR7PW28iUcLjWzNP4+aXBQtIxvjHFvOey3Tfezyihj
         b3VH1oIy6S8NO7g/eE7BOT7w8q/bjgE+pXue2G0q2cm+sSMf+WZJHyL9ukOD/bdnwbwS
         R+GWnbyQE7E0Qu7sSl4yuTXz9LMcAtaaXnkBthrhKQEESzk+iUE+d9fGGEZ+nQQ4jTR4
         +ETtXX1DWdlgi04h30feEn+qAO68GDJOZCxmNltCnRCXsNdk2KWJoUxmGuxWxqJYwjT7
         hP7g==
X-Gm-Message-State: AOAM530sbtIVH0ybYAEhmb+Xe+gfCyHDff4p8160EG3cJC17UUqcrGW8
        /spCTzMI3837HaF8jdM6uz3ICckCTiUHj1ZYQJQ=
X-Google-Smtp-Source: ABdhPJzN0B1NOsm0XToHPzjaSasN30ufTi7ucPNvru3KUZ6j4ILxKqYt7MyjAZFFFSG0phf6w9y1WmYgmSFZYoF/i7o=
X-Received: by 2002:a05:6214:e41:: with SMTP id o1mr1637542qvc.43.1637630123057;
 Mon, 22 Nov 2021 17:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20211122230653.1779162-1-linux@roeck-us.net>
In-Reply-To: <20211122230653.1779162-1-linux@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 23 Nov 2021 01:15:11 +0000
Message-ID: <CACPK8XfM1e7b6m_QBhJFgXCXhqOajMKGUkWqRGxa5sCKyLxRQg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: ntfs: Disable NTFS_RW for PPC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2021 at 23:58, Guenter Roeck <linux@roeck-us.net> wrote:
>
> NTFS_RW code allocates page size dependent arrays on the stack. This
> results in build failures if the page size is 64k, which is now the
> default for PPC.

It became the default for PPC_BOOK3S_64, which doesn't include all of
PPC, in f22969a66041 ("powerpc/64s: Default to 64K pages for 64 bit
book3s").

You might want to add a mention of this commit in your commit message.

>
> fs/ntfs/aops.c: In function 'ntfs_write_mst_block':
> fs/ntfs/aops.c:1311:1: error:
>         the frame size of 2240 bytes is larger than 2048 bytes
>
> Increasing the maximum frame size for PPC just to silence this error does
> not really help. It would have to be set to a really large value for 256k
> pages. Such a large frame size could potentially result in stack overruns
> in this code and elsewhere and is therefore not desirable. Disable NTFS_RW
> for PPC instead.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Introduce new configuration flag DISABLE_NTFS_RW and use it to disable NTFS_RW
>     for PPC
>
>  fs/ntfs/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
> index 1667a7e590d8..324224febb6a 100644
> --- a/fs/ntfs/Kconfig
> +++ b/fs/ntfs/Kconfig
> @@ -49,8 +49,13 @@ config NTFS_DEBUG
>           When reporting bugs, please try to have available a full dump of
>           debugging messages while the misbehaviour was occurring.
>
> +config DISABLE_NTFS_RW
> +       bool
> +       default y if PPC

PPC_64K_PAGES would be more accurate.

I think arm64 was seeing a similar build error, so you could include
ARM64_64K_PAGES as well?

> +
>  config NTFS_RW
>         bool "NTFS write support"
> +       depends on !DISABLE_NTFS_RW
>         depends on NTFS_FS
>         help
>           This enables the partial, but safe, write support in the NTFS driver.
> --
> 2.33.0
>
