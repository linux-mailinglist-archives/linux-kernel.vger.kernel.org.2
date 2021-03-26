Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C769F34B1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCZWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhCZWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:04:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508AAC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 15:04:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx7so7906993edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NhMbn4GcAMbl9agNWrxMfpoDWOn9OHOKSjI2XlOKPcA=;
        b=JsRhNPVll2FnHcGnjMcKrlYEx0lYJGoaiEVYaYgYs0q/tSIU1iebSMJV2C4qXRNVHC
         j/xpHuTprrCE4mV4OBoEqPoLmBa4SbSIGF9YUwooquw7ZoXBZBPV3cFbJjfeOF+B233g
         pjXd5mtup9UXuW2zyO/jkUTpyMnUc3JSedUah8trDhNHU/4hDKbDRufTfhI8csZDzfCz
         UjWdiOEshHoumIBLy5vl9wrVfaQBk4bSwT9RzLGbv8TR0ondD0H1q7HjwDIUcATSTqd2
         QYWEhwxdF/H5kTqSSiJFq2epyi3OIXJnchlgid7OKnKfV9iULl572sNFNI6Lm1oFH4fY
         35JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhMbn4GcAMbl9agNWrxMfpoDWOn9OHOKSjI2XlOKPcA=;
        b=NmPRmyhbDN/MgyQponTrntIiJbQUTiiz8IxGI1LGlZip8GNLx2bgv9U4AhWrMVdG9w
         p95rBxsjuXn4hplio3na6FCUjxrhHH2Hwkv71fXx1Ya2Bypun06HG62rWbCVPYij0dt0
         yVC9bd/iZofWjAubB8L8QNXx84L/bZGKYo30WMo8FV23glUPz2VAByU8OPIuXi2O1DJj
         vXhOSQMcji9/DgZBb3VJSLWOZ26GbKNz5BcdzExWHhFiJXqFvI2cBmmKiiCqUNfuYlpt
         o5nqalS9xtp14xAUZ/9lBDoEUUDGAwfcx23L+iFWHs2RI+Of2XAB/3ueAcMECFCmuSzF
         M8uA==
X-Gm-Message-State: AOAM5302mWHSZOAg30yONpl+VQq1dAvSQwenuRgg91b4TylDkfN9tajP
        Y36Xl7tLzMOSnzFFeUxtLKItnsK9/Pgjc+LHKzpzTuuui1cecw==
X-Google-Smtp-Source: ABdhPJxQD721Oskyn5CTedmmIY6VdwsAeChWfKtYyILt4a/FIBJNX//QnvQnTOKlKoSRC/oYPGEBtznjlD1/YyRBNuk=
X-Received: by 2002:a05:6402:c88:: with SMTP id cm8mr17363764edb.62.1616796243247;
 Fri, 26 Mar 2021 15:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
In-Reply-To: <20210326152645.85225-1-tyhicks@linux.microsoft.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 26 Mar 2021 18:03:27 -0400
Message-ID: <CA+CK2bB_ZeThG=i-RgrZo6By-c1sSvSdgP0+Wk95qVp_LX0xYw@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/region: Allow setting align attribute on
 regions without mappings
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:27 AM Tyler Hicks
<tyhicks@linux.microsoft.com> wrote:
>
> The alignment constraint for namespace creation in a region was
> increased, from 2M to 16M, for non-PowerPC architectures in v5.7 with
> commit 2522afb86a8c ("libnvdimm/region: Introduce an 'align'
> attribute"). The thought behind the change was that region alignment
> should be uniform across all architectures and, since PowerPC had the
> largest alignment constraint of 16M, all architectures should conform to
> that alignment.
>
> The change regressed namespace creation in pre-defined regions that
> relied on 2M alignment but a workaround was provided in the form of a
> sysfs attribute, named 'align', that could be adjusted to a non-default
> alignment value.
>
> However, the sysfs attribute's store function returned an error (-ENXIO)
> when userspace attempted to change the alignment of a region that had no
> mappings. This affected 2M aligned regions of volatile memory that were
> defined in a device tree using "pmem-region" and created by the
> of_pmem_region_driver, since those regions do not contain mappings
> (ndr_mappings is 0).
>
> Allow userspace to set the align attribute on pre-existing regions that
> do not have mappings so that namespaces can still be within those
> regions, despite not being aligned to 16M.
>
> Fixes: 2522afb86a8c ("libnvdimm/region: Introduce an 'align' attribute")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

This solves the problem that I had in this thread:
https://lore.kernel.org/lkml/CA+CK2bCD13JBLMxn2mAuRyVQGKBS5ic2UqYSsxXTccszXCmHkA@mail.gmail.com/

Thank you Tyler for root causing and finding a proper fix.

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

> ---
>  drivers/nvdimm/region_devs.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index ef23119db574..09cff8aa6b40 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -545,29 +545,32 @@ static ssize_t align_store(struct device *dev,
>                 struct device_attribute *attr, const char *buf, size_t len)
>  {
>         struct nd_region *nd_region = to_nd_region(dev);
> -       unsigned long val, dpa;
> -       u32 remainder;
> +       unsigned long val;
>         int rc;
>
>         rc = kstrtoul(buf, 0, &val);
>         if (rc)
>                 return rc;
>
> -       if (!nd_region->ndr_mappings)
> -               return -ENXIO;
> -
> -       /*
> -        * Ensure space-align is evenly divisible by the region
> -        * interleave-width because the kernel typically has no facility
> -        * to determine which DIMM(s), dimm-physical-addresses, would
> -        * contribute to the tail capacity in system-physical-address
> -        * space for the namespace.
> -        */
> -       dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> -       if (!is_power_of_2(dpa) || dpa < PAGE_SIZE
> -                       || val > region_size(nd_region) || remainder)
> +       if (val > region_size(nd_region))
>                 return -EINVAL;
>
> +       if (nd_region->ndr_mappings) {
> +               unsigned long dpa;
> +               u32 remainder;
> +
> +               /*
> +                * Ensure space-align is evenly divisible by the region
> +                * interleave-width because the kernel typically has no facility
> +                * to determine which DIMM(s), dimm-physical-addresses, would
> +                * contribute to the tail capacity in system-physical-address
> +                * space for the namespace.
> +                */
> +               dpa = div_u64_rem(val, nd_region->ndr_mappings, &remainder);
> +               if (!is_power_of_2(dpa) || dpa < PAGE_SIZE || remainder)
> +                       return -EINVAL;
> +       }
> +
>         /*
>          * Given that space allocation consults this value multiple
>          * times ensure it does not change for the duration of the
> --
> 2.25.1
>
