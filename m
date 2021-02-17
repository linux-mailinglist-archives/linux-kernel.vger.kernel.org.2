Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8831E311
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBQXgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:36:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:6965 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBQXg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:36:28 -0500
IronPort-SDR: WgL3J0TwAEqhx4GN75CKvah2/kvg5uW6NPiJ0EmGcnkx1JHtbO0ABT7BzQNdiHsuxS8rB1nFOA
 PPmZ3mSQCPmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="162480269"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="162480269"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:34:37 -0800
IronPort-SDR: 8aU6XhxHyi7qyk2y1L1Hl1VBZWfMbP1fsMfbPfWiFInF1E6Imbry/Sm8ulYiPcDa+KodmXFDH/
 JzBwU6qzQxwA==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="494548356"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:34:36 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id A4E1E6365;
        Wed, 17 Feb 2021 15:34:36 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:34:36 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: Re: [PATCH v6 28/34] misc: Intel tsens IA host driver.
Message-ID: <20210217233436.GG154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-29-mgross@linux.intel.com>
 <52e882de-62d6-5ec2-dfc4-dda74018df3c@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e882de-62d6-5ec2-dfc4-dda74018df3c@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:45:56AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> > index bfb8fe1997f4..8b263fdd80c3 100644
> > --- a/drivers/misc/intel_tsens/Kconfig
> > +++ b/drivers/misc/intel_tsens/Kconfig
> > @@ -13,3 +13,16 @@ config INTEL_TSENS_LOCAL_HOST
> >  	  management controller.
> >  	  Say Y if using a processor that includes the Intel VPU such as
> >  	  Keem Bay.  If unsure, say N.
> > +
> > +config INTEL_TSENS_IA_HOST
> > +	tristate "Temperature sensor driver for intel tsens remote host"
> 
> s/intel/Intel/ ?
> 
> as above and below.
fixed and qued up for posting when merge window closes.

Thanks!

--mark
> 
> > +	depends on I2C && THERMAL
> > +	depends on I2C_SMBUS
> > +	help
> > +	  This option enables tsens i2c and thermal local Host driver.
> > +
> > +	  This driver is used for reading thermal data via I2C SMBUS
> > +	  and registers itself to thermal framework, which can be
> > +	  used by thermal daemon in remote IA host
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 
