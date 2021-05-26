Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753B390E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhEZCEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:04:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40537 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhEZCEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:04:11 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <koba.ko@canonical.com>)
        id 1llisa-0007Q6-5N
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 02:02:40 +0000
Received: by mail-ot1-f72.google.com with SMTP id k7-20020a9d4b870000b02902a5bfbbbd3bso23052766otf.18
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80Q9luL+LwQCDuf3BgkOvtEc2OIfkbeDzIrwJ3hVNYg=;
        b=Auz+5esBRHPt703A6MrHheqyU8Z9uqjb/OI/0YMPuJMaLGDsiff2PJ8IZtZQ7+Eukj
         QDS+Sng1Hfje3VIUDtM49XD/KJYB4mtYcSLC3u4R4HJbqph+W22SprI6WJVLBfLxVl+H
         mVIbLo66/jF8awk94Mb7kr4enjn/8mYEZVJhIZ7yi9buMyDHwMoblR60IvFe62CmFxx0
         n5RhHv11VNcMqXIQ8yyaRGKVpCLssO0ZLxXZ1uwz2TS6ZsEDe1ITwcVWT4lD6Eg0riyT
         XbdS2rRyR7tP+/LXQAwwkDxj31ckv42hJQVKsnsCE2QMITyuy9KfoDV5q8D6VI2NRYpU
         yGbQ==
X-Gm-Message-State: AOAM5325Zx4YYwz9R74xkCen6+1dHZEUrZ5IF1qJWwEIpFxqKkX5+HCL
        Hh82mt3rIkYLqA5eYLKixPsy2vBqWNPCjyfadwF9iouZ4hUl9zc8hivk4ee56lV6cV/gKAJ2xVy
        LEXL2dMDIrghTZK3n8B8tRegzEqQNb9gVSCah8uRMT10WMBTma4kjwXVjVA==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr353839oif.17.1621994559114;
        Tue, 25 May 2021 19:02:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVyQJj1wQcjhyCbkjhZWLHzSkdMbj1UW7fzQW9m2Wo4G/waP+Gb8xrdYJnlCIdJUeKJb5TO7XDHgGKxBL1qrs=
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr353825oif.17.1621994558803;
 Tue, 25 May 2021 19:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com> <20210525074426.GA14916@lst.de>
In-Reply-To: <20210525074426.GA14916@lst.de>
From:   Koba Ko <koba.ko@canonical.com>
Date:   Wed, 26 May 2021 10:02:27 +0800
Message-ID: <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > After resume, host can't change power state of the closed controller
> > from D3cold to D0.
>
> Why?
As per Kai-Heng said, it's a regression introduced by commit
b97120b15ebd ("nvme-pci:
use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
the target nvme ssd uses HMB and the target machine would put nvme to d3cold.
During suspend, nvme driver would shutdown the nvme controller caused by
commit b97120b15ebd ("nvme-pci: use simple suspend when a HMB is enabled").
During resuming, the nvme controller can't change the power state from
d3cold to d0.
    # nvme 0000:58:00.0: can't change power state from D3cold to D0
(config space inaccessible)
Tried some machines, they only put nvme to d3hot so even if nvme is
forced to shutdown,
it could be resumed correctly.

As per commit b97120b15ebd , the TP spec would allow nvme to access
the host memory in any power state in S3.
but the Host would fail to manage. I agree with Kai-Heng's suggestion
but this TP would be broken.

>
> > For these devices, just avoid to go deeper than d3hot.
>
> What are "these devices"?

It's a Samsung ssd using HMB.

> > @@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >
> >       dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> >
> > +     if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
> > +         !pcie_aspm_enabled(pdev) ||
> > +         dev->nr_host_mem_descs ||
> > +         (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
>
> Before we start open coding this in even more places we really want a
> little helper function for these checks, which should be accomodated with
> the comment near the existing copy of the checks.

Thanks, I will refine this.

>
> > +             pdev->d3cold_allowed = false;
> > +             pci_d3cold_disable(pdev);
> > +             pm_runtime_resume(&pdev->dev);
>
> Why do we need to both set d3cold_allowed and call pci_d3cold_disable?
>
> What is the pm_runtime_resume doing here?
I referenced the codes of d3cold_allowed_store@d3cold_allowed_store fun,
As per Bjorn and search in multiple drivers, only pci_d3cold_disable is enough.
