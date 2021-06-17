Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AED23AB2C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhFQLjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232591AbhFQLjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623929826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIsWIjmGNY76gABLgykoc5YhaI64FcwdtGn88E4ap8I=;
        b=SsTcJ1VzLYnwMU+2MF7ne3dbLK6pULtMMFpb6KZrxPFG6dL7Zsx4/LUQ9u/gdX3a8knE0S
        brsInEIWhnxGDVSLhsixOzaxr1g4+nbzRFou88chhiQcOEqGvBZscOtkGhmT1CfDFqDpt6
        wFr9KjHmtadg8LZWYEqeBonaMAmAZM4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-YRJZ5MIzNhStm8TWeNCysw-1; Thu, 17 Jun 2021 07:37:05 -0400
X-MC-Unique: YRJZ5MIzNhStm8TWeNCysw-1
Received: by mail-ed1-f70.google.com with SMTP id p24-20020aa7c8980000b0290393c37fdcb8so1333056eds.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIsWIjmGNY76gABLgykoc5YhaI64FcwdtGn88E4ap8I=;
        b=OmHvvzpyfVIgGHGZ/SvElS3KlzD1GZ86Uvbd5KxbQv3i9bfDBXIcn7dKe7jv7/oJjz
         1ljTlSHmPhtP+862Q6VtKMsNBi0Sp8sVSA/JOd5zDp2sgtnryJJrXUmJx2klSdFyjc6C
         R5BUwgg9P7BIkx11wT7/PEe+BhXZLPiLaM8mG+PRDyPcMx8BfEgdeGEAGAjC69GUd3fM
         2FeiBRrbLo6sTSCRePY24ItoIoU3sCgt0OqtJ00zcqKQnQTc+Z8LAIcMd25sPntXr1wb
         AWon+2iBXPREhZmmfB726DvKB2Y4xZAghPf5Iym0AqTHI3Ox1o7zuZHPyzw/Mu+wpXuU
         J36Q==
X-Gm-Message-State: AOAM531gOLf1l7+zTMLb0Uf2O5GB1QJmhCp5Kh1pdVVPgOOS/JbIgo4m
        nxki8ClRBINDwdHPs299nc1pY3e8kSxxHMnmjaLw8ySd1DvvdZk3QzY4d5vgG/HcjyrSR6lf77G
        Y3gwE44gG67bZoRyYKdsnNLhhCIhsU0Tm77eU4wV+nSCousGz2A/IoInYAiWHEFl+zJIDdOA5Ft
        Tx
X-Received: by 2002:aa7:cc19:: with SMTP id q25mr5834556edt.56.1623929823901;
        Thu, 17 Jun 2021 04:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmU8SgdOE57jIvv3FPAbzafJA7zuo+uXWROMxQc7Q+Imd2O7vmt+x2HrGK92DscISS0qnusg==
X-Received: by 2002:aa7:cc19:: with SMTP id q25mr5834537edt.56.1623929823749;
        Thu, 17 Jun 2021 04:37:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id e18sm3566060ejh.64.2021.06.17.04.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 04:37:03 -0700 (PDT)
Subject: Re: [PATCH 1/2] platform/x86: ISST: Optimize CPU to PCI device
 mapping
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210616221329.1909276-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b93fc0c0-77f9-a9b4-e5dd-28a781332691@redhat.com>
Date:   Thu, 17 Jun 2021 13:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210616221329.1909276-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 6/17/21 12:13 AM, Srinivas Pandruvada wrote:
> It was observed that some of the high performance benchmarks are spending
> more time in kernel depending on which CPU package they are executing.
> The difference is significant and benchmark scores varies more than 10%.
> These benchmarks adjust class of service to improve thread performance
> which run in parallel. This class of service change causes access to
> MMIO region of Intel Speed Select PCI devices depending on the CPU
> package they are executing.
> 
> This mapping from CPU to PCI device instance uses a standard Linux PCI
> interface "pci_get_domain_bus_and_slot()". This function does a linear
> search to get to a PCI device. Since these platforms have 100+ PCI
> devices, this search can be expensive in fast path for benchmarks.
> 
> Since the device and function of PCI device is fixed for Intel
> Speed Select PCI devices, the CPU to PCI device information can be cached
> at the same time when bus number for the CPU is read. In this way during
> runtime the cached information can be used. This improves performance
> of these benchmarks significantly.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../intel_speed_select_if/isst_if_common.c    | 29 +++++++++++++++----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
> index 0c2aa22c7a12..aedb8310214c 100644
> --- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
> +++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
> @@ -281,11 +281,27 @@ static int isst_if_get_platform_info(void __user *argp)
>  struct isst_if_cpu_info {
>  	/* For BUS 0 and BUS 1 only, which we need for PUNIT interface */
>  	int bus_info[2];
> +	struct pci_dev *pci_dev[2];
>  	int punit_cpu_id;
>  };
>  
>  static struct isst_if_cpu_info *isst_cpu_info;
>  
> +static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
> +{
> +	int bus_number;
> +
> +	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
> +	    cpu >= num_possible_cpus())
> +		return NULL;
> +
> +	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
> +	if (bus_number < 0)
> +		return NULL;
> +
> +	return pci_get_domain_bus_and_slot(0, bus_number, PCI_DEVFN(dev, fn));
> +}
> +
>  /**
>   * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
>   * @cpu: Logical CPU number.
> @@ -300,17 +316,18 @@ static struct isst_if_cpu_info *isst_cpu_info;
>   */
>  struct pci_dev *isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
>  {
> -	int bus_number;
> +	struct pci_dev *pci_dev;
>  
>  	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
>  	    cpu >= num_possible_cpus())
>  		return NULL;
>  
> -	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
> -	if (bus_number < 0)
> -		return NULL;
> +	pci_dev = isst_cpu_info[cpu].pci_dev[bus_no];

If the _isst_if_get_pci_dev() call below fails, then pci_dev might
end up getting set to NULL here.

>  
> -	return pci_get_domain_bus_and_slot(0, bus_number, PCI_DEVFN(dev, fn));
> +	if (pci_dev->devfn == PCI_DEVFN(dev, fn))

And then this would lead to a NULL ptr deref, I've replaced this
the above if with:

	if (pci_dev && pci_dev->devfn == PCI_DEVFN(dev, fn))

to avoid this.

I've applied this series with the above change
to my review-hans  branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans





> +		return pci_dev;
> +
> +	return _isst_if_get_pci_dev(cpu, bus_no, dev, fn);
>  }
>  EXPORT_SYMBOL_GPL(isst_if_get_pci_dev);
>  
> @@ -327,6 +344,8 @@ static int isst_if_cpu_online(unsigned int cpu)
>  	} else {
>  		isst_cpu_info[cpu].bus_info[0] = data & 0xff;
>  		isst_cpu_info[cpu].bus_info[1] = (data >> 8) & 0xff;
> +		isst_cpu_info[cpu].pci_dev[0] = _isst_if_get_pci_dev(cpu, 0, 0, 1);
> +		isst_cpu_info[cpu].pci_dev[1] = _isst_if_get_pci_dev(cpu, 1, 30, 1);
>  	}
>  
>  	ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
> 

