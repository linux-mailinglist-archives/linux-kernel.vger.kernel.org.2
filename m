Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C313457F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 07:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCWGs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 02:48:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229897AbhCWGsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 02:48:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64E2661992;
        Tue, 23 Mar 2021 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616482130;
        bh=Yr2HhyT5BBzbgia3YyQX5M1bKzv4UKeQb96izwivo7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHXtiABOwhSmlC5LVCLUA5lwWrBa/npNQMpyVi4jEleJP0onfDbrB604VOfBybbp6
         Q6+J307kj7swEwK1kluMhDAsVTGmwK0SQ/9oXgxErCQIxgSCpsd6JI6Y9/DgIXvNHa
         SAqhDFC4y0i2EmOuAazXe6O1E57m891T/mnZYMxRtZBMCffONWnYwo7RukQJwpklWP
         +mJGCR6os79rj8JrNARfBeCl4m6QMqd8eYL/pz2Q3GfMFvIL3vnM7hs9cM0KBwq9Yh
         /80dKRk4cd38E1xBx+LjYSyAjU/Lbl2cJB1eRoY76v+lh0wdnuAlhVVYOiEE/XR6Ku
         7yuaE0UFhT0Pg==
Date:   Tue, 23 Mar 2021 12:18:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: intel: move to auxiliary bus
Message-ID: <YFmPTkNkX6QPWiCa@vkoul-mobl.Dlink>
References: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323004325.19727-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-21, 08:43, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Now that the auxiliary_bus exists, there's no reason to use platform
> devices as children of a PCI device any longer.
> 
> This patch refactors the code by extending a basic auxiliary device
> with Intel link-specific structures that need to be passed between
> controller and link levels. This refactoring is much cleaner with no
> need for cross-pointers between device and link structures.
> 
> Note that the auxiliary bus API has separate init and add steps, which
> requires more attention in the error unwinding paths. The main loop
> needs to deal with kfree() and auxiliary_device_uninit() for the
> current iteration before jumping to the common label which releases
> everything allocated in prior iterations.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/Kconfig           |   1 +
>  drivers/soundwire/intel.c           |  52 ++++----
>  drivers/soundwire/intel.h           |  14 +-
>  drivers/soundwire/intel_init.c      | 190 +++++++++++++++++++---------
>  include/linux/soundwire/sdw_intel.h |   6 +-
>  5 files changed, 175 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index 016e74230bb7..2b7795233282 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -25,6 +25,7 @@ config SOUNDWIRE_INTEL
>  	tristate "Intel SoundWire Master driver"
>  	select SOUNDWIRE_CADENCE
>  	select SOUNDWIRE_GENERIC_ALLOCATION
> +	select AUXILIARY_BUS
>  	depends on ACPI && SND_SOC
>  	help
>  	  SoundWire Intel Master driver.
> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
> index d2254ee2fee2..039a101982c9 100644
> --- a/drivers/soundwire/intel.c
> +++ b/drivers/soundwire/intel.c
> @@ -11,7 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/platform_device.h>
> +#include <linux/auxiliary_bus.h>
>  #include <sound/pcm_params.h>
>  #include <linux/pm_runtime.h>
>  #include <sound/soc.h>
> @@ -1331,9 +1331,10 @@ static int intel_init(struct sdw_intel *sdw)
>  /*
>   * probe and init
>   */
> -static int intel_master_probe(struct platform_device *pdev)
> +static int intel_link_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = &auxdev->dev;
> +	struct sdw_intel_link_dev *ldev = auxiliary_dev_to_sdw_intel_link_dev(auxdev);

Do we need another abstractions for resources here, why not aux dev
creation set the resources required and we skip this step...

>  	struct sdw_intel *sdw;
>  	struct sdw_cdns *cdns;
>  	struct sdw_bus *bus;
> @@ -1346,14 +1347,14 @@ static int intel_master_probe(struct platform_device *pdev)
>  	cdns = &sdw->cdns;
>  	bus = &cdns->bus;
>  
> -	sdw->instance = pdev->id;
> -	sdw->link_res = dev_get_platdata(dev);
> +	sdw->instance = auxdev->id;

