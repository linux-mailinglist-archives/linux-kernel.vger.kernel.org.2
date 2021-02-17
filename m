Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAC431E30D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhBQXe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:34:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:64991 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232468AbhBQXew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:34:52 -0500
IronPort-SDR: 0lVD1AV4Z1e1E9zm0mpSm8SAT7yjZea06+a9VpMRbX2+kb1wFqCQbWfkbmyotCtTKEvzv/sMDS
 +pWxQBZ0vY5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="244809982"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="244809982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:33:06 -0800
IronPort-SDR: xuotl2Uv6HNlS+jtRkIqgIvXWT878kl8LmSpkPeLhW47SBSr+lu0qcXAx413f1Qly8OgNBNQTR
 /0Ke7Cg83u9Q==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="494544172"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:33:05 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 9F6AD6365;
        Wed, 17 Feb 2021 15:33:04 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:33:04 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>
Subject: Re: [PATCH v6 27/34] misc: Tsens ARM host thermal driver.
Message-ID: <20210217233304.GF154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-28-mgross@linux.intel.com>
 <79f17b05-897c-6851-072b-682932057577@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79f17b05-897c-6851-072b-682932057577@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:44:53AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/intel_tsens/Kconfig b/drivers/misc/intel_tsens/Kconfig
> > new file mode 100644
> > index 000000000000..bfb8fe1997f4
> > --- /dev/null
> > +++ b/drivers/misc/intel_tsens/Kconfig
> > @@ -0,0 +1,15 @@
> > +# Copyright (C) 2020 Intel Corporation
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +config INTEL_TSENS_LOCAL_HOST
> > +	bool "Temperature sensor driver for intel tsens"
> 
> s/intel/Intel/ ?
> 
> as below.
fixed and qued up for posting when merge window closes.

--mark

> 
> > +	select THERMAL
> > +	help
> > +	  This option enables tsens thermal local Host driver.
> > +
> > +	  This driver is used for reporting thermal data via thermal
> > +	  framework.
> > +	  Enable this option if you want to have support for thermal
> > +	  management controller.
> > +	  Say Y if using a processor that includes the Intel VPU such as
> > +	  Keem Bay.  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 
