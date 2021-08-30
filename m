Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615AC3FAFCB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 04:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhH3CeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 22:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbhH3CeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 22:34:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E708C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:33:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t19so27930218ejr.8
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYx5Ec4IK2H1rlO0tfRHMe+rUpApql3pIdTCBRWU9Y0=;
        b=lVeP92XWxVUdO3zISWahAhck+QIHTQvsgVGZMSCprMFdaXVrbPwZj50vFw1A8pW4aO
         Bi56I+s5RsYeo92XuEhFGqXy6sALdJlB+mD0DxVP2/mrrD5Rcg5s2UpkuggH1XvG+y+/
         tUd+nLkk1fsJKD1hOCyZcM1rK8KiFsj3NIlMW2th+gjspuFNRhCzdDNlHlMvSoTJLSXJ
         MM1lDskxqYVb6Zd0Yua3RoD4QVO9jvGI6fKWY2KSxKft9lJaphnWkTGYDcG/6FctAfA+
         B8rh14m6TBGk1v+xUFZHWbB0E5mB3GVAyn6ngPzp4XJQDRaQtO0xoNd3YkdPaTVqXDA3
         RB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYx5Ec4IK2H1rlO0tfRHMe+rUpApql3pIdTCBRWU9Y0=;
        b=UY4zC1444de6p3bv9kgiguAzEQHpNdYoeFwRYzt3VsqRmMZQ7u/sOqZobFNuasbeFo
         blAqyDZspNpUUJWHTeRkVRdYSJXcNn5iliWStR7GqIaJbTsTh2k69cGk+o/Dzk6Xk4tR
         8cPOO52cYT42JjX8cd8rrqD21TMN6GI2YcZq+BSJeUhiZCWeEvvugPBz+sAe/IlkWpC4
         YwdkDpcAiYNKlOqwtznWoPCnuAdhX7HRUZQ2Zb+m4rLKKXdBT27qaTPr4ICEhgor7q0o
         vOAnVdHN0dxJDVFydSf571t7WV9gYz6WekDEW2yvlO+EWplM4G0CDOv/rbA9/5IaYPAJ
         qPuQ==
X-Gm-Message-State: AOAM531NlJAMzx5LLOEC6bgh+YHVnHzCT9Lr3xf2Hv9kAY4noT4i64Ry
        v10myQOYok0+PuJYxRcZFN+ps5HAQtAIOLpQyaA=
X-Google-Smtp-Source: ABdhPJzrr0+xJ2AS+8XzNZNi5nuLpctN2Xd7JoiI0l+yff4sczFKgIzQHeiIDvqp9QCTa+31K0SBW+TIQo2p2OeuO5I=
X-Received: by 2002:a17:906:a3c3:: with SMTP id ca3mr22737772ejb.337.1630290794171;
 Sun, 29 Aug 2021 19:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210827094351.203328-1-mudongliangabcd@gmail.com>
 <YSi3rpsoL3UIuzFY@kroah.com> <CAD-N9QUveJWdK_zaAd6JTwWidMWap5Ri-bRe0n7QnCuBpMqbew@mail.gmail.com>
 <YSj1u1x7ruEysfNq@kroah.com> <CAD-N9QU-zPU6EVaytsN1bEYqHQc1cDcXa4aXrPqg6VTwDkXb5w@mail.gmail.com>
In-Reply-To: <CAD-N9QU-zPU6EVaytsN1bEYqHQc1cDcXa4aXrPqg6VTwDkXb5w@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 30 Aug 2021 10:32:48 +0800
Message-ID: <CAD-N9QUCkaFAGfJ3pzqNoBXqH6rgwg5aHxGqPgdChPRh0_-Lcw@mail.gmail.com>
Subject: Re: [PATCH] ipack: tpci200: change pci_iounmap to iounmap
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 9:22 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Fri, Aug 27, 2021 at 10:25 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 27, 2021 at 06:33:46PM +0800, Dongliang Mu wrote:
> > > On Fri, Aug 27, 2021 at 6:00 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Aug 27, 2021 at 05:43:47PM +0800, Dongliang Mu wrote:
> > > > > The deallocation api for ioremap should be iounmap, other than
> > > > > pci_iounmap.
> > > >
> > > > why?
> > >
> > > Because the tpci200->info->cfg_regs/interface_regs is allocated by
> > > ioremap. From my understanding, ioremap and iounmap are in pairs,
> > > other than pci_iounmap.
> > > See the code below.
> > >
> > > tpci200->info->interface_regs =
> > > ioremap(pci_resource_start(tpci200->info->pdev,
> > >   TPCI200_IP_INTERFACE_BAR),
> > > TPCI200_IFACE_SIZE);
> > >
> > > https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L297
> > >
> > > tpci200->info->cfg_regs = ioremap(
> > > pci_resource_start(pdev, TPCI200_CFG_MEM_BAR),
> > > pci_resource_len(pdev, TPCI200_CFG_MEM_BAR));
> > >
> > > https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L546
> > >
> > > If there is any issue, please let me know
> >
> > The point is that the driver should be calling pci_iomap_bar() instead
> > of ioremap(), and then the call to pci_ioumap() is correct here.

Hi gregkh,

For cfg_regs [1], it is fine to change from:

tpci200->info->cfg_regs = ioremap(
pci_resource_start(pdev, TPCI200_CFG_MEM_BAR),
pci_resource_len(pdev, TPCI200_CFG_MEM_BAR));

to :

tpci200->info->cfg_regs = pci_ioremap_bar(pdev, TPCI200_CFG_MEM_BAR);

But for interface_regs [2], I am not sure as TPCI200_IFACE_SIZE is a
totally separate definition, not calculated by resouce_size or
pci_resource_len(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR).

tpci200->info->interface_regs =
ioremap(pci_resource_start(tpci200->info->pdev,
  TPCI200_IP_INTERFACE_BAR),
TPCI200_IFACE_SIZE);

#define TPCI200_IFACE_SIZE            0x100

Any comment here?

Note that, it is pci_ioremap_bar, not pci_iomap_bar.

[1] https://elixir.bootlin.com/linux/v5.14/source/drivers/ipack/carriers/tpci200.c#L544
[2] https://elixir.bootlin.com/linux/v5.14/source/drivers/ipack/carriers/tpci200.c#L295

> >
> > Please make that change instead.
>
> No problem. I will modify the patch and send a v2 patch afterwards.
>
> >
> > thanks,
> >
> > greg k-h
