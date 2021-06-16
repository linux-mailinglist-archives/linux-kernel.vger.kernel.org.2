Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D660A3A9423
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbhFPHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 03:37:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57745 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhFPHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 03:37:41 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <dimitri.ledkov@canonical.com>)
        id 1ltQ5H-0006NJ-Cs
        for linux-kernel@vger.kernel.org; Wed, 16 Jun 2021 07:35:35 +0000
Received: by mail-io1-f72.google.com with SMTP id e23-20020a6bf1170000b02904d7ff72e203so1334297iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 00:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zCv5taiiINLmRcYNh2cZYkv+GwtyeEEw74jPnQvzmFU=;
        b=Ju7BNmEKOhHFLrko8s6lsEOgHyZC7F0yNNvdaBDzXfKxh+ka//JhMrKK91unuVKHj+
         3N7mqYMynjXuUNPILz0SLSYYWp53/xeXrlnuMgxqaeniaD8myFnxAEjwabaXHj6i4d6v
         7n6T4CPNrwsc/4r3aQ1w/JUB9HG2s2FvTg4y7R08IOWEHsybYTPqTbcNXMOYPTG7YMXU
         mhyOwmCgtNgyOikQWvLJOkjKwDLQubRZFQoF8MqiQgY4rwL13BnLHaFpNfoHWwJ4gzkZ
         efJZlD9Rr9IHU8jFWumbOk9x5IAxr1LDipKfqTF0P0QnvU07dAu/C+oQW9aAMAeoCTb/
         /H8Q==
X-Gm-Message-State: AOAM532L3T737L49IjhCygtP+Dgn8c6/UFj3MzKpY8rHZPlDoG3U+jci
        OFCb2KnDTxYrhWQgAHyBvTr1pbGHTEc5/p26w2i7FKUDoL5sXhFMzwR9j3OVP9gnZU6dPRc74ul
        LM2//u9lvqIVkPdgcUK5koWhRJ6YJQpStIncXywBeRZ+vAmDl8eaa7/FWxQ==
X-Received: by 2002:a92:c56d:: with SMTP id b13mr2674027ilj.267.1623828934478;
        Wed, 16 Jun 2021 00:35:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB1U7wvq70SAIs/4TJahvYTzi6Pv8ottxiN303trgIWIeqOrOrGUa+AYp4lGxZ63sSiaLyusOLQ9YEYVWoDJ4=
X-Received: by 2002:a92:c56d:: with SMTP id b13mr2674013ilj.267.1623828934257;
 Wed, 16 Jun 2021 00:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210615114150.325080-1-dimitri.ledkov@canonical.com> <your-ad-here.call-01623799196-ext-1245@work.hours>
In-Reply-To: <your-ad-here.call-01623799196-ext-1245@work.hours>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Wed, 16 Jun 2021 08:34:58 +0100
Message-ID: <CADWks+bB2YsATLMaPvhtu6MoFsveKYd5cY6GxepeX7OZvto-Ew@mail.gmail.com>
Subject: Re: [PATCH] s390/boot: add zstd support
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:20 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> On Tue, Jun 15, 2021 at 12:41:50PM +0100, Dimitri John Ledkov wrote:
> > Enable ztsd support in s390/boot, to enable booting with zstd
> > compressed kernel when configured with CONFIG_KERNEL_ZSTD=y.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1931725
> > Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> > cc: Heiko Carstens <hca@linux.ibm.com>
> > cc: Vasily Gorbik <gor@linux.ibm.com>
> > cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > cc: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/Kconfig                        | 1 +
> >  arch/s390/boot/compressed/Makefile       | 4 ++++
> >  arch/s390/boot/compressed/decompressor.c | 4 ++++
> >  3 files changed, 9 insertions(+)
>
> Reviewing your patch I noticed that we use wrong condition to
> define BOOT_HEAP_SIZE. So I made a tiny fix:
>
> diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
> index 3061b11c4d27..cf2571050c68 100644
> --- a/arch/s390/boot/compressed/decompressor.c
> +++ b/arch/s390/boot/compressed/decompressor.c
> @@ -29,5 +29,5 @@ extern unsigned char _compressed_start[];
>  extern unsigned char _compressed_end[];
>
> -#ifdef CONFIG_HAVE_KERNEL_BZIP2
> +#ifdef CONFIG_KERNEL_BZIP2
>  #define BOOT_HEAP_SIZE 0x400000
>  #else
>

Nice. I guess it means all kernels were always built with large
HEAP_SIZE, and that's why my boot tests worked too.

Note this bug is also present in arch/sh/boot/compressed/misc.c.


> And applied your patch with the following changes:
> Added to the commit message:
> """
> BOOT_HEAP_SIZE is defined to 0x30000 in this case. Actual decompressor
> memory usage with allyesconfig is currently 0x26150.
> """
>

That's appropriate.

> diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
> index cf2571050c68..37a4a8d33c6c 100644
> --- a/arch/s390/boot/compressed/decompressor.c
> +++ b/arch/s390/boot/compressed/decompressor.c
> @@ -31,4 +31,6 @@ extern unsigned char _compressed_end[];
>  #ifdef CONFIG_KERNEL_BZIP2
>  #define BOOT_HEAP_SIZE 0x400000
> +#elif CONFIG_KERNEL_ZSTD
> +#define BOOT_HEAP_SIZE 0x30000
>  #else
>  #define BOOT_HEAP_SIZE 0x10000
>
> I hope you are ok with that, thanks!

Thank you!

-- 
Regards,

Dimitri.
