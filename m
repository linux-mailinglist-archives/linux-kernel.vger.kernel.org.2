Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0759D3A8B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFOWDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFOWDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:03:22 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D2C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:01:17 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v13so55120ple.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAW0zh0lnrneDmrUJXzBCI0coVLuVRYrnPiW+I/zDg8=;
        b=dUCqcuVG9dMBPasm8laBVdwM1G4BkryuVauvy6BFE6SqaWlfBSH0CxTSBQGVGaZcX+
         /rEday4Tyl8dGM2Dd/hedSpI/A+jd/Lv8lj4BLZjwXj1VgxBYhgkbvJRwhwZguZ/g1tQ
         IRmCRxBsqoprSSOjzBLpx++MdTDnvqpivoMb6LGOSS6aFndQGU18O9IyRstFPRTfr86D
         b4DMTMdUUyssRjdK+qQpNiE1xBVWa0Y+DEE1fhCLf7/6G3pLMh8URjWSIVCIHBEEnTrx
         bsaCJck5RYJ74jw8qK3Qb1LW8bZtQnvG6iH7IRM18qq6n4htUgORN/X4BFFO063YApke
         7BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAW0zh0lnrneDmrUJXzBCI0coVLuVRYrnPiW+I/zDg8=;
        b=GP0kcxb2mdys4lDU57IcmBkySkK+1pjtGAd3ERFhIate0B4ee4E3yQoTlIUHSfK7Vi
         dRftc7OMNZclT1lh72XP1aD5bg+7+Lq0no550tNB1Nfv1twbV+Y8jkLn7W/cJLj6y8+i
         3fMMlfgfVmwYNdne7Mcjeusu7S63c5N8c7+YlBY14+3PkAzTWbxNLRzj16FoI55KzW99
         1IfypdJhQQJUTNFwiMb8x+2WOApv5JWqM8VEaWRqBBbHJ+N6Qg0lNuCN37YnHEN4Kubt
         0e+uYYjLPTSQHYA5ghb/ugrJmGsM+qJfi5WwRZrDDQhRE4mQvrTQok8uDTgr6DwwlUpS
         7KUg==
X-Gm-Message-State: AOAM531hjBvBcTiboNHHSMmb4qhEZZoe4bvQ/DKRPakGllgRW+gZqAa8
        UKCF5WS6aYzh954I583+dhnDhD8VUVyKzRXS8fRU9w==
X-Google-Smtp-Source: ABdhPJxVLbIa/upTKs14f5ukhtRdhj+iRvpV3ZgffOhIHJ/aX884+EuJPrDwe+iPKmTxWwkYMldjCnoBL1a2ZaYJ5CA=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr7230964pjb.13.1623794476682;
 Tue, 15 Jun 2021 15:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623705308.git.alison.schofield@intel.com>
 <0246fe923945ba2b8d885f45279d7d3956c46950.1623705308.git.alison.schofield@intel.com>
 <CAPcyv4houyD9PGG4PKiO7OiHkKEZD81=tVSzr_PTShHBzx956A@mail.gmail.com> <20210615210518.GA22172@alison-desk.jf.intel.com>
