Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097AF39171E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 14:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhEZMNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 08:13:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56002 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhEZMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 08:13:29 -0400
Received: from mail-lj1-f199.google.com ([209.85.208.199])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1llsOA-0006cp-NH
        for linux-kernel@vger.kernel.org; Wed, 26 May 2021 12:11:54 +0000
Received: by mail-lj1-f199.google.com with SMTP id t1-20020a2e9d010000b02900f5b2b52da7so389865lji.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 05:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4iEXWHzNZUnU66UdlOFVaCkSN/bmGsjDThaNffoTfk=;
        b=go/hQVsxUa//o4CpGAzKpOiZgalvJ7PU9U9alNRhmnuVjaL/ddUer/u4hJ8qi4t95x
         pSrrVJ+1TDbqsnI43qB5UzbZV3/wzfg363s6WGcUvYQR4L6fGL8ITFFbU6PEuKtc4Sob
         SG/gncKmA/bBAz8VAyl35taYntA8FB7dhpAAbYtfQozG4bnYDOXw4aK4oJ1mnNKfiw2c
         FycR4V39T5YHUkjY2G+Eg8xT1hunN7GizsvXCPJ4GQfFf7nLoOGXFn/bSHpXDANYk0js
         SxcXNJ76uvzDZj8KwflnAYlRze2jDTI4TTAKrWALkL2B6FE7ge8RrJyI4mVmNjeU50Lz
         o70w==
X-Gm-Message-State: AOAM5305fU6ZdajD4vrXD46iqxJSnj6vH7i8pD6vrqrNQDzwDf/Uf8iX
        ID9ZmG9kpve/DKGE9ANMKcW0Z+W3NQZTWuOBVzyLT5geaelhvHoNJwO8U5wYlVCWiBA2ZDTv6To
        SfU7cn9uyLQPqit0Y47DjKVzKvEELhzbxDEEeJhZLasxuUxbM3PV9BqJbsQ==
X-Received: by 2002:a05:651c:3c9:: with SMTP id f9mr2040019ljp.403.1622031114141;
        Wed, 26 May 2021 05:11:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvrYi6Me7vN2V1qsIo5OzULYPjkA+wU86ikFoE6Ao6vMy4kDVnkEo/WlqK9jtIZJwOy55Hwtp3SiuyfSz11wI=
X-Received: by 2002:a05:651c:3c9:: with SMTP id f9mr2040007ljp.403.1622031113922;
 Wed, 26 May 2021 05:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210520033315.490584-1-koba.ko@canonical.com>
 <20210525074426.GA14916@lst.de> <CAJB-X+UFi-iAkRBZQUsd6B_P+Bi-TAa_sQjnhJagD0S91WoFUQ@mail.gmail.com>
 <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210526024934.GB3704949@dhcp-10-100-145-180.wdc.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 26 May 2021 20:11:41 +0800
Message-ID: <CAAd53p7xabD2t__=t67uRLrrFOB7YGgr_GMhi6L48PFGhNe80w@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>, Christoph Hellwig <hch@lst.de>,
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

On Wed, May 26, 2021 at 10:49 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 10:02:27AM +0800, Koba Ko wrote:
> > On Tue, May 25, 2021 at 3:44 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > On Thu, May 20, 2021 at 11:33:15AM +0800, Koba Ko wrote:
> > > > After resume, host can't change power state of the closed controller
> > > > from D3cold to D0.
> > >
> > > Why?
> > As per Kai-Heng said, it's a regression introduced by commit
> > b97120b15ebd ("nvme-pci:
> > use simple suspend when a HMB is enabled"). The affected NVMe is using HMB.
>
> That really doesn't add up. The mentioned commit restores the driver
> behavior for HMB drives that existed prior to d916b1be94b6d from kernel
> 5.3. Is that NVMe device broken in pre-5.3 kernels, too?

Quite likely. The system in question is a late 2020 Ice Lake laptop,
so it was released after 5.3 kernel.

Kai-Heng
