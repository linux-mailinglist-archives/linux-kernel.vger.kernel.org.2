Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4431E327
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhBQXlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:41:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:52161 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhBQXlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:41:42 -0500
IronPort-SDR: DAo+cFLNhlhW3OXfvkUzJCjUTnYfCjZDHGldgvgUKxB8xN3jwb+RP5jrmTwB7c1i5d1c4t/cE5
 lTK5FpAMOX8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="202583666"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="202583666"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:39:56 -0800
IronPort-SDR: l5pau08vLwqdrwwdltVo1XaSyI3oBoG1y6KAqdpYFr4C2i2Lh1623A5gGiz6/MMD7CXw2zFGS3
 73xFYk/1m1yQ==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="439544551"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:39:56 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 10E336365;
        Wed, 17 Feb 2021 15:39:56 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:39:56 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: Re: [PATCH v6 34/34] misc: HDDL device management for IA host
Message-ID: <20210217233955.GK154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-35-mgross@linux.intel.com>
 <bf135165-35c3-002f-305a-33019fb52b44@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf135165-35c3-002f-305a-33019fb52b44@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:48:53AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:23 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/hddl_device/Kconfig b/drivers/misc/hddl_device/Kconfig
> > index e1ae81fdf177..7f9a6a685275 100644
> > --- a/drivers/misc/hddl_device/Kconfig
> > +++ b/drivers/misc/hddl_device/Kconfig
> > @@ -12,3 +12,15 @@ config HDDL_DEVICE_CLIENT
> >  	  the device connect/disconnect programming sequence.
> >  	  Say Y if using a processor that includes the Intel VPU such as
> >  	  Keem Bay.  If unsure, say N.
> > +
> > +config HDDL_DEVICE_SERVER
> > +	tristate "Support for hddl device server"
> 
> Please use "HDDL" consistently.
fixed and qued up for merge window closure.

--mark

> 
> > +	depends on XLINK_CORE && !HDDL_DEVICE_CLIENT
> > +	help
> > +	  This option enables HDDL device server module.
> > +
> > +	  This driver is used for sharing time sync data to local host and
> > +	  retrives the sensors available on the platform. This also handles
> > +	  the device connect/disconnect programming sequence.
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> thanks.
> -- 
> ~Randy
> 
