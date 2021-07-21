Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDB3D07E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhGUEG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 00:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhGUEE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 00:04:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D13C061768
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 21:44:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v1so748304edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 21:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oh691P4XIOtEoan62ZZ+cq3fvRkvPOeVqxSBdHspTI=;
        b=kUnendCkudBP7K6LuHAlKTUl85jzu9F9KbdcQU0V1gQeWmVovU0wHd1i5UlGIQ82/Q
         9uAn4+AryrDc14KMrkcoD+mS4LDf3JHLvmNCrC3tEffX07LQN6PROL6tfeGZ+ASdJLe4
         zttpSP44Um622vwltczxIIiBEJM+AM7wjLWMyl5/iAXuf+/LBAs4QrPFS1sOwG8u/vVu
         F8gaPek5W2nGahv23TPYswGL8uX28u4U1ms8jY74aG0AjtjsjY2YUgR6tUn9U4DZzZHT
         Qnxar68+sABbBCYvGO+FyqTJwQz6pebLqliXerjzTjLvFHSgKw2V6q+ljR/HnZ1ln8+X
         2byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oh691P4XIOtEoan62ZZ+cq3fvRkvPOeVqxSBdHspTI=;
        b=m/W7Zgy2pxJ22Mg2rpvxKTYofhwX5YQVZ+wqsCami7c75augvkzMoYWluD6uMPhzzm
         AWiHeA1jJz90LKVrBD02uYsJG99ilGWjQSKzDDantJvfi6zWLf5i2jzPrhzLZ05ArtJu
         n/DyrJEqohYVEskwtAgQ6TGHT19a9NCGS62cP1iOJIDCNNZerDnk6+k6AXzsIhmltFzx
         NQ5ECNwLhL/T82Ew2XjpEfYE18J9IPtplpvQ3CEfDXe1eK+R/bSRMm6HKpMAHvfBfR1k
         0KfdcUvEH/FJrnzESiytqOnkgs31NECqF3y+FiDoSC9RUnzKQontm4mX1VT7fPUEJtLH
         NKHw==
X-Gm-Message-State: AOAM530NzaKv97jQkeboN6CyUC4WO8s6fKUXA4hUyJdbLUZ6Xfa2lFII
        PRjjbReUUVP5eSeGpOqnMOGC0TXqlHFdZiI8Ufk=
X-Google-Smtp-Source: ABdhPJzyGt0nsnygfKJcQmbWPDVyie7og3N2BiJ9L2YHDgpqULnlKaf2OkwGFE6PoKW9F9Lqq4kUrAQW36nqK1WzJ8U=
X-Received: by 2002:a05:6402:4c5:: with SMTP id n5mr45295794edw.322.1626842678114;
 Tue, 20 Jul 2021 21:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-N9QVFnhKGfRYDDjWb0o_ty57AbjfzEnFPHZxEC5NOKL1ecg@mail.gmail.com>
 <77df3e1f.22e1.17ac45a1bd9.Coremail.lyl2019@mail.ustc.edu.cn>
In-Reply-To: <77df3e1f.22e1.17ac45a1bd9.Coremail.lyl2019@mail.ustc.edu.cn>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 21 Jul 2021 12:44:09 +0800
Message-ID: <CAD-N9QUEdMMfAC46Wb7DJJRs792_3ukK0ykyh1_U1MAekM1L5g@mail.gmail.com>
Subject: Re: Doubts about Patch "ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe"
To:     lyl2019@mail.ustc.edu.cn
Cc:     siglesias@igalia.com, jens.taprogge@taprogge.org,
        Greg KH <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:38 PM <lyl2019@mail.ustc.edu.cn> wrote:
>
>
> Hello Dongliang Mu,
>
> >  Depending on if CONFIG_PCI defines, the "tpci200->info->cfg_regs" may
> > not be freed.
> >
> > #ifdef CONFIG_PCI
> > /* Destroy a virtual mapping cookie for a PCI BAR (memory or IO) */
> > struct pci_dev;
> > extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
> > #elif defined(CONFIG_GENERIC_IOMAP)
> > struct pci_dev;
> > static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> > { }
> > #endif
>
> I think only `CONFIG_PCI=n` and `CONFIG_GENERIC_IOMAP=y` cause pci_iounmap an empty
> implementation. Actually, `CONFIG_PCI` is a default option when run `make defconfig`,
> pci_iounmap() usually is acted as an extern function.

I see. From the discussion with other developers, the usage of this
driver needs to enable CONFIG_PCI. So we may not worry about this
point any more.

>
>
> > Even if CONFIG_PCI is undefined, it is possible that
> > tpci200->info->cfg_regs is not freed at all. Therefore, this patch
> > would cause memory leak. Take a look at the following code:
> >
> > void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> > {
> >         IO_COND(addr, /* nothing */, iounmap(addr));
> > }
>
> Here i am not sure this is the final implementation of pci_iounmap(),
> because pci_iounmap() is re-implementated in many architectures.
> Even so, i observed there still many call-sites of pci_iounmap() have reset
> `the addr = NULL` after calling.
> Can you have some ways to determine the actual implementation of
> pci_iounmap in our cases?

Yeah, that's the problem. I am not highly certain about the
implementation of this function. So if the free is not done, your
previous patch would cause a memory leak.



>
>
> > #define IO_COND(addr, is_pio, is_mmio) do {                     \
> >         unsigned long port = (unsigned long __force)addr;       \
> >         if (port >= PIO_RESERVED) {                             \
> >                 is_mmio;                                        \
> >         } else if (port > PIO_OFFSET) {                         \
> >                 port &= PIO_MASK;                               \
> >                 is_pio;                                         \
> >         } else                                                  \
> >                 bad_io_access(port, #is_pio );                  \
> > } while (0)
> >
>
> Although the above codes is actually called, the addr might be freed
> if `port >= PIO_RESERVED` is true. The double free still existed.

Of course. There exists a path in which the double free occurs.
However, if you directly add this NULL assignment, it will cause a
memory leak in other paths.

I am not suspecting the validation of this patch in defending the
double free. Instead, I agree with this patch, but it may introduce
some other issues, like memory leak.

>
>
>
> If I make any mistakes, please tell me.
> Thanks your report.
> ---
> Lv Yunlong
>
>
>
>
