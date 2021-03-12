Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E5D3385A2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCLGDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:03:04 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD5EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:03:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mm21so51057440ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfCBCTaP1vXjkaRzljC2VcBZdRN8O9pFYDwkYEocyzU=;
        b=lxffCQD3jaOe97GKa/5NQMiB73O5eAi76/tyW3Pu+JhPNjDzbPRvMOyRY/aHQlUGnn
         cIhlguDTYjUgB4cjRxPgHONNDtBsJFAmJGEQhDXExPZJ/JOfXFozZ93HM5KsC67SyXY9
         c2W2orXhUnalqNJjPfemhU9vcAMz1Q8aiHcaEeIbMb5dKJOLyeROZpkzFjHxSkTfnGFT
         nzfJIr7OYETT2chi6BgSrS7wZUz0PUlm774qQ3az4YXGsWxy0C39CFsPyWcxVt8vXgNY
         7m0TQOLbGn9cflSRrjOfGL23t7JKa3GHFlJVARDcn7tHyyrmrAGYOadgzO1X82NnBvnb
         mibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfCBCTaP1vXjkaRzljC2VcBZdRN8O9pFYDwkYEocyzU=;
        b=NVf+oM8qcmDugYK+vlaP0E7tMGFC9o2gZZnz879Rf4iZIk+j1E5iJ9Kam1jmkJr8C8
         azkcDQSuLQxI89QTkkcd5wQRqJC9dMgtXuVd8/rRARlVLGe37/I8TgQor0mwW6T9UDjh
         /+OTbKIpE7XNFagkyiKwvFVzTpRkhEk24Wh2qCdx1nMeeV6S4b2YeWvi8/qE5+3/D4pW
         dksP7hJ3tYG6CCNtM0i3Ob1gdXCk4sEy2pnw+f3Sar16LH1ffk/wR5NzYF52BdQNkA/r
         XHE8isVrdziE/JSlTYpqUDc1B13496Rl+atAbwDS+GBzcV5TqdvoZgqbK9X1c/1NRn/k
         EVnQ==
X-Gm-Message-State: AOAM531D2ES2iHWgaw3pzbrN+rBGLA4RyYxEjK2pZv9Leoq6AsiExP8S
        D+09itb5rwpF4njyzjmMBKc7eXU+DmZCoLKLidaYXg==
X-Google-Smtp-Source: ABdhPJxDQvayRA8ra9dwsMhMsScdFFOH6MxL7dzrw5+/N+8T56mvPYwThVzjLbUxJJ0BINW83E36ex9iut3BH0vYjNo=
X-Received: by 2002:a17:906:1bf2:: with SMTP id t18mr6807846ejg.418.1615528982973;
 Thu, 11 Mar 2021 22:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20200420131947.41991-1-pankaj.gupta.linux@gmail.com>
 <7e55abc4-5c91-efb8-1b32-87570dde62cc@redhat.com> <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
In-Reply-To: <CALzYo33i5nBuPj4c3cJCZB9qEwfjypDqXf9vtn2wJdTYCFxg8g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 11 Mar 2021 22:02:52 -0800
Message-ID: <CAPcyv4i4=2zT65Ym-sQv4gSa421q7FUAcX6Un3hf8=FW5qi3yw@mail.gmail.com>
Subject: Re: [RFC 0/2] virtio-pmem: Asynchronous flush
To:     Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, jmoyer <jmoyer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 8:21 PM Pankaj Gupta
<pankaj.gupta@cloud.ionos.com> wrote:
>
> Hi David,
>
> > >   Jeff reported preflush order issue with the existing implementation
> > >   of virtio pmem preflush. Dan suggested[1] to implement asynchronous flush
> > >   for virtio pmem using work queue as done in md/RAID. This patch series
> > >   intends to solve the preflush ordering issue and also makes the flush
> > >   asynchronous from the submitting thread POV.
> > >
> > >   Submitting this patch series for feeback and is in WIP. I have
> > >   done basic testing and currently doing more testing.
> > >
> > > Pankaj Gupta (2):
> > >    pmem: make nvdimm_flush asynchronous
> > >    virtio_pmem: Async virtio-pmem flush
> > >
> > >   drivers/nvdimm/nd_virtio.c   | 66 ++++++++++++++++++++++++++----------
> > >   drivers/nvdimm/pmem.c        | 15 ++++----
> > >   drivers/nvdimm/region_devs.c |  3 +-
> > >   drivers/nvdimm/virtio_pmem.c |  9 +++++
> > >   drivers/nvdimm/virtio_pmem.h | 12 +++++++
> > >   5 files changed, 78 insertions(+), 27 deletions(-)
> > >
> > > [1] https://marc.info/?l=linux-kernel&m=157446316409937&w=2
> > >
> >
> > Just wondering, was there any follow up of this or are we still waiting
> > for feedback? :)
>
> Thank you for bringing this up.
>
> My apologies I could not followup on this. I have another version in my local
> tree but could not post it as I was not sure if I solved the problem
> correctly. I will
> clean it up and post for feedback as soon as I can.
>
> P.S: Due to serious personal/family health issues I am not able to
> devote much time
> on this with other professional commitments. I feel bad that I have
> this unfinished task.
> Just in last one year things have not been stable for me & my family
> and still not getting :(

No worries Pankaj. Take care of yourself and your family. The
community can handle this for you. I'm open to coaching somebody
through what's involved to get this fix landed.
