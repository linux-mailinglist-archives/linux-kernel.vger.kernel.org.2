Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC7E32641B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 15:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBZObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 09:31:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhBZObn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 09:31:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 617C764E28;
        Fri, 26 Feb 2021 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614349862;
        bh=eoydl7NT3rcKH12ao6zDbuGLyabBFk8cBHZyvngNOrw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sn/yLAhnuXIyB1Ggx9lTL9E7Gt7Djf2QeNIU43xFL0DUVSBqxzltkTU5mmtZSKu6m
         xZuPtJT3z80smSDzXNqL4t3P/4QFI6zQM2NsgfHcL4t5QRoAEIHlyr9OR3NrxGu4Xt
         BIwboBd4HEdBnJHMAmD9RW0PzyGA007B1e5pi83kSd9+NkoSfXw5wTYN5f+i+PlKQv
         NFu1EckYqri+ApMOHfSHSoOaNjbQvr0iphNEnhzF2j7fdvKeRc/85h4fF02PN16qAO
         S2UQ3ZEYPyTPRpW8mi8y5XjXuOUnofa9z3PEVDO6U5ZYDi4TAkwsXqkVFpJ0zkK4/X
         0MZ/5BIFldbFg==
Received: by mail-oi1-f176.google.com with SMTP id w69so9925231oif.1;
        Fri, 26 Feb 2021 06:31:02 -0800 (PST)
X-Gm-Message-State: AOAM532Id7JupUsJ2wZ8RZ2iXOFbauMRflxzXLDpr7sI5woGIFeSho/8
        Gsuv1OSLo4i7+s+PG5I231jxRJLZx4HE2/eFOI8=
X-Google-Smtp-Source: ABdhPJzAoQODal78eaIbnT8IbU2I8GkjHWnZ7JkEFMA0NJD1umk/XL8soULbUrEdDAwQn5q2ddm6oulE93HipGh5rE4=
X-Received: by 2002:aca:4a47:: with SMTP id x68mr2082122oia.67.1614349861556;
 Fri, 26 Feb 2021 06:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20210226140305.26356-1-nsaenzjulienne@suse.de> <20210226140305.26356-14-nsaenzjulienne@suse.de>
In-Reply-To: <20210226140305.26356-14-nsaenzjulienne@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 15:30:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cDgSo7LTtBZpzBo3xu23_uDEux8=15Xyw6JTpXtGqhw@mail.gmail.com>
Message-ID: <CAK8P3a1cDgSo7LTtBZpzBo3xu23_uDEux8=15Xyw6JTpXtGqhw@mail.gmail.com>
Subject: Re: [RFC 13/13] scsi: megaraid: Make use of dev_64bit_mmio_supported()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 3:03 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:

>         unsigned long flags;
> -       spin_lock_irqsave(&instance->hba_lock, flags);
> -       writel(le32_to_cpu(req_desc->u.low),
> -               &instance->reg_set->inbound_low_queue_port);
> -       writel(le32_to_cpu(req_desc->u.high),
> -               &instance->reg_set->inbound_high_queue_port);
> -       spin_unlock_irqrestore(&instance->hba_lock, flags);

> +
> +       if (dev_64bit_mmio_supported(&instance->pdev->dev)) {
> +               writeq(req_data, &instance->reg_set->inbound_low_queue_port);
> +       } else {
> +               spin_lock_irqsave(&instance->hba_lock, flags);
> +               lo_hi_writeq(req_data, &instance->reg_set->inbound_low_queue_port);
> +               spin_unlock_irqrestore(&instance->hba_lock, flags);
> +       }

I see your patch changes the code to the lo_hi_writeq() accessor,
and it also fixes the endianness bug (double byteswap on big-endian),
but it does not fix the spinlock bug (writel on pci leaks out of the lock
unless it's followed by a read).

I'd suggest splitting the bugfix from the cleanup here, and fixing both
of the bugs while you're at it.

      Arnd
