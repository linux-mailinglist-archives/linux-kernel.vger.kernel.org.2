Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDE34E59C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhC3Kl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:41:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:10935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhC3Klc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:41:32 -0400
IronPort-SDR: 8wCMMwx3+84QQIAHtoj2oCuLABXKI3/NF5yc+hThFT+zq0LFVU6IodmzVHarFDGDysQaoho0Qi
 cdY1FAPWbDiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191211290"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="191211290"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 03:41:31 -0700
IronPort-SDR: iQmwTwy/scIftGbnpXpGawj4WiagnlNianAla164MREaORGSD4BwIQhSNMMGF9uNes3MhFfOCH
 ZF3WMa70tMyg==
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="418119598"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 03:41:27 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 30 Mar 2021 13:41:25 +0300
Date:   Tue, 30 Mar 2021 13:41:25 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 1/2] thunderbolt: Fix a leak in tb_retimer_add()
Message-ID: <20210330104125.GP2542@lahna.fi.intel.com>
References: <YGFulvAa5Kz6HTsd@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGFulvAa5Kz6HTsd@mwanda>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 09:07:18AM +0300, Dan Carpenter wrote:
> After the device_register() succeeds, then the correct way to clean up
> is to call device_unregister().  The unregister calls both device_del()
> and device_put().  Since this code was only device_del() it results in
> a memory leak.
> 
> Fixes: dacb12877d92 ("thunderbolt: Add support for on-board retimers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is from a new static checker warning.  Not tested.  With new
> warnings it's also possible that I have misunderstood something
> fundamental so review carefully etc.
> 
>  drivers/thunderbolt/retimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches applied to thunderbolt.git/fixes. Thanks Dan!
