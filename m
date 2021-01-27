Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F8305045
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhA0Dxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:53:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:26814 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S316671AbhA0BjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 20:39:10 -0500
IronPort-SDR: Ntx8PxEukoIsQp42H7lHGs2nLU+B7yTLVwCkTWtvJtjU/29q8JYhrR3J7xShpBVVb/3yToiQ3z
 YN4WGb+2ikbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="198798412"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="198798412"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 17:37:35 -0800
IronPort-SDR: 5NsOjJLbi7V1CZhY8oZ6q3H4VkUhNBGIqrYqGKyYMDuaEViXqqbCnUKUX533w6W0PfRmR7jU9z
 LwLRxUxu4T6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="scan'208";a="362214360"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jan 2021 17:37:32 -0800
Date:   Wed, 27 Jan 2021 09:33:14 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add entry for Intel MAX 10 mfd driver
Message-ID: <20210127013314.GA11977@yilunxu-OptiPlex-7050>
References: <1611643836-7183-1-git-send-email-yilun.xu@intel.com>
 <1611643836-7183-5-git-send-email-yilun.xu@intel.com>
 <5c75dafc-8103-100e-2b06-f0b229827ef0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c75dafc-8103-100e-2b06-f0b229827ef0@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 07:06:17AM -0800, Tom Rix wrote:
> 
> On 1/25/21 10:50 PM, Xu Yilun wrote:
> > This patch adds maintainer info for Intel MAX 10 mfd driver.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > ---
> >  MAINTAINERS | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5aa18cb..10985d3 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9132,6 +9132,15 @@ F:	include/linux/mei_cl_bus.h
> >  F:	include/uapi/linux/mei.h
> >  F:	samples/mei/*
> >  
> 
> I am interested in reviewing these files like I do with
> 
> FPGA DFL DRIVERS
> 
> So can you add
> 
> R:    Tom Rix <trix@redhat.com>
> 
> if you have to rev this patchset ?

It's good to me. I'll add it if I need to send v3.

Thanks,
Yilun

> 
> Else I will submit a followup.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> > +INTEL MAX 10 BMC MFD DRIVER
> > +M:	Xu Yilun <yilun.xu@intel.com>
> > +S:	Maintained
> > +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > +F:	Documentation/hwmon/intel-m10-bmc-hwmon.rst
> > +F:	drivers/hwmon/intel-m10-bmc-hwmon.c
> > +F:	drivers/mfd/intel-m10-bmc.c
> > +F:	include/linux/mfd/intel-m10-bmc.h
> > +
> >  INTEL MENLOW THERMAL DRIVER
> >  M:	Sujith Thomas <sujith.thomas@intel.com>
> >  L:	platform-driver-x86@vger.kernel.org
