Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAC3389AB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhETBCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhETBCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:02:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB998C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:01:02 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id c20so22640123ejm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PV93lQCglOhbMGVMfJuGtexcibz93Be8FcNhBRCyYy0=;
        b=0fuJ485GdotQotosDlB7w8ZsyIW7lXvt6u5gXJL0+f4VdHJTL/zW0IZBFksc3Rd/OE
         lO/rDEXFXwGylfro3ffeLx9mrxQGY2Zxa/ba3yz7+TFIfpXk5fmtclz7uWzIN0C/jXOr
         WcnV612JXZOHC9kkbcSN42WyS5XLrTp/yTLIvDObuB80PeKq3znZ0ufQKg+FCvvh9ETv
         gFUHJ1G3ZOzeKXD0lqu1wH+C6zdfQw1LR/z7H6NnrQrIWl72kUsSlwpvbdrQwUQu9+Cp
         HCFpOJpmjfXsm6Yd2Nvjq3e1ftsk1gpClygpra1G7XRqTssvN04/h9idzkTsdSKqHk3B
         mtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PV93lQCglOhbMGVMfJuGtexcibz93Be8FcNhBRCyYy0=;
        b=QKBuhvoZHPyu639dq+vcQgfd8LjKtn4Oo37IgbpoQ/uVqKxWv2r+lIj87se+feLI45
         bqeLJNPvhBGq1BvWnaADeF9NvH+JBoWXHIdVaEYMqBfulEH3Bq5Bo5Egr+sjjJ0Lo+Vs
         Bqa+shPYDkellzfdWlrmssMAMmiCbBfAfovb/zXLo+BO5pbWhtYfF6ai8BCFAFsbWxQv
         7g+mjz+ndRxcQMhBKB4Dl48AVlfnQCzWyMuWX+GhvUKVgm66GGV3U6G3ld/1ut/mkALL
         MlLuZlSsXEs3vLDa/RLa2xcjjh0lFCS2lvLDB1xCvULsH9PHgWL/NMjV7c4QEVAdrULd
         g7Cg==
X-Gm-Message-State: AOAM530Rh7eNNuRRtRDlVgrfNoH29vnnBMjV9SFxymr+YynuEqeevdy4
        CXB9V8XK24PPffUgNjo6ph5n0A/lF8jHXT0PF0fi6A==
X-Google-Smtp-Source: ABdhPJyETbYYVte2ikhLlYPAxcbuZKTTPSS3w05FELgDFPBeHQdzaOWTSiibIqTRXuxuSv5Z383WA+LZCv2bbWtco7U=
X-Received: by 2002:a17:906:e210:: with SMTP id gf16mr2003631ejb.472.1621472461276;
 Wed, 19 May 2021 18:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210506223654.1310516-1-ira.weiny@intel.com> <20210506223654.1310516-3-ira.weiny@intel.com>
In-Reply-To: <20210506223654.1310516-3-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 18:00:51 -0700
Message-ID: <CAPcyv4i3V2AYqoSzA=V265aUx5VpZbMXu0zFw0nk_f3FdCr-Yw@mail.gmail.com>
Subject: Re: [PATCH 2/4] cxl/mem: Reserve all device regions at once
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 3:37 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> In order to remap individual register sets each bar region must be
> reserved prior to mapping.  Because the details of individual register
> sets are contained within the BARs themselves, the bar must be mapped 2
> times, once to extract this information and a second time for each
> register set.
>
> Rather than attempt to reserve each BAR individually and track if that
> bar has been reserved.  Open code pcim_iomap_regions() by first
> reserving all memory regions on the device and then mapping the bars
> individually as needed.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 191603b4e10b..40016709b310 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -926,9 +926,9 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32
>  {
>         struct pci_dev *pdev = cxlm->pdev;
>         struct device *dev = &pdev->dev;
> +       void __iomem *rc;
>         u64 offset;
>         u8 bar;
> -       int rc;
>
>         offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
>         bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> @@ -940,13 +940,14 @@ static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32
>                 return (void __iomem *)ERR_PTR(-ENXIO);
>         }
>
> -       rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> -       if (rc) {
> +       rc = pcim_iomap(pdev, bar, 0);

It is odd that the temporary region pinning uses non-pcim, but the
temporary mapping using pcim.

> +       if (!rc) {
>                 dev_err(dev, "failed to map registers\n");
> -               return (void __iomem *)ERR_PTR(rc);
> +               return (void __iomem *)ERR_PTR(-ENOMEM);

I think since this support is a bug/compatibility fix it should
probably be rebased to current cxl.git#next. If you still end up
needing to return an __iomem ERR_PTR() then use IOMEM_ERR_PTR.

>         }
>
> -       dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> +       dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ 0x%llx\n",

s/0x%llx/%#llx/

> +               bar, offset);
>
>         return pcim_iomap_table(pdev)[bar] + offset;
>  }
> @@ -999,6 +1000,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>                 return -ENXIO;
>         }
>
> +       if (pci_request_mem_regions(pdev, pci_name(pdev)))

This tells me this patch is too fine grained and can't stand alone
because it is missing the corresponding call to
pci_release_mem_regions(). Ideally this would be kept in the same
scope as the temporary io mapping.

> +               return -ENODEV;
> +
>         /* Get the size of the Register Locator DVSEC */
>         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> --
> 2.28.0.rc0.12.gb6a658bd00c9
>
