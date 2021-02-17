Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D631E303
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbhBQXb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:31:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:19683 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhBQXbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:31:25 -0500
IronPort-SDR: CyLoedjzDE/lX/xYgfMg6P0LKSxDxciDQ+xqtNzGYrn2Z+odyswtUPjPf0UVwlQPCtbQ4ZR0C3
 LaXeY3r2D9bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183417919"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183417919"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:29:39 -0800
IronPort-SDR: sn366c49e7ftdmEMSpCxEYtyEdNH2roaTs5/wSWTiK0eedRxMwHo+xG2W4WxsUfYbRvoZcWemg
 hhXgp1PGv9bQ==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="513035005"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 15:29:39 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id AA12D6365;
        Wed, 17 Feb 2021 15:29:39 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:29:39 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 20/34] xlink-core: Add xlink core driver xLink
Message-ID: <20210217232939.GD154917@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20210212222304.110194-1-mgross@linux.intel.com>
 <20210212222304.110194-21-mgross@linux.intel.com>
 <ddacd2e2-b491-5443-4006-c8c5d90d583f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddacd2e2-b491-5443-4006-c8c5d90d583f@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:52:51AM -0800, Randy Dunlap wrote:
> On 2/12/21 2:22 PM, mgross@linux.intel.com wrote:
> > diff --git a/drivers/misc/xlink-core/Kconfig b/drivers/misc/xlink-core/Kconfig
> > new file mode 100644
> > index 000000000000..a0ceb0b48219
> > --- /dev/null
> > +++ b/drivers/misc/xlink-core/Kconfig
> > @@ -0,0 +1,33 @@
> > +config XLINK_CORE
> > +	tristate "Support for XLINK CORE"
> > +	depends on ((XLINK_PCIE_RH_DRIVER || XBAY_XLINK_PCIE_RH_DRIVER) || (XLINK_LOCAL_HOST && (XLINK_PCIE_LH_DRIVER || XBAY_XLINK_PCIE_RH_DRIVER)))
> 
> -ELINETOOLONG. Use '\' for line continuation in Kconfig files.
fixed

> 
> > +	help
> > +	  XLINK CORE enables the communication/control subsystem.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called xlink.ko.
> > +
> > +config XLINK_LOCAL_HOST
> > +	tristate "Support for XLINK LOCAL HOST"
> > +	depends on XLINK_IPC
> > +	help
> > +	  XLINK LOCAL HOST enables local host functionality for
> > +	  the communication/control Sub-System.
> > +
> > +	  Enable this config when building the kernel for the Intel Vision
> > +	  Processing Unit (VPU) Local Host core.
> > +
> > +	  If building for a Remote Host kernel, say N.
> > +
> > +config XLINK_PSS
> > +	tristate "Support for XLINK PSS (Pre-Silicon Solution)"
> > +	depends on XLINK_LOCAL_HOST
> > +	help
> > +	  XLINK PSS enables the communication/control subsystem on a PSS platform.
> > +
> > +	  Enable this config when building the kernel for the Intel Vision
> > +	  Processing Unit (VPU) in a simulated env.
> 
> Please s/env/environment/.
fixed

I have the update qued up and I'll post v7 rebased when the merge window closes

--mark

> 
> > +
> > +	  If building for a VPU silicon, say N.
> 
> 
> -- 
> ~Randy
> 
