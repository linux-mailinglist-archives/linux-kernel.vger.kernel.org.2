Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6EB3B1498
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFWHbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:31:35 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A86C061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:29:18 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id k189so304551vkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 00:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OiI0V+yxMIONf4gEnVaBVWNdRCT16qVKxJ40BTU8ic=;
        b=p+aXkgOclQiJf908cOV14Nzac6usd94n7ZjzLLxxVaILz2otBr4Fv2gN9coGh3QPSO
         B5CrC0rGLI2xOYoITpLWdjys5dvKyYWZw+3fpeKfcUQZMfqgNkSO07eli3G3pzYzYwUe
         t6KU+FzDyY6ZRqEKzuW347wQw6I0O21iUWswRVqFQ6ixxXNF99IJDCtn6Lf3pfPlm0zu
         GgBIYuYgQTdMvbSQbAC6LoqgxeGoCI0Jr2fpY+AuImLaCD2JEUAbqnIksYOAZuSz2phZ
         XetoWNq2kycBmOm5VjzhDzoNzqWQvd4NDX23/0Bj5iryK5UOg9L+23tOfp5nJI/c24wh
         Gm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OiI0V+yxMIONf4gEnVaBVWNdRCT16qVKxJ40BTU8ic=;
        b=cip+Ud3vCOpbZVgNR/pX/CVo4PdUM5fC8Rj+45KVl4bpis7dRAdFcjpNb6OiD2oOOo
         7f0eWISuWBcwnol9dDRltEqqdFV2rz62JiRWLZtjJM4AtBQXS9B9579BvQfpWvj3slCA
         kO5dPeHAojdw3o0chzIbxXOiiuW6ACVaP89EHRPH4l+du8cx2NBCUh+NkCzIcOBXYWbM
         0nknYbVR0SPjRTW3dsrfKPZEXtH/H48Qu5YEygS8YnG2zNgzJHPtVv7Mg3dlfeB4vWNl
         ZhEwG0RVzB2QxpCsostlcGUIe2K7m+VOQhZdIRnXqz8MLA/Iz4LKGfh1wINrZd/uPnxV
         UFpg==
X-Gm-Message-State: AOAM530TGa/qe6TbIwD5y0I8v8NmR9pcgie6m0cStMwGPIh0E0gdimhG
        AGNusv6kZ9UO4C7c4K9rC0dYYJJ8dNMu62FZLJs=
X-Google-Smtp-Source: ABdhPJxOnWA5wALAFeYNUynI/DbnbsK1KxwIavA00LNxgW2H+j4Sn3hVD5biN2Sck2rGqSX+cZuYgchyPR4cfOR2iXg=
X-Received: by 2002:a1f:fecc:: with SMTP id l195mr19508445vki.21.1624433357432;
 Wed, 23 Jun 2021 00:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <YNLRn/5JkyYhYwxi@matsya> <YNLhBZokBed/jxNC@kroah.com>
In-Reply-To: <YNLhBZokBed/jxNC@kroah.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 23 Jun 2021 09:29:06 +0200
Message-ID: <CAMhs-H8hV8Lv2B3vCcCqgWmpg3jbhLF8kna2SoFbSd5xV3ARXw@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy updates for v5.14
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, Jun 23, 2021 at 9:21 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 23, 2021 at 11:45:59AM +0530, Vinod Koul wrote:
> > Hello Greg,
> >
> > Please pull to receive Generic phy subsystem updates for v5.14
> >
> > The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> >
> >   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-5.14
> >
> > for you to fetch changes up to f7eedcb8539ddcbb6fe7791f1b4ccf43f905c72f:
> >
> >   phy: ti: dm816x: Fix the error handling path in 'dm816x_usb_phy_probe() (2021-06-21 12:04:18 +0530)
> >
> > ----------------------------------------------------------------
> > phy-for-5.14
> >
> >   - Updates:
> >         - Yaml conversion for renesas,rcar-gen3 pcie phy and
> >         rockchip-usb-phy bindings
> >         - Support for devm_phy_get() taking NULL phy name
> >
> >   - New support:
> >       - PCIe phy for Qualcomm IPQ60xx
> >       - PCIe phy for Qualcomm SDX55
> >       - USB phy for RK3308
> >       - CAN transceivers phy for TI TCAN104x
> >         - Innosilicon-based CSI dphy for rockchip
>
> Why is PHY_MT7621_PCI only y/n?  Shouldn't this be able to be built as a
> module?
>
> The USB phy enables this driver, which now forces me to build it into my
> kernel, which does not seem like a wise idea.  I'm not sure which commit
> in this series does this, but that isn't a good thing.
>
> Ah, it's 6eded551cefe ("phy: ralink: Kconfig: convert mt7621-pci-phy
> into 'bool'"), why is that needed?  We are working to turn more code
> into modules, not force them to be built in, this feels like the wrong
> way to go :(

This was turned into bool to automatically be included if CONFIG_PCI_MT7621
is set. This should be the only requirement to add this phy driver for
real hardware since it has nothing to do if there is no
CONFIG_PCI_MT7621. That's why Kconfig is now:

depends on (RALINK && OF && PCI_MT7621) || COMPILE_TEST
Am I missing something here???

Thanks,
    Sergio Paracuellos

>
> I don't want to take this series because of this at the moment.
>
> thanks,
>
> greg k-h
