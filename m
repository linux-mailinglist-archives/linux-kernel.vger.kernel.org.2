Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2B43011E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 10:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbhJPIZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 04:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239443AbhJPIZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 04:25:28 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84936C061570
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 01:23:20 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e144so10384351iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sn3fEWnQVyBE6l38TAM+W6Gz1Wv8DbKyNC4SbW6kXYA=;
        b=PkWmUSXXeOhuhn5e6ySI0Gkw5Y/k1c/iat8AFXl68yPocD6RcGL1v+CmIbE10O6Gbi
         TVR47rr4TRpb17VTHk5kqODVc+Z3nXiBMHY+3VZnJ+dVh3EbZtjUdiVNx3vJi2wTZDMa
         5oW6x9mHG6hzjKBmguL35b80g/aZF+/kscMJPiFv58c3UTFp55UpO70n92JQROBh54ut
         U1fxGrhuU5t9Nh5JRlgqX4bRvvYYuaZasHTg7s8SSX+QyFX4gldE181JnORXVajcsE6l
         THBFSai7C4wGVDM/IPVDISvkMp8zhLa6YK+icwtmfrQ/ZfW7mOh3Ke8jzizxABwO7JT+
         rsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sn3fEWnQVyBE6l38TAM+W6Gz1Wv8DbKyNC4SbW6kXYA=;
        b=5VTxs4ObGtc3ofloaLf6JOo8xhdswwBTQ/bKWiWZ54HasgwixujWWd8XRCT3Xj14c/
         Ejc2AaRzsSwfnsW2w9HCf/9mEohuLvFqQsJNelSwi3YG627uQWiUsw/WL75ombkqRsTV
         9yLs7G+gIAs4qoYPKgkiRPab8jzLsgAGXsVQV5hxajAoySNd4n35VDENP8jGS1eHFREs
         PJaJiDC97w4yKq5XWcCr8TaEJDw4IRTB5AS1ichcYJCis015tjm7BSk4ld4MBzxu4qiE
         m2zlfZCr+1asECB2BeXEG5mRFnWz2+2E6UOYKPL6do/NABDHJZPNrBU0tmxtFcJmELr6
         +osA==
X-Gm-Message-State: AOAM531ymPp4FswGKPye3FGqpT9rJuz19j8H5GUvqjB01jjWuWhR98T3
        Mkm6Gk+/wCkvIO9TMVM62Af54CDTQijCquhgVLM=
X-Google-Smtp-Source: ABdhPJyjSDKKSYeeQssqAhi1uUODfRGFbuA4G8uK0J8OU4CTin6tUsQbEOz8APatVo7Qmwpfpgy0LDUe62+YeSqpGs8=
X-Received: by 2002:a05:6602:2e95:: with SMTP id m21mr7210622iow.21.1634372599984;
 Sat, 16 Oct 2021 01:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com> <CAM9Jb+jDU7anniT8eL5yUQw1t_MZzndw=n1LWJ5fWV5k871+wQ@mail.gmail.com>
In-Reply-To: <CAM9Jb+jDU7anniT8eL5yUQw1t_MZzndw=n1LWJ5fWV5k871+wQ@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sat, 16 Oct 2021 10:23:08 +0200
Message-ID: <CAM9Jb+i5L4D130psUirHRaHbZc=ODrzOp_OQGxpFfsMXbt3eRg@mail.gmail.com>
Subject: Re: [RFC v2 0/2] virtio-pmem: Asynchronous flush
To:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        jmoyer <jmoyer@redhat.com>, David Hildenbrand <david@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping!

Thanks,
Pankaj

On Thu, 19 Aug 2021 at 13:08, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:
>
> Gentle ping.
>
> >
> >  Jeff reported preflush order issue with the existing implementation
> >  of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
> >  for virtio pmem using work queue as done in md/RAID. This patch series
> >  intends to solve the preflush ordering issue and also makes the flush
> >  asynchronous for the submitting thread.
> >
> >  Submitting this patch series for review. Sorry, It took me long time to
> >  come back to this due to some personal reasons.
> >
> >  RFC v1 -> RFC v2
> >  - More testing and bug fix.
> >
> >  [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
> >
> > Pankaj Gupta (2):
> >   virtio-pmem: Async virtio-pmem flush
> >   pmem: enable pmem_submit_bio for asynchronous flush
> >
> >  drivers/nvdimm/nd_virtio.c   | 72 ++++++++++++++++++++++++++++--------
> >  drivers/nvdimm/pmem.c        | 17 ++++++---
> >  drivers/nvdimm/virtio_pmem.c | 10 ++++-
> >  drivers/nvdimm/virtio_pmem.h | 14 +++++++
> >  4 files changed, 91 insertions(+), 22 deletions(-)
> >
> > --
> > 2.25.1
> >
