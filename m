Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0C732D2CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbhCDMXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbhCDMWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:22:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F1C06175F;
        Thu,  4 Mar 2021 04:22:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 90ED01F462F8
Subject: Re: next/master bisection: baseline.login on rk3399-gru-kevin
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ray Chi <raychi@google.com>
References: <6040cc3b.1c69fb81.cba3d.5b5c@mx.google.com>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <9ada6ed0-eef0-407b-cf9b-22d077cee578@collabora.com>
Date:   Thu, 4 Mar 2021 12:22:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <6040cc3b.1c69fb81.cba3d.5b5c@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ray,

Please see the bisection report below about a boot failure on
rk3399-gru-kevin on linux-next.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

The boot log shows a kernel panic with a NULL pointer
dereference:

  https://storage.kernelci.org/next/master/next-20210304/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html#L673

Some more details can be found here:

  https://kernelci.org/test/case/id/60405c6fa031a93136addcc0/


Please let us know if you need any help with debugging the issue
or trying a fix on this platform.

Thanks,
Guillaume

On 04/03/2021 12:02, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on rk3399-gru-kevin
> 
> Summary:
>   Start:      f5427c2460eb Add linux-next specific files for 20210304
>   Plain log:  https://storage.kernelci.org/next/master/next-20210304/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20210304/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
>   Result:     59fa3def35de usb: dwc3: add a power supply for current control
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     rk3399-gru-kevin
>   CPU arch:   arm64
>   Lab:        lab-collabora
>   Compiler:   gcc-8
>   Config:     defconfig+CONFIG_RANDOMIZE_BASE=y
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 59fa3def35de957881ac142a384487e27e8fe527
> Author: Ray Chi <raychi@google.com>
> Date:   Mon Feb 22 19:51:48 2021 +0800
> 
>     usb: dwc3: add a power supply for current control
>     
>     Currently, VBUS draw callback does no action when the
>     generic PHYs are used. This patch adds an additional
>     path to control charging current through power supply
>     interface.
>     
>     Signed-off-by: Ray Chi <raychi@google.com>
>     Link: https://lore.kernel.org/r/20210222115149.3606776-2-raychi@google.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index f2448d0a9d39..d15f065849cd 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1238,6 +1238,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	u8			rx_max_burst_prd;
>  	u8			tx_thr_num_pkt_prd;
>  	u8			tx_max_burst_prd;
> +	const char		*usb_psy_name;
> +	int			ret;
>  
>  	/* default to highest possible threshold */
>  	lpm_nyet_threshold = 0xf;
> @@ -1263,6 +1265,13 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>  	else
>  		dwc->sysdev = dwc->dev;
>  
> +	ret = device_property_read_string(dev, "usb-psy-name", &usb_psy_name);
> +	if (ret >= 0) {
> +		dwc->usb_psy = power_supply_get_by_name(usb_psy_name);
> +		if (!dwc->usb_psy)
> +			dev_err(dev, "couldn't get usb power supply\n");
> +	}
> +
>  	dwc->has_lpm_erratum = device_property_read_bool(dev,
>  				"snps,has-lpm-erratum");
>  	device_property_read_u8(dev, "snps,lpm-nyet-threshold",
> @@ -1619,6 +1628,9 @@ static int dwc3_probe(struct platform_device *pdev)
>  assert_reset:
>  	reset_control_assert(dwc->reset);
>  
> +	if (!dwc->usb_psy)
> +		power_supply_put(dwc->usb_psy);
> +
>  	return ret;
>  }
>  
> @@ -1641,6 +1653,9 @@ static int dwc3_remove(struct platform_device *pdev)
>  	dwc3_free_event_buffers(dwc);
>  	dwc3_free_scratch_buffers(dwc);
>  
> +	if (!dwc->usb_psy)
> +		power_supply_put(dwc->usb_psy);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 052b20d52651..6708fdf358b3 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -30,6 +30,8 @@
>  
>  #include <linux/phy/phy.h>
>  
> +#include <linux/power_supply.h>
> +
>  #define DWC3_MSG_MAX	500
>  
>  /* Global constants */
> @@ -1125,6 +1127,8 @@ struct dwc3 {
>  	struct usb_role_switch	*role_sw;
>  	enum usb_dr_mode	role_switch_default_mode;
>  
> +	struct power_supply	*usb_psy;
> +
>  	u32			fladj;
>  	u32			irq_gadget;
>  	u32			otg_irq;
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [f69d02e37a85645aa90d18cacfff36dba370f797] Merge tag 'misc-5.12-2021-03-02' of git://git.kernel.dk/linux-block
> git bisect good f69d02e37a85645aa90d18cacfff36dba370f797
> # bad: [f5427c2460ebc11b1a66c1742d41077ae5b99796] Add linux-next specific files for 20210304
> git bisect bad f5427c2460ebc11b1a66c1742d41077ae5b99796
> # good: [10dde63b6343e57cdaf20c7a7f62ea66a45bb437] Merge remote-tracking branch 'bluetooth/master'
> git bisect good 10dde63b6343e57cdaf20c7a7f62ea66a45bb437
> # good: [266b341281956da101598f2bc3435ecda7a41f25] Merge remote-tracking branch 'irqchip/irq/irqchip-next'
> git bisect good 266b341281956da101598f2bc3435ecda7a41f25
> # bad: [2024dc5b38616653e9223479c425c4c79028f2ba] Merge remote-tracking branch 'thunderbolt/next'
> git bisect bad 2024dc5b38616653e9223479c425c4c79028f2ba
> # good: [034fb9700e21a140656a0c5f22c4c740194a8c85] torture: Rename SRCU-t and SRCU-u to avoid lowercase characters
> git bisect good 034fb9700e21a140656a0c5f22c4c740194a8c85
> # good: [4ed7b3163ff5061eef889d1722953389eff021f2] Merge remote-tracking branch 'kvm-arm/next'
> git bisect good 4ed7b3163ff5061eef889d1722953389eff021f2
> # bad: [5bb9cdb320a5ca631b584a9aa1ba472eb14705af] USB: remove usb_bus_type from usb.h
> git bisect bad 5bb9cdb320a5ca631b584a9aa1ba472eb14705af
> # bad: [5410c878cc60bd73a045ba25982a1bad1bd85241] USB: core: no need to save usb_devices_root
> git bisect bad 5410c878cc60bd73a045ba25982a1bad1bd85241
> # bad: [76813aabd81ffe8ef9a084faf6d66233cf013357] usb: typec: tps6598x: Add trace event for power status register
> git bisect bad 76813aabd81ffe8ef9a084faf6d66233cf013357
> # bad: [effcaf3f59b5557b0423f4b0d64df49658a9ec64] usb: dwc3: add an alternate path in vbus_draw callback
> git bisect bad effcaf3f59b5557b0423f4b0d64df49658a9ec64
> # bad: [59fa3def35de957881ac142a384487e27e8fe527] usb: dwc3: add a power supply for current control
> git bisect bad 59fa3def35de957881ac142a384487e27e8fe527
> # first bad commit: [59fa3def35de957881ac142a384487e27e8fe527] usb: dwc3: add a power supply for current control
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#7723): https://groups.io/g/kernelci-results/message/7723
> Mute This Topic: https://groups.io/mt/81049198/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

