Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A08C34F025
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 19:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhC3RuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 13:50:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:47553 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232577AbhC3Rtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:49:35 -0400
IronPort-SDR: kBaf9suBOUPVGcdpslmifk0FSCQlG4gVDFUYb9dKAtPrL14zqxdMJY22lC/+9PUd8P+z9fGJ2S
 m1OcMmOoZHWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191851590"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191851590"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:49:30 -0700
IronPort-SDR: FKvLAxU7/mf8+wi6h4BaZT9P8YOdspJgTsnJqqPxQyxc4VzrRXVhYEv6CxKxIvTfM2cRClkXwf
 b6SYPfDpn1+g==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="393695340"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 10:49:30 -0700
Date:   Tue, 30 Mar 2021 10:52:00 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        jacob.jun.pan@linux.intel.com, "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Enable write protect for supervisor
 SVM
Message-ID: <20210330105200.418bc42b@jacob-builder>
In-Reply-To: <20210322175338.GA24424@roeck-us.net>
References: <1614680040-1989-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1614680040-1989-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20210322175338.GA24424@roeck-us.net>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Mon, 22 Mar 2021 10:53:38 -0700, Guenter Roeck <linux@roeck-us.net>
wrote:

> On Tue, Mar 02, 2021 at 02:13:57AM -0800, Jacob Pan wrote:
> > Write protect bit, when set, inhibits supervisor writes to the read-only
> > pages. In supervisor shared virtual addressing (SVA), where page tables
> > are shared between CPU and DMA, IOMMU PASID entry WPE bit should match
> > CR0.WP bit in the CPU.
> > This patch sets WPE bit for supervisor PASIDs if CR0.WP is set.
> > 
> > Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---  
> 
> ia64:defconfig:
> 
> drivers/iommu/intel/pasid.c: In function 'pasid_enable_wpe':
> drivers/iommu/intel/pasid.c:536:22: error: implicit declaration of
> function 'read_cr0' drivers/iommu/intel/pasid.c:539:23: error:
> 'X86_CR0_WP' undeclared
> 
> Maybe it _is_ time to retire ia64 ?

Good catch, sorry for the late reply. I guess otherwise I will have to do
some #ifdef?

There are many basic x86 helpers are missing in ia64.

+Tony

Thanks,

Jacob

