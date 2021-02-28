Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0632B32749E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 22:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhB1Vcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 16:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhB1Vcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 16:32:52 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A5DC061756
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 13:32:27 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id s7so4593414qkg.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Feb 2021 13:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aunVI4XbR0G9DYsHcxUKTT3aCBcorXkHx677W1dByYQ=;
        b=Ordzh7YxUr4cuocV4xdAedPLH98GbRRa4pAAw4/6EiXcL17MwMvl43doQ3K8bbm5FS
         7ktz2GGUKM8Qy5kmSbv2spc44jGVjTimSm0xD/CeS+gj9V1hGu7Bv9j/N35MveBZZEUe
         +xKsGCitAAmK5B5q97Q16jN/lMSeKLYmgn9IEiBvL0/efSLeKmL615NzI7MOEHXaJpL9
         a+or3Jr/NsmapoeFX9hgNLEtwpWzXzG5RGhCsXIU/skhmBECDSErnorV5WYk87D+NYZA
         U/FWX+lo8cT2tbK33yGtVnT6XBm6yxoC5Q4vKB7X/WPiTZOlT19cSpnHOvbbfVR2t7Yf
         ysAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aunVI4XbR0G9DYsHcxUKTT3aCBcorXkHx677W1dByYQ=;
        b=pSY9QpCOcLJmo5x5AtHG3InQdnFEBS28cpk1K8qSOpxo6/7HHU59+hG5B+1TQGqEaE
         n4A+bMmUGnDZ+8+Tjjijrq8zoTr9+0Ba4ZxU6zF4dYkG7UZYCqPfX0WH69msQVs7nDKq
         PvCwyKGgwXJPk9z/yVlZELifvcl429YIR40YG08wHUY1NXoJV1DzIQETyMgG685+915z
         3ft9t2gYfGVGGogWYmWWKkIQB5V+9HRAsbTmmlZDghWL8ZarFQ4wONtqIyjkYxzJJu1c
         /oJbnKSpBB6XYkDfn7SmPHAQF86m+bmLE2qpCp1pruQXkgatlbbU7rz6DfJpSAyiw+uh
         wp6Q==
X-Gm-Message-State: AOAM531hpf9G0HUp+jA9uIp7NPN2iw5dZyDF4hdPztPubbptaeW7fWap
        HYfDWh07EoHmJGi4AHoe9fyqAzTxxmsgQw==
X-Google-Smtp-Source: ABdhPJy8saZyHvwyLwlKbN2hzTMESYCD1dmE0YnBoaOgeWosj1w0iHuZNmPlEUefElNM81KOP5Uwjw==
X-Received: by 2002:a05:620a:7:: with SMTP id j7mr12174990qki.161.1614547946248;
        Sun, 28 Feb 2021 13:32:26 -0800 (PST)
Received: from ubuntu-mate-laptop.localnet ([208.64.158.253])
        by smtp.gmail.com with ESMTPSA id p6sm11277551qkg.36.2021.02.28.13.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 13:32:25 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: firmware: efi: fix Kconfig dependency on CRYPTO
Date:   Sun, 28 Feb 2021 16:32:20 -0500
Message-ID: <1775911.au21gMaO99@ubuntu-mate-laptop>
In-Reply-To: <CAMj1kXGYUwttj4QYSaM-aqtThenXc3hds6VmfOTsQHApVKhjgQ@mail.gmail.com>
References: <20210227032949.31977-1-julianbraha@gmail.com> <CAMj1kXGYUwttj4QYSaM-aqtThenXc3hds6VmfOTsQHApVKhjgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 28, 2021 9:30:29 AM EST you wrote:
> On Sat, 27 Feb 2021 at 04:29, Julian Braha <julianbraha@gmail.com> wrote:
> >
> > When EFI_EMBEDDED_FIRMWARE is enabled, and CRYPTO is not enabled,
> > Kbuild gives the following warning:
> >
> > WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
> >   Depends on [n]: CRYPTO [=n]
> >   Selected by [y]:
> >   - EFI_EMBEDDED_FIRMWARE [=y] && EFI [=y]
> >
> > This is because EFI_EMBEDDED_FIRMWARE selects CRYPTO_LIB_SHA256
> > without selecting or depending on CRYPTO, despite CRYPTO_LIB_SHA256
> > depending on CRYPTO.
> >
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> 
> Could you try the below instead? CRYPTO_LIB_SHA256 should not depend
> on CRYPTO in the first place, we should fix that if we can
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index a367fcfeb5d4..77e6bc6df0ee 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -1936,9 +1936,10 @@ config CRYPTO_STATS
>  config CRYPTO_HASH_INFO
>         bool
> 
> -source "lib/crypto/Kconfig"
>  source "drivers/crypto/Kconfig"
>  source "crypto/asymmetric_keys/Kconfig"
>  source "certs/Kconfig"
> 
>  endif  # if CRYPTO
> +
> +source "lib/crypto/Kconfig"
> 
> 
> > ---
> >  drivers/firmware/efi/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> > index 2c3dac5ecb36..f914da9845ac 100644
> > --- a/drivers/firmware/efi/Kconfig
> > +++ b/drivers/firmware/efi/Kconfig
> > @@ -248,6 +248,7 @@ endmenu
> >  config EFI_EMBEDDED_FIRMWARE
> >         bool
> >         depends on EFI
> > +       select CRYPTO
> >         select CRYPTO_LIB_SHA256
> >
> >  config UEFI_CPER
> > --
> > 2.27.0
> >
> 

Hi Ard, this solution works fine, and doesn't seem to introduce 
any new issues with unmet dependencies.

- Julian Braha



