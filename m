Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB193B917A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 14:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbhGAMJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 08:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 08:09:00 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5ADC0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 05:06:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j2so7871616wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 05:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ejMlxgdCSh7bhcCGOF4QdbrO4C8aMBBUUOFoe2dbFSI=;
        b=zHMXsVWHe1X0RmiTXlG0eTZ4BhUFs2i1PsHVjP3epKr+4l8+Ufv3pHmtYLPD7OJtGB
         U1RS6AMTe28j0efpj7b6esouVCNrrJPLVOcQdgLDg4o7YHZaMcBxkyPRL3a+93dkoG6u
         0AFA033b82v8OBw8f7ngYGYrwQp2m/cz8NskQDbloJI3NQe6GV9qKl2qfHP7LC7fL1RP
         CcXE/m88rdiP5JFb0hVPWOc2KqUEvz0hql0nIZBIGphcHsoqAzHHYfoF42LsASEDwT8o
         r4fKFA2W/NO3aErVQmE3B8ZScKnc21SDHUyyaHSwdwTV6VFCIpzZggWVshtiC0Efpt01
         vuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ejMlxgdCSh7bhcCGOF4QdbrO4C8aMBBUUOFoe2dbFSI=;
        b=r22+1MKZIXHzL/41ZG/doBdKr5TLGneASvJ00r1pqS8IQqPNMy9blGLDjWAb1WhYOS
         8pu/sdrUg3M1kCxT/OVY/mQ0kjy/MIdzNmBM2wZUPrCaxhDCJnSaOIPvwXwh7QyIZWMU
         s5zRmuqTrZV8NJxE0RtC+7x6wGiqWhaop8exsKo5zU3DbB3xEAzDe756UW0fLMaKT8/J
         6/xKBk6YFrJH2g1UKp7v/bpc5ggyo+VOyMdrH+V7AueN/IJxgu98fm86TN2v0M+a840G
         EgqHSXSddkjM3fdM6TBuWai7coNGv2Fm67tratIPmdQ5zo/3v/oRyei76Qk6iC5m5glH
         XL/g==
X-Gm-Message-State: AOAM531Gze639BLa0h+MJUr3HSsvfp4HEJxNWMtlE/x6XzT/rxhYGdJ4
        tIRJSt7RQSnfe8VOhEmDCedwLw==
X-Google-Smtp-Source: ABdhPJys7PypARaY3xtb+nlQ97FFK3P13DCY8HLs7RWO3yKhXkY1KjwrlFP/08TgBqCWLe2Xsg31AA==
X-Received: by 2002:a5d:560c:: with SMTP id l12mr28940568wrv.310.1625141188224;
        Thu, 01 Jul 2021 05:06:28 -0700 (PDT)
Received: from dell ([109.180.115.217])
        by smtp.gmail.com with ESMTPSA id d186sm10449644wmd.14.2021.07.01.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 05:06:27 -0700 (PDT)
Date:   Thu, 1 Jul 2021 13:06:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
Message-ID: <YN2vwT+7sVRvz8iS@dell>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
 <20210617215408.1412409-3-david.e.box@linux.intel.com>
 <YNxENGGctLXmifzj@dell>
 <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
 <e734a968-818a-380d-0ae5-fee41b3db246@redhat.com>
 <YN2lmdDAOaykCvHK@dell>
 <CAHp75Vfn6GKSj6USUPEWiPdhWRYcJbirqhU6aOeB4gruekmocg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfn6GKSj6USUPEWiPdhWRYcJbirqhU6aOeB4gruekmocg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jul 2021, Andy Shevchenko wrote:

> On Thursday, July 1, 2021, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Thu, 01 Jul 2021, Hans de Goede wrote:
> >
> > > Hi,
> > >
> > > On 6/30/21 11:11 PM, David E. Box wrote:
> > > > On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
> > > >> On Thu, 17 Jun 2021, David E. Box wrote:
> > > >>
> > > >>> Unlike the other devices in intel_pmt, the Out of Band Management
> > > >>> Services
> > > >>> Module (OOBMSM) is actually not a PMT dedicated device. It can also
> > > >>> be used
> > > >>> to describe non-PMT capabilities. Like PMT, these capabilities are
> > > >>> also
> > > >>> enumerated using PCIe Vendor Specific registers in config space. In
> > > >>> order
> > > >>> to better support these devices without the confusion of a
> > > >>> dependency on
> > > >>> MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so that it
> > > >>> can be
> > > >>> later placed in its own driver. Since much of the same code will be
> > > >>> used by
> > > >>> intel_pmt and the new driver, create a new file with symbols to be
> > > >>> used by
> > > >>> both.
> > > >>>
> > > >>> While performing this split we need to also handle the creation of
> > > >>> platform
> > > >>> devices for the non-PMT capabilities. Currently PMT devices are
> > > >>> named by
> > > >>> their capability (e.g. pmt_telemetry). Instead, generically name
> > > >>> them by
> > > >>> their capability ID (e.g. intel_extnd_cap_2). This allows the IDs
> > > >>> to be
> > > >>> created automatically.  However, to ensure that unsupported devices
> > > >>> aren't
> > > >>> created, use an allow list to specify supported capabilities.
> > > >>>
> > > >>> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > >>> ---
> > > >>>  MAINTAINERS                                |   1 +
> > > >>>  drivers/mfd/Kconfig                        |   4 +
> > > >>>  drivers/mfd/Makefile                       |   1 +
> > > >>>  drivers/mfd/intel_extended_caps.c          | 208
> > > >>> +++++++++++++++++++++
> > > >>
> > > >> Please consider moving this <whatever this is> out to either
> > > >> drivers/pci or drivers/platform/x86.
> > > >
> > > > None of the cell drivers are in MFD, only the PCI drivers from which
> > > > the cells are created. I understood that these should be in MFD. But
> > > > moving it to drivers/platform/x86 would be fine with me. That keeps the
> > > > code together in the same subsystem. Comment from Hans or Andy?
> > >
> > > I'm fine with moving everything to drivers/platform/x86, but AFAIK
> > > usually the actual code which has the MFD cells and creates the
> > > child devices usually lives under drivers/mfd
> >
> > Correct.  It must.
> 
> It’s definitely not the first time you are talking about, but it may be the
> first time I asked why it’s not enforced overall. Last time I have checked
> it was like 5-7 MFD uses outside the MFD folder. Are you going to fix that?

Because I can't NACK patches that weren't sent to me. :)

I'll probably look into 'fixing' it when I get some free time.

> > No MFD API users outside of drivers/mfd please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
