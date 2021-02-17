Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC831E31A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbhBQXj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:39:29 -0500
Received: from mga11.intel.com ([192.55.52.93]:37340 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233178AbhBQXiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:38:22 -0500
IronPort-SDR: h0DwQbtvCny1fs6W1G00u/UWJyGo+FAwUAWA09+UKsoxEHMwia/bjt+AoQYmiYaPIbLs6C9R6d
 1/wVCvmNtcIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="179836761"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="179836761"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:36:36 -0800
IronPort-SDR: T5FsD0TdZ5uuUfBT7hTyBrEshkVTBswZZcYeQls/Aeo8auYLDfIVNvUUh+Gqs9IG67Z/qe3VbF
 J5n9ML4JTNCQ==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="427698613"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:36:35 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 8A00D6365;
        Wed, 17 Feb 2021 15:36:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:36:35 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: Re: [PATCH v6 30/34] misc:intel_tsens: Intel Keem Bay tsens driver.
Message-ID: <20210217233635.GI154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-31-mgross@linux.intel.com>
 <9f79622d-8985-42f8-ab25-87908ccdb89a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f79622d-8985-42f8-ab25-87908ccdb89a@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:42:22AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:23 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> > index be8d27e81864..5cfe6b4004e5 100644
> > --- a/drivers/misc/intel_tsens/Kconfig
> > +++ b/drivers/misc/intel_tsens/Kconfig
> > @@ -28,6 +28,18 @@ config INTEL_TSENS_I2C_SLAVE
> >  	  Say Y if using a processor that includes the Intel VPU such as
> >  	  Keem Bay.  If unsure, say N.
> >  
> > +config KEEMBAY_THERMAL
> > +	tristate "Temperature sensor driver for intel Keem Bay"
> 
> s/intel/Intel/ ?
> 
> as above and below.
fixed and qued up for posting with the merge window closes.

--mark
> 
> > +	depends on INTEL_TSENS_LOCAL_HOST && ARCH_KEEMBAY
> > +	help
> > +	  Enable this option if you want to have support for Keem Bay
> > +	  thermal management sensors.
> > +
> > +	  This driver is used for reading onchip temperature sensor
> > +	  values from Keem Bay SoC.
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 
