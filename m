Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847E440BF3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 07:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhIOFR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 01:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhIOFRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 01:17:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6F4C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:16:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n4so888371plh.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLTGBcZj0GiroOYOwsXeB4IRrRlHOBSuTjJevLR3oGQ=;
        b=ra+C/DC/11ZC7mZjfPLq+lXqCO3MnccAGWsrzjLMK/YTGRxjKRDJdeEociIUz1QWjR
         4ypBGEzk4QmVQ9vvenMvFuQ/u8c7UKdojT7lQ5bkFycmImFC9IGjyqfbMeQIc2/1LDum
         lz74ZsZH6TMCuP7El2sFCvnNgKHcXZff9lOUFOc8wemF2n9pEtNR/AFMovlITiwta6m8
         5uMYjt6TkbUvGlip//SGGpbjtykJVX3EeJ9iSD6lSVxLyUY8b6ImIaiuVlGamPANnMSD
         P9i3twLXpjDFXjiujpphMz0cfWZYAWcKwTkKWBT3piPh3HbQi63pyDSg4Tj+Wo+P7Zbk
         6ccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLTGBcZj0GiroOYOwsXeB4IRrRlHOBSuTjJevLR3oGQ=;
        b=dpMhpBJjP8w2nzTvOdpMMR+vAiRPYFYZ9FQV7hjX87kPeRd6B9TeaoHKYVtYeA2/2N
         ozd8TWm1K5G23TmHtJgKMDaDWHHIsAFzC7lcsBe25xmQu+n3vchWxY50Uaotj6Vh77Nb
         loXkDKN3NVa2ns+3058UlHH5EOGKWUTt5rJJcQsr1dUCbrf+wffAsCduMBbenUG3YRY5
         VwMBZ8vRmxIpJoNj+iIJJ3aD+pQ9sblTIoh+Xf6bA0+3RLxdzgYCeicozZkPsizgpBnK
         rFDygeJmXvhlXaZnCvyMG6Lt88UF3GEYAt7Y0qEc5vcJipa9O05av3uXGGf28FMSBql8
         Y1OQ==
X-Gm-Message-State: AOAM532pvzY/n+hHF72Wr/6DQrmaQRtzxCFAeLj3+uU5tCRzIR23E3H2
        qhSpLlZnpBVFLs14XMaE54Wgpytf/kzkcRW4Rw3hCw==
X-Google-Smtp-Source: ABdhPJy9a4IF29cCAlgXRi3+CMQH7qLhWTQYDNS8J74GqkpYnqQnzUdXZjsMFDQY7a7oIS69cPAnAExOkyXxwfmjSKY=
X-Received: by 2002:a17:902:e80f:b0:13b:721d:f750 with SMTP id
 u15-20020a170902e80f00b0013b721df750mr18194024plg.18.1631682965524; Tue, 14
 Sep 2021 22:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210910124628.6261-1-justin.he@arm.com> <CAPcyv4ie_ZzEwrrKJEVrDP19UWAgSiW3GU9f99EqX0e6BPQDPA@mail.gmail.com>
 <AM6PR08MB4376FC35158104629C603197F7DA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376FC35158104629C603197F7DA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 14 Sep 2021 22:15:54 -0700
