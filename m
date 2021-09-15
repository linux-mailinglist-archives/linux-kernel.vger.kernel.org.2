Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE11640BD45
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 03:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhIOBp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 21:45:28 -0400
Received: from mga05.intel.com ([192.55.52.43]:20915 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhIOBp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 21:45:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="307733396"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="307733396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 18:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="472226883"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2021 18:44:06 -0700
Date:   Wed, 15 Sep 2021 09:44:33 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, yu1.wang@intel.com,
        shuox.liu@gmail.com, fei1.li@intel.com
Subject: Re: [PATCH v4 0/2] Introduce some interfaces for ACRN hypervisor HSM
 driver
Message-ID: <20210915014433.GB28232@louislifei-OptiPlex-7050>
References: <20210914062627.16431-1-fei1.li@intel.com>
 <YUBIbqeDyBELtR6H@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUBIbqeDyBELtR6H@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:59:58AM +0200, Greg KH wrote:
> On Tue, Sep 14, 2021 at 02:26:25PM +0800, Fei Li wrote:
> > Add some new interfaces for ACRN hypervisor HSM driver:
> >   - MMIO device passthrough
> >   - virtual device creating/destroying
> >   - platform information fetching from the hypervisor
> > 
> > ChangeLog:
> > v4:
> >  - remove "RFC" from Subject field.
> > 
> > v3:
> >  - remove "platform information fetching from the hypervisor". What platform
> >    information needs to be fetched has not been finally decided. Will send tis
> >    patch out once that has been decided.
> >  - add comments where is the userspace code that uses this new api:
> >    - MMIO device passthrough
> >      (a) assign a MMIO device to a User VM
> >      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L562
> >      (b) de-assign a MMIO device from a User VM
> >      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L568
> >    - virtual device creating/destroying
> >      (a) create a virtual device for a User VM
> >      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L606
> >      (b) destroy a virtual device of a User VM
> >      https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c#L612
> 
> Can you put these comments in the changelog text?  Stuff in the 0/X
> email never shows up in the changelog at all.

Hi Greg

What's the "changelog text" mean ? Would you please tell how could I do this ? 
I see peoples always describe what does their patches change in the cover letter
(the 0/X email).

thanks.

> 
> thanks,
> 
> greg k-h
