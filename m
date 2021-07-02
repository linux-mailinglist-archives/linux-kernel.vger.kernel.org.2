Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C064B3B9EC7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhGBKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:06:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:45127 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhGBKGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:06:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="269836552"
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="269836552"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 03:03:47 -0700
X-IronPort-AV: E=Sophos;i="5.83,316,1616482800"; 
   d="scan'208";a="626689785"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 03:03:42 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lzG1I-007egr-Gq; Fri, 02 Jul 2021 13:03:36 +0300
Date:   Fri, 2 Jul 2021 13:03:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        yury.norov@gmail.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v5 3/3] drivers/base/node.c: use bin_attribute to break
 the size limitation of cpumap ABI
Message-ID: <YN7keAGnfQrM1RBF@smile.fi.intel.com>
References: <20210702092559.8776-1-song.bao.hua@hisilicon.com>
 <20210702092559.8776-4-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702092559.8776-4-song.bao.hua@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:25:59PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute.
> 
> This patch moves to use bin_attribute to extend the ABI to be more
> than one page so that cpumap bitmask and list won't be potentially
> trimmed.

...

>  }
>  
> -static DEVICE_ATTR_RO(cpumap);
>  
> -static inline ssize_t cpulist_show(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> +static BIN_ATTR_RO(cpumap, 0);

It will be extra blank line after this change.

-- 
With Best Regards,
Andy Shevchenko


