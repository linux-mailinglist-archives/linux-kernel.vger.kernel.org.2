Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF53B8E7F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhGAIEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbhGAIEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:04:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF323C0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 01:01:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a13so6919257wrf.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fz/86DzHx2caSczaCAFAcEmUnVZhhFJTlUHOBihelxo=;
        b=CCHDTcc1FiVwvRP6+RDbYv65TuXyYBxQvX26iNkNLoVFa4FqpA0kr8D6B1p2l2iBtG
         jrDWjmlWkyp5xVYloVHjEdpM+pMmfdyiuOTRZwa6G3syKddHeyo8+C8weuS8nItEKgwF
         82oegQw1bNV8XsWQxbeLviKZshzOiEOTDBj4lHAZ3Sm4o7YqxwbfNrKTtSfOcWRypvzR
         xyV/o6Odzf8QcJwc5qADbYd2WcWXPilugkmME4LEmgYQJYxywMQWnzHl9H5Jk53NRfp0
         hjTMajZ1lIcJKPgF+alAbzVPxmyVasXnTrnewGzsPblR1Er3sJyd/jDyr1Ne1DbsBI/e
         ZvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fz/86DzHx2caSczaCAFAcEmUnVZhhFJTlUHOBihelxo=;
        b=HJ/7o5ornplMZySEWq9YhoYjkSBC1Ak/dhvH3gGccNnutwADk1huoWUme5VHceIje8
         sleRIrWiV7H+pFmxagm/TYqTbkKSlbO3+ndtKNCQe/SgDHmjUT/7PMtJ68VvlLJgSWgk
         HJ34x3XR2YQCSLvQWaePSJBIMfbxkWwwYjluvzwPv/t8tusgSOYJEfQiUhZ1HbToRF3O
         Gyoe7PERRxaJMEWCU3R0Dm4zvc7MfDQASDR45rucR1aPTUq6pdleo1/x32UFGgu/xQla
         6lwBzDoNuX+UDP83Htt7T0XuxlracmYJ0TVDOP/YrTsebUksjNRFsHt5/aHTwKE44yND
         5g0Q==
X-Gm-Message-State: AOAM530dLukLafb8b3brSOciQCAdcAihkrOPhNgU3ADRZG748NX0v+ec
        nedG83WD6Az4HzXKTrDCLMNAzQ==
X-Google-Smtp-Source: ABdhPJx3uUQkLABTE9d2yWhlddZ2cY+ZYlFPWwvingwb/axPIdcYN6V6lc/yF4/MNf77qYMoHaUuzQ==
X-Received: by 2002:a5d:65cc:: with SMTP id e12mr43465985wrw.354.1625126495150;
        Thu, 01 Jul 2021 01:01:35 -0700 (PDT)
Received: from dell ([109.180.115.217])
        by smtp.gmail.com with ESMTPSA id h9sm22582904wmb.35.2021.07.01.01.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 01:01:34 -0700 (PDT)
Date:   Thu, 1 Jul 2021 09:01:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
Message-ID: <YN12Xe0EZDdjDIrK@dell>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
 <20210617215408.1412409-3-david.e.box@linux.intel.com>
 <YNxENGGctLXmifzj@dell>
 <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f590ee871d0527a12b307f1494cb4c8a91c5e3c2.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jun 2021, David E. Box wrote:

> On Wed, 2021-06-30 at 11:15 +0100, Lee Jones wrote:
> > On Thu, 17 Jun 2021, David E. Box wrote:
> > 
> > > Unlike the other devices in intel_pmt, the Out of Band Management
> > > Services
> > > Module (OOBMSM) is actually not a PMT dedicated device. It can also
> > > be used
> > > to describe non-PMT capabilities. Like PMT, these capabilities are
> > > also
> > > enumerated using PCIe Vendor Specific registers in config space. In
> > > order
> > > to better support these devices without the confusion of a
> > > dependency on
> > > MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so that it
> > > can be
> > > later placed in its own driver. Since much of the same code will be
> > > used by
> > > intel_pmt and the new driver, create a new file with symbols to be
> > > used by
> > > both.
> > > 
> > > While performing this split we need to also handle the creation of
> > > platform
> > > devices for the non-PMT capabilities. Currently PMT devices are
> > > named by
> > > their capability (e.g. pmt_telemetry). Instead, generically name
> > > them by
> > > their capability ID (e.g. intel_extnd_cap_2). This allows the IDs
> > > to be
> > > created automatically.  However, to ensure that unsupported devices
> > > aren't
> > > created, use an allow list to specify supported capabilities.
> > > 
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > >  MAINTAINERS                                |   1 +
> > >  drivers/mfd/Kconfig                        |   4 +
> > >  drivers/mfd/Makefile                       |   1 +
> > >  drivers/mfd/intel_extended_caps.c          | 208
> > > +++++++++++++++++++++
> > 
> > Please consider moving this <whatever this is> out to either
> > drivers/pci or drivers/platform/x86.
> 
> None of the cell drivers are in MFD, only the PCI drivers from which
> the cells are created. I understood that these should be in MFD. But
> moving it to drivers/platform/x86 would be fine with me. That keeps the
> code together in the same subsystem. Comment from Hans or Andy? 

You don't need to move everything there.  If a driver uses the MFD API
(like intel_pmt.c does), it can stay.  But all of this PCI/hardware/
platform specific capability craziness has no place here AFAICT.

> > I suggest Andy should also be on Cc.
> > 
> > >  drivers/mfd/intel_extended_caps.h          |  40 ++++
> > >  drivers/mfd/intel_pmt.c                    | 198 ++---------------
> > > ---
> > >  drivers/platform/x86/intel_pmt_crashlog.c  |   2 +-
> > >  drivers/platform/x86/intel_pmt_telemetry.c |   2 +-
> > >  8 files changed, 270 insertions(+), 186 deletions(-)
> > >  create mode 100644 drivers/mfd/intel_extended_caps.c
> > >  create mode 100644 drivers/mfd/intel_extended_caps.h
> > 
> 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
