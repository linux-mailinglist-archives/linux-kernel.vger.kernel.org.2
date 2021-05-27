Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876E2392482
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 03:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhE0BsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 21:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232006AbhE0BsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 21:48:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E2786100A;
        Thu, 27 May 2021 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622080004;
        bh=mEA9IjsjBu/7VlkZqmdbZCnoH5ZxGzLMAtcDDHJPzZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9zf52Qq9PvQQiHqXQHaOFdjgZ6aPiL52uQ4GkZgv/GjHosn/gLPaRUDxBN6qEJ2D
         r5Ns2BpwsGt1WevHgxTNlhDMFH0aUiYUcsRfQaeb87gClliGXZWYdJD62wjEQbNvzP
         jMgoC5OwlF+Ja+r9k+nEFZ6OyQN8stUqq22oTSKpgZxkizhNgFpO6x8woswEgKNJEZ
         dOHbv7OTkNmHjc9ull8BUpwk5/F1oIctiRHL2vkJXusyKPUD67MGzAgT4FBsoOvdwy
         BrKJkD86v16dePvF5I6rXVJHrAa82MB3qI0K9ICAJvGBE3PUrybnT6Z4KZ48nXRZf4
         ySPnp0fHSF/0A==
Date:   Thu, 27 May 2021 09:46:36 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ben Dooks <ben@simtec.co.uk>, Daniel Mack <daniel@zonque.org>,
        David Lopo <dlopo@chipidea.mips.com>,
        Fabio Estevam <festevam@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthijs Kooijman <matthijs@stdin.nl>,
        Michal Simek <michal.simek@xilinx.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pawel Jez <pjez@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Roger Quadros <rogerq@kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 00/24] Rid W=1 warnings from USB
Message-ID: <20210527014636.GA7951@nchen>
References: <20210526130037.856068-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526130037.856068-1-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-05-26 14:00:13, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

For chipidea and cdns3 parts:

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> 
> Lee Jones (24):
>   usb: cdns3: core: Fix a couple of incorrectly documented function
>     names
>   usb: dwc2: platform: Provide function name for
>     'dwc2_check_core_version()'
>   usb: common: ulpi: Add leading underscores for function name
>     '__ulpi_register_driver()'
>   usb: cdns3: cdns3-plat: Fix incorrect naming of function
>     'cdns3_plat_remove()'
>   usb: dwc2: params: Fix naming of 'dwc2_get_hwparams()' in the docs
>   usb: isp1760: isp1760-udc: Provide missing description for 'udc' param
>   usb: cdns3: cdns3-gadget: Fix a bunch of kernel-doc related formatting
>     issues
>   usb: cdns3: cdns3-ti: File headers are not good candidates for
>     kernel-doc
>   usb: cdns3: cdns3-ep0: Fix a few kernel-doc formatting issues
>   usb: cdns3: cdns3-imx: File headers are not good candidates for
>     kernel-doc
>   usb: dwc2: hcd_queue: Fix typeo in function name
>     'dwc2_hs_pmap_unschedule()'
>   usb: dwc2: pci: Fix possible copy/paste issue
>   usb: chipidea: core: Fix incorrectly documented function
>     'ci_usb_phy_exit()'
>   usb: chipidea: otg: Fix formatting and missing documentation issues
>   usb: dwc2: gadget: Repair 'dwc2_hsotg_core_init_disconnected()'s
>     documentation
>   usb: chipidea: udc: Fix incorrectly documented function
>     'hw_port_is_high_speed()'
>   usb: host: xhci: Remove unused variable 'len'
>   usb: gadget: udc: pxa27x_udc: Fix documentation for
>     'pxa27x_udc_start()'
>   usb: gadget: udc: udc-xilinx: Place correct function names into the
>     headers
>   usb: cdns3: cdns3-gadget: Provide correct function naming for
>     '__cdns3_gadget_ep_queue()'
>   usb: host: xhci: Move array of structs from the stack onto the heap
>   usb: host: xhci: Document xhci_get_endpoint_index()'s 'desc' param
>   usb: cdns3: cdnsp-gadget: Provide function name for
>     'cdnsp_find_next_ext_cap()'
>   usb: typec: ucsi: Fix copy/paste issue for 'ucsi_set_drvdata()'
> 
>  drivers/usb/cdns3/cdns3-ep0.c       |  6 ++---
>  drivers/usb/cdns3/cdns3-gadget.c    | 34 ++++++++++++++---------------
>  drivers/usb/cdns3/cdns3-imx.c       |  2 +-
>  drivers/usb/cdns3/cdns3-plat.c      |  2 +-
>  drivers/usb/cdns3/cdns3-ti.c        |  2 +-
>  drivers/usb/cdns3/cdnsp-gadget.c    |  3 ++-
>  drivers/usb/cdns3/core.c            |  4 ++--
>  drivers/usb/chipidea/core.c         |  2 +-
>  drivers/usb/chipidea/otg.c          |  9 ++++----
>  drivers/usb/chipidea/udc.c          |  2 +-
>  drivers/usb/common/ulpi.c           |  2 +-
>  drivers/usb/dwc2/gadget.c           |  2 +-
>  drivers/usb/dwc2/hcd_queue.c        |  2 +-
>  drivers/usb/dwc2/params.c           |  4 ++--
>  drivers/usb/dwc2/pci.c              |  2 +-
>  drivers/usb/dwc2/platform.c         |  2 +-
>  drivers/usb/gadget/udc/pxa27x_udc.c |  2 +-
>  drivers/usb/gadget/udc/udc-xilinx.c |  4 ++--
>  drivers/usb/host/xhci.c             | 19 +++++++++++-----
>  drivers/usb/isp1760/isp1760-udc.c   |  1 +
>  drivers/usb/typec/ucsi/ucsi.c       |  2 +-
>  21 files changed, 59 insertions(+), 49 deletions(-)
> 
> Cc: Aswath Govindraju <a-govindraju@ti.com>
> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: Daniel Mack <daniel@zonque.org>
> Cc: David Lopo <dlopo@chipidea.mips.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-usb@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Matthijs Kooijman <matthijs@stdin.nl>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: Minas Harutyunyan <hminas@synopsys.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Pawel Jez <pjez@cadence.com>
> Cc: Pawel Laszczak <pawell@cadence.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Peter Chen <peter.chen@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> -- 
> 2.31.1
> 

-- 

Thanks,
Peter Chen

