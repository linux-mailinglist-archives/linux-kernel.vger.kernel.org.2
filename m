Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA313BA50D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 23:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhGBVdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 17:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhGBVdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 17:33:11 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED760C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 14:30:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y9so7670185qtx.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 14:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Alfjt6eSPGGBgUe0dXvmpysArVuqw7ew4pBZYJ9k5U=;
        b=sZhqfjx8Grl3ya0nowidFbbJ4yEg40g9ktN/qh94AvC3ZP7DHNIaxZEVHWCkCnqgoR
         nNcd42vVZe0UbgtG1LXGjKhlh5KBwkKT6IzEvnzhqu94YU+jrEBqyMMW6X1tsuJQXuZq
         nVeuefDz5ca+BYXo/7b/krpZotVBuDMvoRdW2QZ38sDMIF2Pa9Bg6urddMxOQDSLN2AA
         kwC7kW4G5Qwml+B4vdEmq/vE3sffZwx6wHsRgrKQwORNhuzbKvkzcJT4W9lQP9BIaI3O
         /9J5yY/mTHFcZ3SoZk1TOsKaueg76g6D8Opl/1VAka3IMGQndiXFoKkCun5g3EzsGA9+
         /x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Alfjt6eSPGGBgUe0dXvmpysArVuqw7ew4pBZYJ9k5U=;
        b=V4N93AemydeAN4UaXi6aHoHFyTt+LpCuRZLR80MAssgNWAtgN9LLaQaSvtYaON203G
         IQsxZOlgfZwKMTAqPDQX09Sj/O8TcNyf3Y5wyJNC5rbP3SFxt6ywphOrRC3THXfEThzT
         Qbvusn8VTIjOh6LNIBGg9KuxQnX4NspEoAhoUkvNeViVr0z7ZtNr8CNrPB++cWJp4c9l
         6nodCy98jz4Y3eQ/xyTPyeBHP7bNBye4u+egW7VLU7i5+wBzIUQox01kfc6++RMAMDMI
         O6mNxi48rGhJgh84UjRAgbJHdHn4ohEYAlxIXNFJjNokzr8uh/Fi8ZzKDqNIZ0AyNwWS
         Zv9w==
X-Gm-Message-State: AOAM5338PWAHCOMJ/fnxrYsWvJVZcuh6jgMAD2T6qBoa0LG2aRoXT4c8
        p5Nn1UfvyLL1nqdSGoiL3sw=
X-Google-Smtp-Source: ABdhPJwp8TdDPtpFOSgA+2+W+8HfMNHCO9svJ3YfG/jRr6mOJzjm9WnjKdGD36o04JpHQ8HIzhqLlQ==
X-Received: by 2002:a05:622a:1349:: with SMTP id w9mr1757853qtk.73.1625261436125;
        Fri, 02 Jul 2021 14:30:36 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id t12sm1886919qkg.40.2021.07.02.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:30:35 -0700 (PDT)
Date:   Fri, 2 Jul 2021 14:30:34 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v5 1/3] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Message-ID: <YN+FemDxyeG+lRTC@yury-ThinkPad>
References: <20210702092559.8776-1-song.bao.hua@hisilicon.com>
 <20210702092559.8776-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702092559.8776-2-song.bao.hua@hisilicon.com>
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
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  include/linux/cpumask.h | 19 +++++++++++++++++++
>  lib/cpumask.c           | 18 ++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index bfc4690de4f4..24f410a2e793 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -983,6 +983,25 @@ cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
>  				      nr_cpu_ids);
>  }
>  
> +/**
> + * cpumap_print_to_buf  - copies the cpumask into the buffer either
> + *      as comma-separated list of cpus or hex values of cpumask;
> + *      Typically used by bin_attribute to export cpumask bitmask and
> + *      list ABI.
> + * @list: indicates whether the cpumap must be list
> + *      true:  print in decimal list format
> + *      fasle: print in hexadecimal bitmask format
> + * @mask: the cpumask to copy
> + * @buf: the buffer to copy into
> + * @off: in the string from which we are copying, We copy to @buf
> + * @count: the maximum number of bytes to print
> + *
> + * Returns the length of how many bytes have been copied.
> + */
> +extern ssize_t
> +cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
> +		    loff_t off, size_t count);
> +
>  #if NR_CPUS <= BITS_PER_LONG
>  #define CPU_MASK_ALL							\
>  (cpumask_t) { {								\
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index c3c76b833384..40421a6d31bc 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -279,3 +279,21 @@ int cpumask_any_distribute(const struct cpumask *srcp)
>  	return next;
>  }
>  EXPORT_SYMBOL(cpumask_any_distribute);
> +
> +ssize_t cpumap_print_to_buf(bool list, char *buf, const struct cpumask *mask,
> +		    loff_t off, size_t count)
> +{
> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +	ssize_t size;
> +	void *data;
> +
> +	data = kasprintf(GFP_KERNEL, fmt, nr_cpu_ids, cpumask_bits(mask));
> +	if (!data)
> +		return -ENOMEM;
> +
> +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> +	kfree(data);

Barry,

It looks like my comments for previous iteration were ignored. I don't
like the approach where you allocate potentially big amount of kernel
memory just to free it almost immediately. Nor in lib/bitmap, neither
in lib/cpumask.

For next iterations, please move this function back to lib/bitmap
because there's no specific here for cpumasks.

Thaks,
Yury

> +	return size;
> +}
> +EXPORT_SYMBOL(cpumap_print_to_buf);
> -- 
> 2.25.1
