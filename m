Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA17406E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 17:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhIJPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbhIJPno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:43:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA29C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:42:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g14so2214660pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SiGov35SyrsNa0p/ygBsXRJGs1dQPnAwPQrLMje8peY=;
        b=OhnY6WvivfLN56CFZm2k0VBJ7cJc6GXoso1feCmNuLK8xVSKyNXzypQNHUMoueR81T
         7BAQp8lvgS6+TnBycew5IfreukV5O+HzfQAtQ7TL/uBxrlNXrKBmpJj/yHZMNJ0/7R6g
         IY58OotEPjfFC/tQGdNvx8wa8I46YCObxV3jV/MCEmfvZb+6ypkV9Khryt80BGswpAwm
         8sqtZ/FZygb5Zm33K0mpwsWQlH78jEQEfxT02gtE5FRC/SkrWoEx7FbVMKuGfQ0SoljM
         lSBHY8KsBFLsPIHxc8BNhCHsrBf9E9seNirDnGkTqbnNf84BdhGzyhrY+mmy5OTDo6W/
         YSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SiGov35SyrsNa0p/ygBsXRJGs1dQPnAwPQrLMje8peY=;
        b=32PHIBRDKI+u//cUWHEl0rhzICZowv3of8ryaKz5Jxqqs1SG6Z8p1MUjQJDmwbHruI
         eBlzqOdqshcLURvQ9NJ4lhkh34y6MSm5RYcZRfiRMs4t085KpXgy5R9ZtWSUdOnWCzpO
         6Q1804cXegWRgGVp15rd57rlJBDPNRcYzrUxnXiGtRONH/gkKJ6qTVRPRLRYDjX/bMN3
         pPggPeq8PGoMTbBvpq6MpwWDUVlyqA9qz4HVDEejZ91/ttCp+talklSSEBF0zvIVjytT
         VTS23QmL0vm404h0s3BKuXJPPHEPnZLzPwariw7PfKPN/lwSnJBXafIiBLxyAFn8jXIw
         WjFw==
X-Gm-Message-State: AOAM530UDk4KWKqUN+dFBYmO5gLiDtdidNt2S/KvqOjXE8GIojL2bxqL
        AlvqKC72SXKQoxuvXEjJX/5YMWJbGhhcjMG6a73hZA==
X-Google-Smtp-Source: ABdhPJySmKiB3mBJQHU9hN5iTUa8KrMdmCh9lgDsiS2zVvc6bLRexKehjl8yUaSsg/UkCBe+LeshF6hEHQSQKLitJ4s=
X-Received: by 2002:a05:6a00:1a10:b0:412:448c:89ca with SMTP id
 g16-20020a056a001a1000b00412448c89camr8871652pfv.86.1631288552597; Fri, 10
 Sep 2021 08:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210910124628.6261-1-justin.he@arm.com>
In-Reply-To: <20210910124628.6261-1-justin.he@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Sep 2021 08:42:21 -0700
Message-ID: <CAPcyv4ie_ZzEwrrKJEVrDP19UWAgSiW3GU9f99EqX0e6BPQDPA@mail.gmail.com>
Subject: Re: [PATCH v2] device-dax: use fallback nid when numa node is invalid
To:     Jia He <justin.he@arm.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 5:46 AM Jia He <justin.he@arm.com> wrote:
>
> Previously, numa_off was set unconditionally in dummy_numa_init()
> even with a fake numa node. Then ACPI sets node id as NUMA_NO_NODE(-1)
> after acpi_map_pxm_to_node() because it regards numa_off as turning
> off the numa node. Hence dev_dax->target_node is NUMA_NO_NODE on
> arm64 with fake numa case.
>
> Without this patch, pmem can't be probed as RAM devices on arm64 if
> SRAT table isn't present:
>   $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
>   kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
>   kmem: probe of dax0.0 failed with error -22
>
> This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
> v2: - rebase it based on David's "memory group" patch.
>     - drop the changes in dev_dax_kmem_remove() since nid had been
>       removed in remove_memory().
>  drivers/dax/kmem.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..e4836eb7539e 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -47,20 +47,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>         unsigned long total_len = 0;
>         struct dax_kmem_data *data;
>         int i, rc, mapped = 0;
> -       int numa_node;
> -
> -       /*
> -        * Ensure good NUMA information for the persistent memory.
> -        * Without this check, there is a risk that slow memory
> -        * could be mixed in a node with faster memory, causing
> -        * unavoidable performance issues.
> -        */
> -       numa_node = dev_dax->target_node;
> -       if (numa_node < 0) {
> -               dev_warn(dev, "rejecting DAX region with invalid node: %d\n",
> -                               numa_node);
> -               return -EINVAL;
> -       }
> +       int numa_node = dev_dax->target_node;
>
>         for (i = 0; i < dev_dax->nr_range; i++) {
>                 struct range range;
> @@ -71,6 +58,22 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>                                         i, range.start, range.end);
>                         continue;
>                 }
> +
> +               /*
> +                * Ensure good NUMA information for the persistent memory.
> +                * Without this check, there is a risk but not fatal that slow
> +                * memory could be mixed in a node with faster memory, causing
> +                * unavoidable performance issues. Warn this and use fallback
> +                * node id.
> +                */
> +               if (numa_node < 0) {
> +                       int new_node = memory_add_physaddr_to_nid(range.start);
> +
> +                       dev_info(dev, "changing nid from %d to %d for DAX region [%#llx-%#llx]\n",
> +                                numa_node, new_node, range.start, range.end);
> +                       numa_node = new_node;
> +               }
> +
>                 total_len += range_len(&range);

This fallback change belongs where the parent region for the namespace
adopts its target_node, because it's not clear
memory_add_physaddr_to_nid() is the right fallback in all situations.
Here is where this setting is happening currently:

drivers/acpi/nfit/core.c:3004:          ndr_desc->target_node =
pxm_to_node(spa->proximity_domain);
drivers/acpi/nfit/core.c:3007:          ndr_desc->target_node = NUMA_NO_NODE;
drivers/nvdimm/e820.c:29:       ndr_desc.target_node = nid;
drivers/nvdimm/of_pmem.c:58:            ndr_desc.target_node =
ndr_desc.numa_node;
drivers/nvdimm/region_devs.c:1127:      nd_region->target_node =
ndr_desc->target_node;

...where is this pmem region originating on this arm64 platform?
