Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E373FC280
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhHaGKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:10:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:63991 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhHaGKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:10:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="205539843"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="205539843"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 23:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="687546018"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by fmsmga006.fm.intel.com with ESMTP; 30 Aug 2021 23:09:52 -0700
Date:   Tue, 31 Aug 2021 14:10:27 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [PATCH v2 1/3] virt: acrn: Introduce interfaces for MMIO device
 passthrough
Message-ID: <20210831061027.GA8717@louislifei-OptiPlex-7050>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-2-fei1.li@intel.com>
 <YSarcddFb5wNQ+LK@kroah.com>
 <20210826013838.GA7915@louislifei-OptiPlex-7050>
 <YSimLMpFQyp3gbNl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSimLMpFQyp3gbNl@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:45:32AM +0200, Greg KH wrote:
> On Thu, Aug 26, 2021 at 09:38:38AM +0800, Li Fei1 wrote:
> > On Wed, Aug 25, 2021 at 10:43:29PM +0200, Greg KH wrote:
> > > On Wed, Aug 25, 2021 at 05:01:40PM +0800, Fei Li wrote:
> > > > From: Shuo Liu <shuo.a.liu@intel.com>
> > > > 
> > > > MMIO device passthrough enables an OS in a virtual machine to directly
> > > > access a MMIO device in the host. It promises almost the native
> > > > performance, which is required in performance-critical scenarios of
> > > > ACRN.
> > > > 
> > > > HSM provides the following ioctls:
> > > >   - Assign - ACRN_IOCTL_ASSIGN_MMIODEV
> > > >     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
> > > >     inform the hypervisor to assign a MMIO device to a User VM.
> > > > 
> > > >   - De-assign - ACRN_IOCTL_DEASSIGN_PCIDEV
> > > >     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
> > > >     inform the hypervisor to de-assign a MMIO device from a User VM.
> > > > 
> > > > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > > > Signed-off-by: Fei Li <fei1.li@intel.com>
> > > 
> > > Where is the userspace code that uses this new api?
> > 
> > Hi Greg
> > 
> > An ACRN userspace application (like QEMU) would uses these new apis in
> > https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L562
> > and
> > https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L568

Hi Greg

Sorry to reply late.
> 
> Please provide links in all of these patches when you resend them, to
> the userspace code as well, so that we know how it all works together.
> 

Sure.


> thanks,
> 
> greg k-h
