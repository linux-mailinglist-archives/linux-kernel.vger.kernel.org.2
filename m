Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7F3E8FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbhHKLt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 07:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237589AbhHKLtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5943760C3E;
        Wed, 11 Aug 2021 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628682569;
        bh=NpZoarZNXOYI6N/IP04rCszscxBifRJPQcNMIhZUxq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaLhK8xHUrlzAp7BPCC4GmxUZJLbKJoXtourSyBET2zV2VUqX91dyMNiJGuzrjUp4
         XbutvdMjUbsmcntFVd06sJMl0PVF+LD4tr5LSqCQsd+Dk0A8Xj49al2S2eEHbS40yD
         899aro87UICWXSwLi/EDCD22ulACt7tni089e+n0=
Date:   Wed, 11 Aug 2021 13:49:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, will@kernel.org, linuxarm@huawei.com,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH] platform-msi: Add ABI to show msi_irqs of platform
 devices
Message-ID: <YRO5R0/N9KITjyY9@kroah.com>
References: <20210811105020.12980-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811105020.12980-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 10:50:20PM +1200, Barry Song wrote:
> Just like pci devices have msi_irqs which can be used by userspace irq affinity
> tools or applications to bind irqs, platform devices also widely support msi
> irqs. For platform devices, for example ARM SMMU, userspaces also care about
> its msi irqs as applications can know the mapping between devices and irqs
> and then make smarter decision on handling irq affinity. For example, for
> SVA mode, it is better to pin io page fault to the numa node applications
> are running on. Otherwise, io page fault will get a remote page from the
> node iopf happens.
> With this patch, a system with multiple arm SMMUs in multiple different numa
> node can get the mapping between devices and irqs now:
> root@ubuntu:/sys/devices/platform# ls -l arm-smmu-v3.*/msi_irqs/*
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.0.auto/msi_irqs/25
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.0.auto/msi_irqs/26
> -r--r--r-- 1 root root 4096 Aug 11 10:28 arm-smmu-v3.1.auto/msi_irqs/27
> -r--r--r-- 1 root root 4096 Aug 11 10:28 arm-smmu-v3.1.auto/msi_irqs/28
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.2.auto/msi_irqs/29
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.2.auto/msi_irqs/30
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.3.auto/msi_irqs/31
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.3.auto/msi_irqs/32
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.4.auto/msi_irqs/33
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.4.auto/msi_irqs/34
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.5.auto/msi_irqs/35
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.5.auto/msi_irqs/36
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.6.auto/msi_irqs/37
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.6.auto/msi_irqs/38
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.7.auto/msi_irqs/39
> -r--r--r-- 1 root root 4096 Aug 11 10:29 arm-smmu-v3.7.auto/msi_irqs/40
> 
> Applications can use the mapping and the numa node information to pin
> irqs by leveraging the numa information which has also been exported:
> root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.0.auto/numa_node
> 0
> root@ubuntu:/sys/devices/platform# cat arm-smmu-v3.4.auto/numa_node
> 2
> 
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-platform |  14 +++
>  drivers/base/platform-msi.c                  | 122 +++++++++++++++++++++++++++
>  2 files changed, 136 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-platform b/Documentation/ABI/testing/sysfs-bus-platform
> index 194ca70..4498f89 100644
> --- a/Documentation/ABI/testing/sysfs-bus-platform
> +++ b/Documentation/ABI/testing/sysfs-bus-platform
> @@ -28,3 +28,17 @@ Description:
>  		value comes from an ACPI _PXM method or a similar firmware
>  		source. Initial users for this file would be devices like
>  		arm smmu which are populated by arm64 acpi_iort.
> +
> +What:		/sys/bus/platform/devices/.../msi_irqs/
> +Date:		August 2021
> +Contact:	Barry Song <song.bao.hua@hisilicon.com>
> +Description:
> +		The /sys/devices/.../msi_irqs directory contains a variable set
> +		of files, with each file being named after a corresponding msi
> +		irq vector allocated to that device.
> +
> +What:		/sys/bus/platform/devices/.../msi_irqs/<N>
> +Date:		August 2021
> +Contact:	Barry Song <song.bao.hua@hisilicon.com>
> +Description:
> +		This attribute will show "msi" if <N> is a valid msi irq
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 0b72b13..6a72ebc 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -23,6 +23,7 @@
>  struct platform_msi_priv_data {
>  	struct device		*dev;
>  	void 			*host_data;
> +	const struct attribute_group    **msi_irq_groups;
>  	msi_alloc_info_t	arg;
>  	irq_write_msi_msg_t	write_msg;
>  	int			devid;
> @@ -245,6 +246,120 @@ static void platform_msi_free_priv_data(struct platform_msi_priv_data *data)
>  	kfree(data);
>  }
>  
> +static ssize_t platform_msi_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct msi_desc *entry;
> +	unsigned long irq;
> +	int retval;
> +
> +	retval = kstrtoul(attr->attr.name, 10, &irq);
> +	if (retval)
> +		return retval;
> +
> +	entry = irq_get_msi_desc(irq);
> +	if (entry)
> +		return sprintf(buf, "msi\n");

sysfs_emit()?

But why isn't this all handled by the MSI core code?  Why would each bus
need to have this logic in it?

thanks,

greg k-h
