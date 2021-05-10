Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484B0378E03
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351130AbhEJNDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:03:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:14867 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348919AbhEJMrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 08:47:45 -0400
IronPort-SDR: ylM7ic+Nf4AEnFt5H5yQ50+eZaZ4+076RsGUra7dW55235pKxTsrxhHPY1mlAzIf7a+LZxlDX6
 WiaBQL41Zm3Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="220130793"
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="220130793"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:45:39 -0700
IronPort-SDR: Q7H0TpO7rQN6/tGa1ZcOFjHwC2dxzp0YN6jjFUN+tO/EOqv2ea7XccDolUSV45mV5TjufiGsJ1
 QBiNZaBT7Rig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="624268577"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2021 05:45:37 -0700
Subject: Re: Unhandled fault: imprecise external abort (0x1406) at 0x00000000
 - PC is at xhci_hub_control
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     peter.chen@kernel.org, jackp@codeaurora.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        mathias.nyman@intel.com, Li Jun <jun.li@nxp.com>
References: <CA+G9fYtZZoX53PjJ0VV54beMN6COccES9agttNYSzW=FbC=NFg@mail.gmail.com>
 <CA+G9fYvrhB5-Zfh7Xudetsw+rC=LE3JatW6eh8K+mXQHdDKpHQ@mail.gmail.com>
 <CA+G9fYu7h+XBKvC=j7AFNr5tTmNUYWfDWoEEHHf34Gm2jcQoxg@mail.gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Autocrypt: addr=mathias.nyman@linux.intel.com; prefer-encrypt=mutual; keydata=
 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 fiD/
Message-ID: <9bafb8ef-88d9-a111-5402-bb40e3da08f8@linux.intel.com>
Date:   Mon, 10 May 2021 15:47:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYu7h+XBKvC=j7AFNr5tTmNUYWfDWoEEHHf34Gm2jcQoxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.5.2021 14.05, Naresh Kamboju wrote:
> On Mon, 10 May 2021 at 16:22, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> On Mon, 10 May 2021 at 16:02, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>
>>> The kernel crash reported on arm architecture BeagleBoard-X15 device running
>>> Linux next 5.13.0-rc1-next-20210510 while booting the device.
>>>
>>> [    4.956085] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
>>> [    4.961639] xhci-hcd xhci-hcd.1.auto: new USB bus registered,
>>> assigned bus number 2
>>> [    4.969360] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
>>> [    4.976165] usb usb2: We don't know the algorithms for LPM for this
>>> host, disabling LPM.
>>> [    4.985321] hub 2-0:1.0: USB hub found
>>> [    4.989196] hub 2-0:1.0: 1 port detected
>>> [    5.002197] Waiting for root device
>>> PARTUUID=6b10e805-12ad-b44e-88b8-3abf3d5f52ed...
>>> [    5.022918] 8<--- cut here ---
>>> [    5.026000] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>>> [    5.033root
>>> 081] pgd = ff6a1748
>>> [    5.035797] [00000000] *pgd=00000000
>>> [    5.039398] Internal error: : 1406 [#1] SMP ARM
>>> [    5.043975] Modules linked in:
>>> [    5.047027] CPU: 0 PID: 22 Comm: kworker/0:1 Not tainted
>>> 5.13.0-rc1-next-20210510 #1
>>> [    5.054809] Hardware name: Generic DRA74X (Flattened Device Tree)
>>> [    5.060943] Workqueue: pm pm_runtime_work
>>> [    5.065002] PC is at xhci_hub_control+0xd00/0x248c
>>> [    5.069824] LR is at arm_heavy_mb+0x44/0x48
>>
>> Since, this crash is not easily reproducible I could bisect it.
> 
> sorry, i mean i could *not*
> 
> Since, this crash is not easily reproducible I could not bisect it.

Looks like USB SS roothub is trying to runtime suspend early during boot.

Any chance you could look up the source line of xhci_hub_control+0xd00/0x248c in your kernel?
gdb vmlinux
li *(xhci_hub_control+0xd00)

Thanks
-Mathias

