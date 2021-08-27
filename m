Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BC23F9824
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244862AbhH0KfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244735AbhH0KfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:35:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE15C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:34:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i6so9256554edu.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7suERO5MCRclZTJvjUD3oCaR8o8lrlDPro107QK940Y=;
        b=cTj9Q+YybeT/gf1pd8b6qQ4Scw8wpd8q4FF6FeTpme+S8EIRDp+Z0kBZbtj/MX1GUb
         ir/T2dLcdBcIKpUTEKR+kl77xIo+e/MrL9GSbx6SSNzg7XGAjnFRuSu7VmPvsrlL01Gm
         Hp6ojhs6VRXfqp8r+Ev/0Do0VdaDM5G/14UBX3xTwyROQq4nmftEJN+qCFHI//4gfEDV
         UeJYzEyXzpKbJwcBjMi70xw6KBoI/TnOnVV/3GpPgeFCxvuVLA7U+S3j2VDa+XjdN4TB
         4lrUS7K2we2zffQWgSntm59GteDsSACKP1BN8sHvSig2bQObKpcz70ybxjYRQgubwig0
         gMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7suERO5MCRclZTJvjUD3oCaR8o8lrlDPro107QK940Y=;
        b=qttzbzbHFX8u8wNS5K/fWsVYGEBgUuRO3pDj5cH5MOf9ex6rebOd2gVzeYcCWwCmZs
         eW7RMY4fxDrP1k6hSF9id4UJkW1yqO49P8NQgny0fGaNCgyNMrahYFfj98YJMnCAk+mp
         R2gt5GAG7nqM1bzyfn2BQGWSmETaMlHmwwgRJ1QUBLR3iIZrYDTslzRfXgJ8VWJ6qLoe
         xCku9yd5FahsIPn7QbOKoirE/ClZp5dHZIzuvHbjbt4gMvYKhbS+E1g5Ceb909SuHCsm
         OX7ki09DTjL7+XFZ3RoJuzX43NFytnpO+fby+plalZZUz81oHxkvhhS9xFnPK4uDAmFt
         mFvw==
X-Gm-Message-State: AOAM532SSrHtje9PeZYrt7Vtvn1k6p03EuumkPkT80fYjuQymE0Tkp5N
        OmLkJRkh4UZ2JKXskuys8LdSBgcoaMMF49f2hkQ=
X-Google-Smtp-Source: ABdhPJzCPF7VtpW1gAH8kgy7FiZaP8W3cYOOvS4UkfvCabcgNhXRchLX1ZX6DFje8iTkrU50w/l70XYfIrHk6UpUX8o=
X-Received: by 2002:aa7:c88e:: with SMTP id p14mr9313786eds.174.1630060452603;
 Fri, 27 Aug 2021 03:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210827094351.203328-1-mudongliangabcd@gmail.com> <YSi3rpsoL3UIuzFY@kroah.com>
In-Reply-To: <YSi3rpsoL3UIuzFY@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 27 Aug 2021 18:33:46 +0800
Message-ID: <CAD-N9QUveJWdK_zaAd6JTwWidMWap5Ri-bRe0n7QnCuBpMqbew@mail.gmail.com>
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

On Fri, Aug 27, 2021 at 6:00 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 27, 2021 at 05:43:47PM +0800, Dongliang Mu wrote:
> > The deallocation api for ioremap should be iounmap, other than
> > pci_iounmap.
>
> why?

Because the tpci200->info->cfg_regs/interface_regs is allocated by
ioremap. From my understanding, ioremap and iounmap are in pairs,
other than pci_iounmap.
See the code below.

tpci200->info->interface_regs =
ioremap(pci_resource_start(tpci200->info->pdev,
  TPCI200_IP_INTERFACE_BAR),
TPCI200_IFACE_SIZE);

https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L297

tpci200->info->cfg_regs = ioremap(
pci_resource_start(pdev, TPCI200_CFG_MEM_BAR),
pci_resource_len(pdev, TPCI200_CFG_MEM_BAR));

https://elixir.bootlin.com/linux/latest/source/drivers/ipack/carriers/tpci200.c#L546

If there is any issue, please let me know

>
> Isn't this a pci device?
>
> thanks,
>
> greg k-h
