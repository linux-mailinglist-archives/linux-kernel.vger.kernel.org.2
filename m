Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04A73F9AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbhH0OZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233645AbhH0OZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 101E661004;
        Fri, 27 Aug 2021 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630074305;
        bh=EirSWY54CSyGcXPSy22/Yz2aZ9xdXrTwL7qJCDzFoKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQekdGVHqUAhZHe1qv2T8SdTwHwqUgI3VTQtQlsCAtVDYzxZ/04ehtHDVzuAGVJ2K
         hxP12li6G8Zys4LaSzoK3IBQDjN4UR9SkNS0bFB8OvoEXoD+p4efKDV1xL/EJ2xCq6
         P6EdHsRM8KqKwTmotvge3phSXgwssduBNvEpMLSQ=
Date:   Fri, 27 Aug 2021 16:24:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipack: tpci200: change pci_iounmap to iounmap
Message-ID: <YSj1u1x7ruEysfNq@kroah.com>
References: <20210827094351.203328-1-mudongliangabcd@gmail.com>
 <YSi3rpsoL3UIuzFY@kroah.com>
 <CAD-N9QUveJWdK_zaAd6JTwWidMWap5Ri-bRe0n7QnCuBpMqbew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD-N9QUveJWdK_zaAd6JTwWidMWap5Ri-bRe0n7QnCuBpMqbew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:33:46PM +0800, Dongliang Mu wrote:
> On Fri, Aug 27, 2021 at 6:00 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Aug 27, 2021 at 05:43:47PM +0800, Dongliang Mu wrote:
> > > The deallocation api for ioremap should be iounmap, other than
> > > pci_iounmap.
> >
> > why?
> 
> Because the tpci200->info->cfg_regs/interface_regs is allocated by
> ioremap. From my understanding, ioremap and iounmap are in pairs,
> other than pci_iounmap.
> See the code below.
> 
> tpci200->info->interface_regs =
> ioremap(pci_resource_start(tpci200->info->pdev,
>   TPCI200_IP_INTERFACE_BAR),
> TPCI200_IFACE_SIZE);
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L297
> 
> tpci200->info->cfg_regs = ioremap(
> pci_resource_start(pdev, TPCI200_CFG_MEM_BAR),
> pci_resource_len(pdev, TPCI200_CFG_MEM_BAR));
> 
> https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L546
> 
> If there is any issue, please let me know

The point is that the driver should be calling pci_iomap_bar() instead
of ioremap(), and then the call to pci_ioumap() is correct here.

Please make that change instead.

thanks,

greg k-h
