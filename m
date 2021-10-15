Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8342F93C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241829AbhJOQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbhJOQ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:58:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEAEC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:56:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so7702072pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rseJDUsUddppDbohbSkBM/5HtewlIULW4VGMgF0+/xQ=;
        b=IQFiQUtOxtSojI5RD0jx8K2/1TqmFyFjP2wgYJBVPayxK/X8FiR2MFHaaCQKAfoWHF
         OO/Cq/tIE8ftZrVWurC2mLXqef6aJs72iSQwbwqItwjceei67T6k4fHCwdi/z6xO3zNz
         bvHJDJ3/6HPOIBeKBLlqrZBmhjTBoZsaWg83zIBLPDowMMOtO01Kuj9PNtfneXAu2yUh
         mfC0qCiA1ahjBDONInNwGomF1Rbffx2vDLZ2ef+/1DQ4QlxigGVDQjltOhLsihWuEqgG
         z1muPGtvS/yqvakulyR0WvhdIkF1ezpOnqeSPGJ7/xWz2Zxd0FeNtuUPQMoOgTTF+7Zc
         Bozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rseJDUsUddppDbohbSkBM/5HtewlIULW4VGMgF0+/xQ=;
        b=4C+SOmWYq1hJ7p9lHPHvxcZ1ZBOfX6yL25QkUBrj4RtI57r866tNuXIf1MZWqS076/
         z4U3bsgV3CLMvy+gXyWkePxM+UKqRSJ06nqVp8xNeUieuUGLdCuBxy2MLYPEeiqF9R1z
         CGltvoyhoPjxyN12vaBofnLRyH9H+hWSdS4z6HB0lnXI/xwLT9yi8TkoTtBmqL3CZc9L
         durovxew0emIWBgk7VdfsE6JiFBPxE62dDJlNElQb0jpXNJ6Xlxr5ZEdWsO7cEq7HE7w
         3Th5q50NV0R3/04Nu4WnNisTDNFuzOlQ09YGkHtFsZIwqrCVnlG1SSB2FNPKXR9wkhgE
         CWhg==
X-Gm-Message-State: AOAM5335TMHh0+KJRgTfu1GClrziFjSRMJ+5LRg43w3Q9SM8CQICACFQ
        2pEQ6lgA/Wc5fxSGzMdjNP1gkoEUM0Lx1SN6OlRntQ==
X-Google-Smtp-Source: ABdhPJwr/SzEkevaBKH5tPQiwGaX06NF0U1bUoHev82UApwL1nE6yNCgKypWvidbHKLs5jMcT1g4FW6FwoUUDSFvcpQ=
X-Received: by 2002:a17:90b:350f:: with SMTP id ls15mr14831133pjb.220.1634317011758;
 Fri, 15 Oct 2021 09:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211010042056.GJ3114988@iweiny-DESK2.sc.intel.com> <CAPcyv4hP5ohs10-xC+h=QOH7yiUXji55ubwVG1XfMA006tjR8A@mail.gmail.com>
 <20211015172930.00007f21@Huawei.com>
In-Reply-To: <20211015172930.00007f21@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Oct 2021 09:56:42 -0700
Message-ID: <CAPcyv4gM-wNs6NP7tCKMZfRGoHJd6U8DyPbRr+mO0zUziwFQrA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 9:29 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 13 Oct 2021 15:53:20 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Sat, Oct 9, 2021 at 9:21 PM Ira Weiny <ira.weiny@intel.com> wrote:
> > >
> > > On Sat, Oct 09, 2021 at 09:44:29AM -0700, Dan Williams wrote:
> > > > In addition to carrying @barno, @block_offset, and @reg_type, add @base
> > > > to keep all map/unmap parameters in one object. The helpers
> > > > cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> > > > at map and unmap time.
> > > >
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  drivers/cxl/cxl.h |    1 +
> > > >  drivers/cxl/pci.c |   31 ++++++++++++++++---------------
> > > >  2 files changed, 17 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > > index a6687e7fd598..7cd16ef144dd 100644
> > > > --- a/drivers/cxl/cxl.h
> > > > +++ b/drivers/cxl/cxl.h
> > > > @@ -140,6 +140,7 @@ struct cxl_device_reg_map {
> > > >  };
> > > >
> > > >  struct cxl_register_map {
> > > > +     void __iomem *base;
> > > >       u64 block_offset;
> > > >       u8 reg_type;
> > > >       u8 barno;
> > > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > > index 9f006299a0e3..b42407d067ac 100644
> > > > --- a/drivers/cxl/pci.c
> > > > +++ b/drivers/cxl/pci.c
> > > > @@ -306,8 +306,7 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
> > > >       return 0;
> > > >  }
> > > >
> > > > -static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> > > > -                                       struct cxl_register_map *map)
> > > > +static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> > > >  {
> > > >       void __iomem *addr;
> > > >       int bar = map->barno;
> > > > @@ -318,24 +317,27 @@ static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> > > >       if (pci_resource_len(pdev, bar) < offset) {
> > > >               dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > > >                       &pdev->resource[bar], (unsigned long long)offset);
> > > > -             return NULL;
> > > > +             return -ENXIO;
> > > >       }
> > > >
> > > >       addr = pci_iomap(pdev, bar, 0);
> > > >       if (!addr) {
> > > >               dev_err(dev, "failed to map registers\n");
> > > > -             return addr;
> > > > +             return -ENOMEM;
> > > >       }
> > > >
> > > >       dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
> > > >               bar, offset);
> > > >
> > > > -     return addr;
> > > > +     map->base = addr + map->block_offset;
> > > > +     return 0;
> > > >  }
> > > >
> > > > -static void cxl_pci_unmap_regblock(struct pci_dev *pdev, void __iomem *base)
> > > > +static void cxl_unmap_regblock(struct pci_dev *pdev,
> > > > +                            struct cxl_register_map *map)
> > > >  {
> > > > -     pci_iounmap(pdev, base);
> > > > +     pci_iounmap(pdev, map->base - map->block_offset);
> > >
> > > I know we need to get these in soon.  But I think map->base should be 'base'
> > > and map->block_offset should be handled in cxl_probe_regs() rather than
> > > subtract it here..
> >
> > But why? The goal of the cxl_register_map cleanups is to reduce the
> > open-coding for details that can just be passed around in a @map
> > instance. Once cxl_map_regblock() sets up @base there's little reason
> > to consider the hardware regblock details.
>
> I agree with Ira to the extent that this was a little confusing.   Perhaps it is worth
> a comment at the structure definition to make the relationship of block_offset
> and base clear?
>

I can add that, sure.
