Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBCF434BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhJTNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:06:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:47989 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhJTNGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:06:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="215937382"
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="215937382"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 06:04:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,166,1631602800"; 
   d="scan'208";a="631256361"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2021 06:04:16 -0700
To:     Matthias Kaehlcke <mka@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
References: <20210813195228.2003500-1-mka@chromium.org>
 <20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v16 6/7] usb: host: xhci-plat: Create platform device for
 onboard hubs in probe()
Message-ID: <dfac0025-b693-2431-04c8-1dba7ef32141@linux.intel.com>
Date:   Wed, 20 Oct 2021 16:05:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210813125146.v16.6.I7a3a7d9d2126c34079b1cab87aa0b2ec3030f9b7@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 13.8.2021 22.52, Matthias Kaehlcke wrote:
> Call onboard_hub_create/destroy_pdevs() from  _probe()/_remove()
> to create/destroy platform devices for onboard USB hubs that may
> be connected to the root hub of the controller. These functions
> are a NOP unless CONFIG_USB_ONBOARD_HUB=y/m.
> 
> Also add a field to struct xhci_hcd to keep track of the onboard hub
> platform devices that are owned by the xHCI.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Haven't really looked at this series until now.

Is there any reason why the xhci platform driver was selected as 
the best place to create/remove these onboard hub devices?

This ties the onboard hubs to xhci, and won't work in case we have onboard
hubs connected to a ehci controllers.

If separate devices for controlling onboard hub power is the right solution then
how about creating the onboard hub device in usb_add_hcd() (hcd.c), and
store it in struct usb_hcd.

A bit like how the roothub device is created, or PHYs are tuned.

Thanks
Mathias











