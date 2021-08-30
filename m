Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE63FAF87
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 03:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbhH3BXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 21:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhH3BX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 21:23:29 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3129EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 18:22:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id s25so19311686edw.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 18:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HV/SdXWF5m464kf1PALAt+ukLRt5G/nHgAPJz+q7oU=;
        b=F5XSrOc2bjqUAyuxvcM7okM+8dWiCvqlcrF6o9j973yxTrqwrMsni6zSvOKPEyKugz
         mlYMqDThBa3fnQJeCHJSsx1F5HQ+M9Fp4lT/t/w6l4qi2FPNnNYcADeXCNcN8E0CuBVS
         uFqvImH/x0B5qyUaBaGCwMIOiG5OpQxW/vJ65yuyAuLVtnr2NGLJhqWWeFJv444rGq7G
         6VrRJ0JShKSO/ZBV8rm1kNsy1vogBgPrHXB3ozL36sGU0BZzlU6o5cD2UPwtpefmfp82
         9uwS6ZJLMiI7Gi2qzZG8GgukYRdZWXIRdrVnA1mjeMbYdVF0Ur5A6dqHVoTmofco+/GA
         JYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HV/SdXWF5m464kf1PALAt+ukLRt5G/nHgAPJz+q7oU=;
        b=Ttah4pd1lISeSrrXXbyrygtYLwdmU8NFGHbpKV2PS2DTfh1b/k4Ll0hoY2NXFYRPKN
         ruySE7or84tNARYiQZnT3U8E2pGA7ARXwo6jLIsjBCfERDPdLQ2WAAPj5wtWploq4+mr
         bZzC820jIBDWzfiEz8pCaD9K3OCrsOGOXGYyfXL6LmchBfiB/slLZT8hyRB4TLDGW1Xv
         HgMaIyd7PYhzEyiHtdJ8UIin0iRlwow74wif5wr+bJOph9OMXGE1lRdbLZjqBJv2FSjL
         o4V/BRjoabCqM4eht52mWzac4doZ099YWklLtq/gOhA/IIIPOI3HolAQbo6900xSWM8C
         57yg==
X-Gm-Message-State: AOAM532JnF2cuswIH1812wR30HdgEJAMPHqsO4dg+Y2Xf6gCu7RY6Ekw
        B30p+2OnyS467k2VUktZ8b3AkllE/lM4tYSyAuM=
X-Google-Smtp-Source: ABdhPJzTN7TCx15xE3C7ZQf7sYc5CsBHdZu5B27+tP17V9K9P3lbvJZtB8tWuUREbnWN6J+PsZx+lxq7H0dSuTYePpw=
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr10732287edd.339.1630286554688;
 Sun, 29 Aug 2021 18:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210827094351.203328-1-mudongliangabcd@gmail.com>
 <YSi3rpsoL3UIuzFY@kroah.com> <CAD-N9QUveJWdK_zaAd6JTwWidMWap5Ri-bRe0n7QnCuBpMqbew@mail.gmail.com>
 <YSj1u1x7ruEysfNq@kroah.com>
In-Reply-To: <YSj1u1x7ruEysfNq@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Mon, 30 Aug 2021 09:22:04 +0800
Message-ID: <CAD-N9QU-zPU6EVaytsN1bEYqHQc1cDcXa4aXrPqg6VTwDkXb5w@mail.gmail.com>
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

On Fri, Aug 27, 2021 at 10:25 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 27, 2021 at 06:33:46PM +0800, Dongliang Mu wrote:
> > On Fri, Aug 27, 2021 at 6:00 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Aug 27, 2021 at 05:43:47PM +0800, Dongliang Mu wrote:
> > > > The deallocation api for ioremap should be iounmap, other than
> > > > pci_iounmap.
> > >
> > > why?
> >
> > Because the tpci200->info->cfg_regs/interface_regs is allocated by
> > ioremap. From my understanding, ioremap and iounmap are in pairs,
> > other than pci_iounmap.
> > See the code below.
> >
> > tpci200->info->interface_regs =
> > ioremap(pci_resource_start(tpci200->info->pdev,
> >   TPCI200_IP_INTERFACE_BAR),
> > TPCI200_IFACE_SIZE);
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L297
> >
> > tpci200->info->cfg_regs = ioremap(
> > pci_resource_start(pdev, TPCI200_CFG_MEM_BAR),
> > pci_resource_len(pdev, TPCI200_CFG_MEM_BAR));
> >
> > https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L546
> >
> > If there is any issue, please let me know
>
> The point is that the driver should be calling pci_iomap_bar() instead
> of ioremap(), and then the call to pci_ioumap() is correct here.
>
> Please make that change instead.

No problem. I will modify the patch and send a v2 patch afterwards.

>
> thanks,
>
> greg k-h
