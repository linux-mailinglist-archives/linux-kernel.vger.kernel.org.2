Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE931E308
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBQXcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:32:54 -0500
Received: from mga18.intel.com ([134.134.136.126]:1558 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232120AbhBQXcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:32:51 -0500
IronPort-SDR: BY9zRM/LTmMbOMo2Ir0Cj+0aqNZ5Tn3HFppNtxN6oi8sFNLB6SbBZjvl3dOrV9Kzhfaa+bp0Yy
 oEgtKCrdqGhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="171015288"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="171015288"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:31:01 -0800
IronPort-SDR: rSQxv+bCwsEsy1VR83lFhp2kUXFydWec0O0sHTQzleL6/TDnxF833Z9/PkBYQT/BLSq8mY5I9g
 FlQ+gvobqC0w==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="593137528"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:31:00 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id A635E6365;
        Wed, 17 Feb 2021 15:30:59 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:30:59 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        "Li, Tingqian" <tingqian.li@intel.com>,
        Zhou Luwei <luwei.zhou@intel.com>,
        Wang jue <wang.jue@intel.com>
Subject: Re: [PATCH v6 25/34] misc: Add Keem Bay VPU manager
Message-ID: <20210217233059.GE154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-26-mgross@linux.intel.com>
 <569d29f2-d976-4a5d-271e-f762d59bce70@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <569d29f2-d976-4a5d-271e-f762d59bce70@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:39:55AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/vpumgr/Kconfig b/drivers/misc/vpumgr/Kconfig
> > new file mode 100644
> > index 000000000000..bb82ff83afd3
> > --- /dev/null
> > +++ b/drivers/misc/vpumgr/Kconfig
> > @@ -0,0 +1,9 @@
> > +config VPUMGR
> > +	tristate "VPU Manager"
> > +	depends on ARM64 && XLINK_CORE
> > +	help
> > +	  VPUMGR manages life-cycle of VPU related resources which were
> > +	  dynamically allocated on demands of user-space application
> 
> End the sentence above with a period ('.').
fixed and qued up for merge window closure.

--mark

> 
> > +
> > +	  Select y or m if you have a processor including the Intel
> > +	  Vision Processor (VPU) on it.
> 
> 
> -- 
> ~Randy
> 
