Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA4B3E2B40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbhHFNWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhHFNWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:22:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24BDB61078;
        Fri,  6 Aug 2021 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628256141;
        bh=B7GWHAcNUWXEaO8L/ClnH19FECxWE0aGXM9liM3HGk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJUwhcF0e8sLHCf8wj4K+iNG2/S2erX+P78Nk3tUt30TuFAaX08YnRdFY4xqADe6l
         4Aczww1xDQUeEH1v6AKO/8K92Tq/c2oFMKGbgwUlbYcyBzZyHS/xEoFmsTaM8VQxJK
         o6ibuYmaHUUcbLwQuQYoNzTN8a8dBUhh1cLHiaLk=
Date:   Fri, 6 Aug 2021 15:22:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     andriy.shevchenko@linux.intel.com, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, Tian Tao <tiantao6@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v9 1/5] cpumask: introduce
 cpumap_print_list/bitmask_to_buf to support large bitmask and list
Message-ID: <YQ03ixksDJyVwCEv@kroah.com>
References: <20210806110251.560-1-song.bao.hua@hisilicon.com>
 <20210806110251.560-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806110251.560-2-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 11:02:47PM +1200, Barry Song wrote:
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
> 	return cpumap_print_to_pagebuf(true, buf, &pmu_mmdc->cpu);
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
> 	return bitmap_print_to_pagebuf(list, buf, cpumask_bits(mask),
> 				       nr_cpu_ids);
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
> 	...
> }
> 
> With the new offset and count parameters, this makes sysfs ABI be able
> to support file size more than one page. For example, offset could be
> >= 4096.
> 
> This patch introduces cpumap_print_bitmask/list_to_buf() and their bitmap
> infrastructure bitmap_print_bitmask/list_to_buf() so that those drivers
> can move to bin_attribute to support large bitmask and list. At the same
> time, we have to pass those corresponding parameters such as offset, count
> from bin_attribute to this new API.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stefano Brivio <sbrivio@redhat.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: "Ma, Jianpeng" <jianpeng.ma@intel.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  include/linux/bitmap.h  |   6 +++
>  include/linux/cpumask.h |  38 +++++++++++++++
>  lib/bitmap.c            | 103 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index a36cfcec4e77..37f36dad18bd 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -227,6 +227,12 @@ unsigned int bitmap_ord_to_pos(const unsigned long *bitmap, unsigned int ord, un
>  int bitmap_print_to_pagebuf(bool list, char *buf,
>  				   const unsigned long *maskp, int nmaskbits);
>  
> +extern int bitmap_print_bitmask_to_buf(char *buf, const unsigned long *maskp,
> +				      int nmaskbits, loff_t off, size_t count);
> +
> +extern int bitmap_print_list_to_buf(char *buf, const unsigned long *maskp,
> +				      int nmaskbits, loff_t off, size_t count);
> +

Why are you adding bitmap_print_list_to_buf() when no one uses it in
this patch series?

Did I miss it somewhere?

thanks,

greg k-h
