Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3231032ED83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 15:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCEOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 09:54:49 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:34612 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCEOyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 09:54:35 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 125EsH5D016251
        for <linux-kernel@vger.kernel.org>; Fri, 5 Mar 2021 23:54:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 125EsH5D016251
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614956057;
        bh=Y3eO8EWBsprAXCVOP0wtSbCwwGc8HXwAuxVOJWhlFhw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VewaRL2UQVeQlwVOfZocQgoH4i4L7q2oSLIoucmOTjB8vuMbazzLfgVgdgsUW8heK
         WT+LqcnKBUzp9JwalVNcdou4IxfRUtPkYGEUFQr63nrZZbZrB+xJZmebZvowkfR2EP
         45F3I6NNR56i/Rf6iDuDoX1L292KVIygld8yhlFhCwbDTlsBFEZ5eIYM48LGdsIQ0y
         YU7JXI/e44QcpHkAKF7lwg/AmmDNVrajGdvCgwFGHmgyxYkO5lYsh5JYT1/dXW2nGX
         3EO3IsYxnh0KiFgWG4no4nCSHlSLEBgmzaYfqGDHldnj1s/CDaCUf2611h9bKA9mnx
         Kj9hLoR9M/P4g==
X-Nifty-SrcIP: [209.85.210.173]
Received: by mail-pf1-f173.google.com with SMTP id q20so2250422pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 06:54:17 -0800 (PST)
X-Gm-Message-State: AOAM531amV+oqTjeB2KNp9vSZH4jkTh7V6cNe6zGY5D4ZUANhF7OhOo8
        28a//GPuPKyCVHXqlqmtV0Lu7eoyIMeBDe62hl8=
X-Google-Smtp-Source: ABdhPJz++h2+eqJmmit6AmGDVv2uNnte75cj/7Ss1+ZRJALFK+77iLAKiMXN8HvkpG2uwain5BGmZYTAsowzdUjD2CE=
X-Received: by 2002:a63:dd49:: with SMTP id g9mr9232462pgj.175.1614956056481;
 Fri, 05 Mar 2021 06:54:16 -0800 (PST)
MIME-Version: 1.0
References: <20210301142834.345062-1-masahiroy@kernel.org> <CACRpkdZ8niLC8+LFs3+Wa79HCzYGSmKN4uLbkHsY_zk881nPQA@mail.gmail.com>
In-Reply-To: <CACRpkdZ8niLC8+LFs3+Wa79HCzYGSmKN4uLbkHsY_zk881nPQA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 5 Mar 2021 23:53:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASmu5EocRpQP5DLhkAz5ryHwHw24jO4w0au2tE+2jCo=w@mail.gmail.com>
Message-ID: <CAK7LNASmu5EocRpQP5DLhkAz5ryHwHw24jO4w0au2tE+2jCo=w@mail.gmail.com>
Subject: Re: [PATCH] ARM: syscalls: switch to generic syscalltbl.sh
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, patches@arm.linux.org.uk,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 7:04 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Mar 1, 2021 at 3:29 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > Many architectures duplicate similar shell scripts.
> >
> > This commit converts ARM to use scripts/syscalltbl.sh.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> This looks good to me to FWIW:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for the review.
This patch is already in Russell's patch tracker.

I manually copy/pasted your Ack:
https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=9068/1


> I'd like the arch maintainer Arnd Bergmann to take a look at it
> though, he's the authority of cross-arch code sharing.


Actually, I sent a big series to linux-arch a few months ago,
but did not get much feedback.
https://lore.kernel.org/linux-arch/20210128005110.2613902-1-masahiroy@kernel.org/

I picked up scripts to my kbuild tree, then sent out
the rest per-arch.

Anyway, a lot of patches are flying.
Comments are appreciated.



--
Best Regards
Masahiro Yamada