In-Reply-To: <20210615210518.GA22172@alison-desk.jf.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Jun 2021 15:01:06 -0700
Message-ID: <CAPcyv4jeaJwgOMWyCjQy_32gPhSq2T-7JfwRPAmDCg5qMEB+kg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cxl/acpi: Use the ACPI CFMWS to create static decoder objects
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 2:09 PM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> Thanks for the review Dan...
>
> On Tue, Jun 15, 2021 at 11:48:43AM -0700, Dan Williams wrote:
> > [ add linu-acpi for variable length array question below ]
> >
> >
> > On Mon, Jun 14, 2021 at 3:57 PM Alison Schofield
> > <alison.schofield@intel.com> wrote:
> > >
> > > The ACPI CXL Early Discovery Table (CEDT) includes a list of CXL memory
> > > resources in CXL Fixed Memory Window Structures (CFMWS). Retrieve each
> > > CFMWS in the CEDT and add a cxl_decoder object to the root port (root0)
> > > for each memory resource.
> > >
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  drivers/cxl/acpi.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 106 insertions(+)
> > >
> > > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > > index 16f60bc6801f..ac4b3e37e294 100644
> > > --- a/drivers/cxl/acpi.c
> > > +++ b/drivers/cxl/acpi.c
> > > @@ -8,8 +8,112 @@
> > >  #include <linux/pci.h>
> > >  #include "cxl.h"
> > >
> > > +/* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> > > +#define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> > > +#define CFMWS_INTERLEAVE_GRANULARITY(x)        ((x)->granularity + 8)
> > > +
> > > +/*
> > > + * CFMWS Restrictions mapped to CXL Decoder Flags
> > > + * Restrictions defined in CXL 2.0 ECN CEDT CFMWS
> > > + * Decoder Flags defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register
> > > + */
> > > +#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> > > +#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> > > +#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> > > +#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> > > +#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> > > +
> > > +#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> > > +                                  CFMWS_TO_DECODE_TYPE3(x) | \
> > > +                                  CFMWS_TO_DECODE_RAM(x)   | \
> > > +                                  CFMWS_TO_DECODE_PMEM(x)  | \
> > > +                                  CFMWS_TO_DECODE_FIXED(x))
> >
> > I don't understand the approach taken above. It seems to assume that
> > the CXL_DECODER_F_* values are fixed. Those flag values are arbitrary
> > and mutable. There is no guarantee that today's CXL_DECODER_F_* values
> > match tomorrow's so I'd rather not have 2 places to check when / if
> > that happens.
> >
>
> Here's my next take - making the handling resilient.
> Not so sure on gracefulness. Open for suggestions.
>
> -#define CFMWS_TO_DECODE_TYPE2(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) << 2)
> -#define CFMWS_TO_DECODE_TYPE3(x) ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) << 2)
> -#define CFMWS_TO_DECODE_RAM(x)   ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) >> 2)
> -#define CFMWS_TO_DECODE_PMEM(x)         ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) >> 2)
> -#define CFMWS_TO_DECODE_FIXED(x) (x & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
> -
> -#define CFMWS_TO_DECODER_FLAGS(x) (CFMWS_TO_DECODE_TYPE2(x) | \
> -                                  CFMWS_TO_DECODE_TYPE3(x) | \
> -                                  CFMWS_TO_DECODE_RAM(x)   | \
> -                                  CFMWS_TO_DECODE_PMEM(x)  | \
> -                                  CFMWS_TO_DECODE_FIXED(x))
> +#define FLAG_TYPE2(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE2) ? CXL_DECODER_F_TYPE2 : 0)
> +#define FLAG_TYPE3(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_TYPE3) ? CXL_DECODER_F_TYPE3 : 0)
> +#define FLAG_RAM(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE) ? CXL_DECODER_F_RAM : 0)
> +#define FLAG_PMEM(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_PMEM) ? CXL_DECODER_F_PMEM : 0)
> +#define FLAG_FIXED(x) \
> +       ((x & ACPI_CEDT_CFMWS_RESTRICT_FIXED) ? CXL_DECODER_F_LOCK : 0)
> +
> +#define CFMWS_TO_DECODER_FLAGS(x) (FLAG_TYPE2(x) | FLAG_TYPE3(x) | \
> +                                  FLAG_RAM(x) | FLAG_PMEM(x)| FLAG_FIXED(x))

Hmm, why the macros? Just make CFMWS_TO_DECODER_FLAGS a proper function.

if (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
    flags |= CXL_DECODER_F_TYPE2;

...etc

Unless you foresee where macros were going to be reused somewhere else
I would just as soon open code them like above.
