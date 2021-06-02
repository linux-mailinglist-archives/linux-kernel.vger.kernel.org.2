Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4AA398F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhFBPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:51:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:20576 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232123AbhFBPv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:51:27 -0400
IronPort-SDR: ttJNa5D2Fgh25firxGi+DQzaEhFtpAwZaRlGcFiyiX3VcYWXQBky0wMPcQUXsEFy+QcGMoTm4I
 Ffw8Lhukqpxg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191170567"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="191170567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:48:42 -0700
IronPort-SDR: uzN4ydBIi/13SqZ8GZMPqzzThf2EZ7MLbfi07o7PU4/FJf+I7WeKfSMvjjuDkACxfSGeCtiL3b
 HuYRp8vDjD0g==
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="617247089"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 08:48:40 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1loT6j-00Gk6M-LJ; Wed, 02 Jun 2021 18:48:37 +0300
Date:   Wed, 2 Jun 2021 18:48:37 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] topology: use bin_attribute to avoid buff overflow
Message-ID: <YLeoVVF8z4ikaRnp@smile.fi.intel.com>
References: <1622641734-22538-1-git-send-email-tiantao6@hisilicon.com>
 <1622641734-22538-3-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622641734-22538-3-git-send-email-tiantao6@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 09:48:53PM +0800, Tian Tao wrote:
> Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute. so we use bin_attribute instead of
> attribute to avoid NR_CPUS too big to cause buff overflow.

> This patch is based on the following discussion.
> https://lore.kernel.org/lkml/20210319041618.14316-2-song.bao.hua@hisilicon.com/

Link: tag?

...

> +static struct bin_attribute *bin_attrs[] = {
> +	&bin_attr_core_cpus,
> +	&bin_attr_core_cpus_list,
> +	&bin_attr_thread_siblings,
> +	&bin_attr_thread_siblings_list,
> +	&bin_attr_core_siblings,
> +	&bin_attr_core_siblings_list,
> +	&bin_attr_die_cpus,
> +	&bin_attr_die_cpus_list,
> +	&bin_attr_package_cpus,
> +	&bin_attr_package_cpus_list,
> +#ifdef CONFIG_SCHED_BOOK
> +	&bin_attr_book_siblings,
> +	&bin_attr_book_siblings_list,
> +#endif
> +#ifdef CONFIG_SCHED_DRAWER
> +	&bin_attr_drawer_siblings,
> +	&bin_attr_drawer_siblings_list,
> +#endif

> +	NULL,

No comma for terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko


