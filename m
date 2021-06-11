Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D246B3A48E9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFKS6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:58:50 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:54003 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbhFKS6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:58:48 -0400
Received: by mail-pj1-f54.google.com with SMTP id ei4so6195401pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kI53Z+V1yTIGhMYD3HVCzqkT1+IVR3Un8CLLjrdyiOs=;
        b=eBJNwcfa0JaWCYzFgaEniV+zLZWtVHQwsScf5x35yGxrkKnfNGToJT2tVmKva+NBmm
         Is0JaMgDOJhJtzpp6Xj7ckHHBtt+NAUZLm0d2DoW4GylxKhTYQv/PF4+WKnIcO2O2RnX
         CfmACMYSNcXnEh6+fDv/FJ4pgyeJscSiZw68zzPBKjAiELpWW6nlMbPjd8JT/16WYANN
         wBkLMSLvBwMFQ2biTSAmZN5C+s4A3Z4Y1/sDWTXecPBIrlsEP+x/rspMHSIG0c2i0V6X
         FwTKAY3leUWh5qYvK75kbRD+RUxsfoHsnqisN9wrW4c1fB7XVIOY43Y8TD1zDCqhJvHH
         61DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kI53Z+V1yTIGhMYD3HVCzqkT1+IVR3Un8CLLjrdyiOs=;
        b=UIP3LH5K87BtDgGF+LgYj8PaSQ4yZc31FOU7KTrO5PbCHNxO8IaLufXfYkTpdRhi4x
         yDQdEbe5pwvxnLdInRozDdD+uepuAewax65Ro7Y5HFKXjvCGEIow3l43qI4RH1d9IQ3G
         wvlUSh/w5sEdZndWXlkACNtVaCdObB96Trxv+UpsNhEswFYwxiG8zpOdbefiMnUjqe9F
         LToAPRkivFkOfKsWJHLqQOFS8HCeAoEYQyQRS+062DJYo/YIjUca50BQ8mxhCoVwormS
         V0uW91+n2h0dLZ7KkPfBClPOCMuDTIXmWkxNo3ulD4yOyiuNHVx/kwqCf/VLM0+E85fr
         5BCg==
X-Gm-Message-State: AOAM530exKB6nlKSh4ZNj6qNAO9tP7DxUdNzhmZptNX+zPPbEk3594Bf
        6P1KlPAVI4eO5UBvxU8jZcqmjjLMJevB5a9kLqHIWQ==
X-Google-Smtp-Source: ABdhPJzFxO0z6jGgoRvJi+g4R0wceRN+04EDU3p20moiFueBAzTkKFDWYGY37zrhWECTxftIdcjsrTN4lXVvI7iybmE=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr10605989pjb.13.1623437750427;
 Fri, 11 Jun 2021 11:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <162336395765.2462439.11368504490069925374.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162336396329.2462439.16556923116284874437.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210611174736.ttzpk5uniyoyd4vw@intel.com>
In-Reply-To: <20210611174736.ttzpk5uniyoyd4vw@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 11 Jun 2021 11:55:39 -0700
Message-ID: <CAPcyv4i7_RhfiYMX=QP2Ts4ye1Q2e0=_aBCP4rsuopo=0HWKVw@mail.gmail.com>
Subject: Re: [PATCH 1/5] cxl/core: Add cxl-bus driver infrastructure
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux NVDIMM <nvdimm@lists.linux.dev>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:47 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-06-10 15:26:03, Dan Williams wrote:
> > Enable devices on the 'cxl' bus to be attached to drivers. The initial
> > user of this functionality is a driver for an 'nvdimm-bridge' device
> > that anchors a libnvdimm hierarchy attached to CXL persistent memory
> > resources. Other device types that will leverage this include:
> >
> > cxl_port: map and use component register functionality (HDM Decoders)
>
> Since I'm looking at this now, perhaps I can open the discussion here. Have you
> thought about how this works yet? Right now I'm thinking there are two "drivers":
> cxl_port: Switches (and ACPI0016)
> cxl_mem: The memory device's HDM decoders
>
> For port, probe() will figure out that the thing is an upstream port, call
> cxl_probe_component_regs and then call devm_cxl_add_port(). I think that's
> straight forward.

I was expecting cxl_port_driver.probe() comes *after* port discovery.
Think of it like PCI discovery. Some agent does the hardware topology
scan to add devices, in this case devm_cxl_add_port(), and that
triggers cxl_port_driver to load. So the initial enumeration done by
the cxl_acpi driver will populate the first two levels of the port
hierarchy with port objects and populate their component register
physical base addresses. For any other port deeper in the hierarchy I
was expecting that to be scanned after the discovery of a cxl_memdev
that is not attached to the current hierarchy. So, for example imagine
a config like:

Platform --> Host Bridge --> Switch --> Endpoint

...where in sysfs that's modeled as:

root0 --> port1 --> port2 --> port3

Where port3 is assuming that the CXL core models the device's
connection to the topology as yet another cxl_port. At the beginning
of time after cxl_acpi has loaded but before cxl_pci has discovered
the endpoint the topology is:

root0 --> port1

Upon the detection of the endpoint the CXL core can assume that all
intermediary switches between the root and this device have been
registered as PCI devices. So, it follows that endpoint device arrival
triggers "cxl_bus_rescan()" that goes and enumerates all the CXL
resources in the topology to produce:

root0 --> port1 --> port2 --> port3

> For the memory device we've already probed the thing via class code so there is
> no need to use this driver registration, however, I think it would be nice to do
> so. Is there a clean way to do that?

The PCI device associated with the endpoint is already probed, but the
cxl_memdev itself can have a driver on the CXL bus. So I think the
cxl_memdev driver should try to register a cxl_port after telling
cxl_acpi to rescan. If a check like "is_cxl_dport(pdev->dev.parent)"
for the endpoint returns false it means that the cxl_bus_rescan()
failed to enumerate the CXL topology to this endpoint and this
endpoint is limited to only CXL.io operation.

> Also, I'd like to make sure we're on the same page about struct cxl_decoder.
> Right now they are only created for active HDM decoders.

No, I was expecting they are also created for inactive ones. I am
thinking that all decoders ultimately belong to the cxl_acpi driver,
or whatever driver is acting as the root on a non-ACPI system. All
decoder programming is driven by region activation stimulus that asks
the root driver to try to establish a decode chain through the
hieararchy per a given region.

> Going forward, we can
> either maintain a count of unused decoders on the given CXL component, or we can
> instantiate a struct cxl_decoder that isn't active, ie. no interleave ways
> granularit, base, etc. What's your thinking there?

All resources are enumerated, just like PCI. Decode setup belongs to
the core, just like PCI MMIO resource setup. The difference is that
port drivers are needed to map component registers and service
requests from cxl_acpi to reconfigure, but other than that
cxl_decoders themselves don't have drivers and just reflect the
current state of what cxl_acpi / cxl_core have established.
