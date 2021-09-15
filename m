Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31F40C9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhIOQYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhIOQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:24:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:22:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so5343167pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uo9eXS3r1ePjhHgKEVY7iDRGL6C2CVufWx2q0EBxp6c=;
        b=VbSQ6m+QZ2Ovtk44be3X7yH2ZcuXgRlB+8QKMGJHG/EN0obGcxP9LIOS9PpfBAjt5s
         SdgAt7cKxRsI40DCPobdI9zsLGClZhLcAGTSarAKUV3NQDMDUhcEMY4xw7/LU5yGUNxZ
         lv2KdmqEUqRmftpvW/6jXrZUy58U8iLvue7Foxpx7qe7UaSOxcAB3k/JLO9vOBt4uKl5
         ki+GbQMJADLKXRYjzsFUQrZ2gpF1bc+HYMEmyPpV0U+tRPUxi+toWEwSRCR90rSiM8Yc
         YLxyMlCRsOjX8KJhi+8L6utnlNCPt8OjbFduBG6YqMnH7BMFfFGm7UHuF0yfK+/qlCng
         Rlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uo9eXS3r1ePjhHgKEVY7iDRGL6C2CVufWx2q0EBxp6c=;
        b=og8QGcQ0CrzhPypLozpYxPTJiRhkZp8afnvxDYc1EiUgDM0oK6AHE+F/fvJSTB53GZ
         y8RHWavJdFLEqLjDBJIyEA1BOR//Tu+Duki1p5X6bp3T5eEW/6kW/zEjlrzGbnfcFs40
         5+OH2qUOnJWcEN9NeOKg9n1sdBJdv7Z9QElGDkZ+GzIgXZ1Gfll1/GwsGHEK1XyBsbz1
         wzRSBasMMFvjVK8WDvYufOr/9qKhGY1AleOnnvWQ9CrTVcp2aexSG05GVcd/sTNT5VJ8
         ZjuioD4VKKaioi4g4oBlcYdRGFXeUJAMbux9I9OnRXJGcvzZd35JlfTJ6EXmeS7AH5l6
         CYsg==
X-Gm-Message-State: AOAM531vBUP8MckR5oNXnivyNwbs0YeGm241F6P8vm6P6fkNQRMg6swJ
        W8gPKuTyobvE1RGHwWmtzrNODPvvtgWBIK3peJOioA==
X-Google-Smtp-Source: ABdhPJxfUGSb+GUqBJtlSscG5n9JftXnWgXq3rUqcLOxL+UT8vNGrvZsFtC4IKySAWzvT+Gcd/iQJo9UqpPmNuL8cLA=
X-Received: by 2002:a17:90b:3b84:: with SMTP id pc4mr658569pjb.220.1631722970520;
 Wed, 15 Sep 2021 09:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210910124628.6261-1-justin.he@arm.com> <CAPcyv4ie_ZzEwrrKJEVrDP19UWAgSiW3GU9f99EqX0e6BPQDPA@mail.gmail.com>
 <AM6PR08MB4376FC35158104629C603197F7DA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <CAPcyv4gyCHTcXUSLcsgnX8o0JUfpSNf8B=7zbfcZcvWFCUSCvw@mail.gmail.com> <AM6PR08MB4376877792291C237AE1AE30F7DB9@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376877792291C237AE1AE30F7DB9@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Sep 2021 09:22:39 -0700
Message-ID: <CAPcyv4j6rusw7ixpjLsTK3NhJDD_poTp8dUKjQ45jn=vuqgncw@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 11:51 PM Justin He <Justin.He@arm.com> wrote:
[..]
> > > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > > index fb775b967c52..d3a0cec635b1 100644
> > > --- a/drivers/acpi/nfit/core.c
> > > +++ b/drivers/acpi/nfit/core.c
> > > @@ -3005,15 +3005,8 @@ static int acpi_nfit_register_region(struct
> > > acpi_nfit_desc *acpi_desc,
> > >         ndr_desc->res = &res;
> > >         ndr_desc->provider_data = nfit_spa;
> > >         ndr_desc->attr_groups = acpi_nfit_region_attribute_groups;
> > > -       if (spa->flags & ACPI_NFIT_PROXIMITY_VALID) {
> > > -               ndr_desc->numa_node = acpi_map_pxm_to_online_node(
> > > -                                               spa->proximity_domain);
> > > -               ndr_desc->target_node = acpi_map_pxm_to_node(
> > > -                               spa->proximity_domain);
> > > -       } else {
> > > -               ndr_desc->numa_node = NUMA_NO_NODE;
> > > -               ndr_desc->target_node = NUMA_NO_NODE;
> > > -       }
> > > +       ndr_desc->numa_node = memory_add_physaddr_to_nid(spa->address);
> > > +       ndr_desc->target_node = phys_to_target_node(spa->address);
> > >
> > >         /*
> > >          * Persistence domain bits are hierarchical, if
> > > ===================================================
> > >
> > > Do you still suggest fixing like this?
> >
> > Are you saying that ACPI_NFIT_PROXIMITY_VALID is not set on your
> > platform, or that pxm_to_node() returns NUMA_NO_NODE?
> >
> Latter,  ACPI_NFIT_PROXIMITY_VALID is *set* in my case.
>
> > I would expect something like this:
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index a3ef6cce644c..95de7dc18ed8 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -3007,6 +3007,15 @@ static int acpi_nfit_register_region(struct
> > acpi_nfit_desc *acpi_desc,
> >                 ndr_desc->target_node = NUMA_NO_NODE;
> >         }
> >
> > +       /*
> > +        * Fallback to address based numa information if node lookup
> > +        * failed
> > +        */
> > +       if (ndr_desc->numa_node == NUMA_NO_NODE)
> > +               ndr_desc->numa_node = memory_add_physaddr_to_nid(spa-
> > >address);
> > +       if (ndr_desc->target_node == NUMA_NO_NODE)
> > +               phys_to_target_node(spa->address);
> > +
>
> Would it better to add a dev_info() here to report this node id changing?

Yes, given all the possibilities here, a dev_info() reporting the
final result of the node mapping is justifiable.
