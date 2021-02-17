Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0865A31E319
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhBQXjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:39:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:18962 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232867AbhBQXh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:29 -0500
IronPort-SDR: udH8UKsl0MM6Qh7gGH6qTQXoeqbeQQPp1+lEj/Qd4MQo7qEIEYb7FtMx0dN7E/gOooZpWnmiu2
 qBfTnGnHSHpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183473197"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183473197"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:35:43 -0800
IronPort-SDR: J/W1vCIp1CTjxtUy8uLWVixNUloEJn1tLdh7PB/yZA/7j4bn8wWbNX6x2bstkZS9UosvfErsSn
 Idcz8zpt3mWw==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="427698389"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:35:42 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id AF4AF6365;
        Wed, 17 Feb 2021 15:35:41 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:35:41 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: Re: [PATCH v6 29/34] Intel tsens i2c slave driver.
Message-ID: <20210217233541.GH154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-30-mgross@linux.intel.com>
 <abdb8d8a-d382-7dec-4ce1-a0dc447dea32@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abdb8d8a-d382-7dec-4ce1-a0dc447dea32@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:41:26AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> > index 8b263fdd80c3..be8d27e81864 100644
> > --- a/drivers/misc/intel_tsens/Kconfig
> > +++ b/drivers/misc/intel_tsens/Kconfig
> > @@ -14,6 +14,20 @@ config INTEL_TSENS_LOCAL_HOST
> >  	  Say Y if using a processor that includes the Intel VPU such as
> >  	  Keem Bay.  If unsure, say N.
> >  
> > +config INTEL_TSENS_I2C_SLAVE
> > +	bool "I2C slave driver for intel tsens"
> 
> s/intel/Intel/ ?
> (as below)
fixed and qued up for posting when merge window closes.

Thanks

--mark

> 
> > +	depends on INTEL_TSENS_LOCAL_HOST
> > +	depends on I2C=y && I2C_SLAVE
> > +	help
> > +	  This option enables tsens I2C slave driver.
> > +
> > +	  This driver is used for reporting thermal data via I2C
> > +	  SMBUS to remote host.
> > +	  Enable this option if you want to have support for thermal
> > +	  management controller.
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 
