Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF59332D35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhCIR1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:27:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:57323 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231601AbhCIR1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:27:18 -0500
IronPort-SDR: CT+++CdrvdQc5bsZ/o+5WHxJ7S3lo4c0NzeYsa0aiONu1Ah8NgrCFMYQ3lXJEud01hiMOCNcQ4
 QRfWe7rXxBjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273319097"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="273319097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 09:27:18 -0800
IronPort-SDR: 244igZJq/cMFewNAXx2UFoh8r8rI621DhXK1wDO1K8l0gccXUtdHP4R2AswB2l36Hztd71XaHO
 4KFskcNA/Ljg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="408724507"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2021 09:27:18 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.57])
        by linux.intel.com (Postfix) with ESMTP id 2319E58088F;
        Tue,  9 Mar 2021 09:27:18 -0800 (PST)
Message-ID: <d4e0883f6f71bbfc68804c97222b28acad77f969.camel@linux.intel.com>
Subject: Re: [PATCH 2/2 V2] MFD: intel_pmt: Add support for DG1
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Tue, 09 Mar 2021 09:27:18 -0800
In-Reply-To: <20210309164505.GS4931@dell>
References: <20210128172846.99352-1-david.e.box@linux.intel.com>
         <20210224201005.1034005-2-david.e.box@linux.intel.com>
         <20210309164505.GS4931@dell>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-09 at 16:45 +0000, Lee Jones wrote:
> On Wed, 24 Feb 2021, David E. Box wrote:
> 
> > Adds PMT Telemetry aggregator support for the DG1 graphics PCIe
> > card. The
> > device does not have the DVSEC region in its PCI config space so
> > hard
> > code the discovery table data in the driver. Also requires a fix
> > for DG1
> > in the Telemetry driver for how the ACCESS_TYPE field is used.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > Based on 5.11-rc1 review-hans branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> > 
> > Changes from V1:
> > 
> >         - New patch
> > 
> >  drivers/mfd/intel_pmt.c                    | 101 +++++++++++++++--
> > ----
> >  drivers/platform/x86/intel_pmt_class.c     |  46 ++++++++++
> >  drivers/platform/x86/intel_pmt_class.h     |   1 +
> >  drivers/platform/x86/intel_pmt_telemetry.c |  20 ----
> >  4 files changed, 119 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> > index 65da2b17a204..dd7eb614c28e 100644
> > --- a/drivers/mfd/intel_pmt.c
> > +++ b/drivers/mfd/intel_pmt.c
> > @@ -49,10 +49,14 @@ enum pmt_quirks {
> >  
> >         /* Use shift instead of mask to read discovery table offset
> > */
> >         PMT_QUIRK_TABLE_SHIFT   = BIT(2),
> > +
> > +       /* DVSEC not present (provided in driver data) */
> > +       PMT_QUIRK_NO_DVSEC      = BIT(3),
> >  };
> >  
> >  struct pmt_platform_info {
> >         unsigned long quirks;
> > +       struct intel_dvsec_header **capabilities;
> >  };
> >  
> >  static const struct pmt_platform_info tgl_info = {
> > @@ -60,6 +64,26 @@ static const struct pmt_platform_info tgl_info =
> > {
> >                   PMT_QUIRK_TABLE_SHIFT,
> >  };
> >  
> > +/* DG1 Platform with DVSEC quirk*/
> > +static struct intel_dvsec_header dg1_telemetry = {
> > +       .length = 0x10,
> > +       .id = 2,
> > +       .num_entries = 1,
> > +       .entry_size = 3,
> > +       .tbir = 0,
> > +       .offset = 0x466000,
> > +};
> > +
> > +static struct intel_dvsec_header *dg1_capabilities[] = {
> > +       &dg1_telemetry,
> > +       NULL
> > +};
> > +
> > +static const struct pmt_platform_info dg1_info = {
> > +       .quirks = PMT_QUIRK_NO_DVSEC,
> > +       .capabilities = dg1_capabilities,
> > +};
> > +
> >  static int pmt_add_dev(struct pci_dev *pdev, struct
> > intel_dvsec_header *header,
> >                        unsigned long quirks)
> >  {
> > @@ -147,37 +171,54 @@ static int pmt_pci_probe(struct pci_dev
> > *pdev, const struct pci_device_id *id)
> >         if (info)
> >                 quirks = info->quirks;
> >  
> > -       do {
> > -               struct intel_dvsec_header header;
> > -               u32 table;
> > -               u16 vid;
> > +       if (info && (info->quirks & PMT_QUIRK_NO_DVSEC)) {
> 
> Nit: Why not use 'quirks' from a few lines above?

Ack

David

> 

