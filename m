Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B34837B71A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhELHxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:53:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:16903 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhELHxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:53:11 -0400
IronPort-SDR: qkWVK7Ky7f9R9LvNuVmOmBexDRcElYIZXioD2hFXYBYkuVyw3Zo+UzFCAtsegEpsKm4gOJAExB
 IYbTgyQAs1PA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="196549779"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="196549779"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 00:51:45 -0700
IronPort-SDR: XEI2VAG5MgQ7nWwmMX1gpUQ2AWp7hhJa+2EmSLWWsBsXCyEWahYjWkgo0tdyarLad1T0RFYjAf
 yRgwjAdDeN1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="541973960"
Received: from aipg-stp-03.iil.intel.com ([143.185.92.28])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2021 00:51:42 -0700
Date:   Wed, 12 May 2021 10:51:41 +0300
From:   Guy Zadicario <guy.zadicario@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net,
        alexander.shishkin@linux.intel.com, andriy.shevchenko@intel.com,
        yochai.shefi-simchon@intel.com
Subject: Re: [PATCH 00/15] misc: nnpi: New PCIe driver for Intel's NNP-I pcie
 device
Message-ID: <20210512075141.GA35140@aipg-stp-03.iil.intel.com>
References: <20210512071046.34941-1-guy.zadicario@intel.com>
 <YJuDUXennxtR5rCZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJuDUXennxtR5rCZ@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 09:27:13AM +0200, Greg KH wrote:
> On Wed, May 12, 2021 at 10:10:31AM +0300, Guy Zadicario wrote:
> > Hi,
> > 
> > The following series is a driver for a new PCIe device from Intel named NNP-I
> > (Nirvana Neural Processor for Inference). NNP-I is a PCIe connected compute
> > device used for acceleration of AI deep learning inference applications in the
> > data-center.
> > 
> > The reason that this driver should be in the kernel is that it aims to serve
> > multiple users and user-space applications which might share the same NNP-I
> > card. Workloads from multiple applications can be processed simultanously by
> > the NNP-I card if enough compute resources exist.
> > 
> > Overview of the NNP-I device, driver structure and ABIs used in the driver is in
> > patch#1, which adds the info as a document as it might be a useful info for
> > anyone trying to understand the driver even past review.
> > 
> > In order to ease the review process, there will be multiple series for the
> > entire driver code. This is the first series, and it implements everything
> > necessary to initialize the NNP-I device and allow a user-space inference
> > application to use it. Other features, which are mostly related to maintenance,
> > device status visibility and error-handling, will be submitted on the next stage.
> > 
> > A basic user-space library and test application which illustrates the flow of
> > an NNP-I inference application can be found here: https://github.com/IntelAI/nnpi-host
> > (This series is enough for the test application to run)
> > 
> > This patchset has gone through internal review inside Intel, the summary of the
> > change log from the internal review follows.
> > 
> > I would appreciate any feedback, questions or comments to this series.
> > 
> > Changes in v22:
> 
> Why is "v22" not in the [PATCH...] part of the subjects here?
> 
> And has there really been 21 other series posted to lkml for this?
> 

This is the first post to lkml. The first 21 versions was sent for
internal review in Intel only.
I could possibly remove the long change log from the cover letter.

Thanks,
Guy.
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