Message-ID: <CAPcyv4gyCHTcXUSLcsgnX8o0JUfpSNf8B=7zbfcZcvWFCUSCvw@mail.gmail.com>
Subject: Re: [PATCH v2] device-dax: use fallback nid when numa node is invalid
To:     Justin He <Justin.He@arm.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 7:06 PM Justin He <Justin.He@arm.com> wrote:
>
> Hi Dan,
>
> > -----Original Message-----
> > From: Dan Williams <dan.j.williams@intel.com>
> > Sent: Friday, September 10, 2021 11:42 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>; Dave Jiang
> > <dave.jiang@intel.com>; David Hildenbrand <david@redhat.com>; Linux NVDIMM
> > <nvdimm@lists.linux.dev>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2] device-dax: use fallback nid when numa node is
> > invalid
> >
> > On Fri, Sep 10, 2021 at 5:46 AM Jia He <justin.he@arm.com> wrote:
> > >
> > > Previously, numa_off was set unconditionally in dummy_numa_init()
> > > even with a fake numa node. Then ACPI sets node id as NUMA_NO_NODE(-1)
> > > after acpi_map_pxm_to_node() because it regards numa_off as turning
> > > off the numa node. Hence dev_dax->target_node is NUMA_NO_NODE on
> > > arm64 with fake numa case.
> > >
> > > Without this patch, pmem can't be probed as RAM devices on arm64 if
> > > SRAT table isn't present:
> > >   $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g
> > -a 64K
> > >   kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with
> > invalid node: -1
> > >   kmem: probe of dax0.0 failed with error -22
> > >
> > > This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > > v2: - rebase it based on David's "memory group" patch.
> > >     - drop the changes in dev_dax_kmem_remove() since nid had been
> > >       removed in remove_memory().
> > >  drivers/dax/kmem.c | 31 +++++++++++++++++--------------
> > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > > index a37622060fff..e4836eb7539e 100644
> > > --- a/drivers/dax/kmem.c
> > > +++ b/drivers/dax/kmem.c
> > > @@ -47,20 +47,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> > >         unsigned long total_len = 0;
> > >         struct dax_kmem_data *data;
> > >         int i, rc, mapped = 0;
> > > -       int numa_node;
> > > -
> > > -       /*
> > > -        * Ensure good NUMA information for the persistent memory.
> > > -        * Without this check, there is a risk that slow memory
> > > -        * could be mixed in a node with faster memory, causing
> > > -        * unavoidable performance issues.
> > > -        */
> > > -       numa_node = dev_dax->target_node;
> > > -       if (numa_node < 0) {
> > > -               dev_warn(dev, "rejecting DAX region with invalid
> > node: %d\n",
> > > -                               numa_node);
> > > -               return -EINVAL;
> > > -       }
> > > +       int numa_node = dev_dax->target_node;
> > >
> > >         for (i = 0; i < dev_dax->nr_range; i++) {
> > >                 struct range range;
> > > @@ -71,6 +58,22 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
> > >                                         i, range.start, range.end);
> > >                         continue;
> > >                 }
> > > +
> > > +               /*
> > > +                * Ensure good NUMA information for the persistent
> > memory.
> > > +                * Without this check, there is a risk but not fatal
> > that slow
> > > +                * memory could be mixed in a node with faster memory,
> > causing
> > > +                * unavoidable performance issues. Warn this and use
> > fallback
> > > +                * node id.
> > > +                */
> > > +               if (numa_node < 0) {
> > > +                       int new_node =
> > memory_add_physaddr_to_nid(range.start);
> > > +
> > > +                       dev_info(dev, "changing nid from %d to %d for
> > DAX region [%#llx-%#llx]\n",
> > > +                                numa_node, new_node, range.start,
> > range.end);
> > > +                       numa_node = new_node;
> > > +               }
> > > +
> > >                 total_len += range_len(&range);
> >
> > This fallback change belongs where the parent region for the namespace
> > adopts its target_node, because it's not clear
> > memory_add_physaddr_to_nid() is the right fallback in all situations.
> > Here is where this setting is happening currently:
> >
> > drivers/acpi/nfit/core.c:3004:          ndr_desc->target_node =
> > pxm_to_node(spa->proximity_domain);
> On my local arm64 guest('virt' machine type), the target_node is
> set to -1 at this line.
> That is:
> The condition "spa->flags & ACPI_NFIT_PROXIMITY_VALID" is hit.
>
> > drivers/acpi/nfit/core.c:3007:          ndr_desc->target_node =
> > NUMA_NO_NODE;
> > drivers/nvdimm/e820.c:29:       ndr_desc.target_node = nid;
> > drivers/nvdimm/of_pmem.c:58:            ndr_desc.target_node =
> > ndr_desc.numa_node;
> > drivers/nvdimm/region_devs.c:1127:      nd_region->target_node =
> > ndr_desc->target_node;
>
>
> Sorry,Dan. I thought I missed your previous mail:
>
> =========================================
> Looks like it is the NFIT driver, thanks.
>
> If you're getting NUMA_NO_NODE in dax_kmem from the NFIT driver in
> means your ACPI NFIT table is failing to populate correct numa
> information. You could try the following to fix it up, but I think the
> real problem is that your platform BIOS needs to add the proper numa
> data.
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index fb775b967c52..d3a0cec635b1 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3005,15 +3005,8 @@ static int acpi_nfit_register_region(struct
> acpi_nfit_desc *acpi_desc,
>         ndr_desc->res = &res;
>         ndr_desc->provider_data = nfit_spa;
>         ndr_desc->attr_groups = acpi_nfit_region_attribute_groups;
> -       if (spa->flags & ACPI_NFIT_PROXIMITY_VALID) {
> -               ndr_desc->numa_node = acpi_map_pxm_to_online_node(
> -                                               spa->proximity_domain);
> -               ndr_desc->target_node = acpi_map_pxm_to_node(
> -                               spa->proximity_domain);
> -       } else {
> -               ndr_desc->numa_node = NUMA_NO_NODE;
> -               ndr_desc->target_node = NUMA_NO_NODE;
> -       }
> +       ndr_desc->numa_node = memory_add_physaddr_to_nid(spa->address);
> +       ndr_desc->target_node = phys_to_target_node(spa->address);
>
>         /*
>          * Persistence domain bits are hierarchical, if
> ===================================================
>
> Do you still suggest fixing like this?

Are you saying that ACPI_NFIT_PROXIMITY_VALID is not set on your
platform, or that pxm_to_node() returns NUMA_NO_NODE?

I would expect something like this:

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a3ef6cce644c..95de7dc18ed8 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3007,6 +3007,15 @@ static int acpi_nfit_register_region(struct
acpi_nfit_desc *acpi_desc,
                ndr_desc->target_node = NUMA_NO_NODE;
        }

+       /*
+        * Fallback to address based numa information if node lookup
+        * failed
+        */
+       if (ndr_desc->numa_node == NUMA_NO_NODE)
+               ndr_desc->numa_node = memory_add_physaddr_to_nid(spa->address);
+       if (ndr_desc->target_node == NUMA_NO_NODE)
+               phys_to_target_node(spa->address);
+
        /*
         * Persistence domain bits are hierarchical, if
         * ACPI_NFIT_CAPABILITY_CACHE_FLUSH is set then
