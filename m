Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2063384A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 05:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhCLEWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 23:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhCLEV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 23:21:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 20:21:28 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id x4so36856644lfu.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2UujaTrfRHurTxUIOvZX13ebBTXXB4ge6ZkHfxLOJc=;
        b=jRRWw3s+gDc/TM2KGngoCnT4EjieGWpZy4OsQuPBtoG18gNVuRVl4PTaoCZ3Al7gAc
         2BA9iFvVVYkQzCYibz4t50KOVphhUtnrLKVDI6Kl4U1Ka4CefhSyt/C1X5E0b9WRHq71
         n0/51GvL/E8k2pOFzsn4LStIJusD/pGkfjoOF/MxwhTyffrmjqE56xv0z+XkkXmUFfi0
         5UImo4mvljVZ79utr2/uY/cpw2LVPbxsnP1ldcc4qs8dHRABFJgNL7AcQnZBuw9gKPJP
         CGn25eBHcs48/nG8aQFF/+J4/cSzwtxvmZ3RIJkZesN7EmawZ4lSu7tYtX7d9DWnKJLC
         BFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2UujaTrfRHurTxUIOvZX13ebBTXXB4ge6ZkHfxLOJc=;
        b=IUxhbpnneRxrCPhHLU001uL+YHVKzcbWET+BDurzW+icf488KF/+ai2bdcsTJB2Eab
         SUGIaTKqxnrmhiUjqOKpmkfQS58ADpM+35amrxjlE9JBfrEIBuIHQjPZeJLj/uZwHVtl
         o6Xn0T7LV5qG4MpqTbbsEQhXbRp2otWT8fYXXrkv7JWLu6hxS5qIxf4wkJu3aS8oPmY6
         bG8KBs/rEeKg07LUELc18Yt1k9WdYVIJC3r6Dc8km4pmGKpBs/7/jvjrofbWZyqF5czz
         t0/1WNaM/pD5rSqTCJTvbt+6+usxNoBs4Z9wZXJkz+ipISkGPmzmMnw6C+VTbkPokyKj
         r51Q==
X-Gm-Message-State: AOAM531ctXHY7B/7yG2m8UZgFCtU2ECtmgSLSnCTeFvxNbO2/BiIqrg0
        gvrG2tc++JmlUbDVbxdoM1T0di0HHUQX3n4xpoYXlg==
X-Google-Smtp-Source: ABdhPJxEsTRa+p/GJ5b3jEaXi5W4gqiB8heDCJwqpk7DymhAA2BQLF3qfqtOWc53h8RKOPnbJzg2ZPABM9Qw9s00Dxo=
X-Received: by 2002:a19:6b10:: with SMTP id d16mr4104042lfa.540.1615522886724;
 Thu, 11 Mar 2021 20:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com> <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com>
In-Reply-To: <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com>
From:   Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Date:   Fri, 12 Mar 2021 05:21:14 +0100
Message-ID: <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
Subject: Re: [RFC 0/2] virtio-pmem: Asynchronous flush
To:     David Hildenbrand <david@redhat.com>
Cc:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, mst@redhat.com, jmoyer@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> >   Jeff reported preflush order issue with the existing implementation
> >   of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
> >   for virtio pmem using work queue as done in md/RAID. This patch series
> >   intends to solve the preflush ordering issue and also makes the flush
> >   asynchronous from the submitting thread POV.
> >
> >   Submitting this patch series for feeback and is in WIP. I have
> >   done basic testing and currently doing more testing.
> >
> > Pankaj Gupta (2):
> >    pmem: make nvdimm_flush asynchronous
> >    virtio_pmem: Async virtio-pmem flush
> >
> >   drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
> >   drivers/nvdimm/pmem.c        | 15 ++++----
> >   drivers/nvdimm/region_devs.c |  3 +-
> >   drivers/nvdimm/virtio_pmem.c |  9 +++++
> >   drivers/nvdimm/virtio_pmem.h | 12 +++++++
> >   5 files changed, 78 insertions(+), 27 deletions(-)
> >
> > [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
> >
>
> Just wondering, was there any follow up of this or are we still waiting
> for feedback? :)

Thank you for bringing this up.

My apologies I could not followup on this. I have another version in my local
tree but could not post it as I was not sure if I solved the problem
correctly. I will
clean it up and post for feedback as soon as I can.

P.S: Due to serious personal/family health issues I am not able to
devote much time
on this with other professional commitments. I feel bad that I have
this unfinished task.
Just in last one year things have not been stable for me & my family
and still not getting :(

Best regards,
Pankaj
