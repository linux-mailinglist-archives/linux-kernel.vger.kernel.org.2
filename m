Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE50454C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 18:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbhKQRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 12:55:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237331AbhKQRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637171579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jWtFyS9ivTE7xTWIAATitqE+oll2TeynPGymMQnLAE=;
        b=epaLVED2ULRsO9iSCVLfvsPOfNJQ6XKFXwsAVwvmuNVKWhGWzUnPdA52KMpLYTPNZguu1x
        4tamwOJbVDOqqjW3g2tjhhEr2p3EldZDmcop7T5C/PwyqcgyHcbWcZTdrvWwTBirnrkOgq
        dCYOU8bz2phh1VigTieDGHzsjVCiuR4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-NZp_F1BIO4KY4TvMsz1oRw-1; Wed, 17 Nov 2021 12:52:57 -0500
X-MC-Unique: NZp_F1BIO4KY4TvMsz1oRw-1
Received: by mail-oi1-f199.google.com with SMTP id bi9-20020a056808188900b002bc4f64083aso2474397oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 09:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1jWtFyS9ivTE7xTWIAATitqE+oll2TeynPGymMQnLAE=;
        b=Djnlv/kUI7wXPBKWNEBeMWL3SEouQoN2hhFbZ3JDDZQznmDbtmGvJYW53fB7/52azl
         1zUFE4Iqs9uONqwTQdLamXEF3fBIbZrsH3b5DMOyj9n1nhZH8LIZ8MWrTATpWhE1MXOb
         yrMW+dLFukqneTX2eIAzaaSXOE8BHuKX4t7c+lpR+5YlowgvnwOXfDJy0oVJqS52kcda
         I74AlqJkCPVqks1YZH0REgfyVWpN7zMvQRGbcIb+IvIjRKz2LUCVe9Mc8OS6UWrt3f7b
         +iSPcQlGphwOzyDZHFrkNTIjdyodYC/X06oPkjI9+ZOhIrMnGbfyz0G81V9HA3iDG1dH
         YDrw==
X-Gm-Message-State: AOAM530iZ0PRnDKfuM18JynG8x+Tdo+8o+8AxnTbSOL/9hGtAESZz3SO
        MwWVS/VJkOiAUbdiDYB2nv9yH0+aY7Nq0OgsjJdG+bLzCQ1YxHx6waXetYta/HbXDXruH8NH83c
        DxWsfsKaIg9vO05SoxORi/FkZ
X-Received: by 2002:a9d:2648:: with SMTP id a66mr12174651otb.65.1637171576438;
        Wed, 17 Nov 2021 09:52:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCqi8Ay82/Y4hfVj6unbHmXJl63Vz5HTXCFyVsgCInr1skqO3Z21l3EdY1XhJZNpIeAcuYVg==
X-Received: by 2002:a9d:2648:: with SMTP id a66mr12174610otb.65.1637171576013;
        Wed, 17 Nov 2021 09:52:56 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id bi20sm136475oib.29.2021.11.17.09.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 09:52:55 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:52:54 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <abhsahu@nvidia.com>
Cc:     <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/3] vfio/pci: register vfio-pci driver with runtime PM
 framework
Message-ID: <20211117105254.49227dc1.alex.williamson@redhat.com>
In-Reply-To: <20211115133640.2231-2-abhsahu@nvidia.com>
References: <20211115133640.2231-1-abhsahu@nvidia.com>
        <20211115133640.2231-2-abhsahu@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 19:06:38 +0530
<abhsahu@nvidia.com> wrote:

