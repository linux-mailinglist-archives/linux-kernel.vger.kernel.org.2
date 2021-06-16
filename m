Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423AB3A8D51
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhFPAUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFPAUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:20:34 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1BDC061760
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:18:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h12so209660plf.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9ut0QO/e/N5V/O+/xxowpWen8UQyCbn6qtxkVe0D8Y=;
        b=JcupgDdHq+fmTtYahFp9g+jILqxB19u88v4xnoU55fWLv4k3YOt/xNPurkbzegMsAG
         NNMrQSJN/bCEgjMYNZUC20WGOBAV1diTK74G7f/VHGvqLwYEedYJtJ3nI0833KtrM7kU
         t9kGTrMECpFStf9TPmnQQJw6nw5sTkNZ2hgie5DWKEimBuk2Ql3jpZVgHKeZscFIfEWT
         FSm5OEwpwmmecOzudMjp4Rt+2O5WBV1LrdshwyVWQvhqJ4gbyL3GU3vgiXpk/OOtUG+R
         9SDYxzyZHGzVP/HJP4qSzGSitzNNqYPJe6gGlgIMCb0EV5UH0BYz1vfNwhv1uIyZDqE+
         Oifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9ut0QO/e/N5V/O+/xxowpWen8UQyCbn6qtxkVe0D8Y=;
        b=b9OXhO69hkzSWUxCiNxhsWoDQDbueNDC4tnDXD8ocsy1XpWaWzrC7Ynl9Tz2Eqo7Ww
         pe1Kg0CFpolJ/+jMK7kmCP5NJsylqGyx2eq57Ib1/NK7JFrsn7VivPigfcgYMM7ibChz
         MBoJENgbV1pNF8k2vLG2UY94Vm6joul1uAkDK3tm+eZ/UjB5LNfzxSDMHuioksaYHgMT
         Bxyg1YmmvIXZy1yjL4KP6k36U8KzIqqHZKgkv6F7+5cCcABWSTGA5/QaehivZD+ZayfE
         mcTTOhlUNfj6YsMCncHlkZPVGx64N8mfGjHxoPrOJN+KmzlnFLS8Wyvn5CGwRT81uUTC
         a+GA==
X-Gm-Message-State: AOAM531nq0ZnXOQJ10njC9M/0zN+0jrv9GVj/JXq9yjf4+y3CT8uo5xu
        Y//OkK3GLBAHgPbO+3zS1SR07pQUgkKzIl04l1OQoQ==
X-Google-Smtp-Source: ABdhPJyDslf/YwZkzYx2Z/IqSadb826GT3g94w753bjCVGDQs7kdVkKXA5TwIzZBSN9veDsTezagh2Bmxl7wkmkaDYQ=
X-Received: by 2002:a17:90a:ea8c:: with SMTP id h12mr7432919pjz.149.1623802708921;
 Tue, 15 Jun 2021 17:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com> <20210604011844.1756145-2-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210604011844.1756145-2-ruansy.fnst@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jun 2021 17:18:18 -0700
Message-ID: <CAPcyv4ibuHeQ7o=sTZpQoryv=_3WuBFJhodBnAEVRPmvo=nAeQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] pagemap: Introduce ->memory_failure()
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 6:19 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrote:

Hi Ruan, apologies for the delays circling back to this.

>
> When memory-failure occurs, we call this function which is implemented
> by each kind of devices.  For the fsdax case, pmem device driver
> implements it.  Pmem device driver will find out the filesystem in which
> the corrupted page located in.  And finally call filesystem handler to
> deal with this error.
>
> The filesystem will try to recover the corrupted data if possiable.
>

Let's move this change to the patch that needs it, this patch does not
do anything on its own.

> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  include/linux/memremap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 45a79da89c5f..473fe18c516a 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
>          * the page back to a CPU accessible page.
>          */
>         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> +
> +       /*
> +        * Handle the memory failure happens on one page.  Notify the processes
> +        * who are using this page, and try to recover the data on this page
> +        * if necessary.
> +        */

I thought we discussed that this needed to be range based here:

https://lore.kernel.org/r/CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com

...but also incorporate Christoph's feedback to not use notifiers.

> +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> +                             int flags);

Change this callback to

int (*notify_memory_failure)(struct dev_pagemap *pgmap, unsigned long
pfn, unsigned long nr_pfns)

...to pass a range and to clarify that this callback is for
memory_failure() to notify the pgmap, the pgmap notifies the owner via
the holder callbacks.
