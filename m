Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD493AB5B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhFQOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:20:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:19996 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhFQOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:20:45 -0400
IronPort-SDR: V8+kgvwotzxpTReWyJ3UwGZPn3uxKJYD93hG/az+2gtHAxlV53Ux/rFQvzWmd+Uea88FBjLsKt
 1NNwXU/s1+Xg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="267524930"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="267524930"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 07:18:36 -0700
IronPort-SDR: RNaagrLWZzY7C0Gco/HmGVrEJrnG1Wqt5D1vriL+J1wHGobu1UXEgHrjkrr+5jeF8rP9IZuS/L
 83kPoc38skEw==
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="451032392"
Received: from abadmaev-mobl3.amr.corp.intel.com ([10.212.173.214])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 07:18:36 -0700
Message-ID: <87c42db2e913df0dbb1cd772ba3fba5da59b1ed1.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] platform/x86: ISST: Optimize CPU to PCI device
 mapping
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 17 Jun 2021 07:18:34 -0700
In-Reply-To: <b93fc0c0-77f9-a9b4-e5dd-28a781332691@redhat.com>
References: <20210616221329.1909276-1-srinivas.pandruvada@linux.intel.com>
         <b93fc0c0-77f9-a9b4-e5dd-28a781332691@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Thu, 2021-06-17 at 13:37 +0200, Hans de Goede wrote:
> > 

[...]

> Hi Srinivas,
> 
> On 6/17/21 12:13 AM, Srinivas Pandruvada wrote:
> >  
> > -	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
> > -	if (bus_number < 0)
> > -		return NULL;
> > +	pci_dev = isst_cpu_info[cpu].pci_dev[bus_no];
> 
> If the _isst_if_get_pci_dev() call below fails, then pci_dev might
> end up getting set to NULL here.
> 
> >  
> > -	return pci_get_domain_bus_and_slot(0, bus_number,
> > PCI_DEVFN(dev, fn));
> > +	if (pci_dev->devfn == PCI_DEVFN(dev, fn))
> 
> And then this would lead to a NULL ptr deref, I've replaced this
> the above if with:
> 
> 	if (pci_dev && pci_dev->devfn == PCI_DEVFN(dev, fn))
> 
> to avoid this.
Looks good.

Thanks for doing the change.

-Srinivas

> 
> I've applied this series with the above change
> to my review-hans  branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> > +		return pci_dev;
> > +
> > +	return _isst_if_get_pci_dev(cpu, bus_no, dev, fn);
> >  }
> >  EXPORT_SYMBOL_GPL(isst_if_get_pci_dev);
> >  
> > @@ -327,6 +344,8 @@ static int isst_if_cpu_online(unsigned int cpu)
> >  	} else {
> >  		isst_cpu_info[cpu].bus_info[0] = data & 0xff;
> >  		isst_cpu_info[cpu].bus_info[1] = (data >> 8) & 0xff;
> > +		isst_cpu_info[cpu].pci_dev[0] =
> > _isst_if_get_pci_dev(cpu, 0, 0, 1);
> > +		isst_cpu_info[cpu].pci_dev[1] =
> > _isst_if_get_pci_dev(cpu, 1, 30, 1);
> >  	}
> >  
> >  	ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
> > 

