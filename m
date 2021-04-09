Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED8235A39D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbhDIQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:42:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:17639 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234142AbhDIQl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:41:59 -0400
IronPort-SDR: u6ZgXYYyAtWMf2vZsU79hg4jAnQ3hBdFQ+78VLBTrLf3lk4JNZa12p9sJqpKddHVmwaUP2wLJK
 e8KjVKfN+VSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="181330641"
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="181330641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:41:46 -0700
IronPort-SDR: ln9tRBqUAzx6WVFVR2aPszLeA8Rhu1kRmICVOKiGFRXQ7IH47CsInbY28hob42C65D310519oS
 gpLb6l0pGjtg==
X-IronPort-AV: E=Sophos;i="5.82,209,1613462400"; 
   d="scan'208";a="416332651"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 09:41:46 -0700
Date:   Fri, 9 Apr 2021 09:41:45 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     wangyingjie55@126.com
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Message-ID: <20210409164145.GQ3014244@iweiny-DESK2.sc.intel.com>
References: <1617933506-13684-1-git-send-email-wangyingjie55@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617933506-13684-1-git-send-email-wangyingjie55@126.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 06:58:26PM -0700, wangyingjie55@126.com wrote:
> From: Yingjie Wang <wangyingjie55@126.com>
> 
> In nd_dax_probe(), 'nd_dax' is allocated by nd_dax_alloc().
> nd_dax_alloc() may fail and return NULL, so we should better check

Avoid the use of 'we'.

> it's return value to avoid a NULL pointer dereference
> a bit later in the code.

How about:

"nd_dax_alloc() may fail and return NULL.  Check for NULL before attempting to
use nd_dax to avoid a NULL pointer dereference."

> 
> Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
> Signed-off-by: Yingjie Wang <wangyingjie55@126.com>

The code looks good though.

Ira

> ---
>  drivers/nvdimm/dax_devs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
> index 99965077bac4..b1426ac03f01 100644
> --- a/drivers/nvdimm/dax_devs.c
> +++ b/drivers/nvdimm/dax_devs.c
> @@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
>  
>  	nvdimm_bus_lock(&ndns->dev);
>  	nd_dax = nd_dax_alloc(nd_region);
> +	if (!nd_dax)
> +		return -ENOMEM;
>  	nd_pfn = &nd_dax->nd_pfn;
>  	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
>  	nvdimm_bus_unlock(&ndns->dev);
> -- 
> 2.7.4
> 
