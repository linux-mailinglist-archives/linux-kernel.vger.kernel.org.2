Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7239AB3B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFCUCF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Jun 2021 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhFCUCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:02:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B8C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:00:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 631241F434FB
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        Guillaume Tucker <gtucker.collabora@gmail.com>,
        Enric =?utf-8?Q?Balletb=C3=B2?= <enric.balletbo@collabora.com>
Subject: Re: [RFC PATCH 1/1] drivers: base: Expose probe failures via debugfs
In-Reply-To: <YLjWKwhp7akqyR1S@kroah.com>
References: <20210603125534.638672-1-adrian.ratiu@collabora.com>
 <20210603125534.638672-2-adrian.ratiu@collabora.com>
 <YLjWKwhp7akqyR1S@kroah.com>
Date:   Thu, 03 Jun 2021 23:00:14 +0300
Message-ID: <87wnrawwfl.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Jun 2021, Greg Kroah-Hartman 
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 03, 2021 at 03:55:34PM +0300, Adrian Ratiu wrote: 
>> This adds a new devices_failed debugfs attribute to list driver 
>> probe failures excepting -EPROBE_DEFER which are still handled 
>> as before via their own devices_deferred attribute. 
> 
> Who is going to use this? 
> 

It's for KernelCI testing, I explained the background in my other 
reply.

>> This is useful on automated test systems like KernelCI to avoid 
>> filtering dmesg dev_err() messages to extract potential probe 
>> failures. 
> 
> I thought we listed these already some other way today? 
>

The only other place is the printk buffer via dev_err() and only 
the result subset of -EPROBE_DEFER info is exported via debugfs.

An additional problem with this new interface implementation is 
that it is based on the new-ish driver core "dev_err_probe" helper 
to which not all drivers have been converted (yet...), so there 
will be a mismatch between printk and this new interface.
 
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> Cc: "Rafael 
>> J. Wysocki" <rafael@kernel.org> Cc: Guillaume Tucker 
>> <gtucker.collabora@gmail.com> Suggested-by: Enric Balletbò 
>> <enric.balletbo@collabora.com> Signed-off-by: Adrian Ratiu 
>> <adrian.ratiu@collabora.com> --- 
>>  drivers/base/core.c | 76 
>>  +++++++++++++++++++++++++++++++++++++++++++-- 
>>  lib/Kconfig.debug   | 23 ++++++++++++++ 2 files changed, 96 
>>  insertions(+), 3 deletions(-) 
>>  diff --git a/drivers/base/core.c b/drivers/base/core.c index 
>> b8a8c96dca58..74bf057234b8 100644 --- a/drivers/base/core.c +++ 
>> b/drivers/base/core.c @@ -9,7 +9,9 @@ 
>>   */ 
>>   #include <linux/acpi.h> 
>> +#include <linux/circ_buf.h> 
>>  #include <linux/cpufreq.h> 
>> +#include <linux/debugfs.h> 
>>  #include <linux/device.h> #include <linux/err.h> #include 
>>  <linux/fwnode.h> 
>> @@ -53,6 +55,15 @@ static DEFINE_MUTEX(fwnode_link_lock); 
>>  static bool fw_devlink_is_permissive(void); static bool 
>>  fw_devlink_drv_reg_done;  
>> +#ifdef CONFIG_DEBUG_FS_PROBE_ERR +#define 
>> PROBE_ERR_BUF_ELEM_SIZE	64 +#define PROBE_ERR_BUF_SIZE	(1 
>> << CONFIG_DEBUG_FS_PROBE_ERR_BUF_SHIFT) +static struct circ_buf 
>> probe_err_crbuf; +static char 
>> failed_probe_buffer[PROBE_ERR_BUF_SIZE]; +static 
>> DEFINE_MUTEX(failed_probe_mutex); +static struct dentry 
>> *devices_failed_probe; +#endif 
> 
> All of this just for a log buffer?  The kernel provides a great 
> one, printk, let's not create yet-another-log-buffer if at all 
> possible please.

Yes, that is correct, this is esentially duplicating information 
already exposed via the printk buffer.
 
> 
> If the existing messages are "hard to parse", what can we do to 
> make them "easier" that would allow systems to do something with 
> them? 
> 
> What _do_ systems want to do with this information anyway?  What 
> does it help with exactly? 
>

I know driver core probe error message formats are unlikely to 
change over time and debugfs in theory is as "stable" as printk, 
but I think the main concern is to find a a more reliable way than 
parsing printk to extract probe erros, like for the existing 
devices_deferred in debugfs.

The idea in my specific case is to be able to reliably run driver 
tests in KernelCI for expected or unexpected probe errors like 
-EINVAL.

>
>
>> +
>>  /**
>>   * fwnode_link_add - Create a link between two fwnode_handles.
>>   * @con: Consumer end of the link.
>> @@ -3769,6 +3780,29 @@ struct device *device_find_child_by_name(struct device *parent,
>>  }
>>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>>  
>> +/*
>> + * failed_devs_show() - Show devices & drivers which failed to probe.
>> + */
>> +#ifdef CONFIG_DEBUG_FS_PROBE_ERR
>
> .c files shouldn't have #ifdefs if at all possible, so this patch isn't
> good for that reason alone :(
>
>
>> +static int failed_devs_show(struct seq_file *s, void *data)
>> +{
>> +	size_t offset;
>> +
>> +	mutex_lock(&failed_probe_mutex);
>> +
>> +	for (offset = 0;
>> +	     offset < PROBE_ERR_BUF_SIZE;
>> +	     offset += PROBE_ERR_BUF_ELEM_SIZE)
>> +		if (probe_err_crbuf.buf[offset])
>> +			seq_printf(s, "%s\n", probe_err_crbuf.buf + offset);
>> +
>> +	mutex_unlock(&failed_probe_mutex);
>> +
>> +	return 0;
>> +}
>> +DEFINE_SHOW_ATTRIBUTE(failed_devs);
>> +#endif
>> +
>>  int __init devices_init(void)
>>  {
>>  	devices_kset = kset_create_and_add("devices", &device_uevent_ops, NULL);
>> @@ -3784,6 +3818,12 @@ int __init devices_init(void)
>>  	if (!sysfs_dev_char_kobj)
>>  		goto char_kobj_err;
>>  
>> +#ifdef CONFIG_DEBUG_FS_PROBE_ERR
>> +	devices_failed_probe = debugfs_create_file("devices_failed", 0444, NULL,
>> +						   NULL, &failed_devs_fops);
>> +	probe_err_crbuf.buf = failed_probe_buffer;
>
> Nit, no need to save the dentry here, you can look it up if you really
> need it later on, but most importantly, you NEVER do anything with this
> dentry so why save it at all?
>
> And again, #ifdef is not ok, that makes the code much more
> unmaintainable over time.
>
> thanks,
>
> greg k-h
