Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C9F31E323
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhBQXkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:40:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:6273 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233478AbhBQXkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:40:05 -0500
IronPort-SDR: /c5ASMLnziC2oWudVa/3mr66SZ0SP2UIWeJtDz/h0rUnBS5gPUNbUrmhfSVSsm0BWyazQGHP2W
 B8YHxduzFLXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="247420481"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="247420481"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:38:06 -0800
IronPort-SDR: LnmPHAALu5beXDv9MjoGt68hk/4WYBTwOZugo6fms8UlOf0ktBsUKV3/VbqNy5Ejq8Ofr+fME5
 j3Kv2Yb8Bzgg==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="439542777"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:38:07 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 076C46365;
        Wed, 17 Feb 2021 15:38:07 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:38:07 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: Re: [PATCH v6 33/34] misc: Hddl device management for local host
Message-ID: <20210217233806.GJ154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-34-mgross@linux.intel.com>
 <e3bf77bf-d22b-5163-2af4-db88627b5450@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3bf77bf-d22b-5163-2af4-db88627b5450@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:47:51AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:23 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/hddl_device/Kconfig b/drivers/misc/hddl_device/Kconfig
> > new file mode 100644
> > index 000000000000..e1ae81fdf177
> > --- /dev/null
> > +++ b/drivers/misc/hddl_device/Kconfig
> > @@ -0,0 +1,14 @@
> > +# Copyright (C) 2020 Intel Corporation
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config HDDL_DEVICE_CLIENT
> > +	tristate "Support for hddl device client"
> 
> Please use "HDDL" consistently.
fixed and qued up for merge window closure.

--mark


> > +	depends on XLINK_CORE && INTEL_TSENS_LOCAL_HOST
> > +	help
> > +	  This option enables HDDL device client module.
> > +
> > +	  This driver is used for sharing time sync data to local host and
> > +	  retrives the sensors available on the platform. This also handles
> > +	  the device connect/disconnect programming sequence.
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 
