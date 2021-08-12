Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEAE3EA1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhHLJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhHLJOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:14:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABBC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:14:12 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qk33so10142042ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvGkITJdrDMMMnI3/BWEDQrqzv4MiM8BZMPQ8cJaAog=;
        b=rBbpOT+Hrt+gcKzfmeSjx7vcqlbNcSr1NbtfctFuMvVzEfGUxdiHXa6sFk7nNq1vO2
         bzWcIpHco2B0tq3kcAc0abkg/pHcsqo4LRdnuQz2Q/OwKXSHBHrfPD27h6Ms9cRUA73G
         0GfgKieqcxyGEibwt+V5fRVvqWdfBDtUE4rKLeezgrN7yVEvlHcdv0Fo+QMumMNFh+3C
         YKJRy5jdQLem9WrPZPZow83FeLbdjdhOBPdySr5pgaLUnhLTLiD+K+EY8BTbP0ita/tO
         Ze17Aicy6ncNlYdcqFmfImU7BTCMgsoyuCwmgKJn9P7o/uqoAe6fC4Wy45wOpG0vrLZ2
         WM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvGkITJdrDMMMnI3/BWEDQrqzv4MiM8BZMPQ8cJaAog=;
        b=Hy9NeCEND4bLUgvXOs0GU6NZCbW9ZMyLw+4HYAM/T6V5u6t0dGD3lfbdGQdY7n77cX
         vUaCbBJ6EQFMACA7TJtYvR25YWyLbvDrb1WFw5OM0EFw59XiA4BABon1vZOzMYjeA5nn
         7pNcTLM8XjLmw5sfscwafCDEPVg6mDrqgoOjfyc10tlCm8nkWUw0qcW5JQtG9Igw5GL/
         ouuNPPokC6uoBJHefgG/v3toCF1zDOXpA/tJjOSKoH8aTp66dH5FlewvW7Ck8OnC42Vy
         gYXuRMvcMnGYSBJGtXIByfhMNRqzN9zalGTJDBmjM1fRzG5vZcbrHia0XTOnPUk4G2MT
         RwXg==
X-Gm-Message-State: AOAM531qFNcRCX36QDRqgBCI8C4szzF3OYx7t/IdWJm4XkZsNlG4aqYX
        zZ+j4Wa1NvnG2AXPSZSScqKYL3E2esGM2v9KHN4=
X-Google-Smtp-Source: ABdhPJyyqs7nY59vyUINOn7gF0lJ/tMsmOkfem1kM5zxVAqauTLN1o6Lq/jhKEVu34AnDzHL6PrL66558CYQZPt29eE=
X-Received: by 2002:a17:906:9bf1:: with SMTP id de49mr2737284ejc.480.1628759651282;
 Thu, 12 Aug 2021 02:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <YRO5R0/N9KITjyY9@kroah.com> <20210812041930.28931-1-21cnbao@gmail.com>
 <YRTMuU4dE9RqyDC+@kroah.com>
In-Reply-To: <YRTMuU4dE9RqyDC+@kroah.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Thu, 12 Aug 2021 21:13:59 +1200
Message-ID: <CAGsJ_4xpidX79zO2LRxtUu-jBpa3F1Wra-41ZoaczrTv-A1QDA@mail.gmail.com>
Subject: Re: [PATCH] platform-msi: Add ABI to show msi_irqs of platform devices
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com,
        rafael@kernel.org, robin.murphy@arm.com,
        song.bao.hua@hisilicon.com, wangzhou1@hisilicon.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 7:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 12, 2021 at 04:19:30PM +1200, Barry Song wrote:
> > > But why isn't this all handled by the MSI core code?  Why would each bus
> > > need to have this logic in it?
> >
> > i think i can extract some common code for sysfs populate/destroy to msi core from pci and platform.
> > but we still need some pci/platform specific code in pci-msi and platform-msi cores. for example,
> > pci-msi has specific data which will be accessed in its show() entry.
> >
> > struct msi_desc {
> >         ...
> >         union {
> >                 /* PCI MSI/X specific data */
> >                 struct {
> >                         u32 masked;
> >                         struct {
> >                                 u8      is_msix         : 1;
> >                                 u8      multiple        : 3;
> >                                 u8      multi_cap       : 3;
> >                                 u8      maskbit         : 1;
> >                                 u8      is_64           : 1;
> >                                 u8      is_virtual      : 1;
> >                                 u16     entry_nr;
> >                                 unsigned default_irq;
> >                         } msi_attrib;
> >                         union {
> >                                 u8      mask_pos;
> >                                 void __iomem *mask_base;
> >                         };
> >                 };
> >
> >                 ...
> >                 struct platform_msi_desc platform;
> >                 ...
> >         };
> > };
> >
> > in addition, they are quite different in initialization/release and also need different places to save sysfs groups.
> > so probably i can let msi cores provide msi_populate_sysfs() and msi_destroy_sysfs() APIs. And ask pci and platform
> > to call msi_populate_sysfs() in their init code and save the groups in their specific pointers,  and then they can
> > free sysfs in their release paths by calling msi_destroy_sysfs()
>
> Ok, if this isn't easy then I guess it's not a big deal, but you should
> go through the MSI developers first.
>
> Why does a platform device have MSI interrupts?  I thought they were
> only for PCI devices.

I really don't know the story of hardware, but as long as a device can
write some mmio address with some
messages (interrupt-describing data) to generate interrupts instead of
using a hardware interrupt line, MSI is
supported :-)

>
> thanks,
>
> greg k-h

Thanks
Barry