> From: Abhishek Sahu <abhsahu@nvidia.com>
> 
> Currently, there is very limited power management support
> available in upstream vfio-pci driver. If there is no user of vfio-pci
> device, then the PCI device will be moved into D3Hot state by writing
> directly into PCI PM registers. This D3Hot state help in saving some
> amount of power but we can achieve zero power consumption if we go
> into D3cold state. The D3cold state cannot be possible with Native PCI
> PM. It requires interaction with platform firmware which is
> system-specific. To go into low power states (including D3cold), the
> runtime PM framework can be used which internally interacts with PCI
> and platform firmware and puts the device into the lowest possible
> D-States.
> 
> This patch registers vfio-pci driver with the runtime PM framework.
> 
> 1. The PCI core framework takes care of most of the runtime PM
>    related things. For enabling the runtime PM, the PCI driver needs to
>    decrement the usage count and needs to register the runtime
>    suspend/resume routines. For vfio-pci based driver, these routines can
>    be stubbed since the vfio-pci driver is not doing the PCI device
>    initialization. All the config state saving, and PCI power management
>    related things will be done by PCI core framework itself inside its
>    runtime suspend/resume callbacks.
> 
> 2. To prevent frequent runtime, suspend/resume, it uses autosuspend
>    support with a default delay of 1 second.
> 
> 3. Inside pci_reset_bus(), all the devices in bus/slot will be moved
>    out of D0 state. This state change to D0 can happen directly without
>    going through the runtime PM framework. So if runtime PM is enabled,
>    then pm_runtime_resume() makes the runtime state active. Since the PCI
>    device power state is already D0, so it should return early when it
>    tries to change the state with  pci_set_power_state(). Then
>    pm_request_autosuspend() can be used which will internally check for
>    device usage count and will move the device again into low power
>    state.
> 
> 4. Inside vfio_pci_core_disable(), the device usage count always needs
>    to decremented which was incremented vfio_pci_core_enable() with
>    pm_runtime_get_sync().
> 
> 5. Since the runtime PM framework will provide the same functionality,
>    so directly writing into PCI PM config register can be replaced with
>    use of runtime PM routines. Also, the use of runtime PM can help us in
>    more power saving.
> 
>    In the systems which do not support D3Cold,
> 
>    With the existing implementation:
> 
>    // PCI device
>    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
>    D3hot
>    // upstream bridge
>    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
>    D0
> 
>    With runtime PM:
> 
>    // PCI device
>    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
>    D3hot
>    // upstream bridge
>    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
>    D3hot
> 
>    So, with runtime PM, the upstream bridge or root port will also go
>    into lower power state which is not possible with existing
>    implementation.
> 
>    In the systems which support D3Cold,
> 
>    // PCI device
>    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
>    D3hot
>    // upstream bridge
>    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
>    D0
> 
>    With runtime PM:
> 
>    // PCI device
>    # cat /sys/bus/pci/devices/0000\:01\:00.0/power_state
>    D3cold
>    // upstream bridge
>    # cat /sys/bus/pci/devices/0000\:00\:01.0/power_state
>    D3cold
> 
>    So, with runtime PM, both the PCI device and upstream bridge will
>    go into D3cold state.
> 
> 6. If 'disable_idle_d3' module parameter is set, then also the runtime
>    PM will be enabled, but in this case, the usage count should not be
>    decremented.
> 
> 7. vfio_pci_dev_set_try_reset() return value is unused now, so this
>    function return type can be changed to void.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci.c      |   3 +
>  drivers/vfio/pci/vfio_pci_core.c | 104 +++++++++++++++++++++++--------
>  include/linux/vfio_pci_core.h    |   4 ++
>  3 files changed, 84 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a5ce92beb655..c8695baf3b54 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -193,6 +193,9 @@ static struct pci_driver vfio_pci_driver = {
>  	.remove			= vfio_pci_remove,
>  	.sriov_configure	= vfio_pci_sriov_configure,
>  	.err_handler		= &vfio_pci_core_err_handlers,
> +#if defined(CONFIG_PM)
> +	.driver.pm              = &vfio_pci_core_pm_ops,
> +#endif
>  };
>  
>  static void __init vfio_pci_fill_ids(void)
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f948e6cd2993..511a52e92b32 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -152,7 +152,7 @@ static void vfio_pci_probe_mmaps(struct vfio_pci_core_device *vdev)
>  }
>  
>  struct vfio_pci_group_info;
> -static bool vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set);
> +static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set);
>  static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  				      struct vfio_pci_group_info *groups);
>  
> @@ -245,7 +245,8 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  	u16 cmd;
>  	u8 msix_pos;
>  
> -	vfio_pci_set_power_state(vdev, PCI_D0);
> +	if (!disable_idle_d3)
> +		pm_runtime_get_sync(&pdev->dev);

I'm not a pm_runtime expert, but why are we not using
pm_runtime_resume_and_get() here and aborting the function on error?

I hope some folks more familiar with pm_runtime can also review usage
across this series.

>  
>  	/* Don't allow our initial saved state to include busmaster */
>  	pci_clear_master(pdev);
> @@ -405,8 +406,17 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  out:
>  	pci_disable_device(pdev);
>  
> -	if (!vfio_pci_dev_set_try_reset(vdev->vdev.dev_set) && !disable_idle_d3)
> -		vfio_pci_set_power_state(vdev, PCI_D3hot);
> +	vfio_pci_dev_set_try_reset(vdev->vdev.dev_set);
> +
> +	/*
> +	 * The device usage count always needs to decremented which was
> +	 * incremented in vfio_pci_core_enable() with
> +	 * pm_runtime_get_sync().
> +	 */

*to be

Maybe:

	/*
	 * Put the pm-runtime usage counter acquired during enable; mark
	 * last use time to delay autosuspend.
	 */

