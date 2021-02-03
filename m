Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C021430D698
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhBCJrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:47:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:57354 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233125AbhBCJqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:46:38 -0500
IronPort-SDR: 9Q6cE8sgMS5geuGshIU0DXXwj1KDqrEITT0bY2wczN5EhoY6N/wnQ+iT6dIXSgv3iVCCPDc63Q
 L47XHkE0WPhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="245090923"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="245090923"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:44:51 -0800
IronPort-SDR: iNEkkA99oJXr/xDktZgAFMc4eOBnxGRRgY49etX9b1grglY7/WxA5QyxJIMgssL9VkZQ3xBgfK
 LaDc4UKIesKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="480285552"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga001.fm.intel.com with ESMTP; 03 Feb 2021 01:44:48 -0800
Subject: Re: [PATCH v2] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Peter Chen <peter.chen@nxp.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jun Li <jun.li@nxp.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Marek Behun <marek.behun@nic.cz>
References: <20201223162403.10897-1-pali@kernel.org>
 <20210201150803.7305-1-pali@kernel.org> <YBmc8go9W1qZ8WMe@kroah.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <d630ced6-a662-399d-ed1a-184f74489d44@linux.intel.com>
Date:   Wed, 3 Feb 2021 11:46:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBmc8go9W1qZ8WMe@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.2.2021 20.41, Greg Kroah-Hartman wrote:
> On Mon, Feb 01, 2021 at 04:08:03PM +0100, Pali Rohár wrote:
>> Older ATF does not provide SMC call for USB 3.0 phy power on functionality
>> and therefore initialization of xhci-hcd is failing when older version of
>> ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.
>>
>> [    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try updating your firmware
>> [    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
>> [    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95
>>
>> This patch introduces a new plat_setup callback for xhci platform drivers
>> which is called prior calling usb_add_hcd() function. This function at its
>> beginning skips PHY init if hcd->skip_phy_initialization is set.
>>
>> Current init_quirk callback for xhci platform drivers is called from
>> xhci_plat_setup() function which is called after chip reset completes.
>> It happens in the middle of the usb_add_hcd() function and therefore this
>> callback cannot be used for setting if PHY init should be skipped or not.
>>
>> For Armada 3720 this patch introduce a new xhci_mvebu_a3700_plat_setup()
>> function configured as a xhci platform plat_setup callback. This new
>> function calls phy_power_on() and in case it returns -EOPNOTSUPP then
>> XHCI_SKIP_PHY_INIT quirk is set to instruct xhci-plat to skip PHY
>> initialization.
>>
>> This patch fixes above failure by ignoring 'not supported' error in
>> xhci-hcd driver. In this case it is expected that phy is already power on.
>>
>> It fixes initialization of xhci-hcd on Espressobin boards where is older
>> Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.
>>
>> This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvell:
>> armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defined
>> and therefore xhci-hcd on Espressobin with older ATF started failing.
>>
>> Signed-off-by: Pali Rohár <pali@kernel.org>
>> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
>> Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
>> Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: Convert internal SMCC firmware return codes to errno
>> Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: add priv quirk for skip PHY initialization
> 
> 
> Mathias, any objection for me taking this now to get into 5.11-final?
> 
> thanks,
> 
> greg k-h
> 

No objections, looks good to me.

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