so auxdev has id and still we pass id as argument :( Not sure if folks
can fix this now

> +	sdw->link_res = &ldev->link_res;
>  	cdns->dev = dev;
>  	cdns->registers = sdw->link_res->registers;
>  	cdns->instance = sdw->instance;
>  	cdns->msg_count = 0;
>  
> -	bus->link_id = pdev->id;
> +	bus->link_id = auxdev->id;
>  
>  	sdw_cdns_probe(cdns);
>  
> @@ -1386,10 +1387,10 @@ static int intel_master_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -int intel_master_startup(struct platform_device *pdev)
> +int intel_link_startup(struct auxiliary_device *auxdev)
>  {
>  	struct sdw_cdns_stream_config config;
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = &auxdev->dev;
>  	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_bus *bus = &cdns->bus;
> @@ -1526,9 +1527,9 @@ int intel_master_startup(struct platform_device *pdev)
>  	return ret;
>  }
>  
> -static int intel_master_remove(struct platform_device *pdev)
> +static void intel_link_remove(struct auxiliary_device *auxdev)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = &auxdev->dev;
>  	struct sdw_cdns *cdns = dev_get_drvdata(dev);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
>  	struct sdw_bus *bus = &cdns->bus;
> @@ -1544,19 +1545,17 @@ static int intel_master_remove(struct platform_device *pdev)
>  		snd_soc_unregister_component(dev);
>  	}
>  	sdw_bus_master_delete(bus);
> -
> -	return 0;
>  }
>  
> -int intel_master_process_wakeen_event(struct platform_device *pdev)
> +int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = &auxdev->dev;
>  	struct sdw_intel *sdw;
>  	struct sdw_bus *bus;
>  	void __iomem *shim;
>  	u16 wake_sts;
>  
> -	sdw = platform_get_drvdata(pdev);
> +	sdw = dev_get_drvdata(dev);

No auxdev_get_drvdata() ?

>  	bus = &sdw->cdns.bus;
>  
>  	if (bus->prop.hw_disabled) {
> @@ -1978,17 +1977,22 @@ static const struct dev_pm_ops intel_pm = {
>  	SET_RUNTIME_PM_OPS(intel_suspend_runtime, intel_resume_runtime, NULL)
>  };
>  
> -static struct platform_driver sdw_intel_drv = {
> -	.probe = intel_master_probe,
> -	.remove = intel_master_remove,
> +static const struct auxiliary_device_id intel_link_id_table[] = {
> +	{ .name = "soundwire_intel.link" },

Curious why name with .link..?

> +	{},
> +};
> +MODULE_DEVICE_TABLE(auxiliary, intel_link_id_table);
> +
> +static struct auxiliary_driver sdw_intel_drv = {
> +	.probe = intel_link_probe,
> +	.remove = intel_link_remove,
>  	.driver = {
> -		.name = "intel-sdw",
> +		/* auxiliary_driver_register() sets .name to be the modname */
>  		.pm = &intel_pm,
> -	}
> +	},
> +	.id_table = intel_link_id_table
>  };
> -
> -module_platform_driver(sdw_intel_drv);
> +module_auxiliary_driver(sdw_intel_drv);
>  
>  MODULE_LICENSE("Dual BSD/GPL");
> -MODULE_ALIAS("platform:intel-sdw");
> -MODULE_DESCRIPTION("Intel Soundwire Master Driver");
> +MODULE_DESCRIPTION("Intel Soundwire Link Driver");
> diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
> index 06bac8ba14e9..0b47b148da3f 100644
> --- a/drivers/soundwire/intel.h
> +++ b/drivers/soundwire/intel.h
> @@ -7,7 +7,6 @@
>  /**
>   * struct sdw_intel_link_res - Soundwire Intel link resource structure,
>   * typically populated by the controller driver.
> - * @pdev: platform_device
>   * @mmio_base: mmio base of SoundWire registers
>   * @registers: Link IO registers base
>   * @shim: Audio shim pointer
> @@ -23,7 +22,6 @@
>   * @list: used to walk-through all masters exposed by the same controller
>   */
>  struct sdw_intel_link_res {
> -	struct platform_device *pdev;
>  	void __iomem *mmio_base; /* not strictly needed, useful for debug */
>  	void __iomem *registers;
>  	void __iomem *shim;
> @@ -48,7 +46,15 @@ struct sdw_intel {
>  #endif
>  };
>  
> -int intel_master_startup(struct platform_device *pdev);
> -int intel_master_process_wakeen_event(struct platform_device *pdev);
> +int intel_link_startup(struct auxiliary_device *auxdev);
> +int intel_link_process_wakeen_event(struct auxiliary_device *auxdev);
> +
> +struct sdw_intel_link_dev {
> +	struct auxiliary_device auxdev;
> +	struct sdw_intel_link_res link_res;
> +};

I was hoping that with auxdev we can get rid of this init layer, can
that still be done?

The auxdev is created by Intel controller, so it sets up resources. I am
not really happy that we need to continue having this layer.. can we add
something is auxdev core to handle these situations.

What I would like to see the end result is that sdw driver for Intel
controller here is a simple auxdev device and no additional custom setup
layer required... which implies that this handling should be moved into
auxdev or Intel code setting up auxdev...

-- 
~Vinod
