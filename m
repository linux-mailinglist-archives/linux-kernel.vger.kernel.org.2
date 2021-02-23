Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AB8322A46
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhBWMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:06:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:61678 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhBWMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:02:11 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 11NC0sDI000563
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 21:00:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 11NC0sDI000563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614081654;
        bh=HHpZZBZ0eHB97x5Y38pVRXFORux92t/c5GPZCk1W4fU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zHpSOlYwpPgrC0BM9ICiQkjRqR04ZiDiM8Cadlbh4h/uSAxaMxGxBbkRZe5OP28vY
         /iyL5Zi5Ji6qdD9D9hJF3U/OSvTrFDtxLAjxnjtGK10I1uG0tBiA1KkeAkxBNW5V28
         FVIPn/2G9u8pJPXTVkmfBEjYybmjtFo95nn7iIaeinZqCFdPZUSmGYvaPL0BqgMJ/m
         8wSULkh/e2wi4wKKmcLJFySH/800F3T0yDFkhFIFVd5hjYnSkCp5DIP3DWRkiLnjq/
         CZ0Oq4GzL7DU7xJCs4fCgqpAz9R5Smf4GiCh8dysYUhIPKvkHNn7qIm9PooFHqYHxG
         oKe9z30BnYO1Q==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id u11so9663319plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:00:54 -0800 (PST)
X-Gm-Message-State: AOAM533Sy54/ko4UttphAExEeWIWxFGe9Hj+FnhFLFvHlrj/RpGrf7Tx
        hy2kaYlEt094rY92Ef3U786tSaOjvQnosNPF5zc=
X-Google-Smtp-Source: ABdhPJwQTH2iisLDNeoXWZq2ZrnJNM5T34fixgBXn5qo1GR6nTZRY8NCMqpMt1M5d15s5Z1Drx6FjwQkToVEQFAEdXA=
X-Received: by 2002:a17:90a:bc8e:: with SMTP id x14mr14499923pjr.153.1614081653986;
 Tue, 23 Feb 2021 04:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20210222125428.4168247-1-geert@linux-m68k.org>
In-Reply-To: <20210222125428.4168247-1-geert@linux-m68k.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 Feb 2021 21:00:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQdmr8XjYQ9DBvRcQn0m1E7dHaAu7_JQcWMirqDPiobrQ@mail.gmail.com>
Message-ID: <CAK7LNAQdmr8XjYQ9DBvRcQn0m1E7dHaAu7_JQcWMirqDPiobrQ@mail.gmail.com>
Subject: Re: [PATCH] initramfs: Remove redundant dependency of RD_ZSTD on BLK_DEV_INITRD
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Terrell <terrelln@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 9:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Commit be1859bdc660213b ("initramfs: remove redundant dependency on
> BLK_DEV_INITRD") removed all redundant dependencies on BLK_DEV_INITRD,
> but the recent addition of zstd support introduced a new one.

This patch is trivial.
Applied to linux-kbuild. Thanks.


> Fixes: a30d8a39f0571425 ("usr: Add support for zstd compressed initramfs")

I changed this to 12-digit hash.


Documentation/process/submitting-patches.rst says:

please use the 'Fixes:' tag with the first 12 characters of
the SHA-1 ID, and the one line summary.





> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  usr/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/usr/Kconfig b/usr/Kconfig
> index 2599bc21c1b227ba..8bbcf699fe3bebec 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -103,7 +103,6 @@ config RD_LZ4
>  config RD_ZSTD
>         bool "Support initial ramdisk/ramfs compressed using ZSTD"
>         default y
> -       depends on BLK_DEV_INITRD
>         select DECOMPRESS_ZSTD
>         help
>           Support loading of a ZSTD encoded initial ramdisk or cpio buffer.
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
