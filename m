Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB793F7FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 03:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbhHZBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 21:38:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:21666 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235677AbhHZBix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 21:38:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10087"; a="217648801"
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="217648801"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2021 18:38:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,352,1620716400"; 
   d="scan'208";a="684711931"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2021 18:37:59 -0700
Date:   Thu, 26 Aug 2021 09:38:38 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [PATCH v2 1/3] virt: acrn: Introduce interfaces for MMIO device
 passthrough
Message-ID: <20210826013838.GA7915@louislifei-OptiPlex-7050>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-2-fei1.li@intel.com>
 <YSarcddFb5wNQ+LK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSarcddFb5wNQ+LK@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:43:29PM +0200, Greg KH wrote:
> On Wed, Aug 25, 2021 at 05:01:40PM +0800, Fei Li wrote:
> > From: Shuo Liu <shuo.a.liu@intel.com>
> > 
> > MMIO device passthrough enables an OS in a virtual machine to directly
> > access a MMIO device in the host. It promises almost the native
> > performance, which is required in performance-critical scenarios of
> > ACRN.
> > 
> > HSM provides the following ioctls:
> >   - Assign - ACRN_IOCTL_ASSIGN_MMIODEV
> >     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
> >     inform the hypervisor to assign a MMIO device to a User VM.
> > 
> >   - De-assign - ACRN_IOCTL_DEASSIGN_PCIDEV
> >     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
> >     inform the hypervisor to de-assign a MMIO device from a User VM.
> > 
> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > Signed-off-by: Fei Li <fei1.li@intel.com>
> 
> Where is the userspace code that uses this new api?

Hi Greg

An ACRN userspace application (like QEMU) would uses these new apis in
https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L562
and
https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L568

thanks.

> 
> thanks,
> 
> greg k-h
