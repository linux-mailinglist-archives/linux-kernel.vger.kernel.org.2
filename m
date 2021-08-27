Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D46B3F965E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbhH0Iq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244548AbhH0Iq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:46:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C124160FDA;
        Fri, 27 Aug 2021 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630053939;
        bh=MiP2UIQ4KnpSOIPJ77kWFfno3nhfZ/L/F6vYRuSNwRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxXJAAvjzhPC2NNJj66cW5aAzXrPDUGTV3u+iGjWQOSCrPRbM1meJljy3Vn7wWqCl
         bfZmjsM7hOImDpgq7UuzlTfUFVuLGqb5OWChTm4Wi0yrT4NfDs2hv7blbAiQT5zX3Y
         L1seQXJESKdPOHcS4bkNPaZVTzdwMTT+sLFiQrvs=
Date:   Fri, 27 Aug 2021 10:45:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Li Fei1 <fei1.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com
Subject: Re: [PATCH v2 1/3] virt: acrn: Introduce interfaces for MMIO device
 passthrough
Message-ID: <YSimLMpFQyp3gbNl@kroah.com>
References: <20210825090142.4418-1-fei1.li@intel.com>
 <20210825090142.4418-2-fei1.li@intel.com>
 <YSarcddFb5wNQ+LK@kroah.com>
 <20210826013838.GA7915@louislifei-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826013838.GA7915@louislifei-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 09:38:38AM +0800, Li Fei1 wrote:
> On Wed, Aug 25, 2021 at 10:43:29PM +0200, Greg KH wrote:
> > On Wed, Aug 25, 2021 at 05:01:40PM +0800, Fei Li wrote:
> > > From: Shuo Liu <shuo.a.liu@intel.com>
> > > 
> > > MMIO device passthrough enables an OS in a virtual machine to directly
> > > access a MMIO device in the host. It promises almost the native
> > > performance, which is required in performance-critical scenarios of
> > > ACRN.
> > > 
> > > HSM provides the following ioctls:
> > >   - Assign - ACRN_IOCTL_ASSIGN_MMIODEV
> > >     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
> > >     inform the hypervisor to assign a MMIO device to a User VM.
> > > 
> > >   - De-assign - ACRN_IOCTL_DEASSIGN_PCIDEV
> > >     Pass data struct acrn_mmiodev from userspace to the hypervisor, and
> > >     inform the hypervisor to de-assign a MMIO device from a User VM.
> > > 
> > > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > > Signed-off-by: Fei Li <fei1.li@intel.com>
> > 
> > Where is the userspace code that uses this new api?
> 
> Hi Greg
> 
> An ACRN userspace application (like QEMU) would uses these new apis in
> https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L562
> and
> https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L568

Please provide links in all of these patches when you resend them, to
the userspace code as well, so that we know how it all works together.

thanks,

greg k-h
