Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8C33266B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBZSHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhBZSHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:07:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3327A64F17;
        Fri, 26 Feb 2021 18:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614362821;
        bh=MsTenNoyOnWmOLDR4TgPo35YUl2jpUyfq4i4eUjVLSY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rh1bns5sUNNDacFR+rXol0byU633qLb3eJ3Fy/97VgbvaWXeP1X0Jbcgwdvc8LrG4
         c42fkje7HR81HJlf03QcNz45JISLidxUahvGTS86gtQvmmlBU8aU000OwRtcyScAIU
         f9ERBN0D/HrA/S0mjKWbHgM7l3qSz7ZMIC2O2dd6nTlP64d7zilQZZ3Qu6y66KDQnU
         i2teBVtXx0kdoULktpCNWZfd89/LJSnroftYnGgaEfP7pKLxaY/pEpEQDr055SxYjP
         Iz3HRLSvnxit637oMepDvYl+p0YF+iUB42doBLa2gvjtsiA5akdt8/QohTtV53Vh9g
         Qk14gwmJi+D2w==
Received: by mail-oi1-f177.google.com with SMTP id j1so10623639oiw.3;
        Fri, 26 Feb 2021 10:07:01 -0800 (PST)
X-Gm-Message-State: AOAM533CEkOq1J+isYDREutBBGn2CGE7MweNJPXUB4g3aIGaLgMnNGZl
        6x0D1ck0MUd5gnBZsEhTkBdB34PmXcvlF9PXmJg=
X-Google-Smtp-Source: ABdhPJyeZg3Pwe0jqw+NGo0qyDRNND7ksKo0FA7RNXG7z9WTLUgtfxlM+JIQEpOq+Q9tvDsGtU+39X1uraynmxH6nvs=
X-Received: by 2002:aca:4fd3:: with SMTP id d202mr2839613oib.11.1614362820512;
 Fri, 26 Feb 2021 10:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20210226140305.26356-1-nsaenzjulienne@suse.de>
 <20210226140305.26356-14-nsaenzjulienne@suse.de> <CAK8P3a1cDgSo7LTtBZpzBo3xu23_uDEux8=15Xyw6JTpXtGqhw@mail.gmail.com>
In-Reply-To: <CAK8P3a1cDgSo7LTtBZpzBo3xu23_uDEux8=15Xyw6JTpXtGqhw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 26 Feb 2021 19:06:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a03BcXZu+On885GaR547SHJYtiu3d_QHG0zOr2UiKn6qQ@mail.gmail.com>
Message-ID: <CAK8P3a03BcXZu+On885GaR547SHJYtiu3d_QHG0zOr2UiKn6qQ@mail.gmail.com>
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

On Fri, Feb 26, 2021 at 3:30 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Feb 26, 2021 at 3:03 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
>
> >         unsigned long flags;
> > -       spin_lock_irqsave(&instance->hba_lock, flags);
> > -       writel(le32_to_cpu(req_desc->u.low),
> > -               &instance->reg_set->inbound_low_queue_port);
> > -       writel(le32_to_cpu(req_desc->u.high),
> > -               &instance->reg_set->inbound_high_queue_port);
> > -       spin_unlock_irqrestore(&instance->hba_lock, flags);
>
> > +
> > +       if (dev_64bit_mmio_supported(&instance->pdev->dev)) {
> > +               writeq(req_data, &instance->reg_set->inbound_low_queue_port);
> > +       } else {
> > +               spin_lock_irqsave(&instance->hba_lock, flags);
> > +               lo_hi_writeq(req_data, &instance->reg_set->inbound_low_queue_port);
> > +               spin_unlock_irqrestore(&instance->hba_lock, flags);
> > +       }
>
> I see your patch changes the code to the lo_hi_writeq() accessor,
> and it also fixes the endianness bug (double byteswap on big-endian),
> but it does not fix the spinlock bug (writel on pci leaks out of the lock
> unless it's followed by a read).

On second look, it seems your patch breaks the byteorder logic,
rather than fixing it. It would seem better to leave it unchanged
then, or to send a separate rework of the endianness conversion if
you think it is wrong.

       Arnd
