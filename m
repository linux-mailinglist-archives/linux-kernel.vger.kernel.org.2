Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396FF391A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbhEZOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:23:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59824 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhEZOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:23:45 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lluQH-00082n-9Q
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 14:22:13 +0000
Received: by mail-lj1-f198.google.com with SMTP id b35-20020a2ebc230000b02900e586a5ceaeso556383ljf.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:22:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KRO+7j/5yLVMVQTeKppilXzCeyP1PjLQ0t5VspLhv9A=;
        b=hZJtRn5eLqHI7RgXQgzsNswhXO8fhDm/cOXTGo6Ac2Swr2FAGbQEa95UBg/91SifYL
         wwsZlMVGh4WMdAy4xhrMMHQzsW9Xmi4vKTfltZJgCpUQJ1zy8ryAK2L9JBU3bAh5h0/j
         cYn5ghG/4H6Gdlx0k51rNGpEreVMTiMkJkXaVxgC++VZCAOCe8knkzpWyzCFSncFwri/
         7SJhF7iNSEP4b3bv36my77lwqrzUeWJV3kqDfwxpocOkTq4g270ox4uKZlW9ByWM8tT8
         LLiv7NzhIovuZmcZGSF69LQsQpn2oi84k7uo91lWHJGO8+73AKDQEW8/FSGDAjDkcgYE
         xbOg==
X-Gm-Message-State: AOAM533xQCuEXNaOrJghKnpn1coh047g+Gf4NVVPvC/Jxe2Bw1uAR4oN
        ZnQd8jZYxTHPckq/atOY73ntUYWi54AWEyCg33btw57ou5ITNwAu0JJb7R93Sp0BDeLh2j6mo/Q
        MdnpttfIEl7byQzBSelxKlPNfZdhNrhAWPlCDqBoP6GZwGNIfE+PyA5stBg==
X-Received: by 2002:a05:6512:3488:: with SMTP id v8mr2271803lfr.622.1622038932740;
        Wed, 26 May 2021 07:22:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9Ncbz7tk+afIZiBiaVQaJ7SPjwGt7E11q4JRhgLfAPg8wtMkeKE7zuYtCMaSiZwT2FQxkbslAA1z6L4dgG5o=
X-Received: by 2002:a05:6512:3488:: with SMTP id v8mr2271787lfr.622.1622038932348;
 Wed, 26 May 2021 07:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de> <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com> <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
 <20210526125942.GA25080@lst.de>
In-Reply-To: <20210526125942.GA25080@lst.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 26 May 2021 22:21:59 +0800
Message-ID: <CAAd53p4f2ZFsVRv-Q9maPBSD_uGjj7FoYKYy9MGjBPc6chk_1Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Koba Ko <koba.ko@canonical.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Henrik Juul Hansen <hjhansen2020@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 8:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 26, 2021 at 08:11:41PM +0800, Kai-Heng Feng wrote:
> > On Wed, May 26, 2021 at 10:49 AM Keith Busch <kbusch@kernel.org> wrote:
> > >
> > > On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> > > > On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > > > >
> > > > > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > > > > After resume, host can't change power state of the closed controller
> > > > > > from D3cold to D0.
> > > > >
> > > > > Why?
> > > > As per Kai-Heng said, it's a regression introduced by commit
> > > > b97120b15ebd ("nvme-pci:
> > > > use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
> > >
> > > That really doesn't add up. The mentioned commit restores the driver
> > > behavior for HMB drives that existed prior to d916b1be94b6d from kernel
> > > 5.3. Is that NVMe device broken in pre-5.3 kernels, too?
> >
> > Quite likely. The system in question is a late 2020 Ice Lake laptop,
> > so it was released after 5.3 kernel.
>
> This is just a mess.  We had to disable the sensible power state based
> suspend on these systems because Intel broke it by just cutting the power
> off.  And now the shutdown based one doesn't work either because it can't
> handle d3cold.  Someone we need to stop Intel and the integrators from
> doing stupid things, and I'm not sure how.

To be fair, resuming the NVMe from D3hot is much slower than keep it
at D0, which gives us a faster s2idle resume time. And now AMD also
requires s2idle on their latest laptops.

And it's more like NVMe controllers don't respect PCI D3hot.

>
> But degrading all systems even more is just a bad idea, so I fear we'll
> need a quirk again.  Can you figure out by switching the cards if this
> is the fault of the platform or the nvme device?

Here's the original bug report:
https://bugs.launchpad.net/bugs/1912057

Because the NVMe continues to work after s2idle and the symbol is
rather subtle, so I suspect this is not platform or vendor specific.
Is it possible to disable DMA for HMB NVMe on suspend?

Kai-Heng

>
> >
> > Kai-Heng
> ---end quoted text---
