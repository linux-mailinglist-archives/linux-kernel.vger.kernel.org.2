Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E421D399E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 11:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFCJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 05:55:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:44240 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhFCJzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 05:55:08 -0400
IronPort-SDR: YSK4tgk1LlxGNK/cPWePiSadLqj7YB+5ingjal3DtmUpHnmcIkQcCVxaIS1vs93oQR5qBkKtYm
 2z8pmfxkUh3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="265180960"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="265180960"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 02:53:24 -0700
IronPort-SDR: uyEPPLgSCDKNELgIyYb6qvYzhUNE1Jz8SxVKSdd+x1yvjeQLF/YhYhlIvTPl2PwDFFOFfU3q7M
 IuCIWf6ZDSsw==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; 
   d="scan'208";a="550638310"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 02:53:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lok2R-00GuWe-Oc; Thu, 03 Jun 2021 12:53:19 +0300
Date:   Thu, 3 Jun 2021 12:53:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jonathan.cameron@huawei.com, song.bao.hua@hisilicon.com
Subject: Re: [PATCH v3 3/3] drivers/base/node.c: use bin_attribute to avoid
 buff overflow
Message-ID: <YLimj+KPaQ2P/cnl@smile.fi.intel.com>
References: <1622712162-7028-1-git-send-email-tiantao6@hisilicon.com>
 <1622712162-7028-4-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622712162-7028-4-git-send-email-tiantao6@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 05:22:42PM +0800, Tian Tao wrote:
> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute. so we use bin_attribute instead of
> attribute to avoid NR_CPUS too big to cause buff overflow.

...

>  }
>  
> -static DEVICE_ATTR_RO(cpumap);
>  
> -static inline ssize_t cpulist_show(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> +static BIN_ATTR_RO(cpumap, 0);

So, you will have 2 blank lines in a row after this. Why one is not enough?
Same question for other similar cases, if any.

-- 
With Best Regards,
Andy Shevchenko


