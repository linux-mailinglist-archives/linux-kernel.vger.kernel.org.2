Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32FA63AA162
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhFPQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhFPQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:34:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E7C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:32:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t13so2409506pgu.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LgEvtax5sgfmjjrhgKwKQwSVaBY+DvlQnT1NfAz1r9g=;
        b=1hcP+YAeAqS7ogKiZuC3JOg0nrRosmlQ+/IxyYf9p4F0pHW4TcuQefQCO86PNAAWy1
         +IOvR/7EL4bbgif/BwOuHFbnEIgOYc5lkobTM9TRoOsIzZfHtSUiWe0vLkFq9FgEjzyZ
         ByxXRhl9VgLrG2EVdC85CsSFHZbCkxnjcTuJJlxdDQ8+N2hUZ1sJXEBXP5MEfRykqAlK
         E8meQUJGqUb8qr3bFM6hITb+bowuxf6WG5TxBXG09NyZakyYHPxIerAYpODSo9xquRW7
         XdFB1CKn7Ekzy+udsg2u/M33tbZ1MJYZHRxlESye7+e3nBCfFzNYpXG4iqhgDXx/cfex
         LY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LgEvtax5sgfmjjrhgKwKQwSVaBY+DvlQnT1NfAz1r9g=;
        b=ofGqIvYHn7RJIMEtKwvN11qVzK42eb3ftSduAn2jSN6rDOtABWw94deg7XtuWrEavn
         XOCA9309v7V2Yb3lYBSFKLzPusBX2ZaWLkWwQED89uQpLYqIqUS16ZJW4OskgQWWyH6g
         +OPMEwekDKzcBIT/v4wXx6EBY4XibtanvqK8rBwfMRDNYbic9hK2D0OuHRNwnFv8j4gx
         Z2dhvy47XFjffnoWl5c8ehoG0Y31fwt90MgmBhM5ftpxdKKRh2hYgOwEz6HfFZfYkvvd
         5M10uXq9GWYkQnFgD9z0kzhtrSGbX8t0yFeLJeBV4KWfwKBvjLXWAaenAz0VcDZo3l/k
         oWJA==
X-Gm-Message-State: AOAM531YrpfDcl3XdKXoVTMneLHSWWxvQFo9cp5EmhYj31WMjOsNE/E2
        3D5Eia5Cw95C4MdnaAsLzzeFIc70VzRBKfClyJvQ+Q==
X-Google-Smtp-Source: ABdhPJyZvZL0A0K44zy/aMo4UY4FYkRWBOijbl8gbJYaH2WDdTs7d+pPN30OUFs00aZSFvvgfpO+hxC4Wgxuat0VkIY=
X-Received: by 2002:a62:8647:0:b029:2c4:b8d6:843 with SMTP id
 x68-20020a6286470000b02902c4b8d60843mr590229pfd.71.1623861164908; Wed, 16 Jun
 2021 09:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623800340.git.alison.schofield@intel.com>
 <48f1b59105e46f04b38347fc1555bb5c8d654cff.1623800340.git.alison.schofield@intel.com>
 <20210616161740.k4nxeh3bmem56gwa@intel.com>
In-Reply-To: <20210616161740.k4nxeh3bmem56gwa@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Jun 2021 09:32:34 -0700
Message-ID: <CAPcyv4hNxAw99iNF_puwuYmegCGBR2mOUhQ_t56q_XZ0p7hjcw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cxl/acpi: Use the ACPI CFMWS to create static
 decoder objects
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 9:17 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-06-15 17:20:39, Alison Schofield wrote:
> > The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> > resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> > CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> > for each memory resource.
> >
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/acpi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index b6d9cd45428c..e3aa356d4dcd 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -8,8 +8,120 @@
> >  #include <linux/pci.h>
> >  #include "cxl.h"
> >
> > +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > +#define CFMWS_INTERLEAVE_WAYS(x)     (1 << (x)->interleave_ways)
> > +#define CFMWS_INTERLEAVE_GRANULARITY(x)      ((x)->granularity + 8)
> > +
> >  static struct acpi_table_header *cedt_table;
> >
> > +static unsigned long cfmws_to_decoder_flags(int restrictions)
> > +{
> > +     unsigned long flags = 0;
> > +
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
> > +             flags |= CXL_DECODER_F_TYPE2;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
> > +             flags |= CXL_DECODER_F_TYPE3;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> > +             flags |= CXL_DECODER_F_RAM;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
> > +             flags |= CXL_DECODER_F_PMEM;
> > +     if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > +             flags |= CXL_DECODER_F_LOCK;
> > +
> > +     return flags;
> > +}
>
> I know these flags aren't introduced by this patch, but I'm wondering if it
> makes sense to not just use the spec definitions rather than defining our own.
> It doesn't do much harm, but it's extra typing everytime the spec adds new flags
> and I don't really see the upside.

The flags are bounded by what's in HDM decoders, I don't see them
moving so fast that the kernel can not keep up. The rationale for the
split is the same as the split between ACPI NFIT and the LIBNVDIMM
core. The ACPI specifics are just one way to convey a common platform
attribute to the core.

In fact this was one of the main feedbacks of the initial "ND"
subsystem which eventually became LIBNVDIMM [1]. ND stood for "NFIT
Defined" and the arch split between ACPI specific and Linux
translation has paid off over the years.

[1]: https://lore.kernel.org/lkml/20150420070624.GB13876@gmail.com/


>
> > +
> > +static int cxl_acpi_cfmws_verify(struct device *dev,
> > +                              struct acpi_cedt_cfmws *cfmws)
> > +{
> > +     int expected_len;
> > +
> > +     if (cfmws->interleave_arithmetic != ACPI_CEDT_CFMWS_ARITHMETIC_MODULO) {
> > +             dev_err(dev, "CFMWS Unsupported Interleave Arithmetic\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!IS_ALIGNED(cfmws->base_hpa, SZ_256M)) {
> > +             dev_err(dev, "CFMWS Base HPA not 256MB aligned\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!IS_ALIGNED(cfmws->window_size, SZ_256M)) {
> > +             dev_err(dev, "CFMWS Window Size not 256MB aligned\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     expected_len = struct_size((cfmws), interleave_targets,
> > +                                CFMWS_INTERLEAVE_WAYS(cfmws));
> > +
> > +     if (expected_len != cfmws->header.length) {
>
> I'd switch this to:
> if (expected_len < cfmws->header.length)
>
> If it's too big, just print a dev_dbg.

Maybe call it min_len then?

[..]
> > +
> > +             cxld = devm_cxl_add_decoder(dev, root_port,
> > +                             CFMWS_INTERLEAVE_WAYS(cfmws),
> > +                             cfmws->base_hpa, cfmws->window_size,
> > +                             CFMWS_INTERLEAVE_WAYS(cfmws),
>
> Interesting... this made me question, how can we have a different number of
> targets and ways?

These settings can be changed later on a switch-level decoder, for a
root-level decoder these initial values are fixed.
