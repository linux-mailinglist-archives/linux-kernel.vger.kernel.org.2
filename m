Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C03C22C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 13:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhGIL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 07:28:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:36927 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhGIL2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 07:28:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="206677110"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="206677110"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 04:25:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="560939469"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2021 04:25:44 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m1odW-00Ax91-9P; Fri, 09 Jul 2021 14:25:38 +0300
Date:   Fri, 9 Jul 2021 14:25:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, Tian Tao <tiantao6@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v6 3/4] drivers/base/node.c: use bin_attribute to break
 the size limitation of cpumap ABI
Message-ID: <YOgyMuwwS74mgclU@smile.fi.intel.com>
References: <20210709075544.11412-1-song.bao.hua@hisilicon.com>
 <20210709075544.11412-4-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709075544.11412-4-song.bao.hua@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 07:55:43PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.

/sys

> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute.
> 
> This patch moves to use bin_attribute to extend the ABI to be more
> than one page so that cpumap bitmask and list won't be potentially
> trimmed.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  -v6: remove an extra blank line according to Andy Shevchenko's comment;
> 
>  drivers/base/node.c | 51 +++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 4a4ae868ad9f..89a72aba72a3 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -27,42 +27,44 @@ static struct bus_type node_subsys = {
>  };
>  
>  
> -static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf)
> +static ssize_t node_read_cpumap(struct device *dev, bool list, char *buf,
> +				loff_t off, size_t count)
>  {
>  	ssize_t n;
>  	cpumask_var_t mask;
>  	struct node *node_dev = to_node(dev);
>  
> -	/* 2008/04/07: buf currently PAGE_SIZE, need 9 chars per 32 bits. */
> -	BUILD_BUG_ON((NR_CPUS/32 * 9) > (PAGE_SIZE-1));
> -
>  	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>  		return 0;
>  
>  	cpumask_and(mask, cpumask_of_node(node_dev->dev.id), cpu_online_mask);
> -	n = cpumap_print_to_pagebuf(list, buf, mask);
> +	n = cpumap_print_to_buf(list, buf, mask, off, count);
>  	free_cpumask_var(mask);
>  
>  	return n;
>  }
>  
> -static inline ssize_t cpumap_show(struct device *dev,
> -				  struct device_attribute *attr,
> -				  char *buf)
> +static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
> +				  struct bin_attribute *attr, char *buf,
> +				  loff_t off, size_t count)
>  {
> -	return node_read_cpumap(dev, false, buf);
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	return node_read_cpumap(dev, false, buf, off, count);
>  }
>  
> -static DEVICE_ATTR_RO(cpumap);
> +static BIN_ATTR_RO(cpumap, 0);
>  
> -static inline ssize_t cpulist_show(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf)
> +static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
> +				   struct bin_attribute *attr, char *buf,
> +				   loff_t off, size_t count)
>  {
> -	return node_read_cpumap(dev, true, buf);
> +	struct device *dev = kobj_to_dev(kobj);
> +
> +	return node_read_cpumap(dev, true, buf, off, count);
>  }
>  
> -static DEVICE_ATTR_RO(cpulist);
> +static BIN_ATTR_RO(cpulist, 0);
>  
>  /**
>   * struct node_access_nodes - Access class device to hold user visible
> @@ -557,15 +559,28 @@ static ssize_t node_read_distance(struct device *dev,
>  static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
>  
>  static struct attribute *node_dev_attrs[] = {
> -	&dev_attr_cpumap.attr,
> -	&dev_attr_cpulist.attr,
>  	&dev_attr_meminfo.attr,
>  	&dev_attr_numastat.attr,
>  	&dev_attr_distance.attr,
>  	&dev_attr_vmstat.attr,
>  	NULL
>  };
> -ATTRIBUTE_GROUPS(node_dev);
> +
> +static struct bin_attribute *node_dev_bin_attrs[] = {
> +	&bin_attr_cpumap,
> +	&bin_attr_cpulist,
> +	NULL
> +};
> +
> +static const struct attribute_group node_dev_group = {
> +	.attrs = node_dev_attrs,
> +	.bin_attrs = node_dev_bin_attrs
> +};
> +
> +static const struct attribute_group *node_dev_groups[] = {
> +	&node_dev_group,
> +	NULL
> +};
>  
>  #ifdef CONFIG_HUGETLBFS
>  /*
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


