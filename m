Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E803B9ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhGBKJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:09:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:52499 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhGBKJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:09:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="206885880"
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="206885880"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 03:07:12 -0700
X-IronPort-AV: E=Sophos;i="5.83,317,1616482800"; 
   d="scan'208";a="642620284"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2021 03:07:08 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lzG4c-007ekE-JP; Fri, 02 Jul 2021 13:07:02 +0300
Date:   Fri, 2 Jul 2021 13:07:02 +0300
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
Subject: Re: [PATCH v5 1/3] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Message-ID: <YN7lRtMRcBAH98eB@smile.fi.intel.com>
References: <20210702092559.8776-1-song.bao.hua@hisilicon.com>
 <20210702092559.8776-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702092559.8776-2-song.bao.hua@hisilicon.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 09:25:57PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> The existing cpumap_print_to_pagebuf() is used by cpu topology and other
> drivers to export hexadecimal bitmask and decimal list to userspace by
> sysfs ABI.
> 
> Right now, those drivers are using a normal attribute for this kind of
> ABIs. A normal attribute typically has show entry as below:
> 
> static ssize_t example_dev_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
> {
> 	...
>         return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
> }
> show entry of attribute has no offset and count parameters and this
> means the file is limited to one page only.
> 
> cpumap_print_to_pagebuf() API works terribly well for this kind of
> normal attribute with buf parameter and without offset, count:
> 
> static inline ssize_t
> cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
> {
>         return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
>                                       nr_cpu_ids);
> }
> 
> The problem is once we have many cpus, we have a chance to make bitmask
> or list more than one page. Especially for list, it could be as complex
> as 0,3,5,7,9,...... We have no simple way to know it exact size.
> 
> It turns out bin_attribute is a way to break this limit. bin_attribute
> has show entry as below:
> static ssize_t
> example_bin_attribute_show(struct file *filp, struct kobject *kobj,
>              struct bin_attribute *attr, char *buf,
>              loff_t offset, size_t count)
> {
>         ...
> }
> 
> With the new offset and count parameters, this makes sysfs ABI be able
> to support file size more than one page. For example, offset could be
> >= 4096.
> 
> This patch introduces cpumap_print_to_buf() so that those drivers can
> move to bin_attribute to support large bitmask and list. In result,
> we have to pass the corresponding parameters from bin_attribute to this
> new API.

...

> +/**
> + * cpumap_print_to_buf  - copies the cpumask into the buffer either
> + *      as comma-separated list of cpus or hex values of cpumask;
> + *      Typically used by bin_attribute to export cpumask bitmask and
> + *      list ABI.

It can be split to

 * cpumap_print_to_buf  - copies the cpumask into the buffer

here...

> + * @list: indicates whether the cpumap must be list
> + *      true:  print in decimal list format
> + *      fasle: print in hexadecimal bitmask format
> + * @mask: the cpumask to copy
> + * @buf: the buffer to copy into
> + * @off: in the string from which we are copying, We copy to @buf
> + * @count: the maximum number of bytes to print

..and

 *
 * The function copies the cpumask into the buffer either as comma-separated
 * list of cpus or hex values of cpumask; Typically used by bin_attribute to
 * export cpumask bitmask and list ABI.

here.

> + *
> + * Returns the length of how many bytes have been copied.
> + */

-- 
With Best Regards,
Andy Shevchenko


