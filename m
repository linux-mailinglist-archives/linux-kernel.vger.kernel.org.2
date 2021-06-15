Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE053A8379
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 16:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFOPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:00:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:37679 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhFOPAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:00:32 -0400
IronPort-SDR: uD/x4eagFIOkDhvkDhCgQKqi+w5IJEDV6ceZHaCFMerVmK67fAFop/llG3zFN2m6LeegnEB0eJ
 uKOuF+2kO0pQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227478360"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="227478360"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 07:58:11 -0700
IronPort-SDR: 2bg7qZ99qW8H6DUoyeuVYdugQQGz5fu5fRDN4/lvbTmAeW3FBqijUhczRRO9mLTMCGcjSz1VPx
 VfagcLNqQMqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="442578529"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2021 07:58:09 -0700
Date:   Tue, 15 Jun 2021 17:58:09 +0300
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Shefi-simchon, Yochai" <yochai.shefi-simchon@intel.com>
Subject: Re: [PATCH v2 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I
 pcie device
Message-ID: <20210615145755.GA25911@aipg-stp-03.iil.intel.com>
References: <20210513085725.45528-1-guy.zadicario@intel.com>
 <YJ4121X/fkSkeHaj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ4121X/fkSkeHaj@kroah.com>
Organization: Intel Israel (74) Limited
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:33:31AM +0300, Greg KH wrote:
> On Thu, May 13, 2021 at 11:57:10AM +0300, Guy Zadicario wrote:
> > Hi,
> > 
> > The following series is a driver for a new PCIe device from Intel named NNP-I
> > (Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
> > device used for acceleration of AI deep learning inference applications in the
> > data-center.
> 
> How does this differ from the "intel_gna" driver being proposed here:
> 	https://lore.kernel.org/linux-doc/20210513110040.2268-1-maciej.kwapulinski@linux.intel.com/
> 
> Please work together to come up with a unified userspace api for these
> devices, and hopefully, shared kernel code as well.
> 
Ok, after consulting, we will try to share api and some kernel code
between the two drivers.

The plan is to suggest a common framework for both devices
and let each device driver register with that framework,
some functionality will be common and some will be device driver
specific (same model as drm for gpus). At first I think the common part
will be small and will deal only with host memory management, later,
it might grow, if/when some other drivers will adopt it as well.

We will first change the NNP-I driver to use this framework.
The GNA driver will wait for this API to be accepted and only then will
adopt it and request to upstream.

Thanks,
Guy.