> +	if (!disable_idle_d3) {
> +		pm_runtime_mark_last_busy(&pdev->dev);
> +		pm_runtime_put_autosuspend(&pdev->dev);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_disable);
>  
> @@ -1847,19 +1857,23 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
>  
>  	vfio_pci_probe_power_state(vdev);
>  
> -	if (!disable_idle_d3) {
> -		/*
> -		 * pci-core sets the device power state to an unknown value at
> -		 * bootup and after being removed from a driver.  The only
> -		 * transition it allows from this unknown state is to D0, which
> -		 * typically happens when a driver calls pci_enable_device().
> -		 * We're not ready to enable the device yet, but we do want to
> -		 * be able to get to D3.  Therefore first do a D0 transition
> -		 * before going to D3.
> -		 */
> -		vfio_pci_set_power_state(vdev, PCI_D0);
> -		vfio_pci_set_power_state(vdev, PCI_D3hot);
> -	}
> +	/*
> +	 * pci-core sets the device power state to an unknown value at
> +	 * bootup and after being removed from a driver.  The only
> +	 * transition it allows from this unknown state is to D0, which
> +	 * typically happens when a driver calls pci_enable_device().
> +	 * We're not ready to enable the device yet, but we do want to
> +	 * be able to get to D3.  Therefore first do a D0 transition
> +	 * before enabling runtime PM.
> +	 */
> +	pci_set_power_state(pdev, PCI_D0);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);

Let's #define this 1000 at the top of the file with some rationale how
we arrived at this heuristic (ie. avoid magic numbers in code).  Thanks,

Alex

> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
> +
> +	if (!disable_idle_d3)
> +		pm_runtime_put_autosuspend(&pdev->dev);
>  
>  	ret = vfio_register_group_dev(&vdev->vdev);
>  	if (ret)
> @@ -1868,7 +1882,10 @@ int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev)
>  
>  out_power:
>  	if (!disable_idle_d3)
> -		vfio_pci_set_power_state(vdev, PCI_D0);
> +		pm_runtime_get_noresume(&pdev->dev);
> +
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_forbid(&pdev->dev);
>  out_vf:
>  	vfio_pci_vf_uninit(vdev);
>  	return ret;
> @@ -1887,7 +1904,10 @@ void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev)
>  	vfio_pci_vga_uninit(vdev);
>  
>  	if (!disable_idle_d3)
> -		vfio_pci_set_power_state(vdev, PCI_D0);
> +		pm_runtime_get_noresume(&pdev->dev);
> +
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	pm_runtime_forbid(&pdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_device);
>  
> @@ -2093,33 +2113,63 @@ static bool vfio_pci_dev_set_needs_reset(struct vfio_device_set *dev_set)
>   *  - At least one of the affected devices is marked dirty via
>   *    needs_reset (such as by lack of FLR support)
>   * Then attempt to perform that bus or slot reset.
> - * Returns true if the dev_set was reset.
>   */
> -static bool vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
> +static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
>  {
>  	struct vfio_pci_core_device *cur;
>  	struct pci_dev *pdev;
>  	int ret;
>  
>  	if (!vfio_pci_dev_set_needs_reset(dev_set))
> -		return false;
> +		return;
>  
>  	pdev = vfio_pci_dev_set_resettable(dev_set);
>  	if (!pdev)
> -		return false;
> +		return;
>  
>  	ret = pci_reset_bus(pdev);
>  	if (ret)
> -		return false;
> +		return;
>  
>  	list_for_each_entry(cur, &dev_set->device_list, vdev.dev_set_list) {
>  		cur->needs_reset = false;
> -		if (!disable_idle_d3)
> -			vfio_pci_set_power_state(cur, PCI_D3hot);
> +		if (!disable_idle_d3) {
> +			/*
> +			 * Inside pci_reset_bus(), all the devices in bus/slot
> +			 * will be moved out of D0 state. This state change to
> +			 * D0 can happen directly without going through the
> +			 * runtime PM framework. pm_runtime_resume() will
> +			 * help make the runtime state as active and then
> +			 * pm_request_autosuspend() can be used which will
> +			 * internally check for device usage count and will
> +			 * move the device again into the low power state.
> +			 */
> +			pm_runtime_resume(&pdev->dev);
> +			pm_runtime_mark_last_busy(&pdev->dev);
> +			pm_request_autosuspend(&pdev->dev);
> +		}
>  	}
> -	return true;
>  }
>  
> +#ifdef CONFIG_PM
> +static int vfio_pci_core_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int vfio_pci_core_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +const struct dev_pm_ops vfio_pci_core_pm_ops = {
> +	SET_RUNTIME_PM_OPS(vfio_pci_core_runtime_suspend,
> +			   vfio_pci_core_runtime_resume,
> +			   NULL)
> +};
> +EXPORT_SYMBOL_GPL(vfio_pci_core_pm_ops);
> +#endif
> +
>  void vfio_pci_core_set_params(bool is_nointxmask, bool is_disable_vga,
>  			      bool is_disable_idle_d3)
>  {
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index ef9a44b6cf5d..aafe09c9fa64 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -231,6 +231,10 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_disable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
>  
> +#ifdef CONFIG_PM
> +extern const struct dev_pm_ops vfio_pci_core_pm_ops;
> +#endif
> +
>  static inline bool vfio_pci_is_vga(struct pci_dev *pdev)
>  {
>  	return (pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA;

