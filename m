Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AECA44499E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 21:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhKCUit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 16:38:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:28920 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhKCUis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 16:38:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231840605"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="231840605"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 13:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="639057499"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 03 Nov 2021 13:36:08 -0700
Subject: Re: [PATCH v2] usb: core: reduce power-on-good delay time of root hub
To:     "Walt Jr. Brake" <mr.yming81@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <1618017645-12259-1-git-send-email-chunfeng.yun@mediatek.com>
 <5e907ccd-40bb-2ece-fe05-1a65a74f3aa2@gmail.com>
 <20211101140613.GC1456700@rowland.harvard.edu>
 <3cf46eaf-5443-30df-6d72-b92a6a518afc@linux.intel.com>
 <62d0ac30-f2b9-f58c-cb1e-215ccb455753@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <13d55059-9f66-8599-54fc-46698bae41d1@linux.intel.com>
Date:   Wed, 3 Nov 2021 22:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <62d0ac30-f2b9-f58c-cb1e-215ccb455753@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.11.2021 22.29, Walt Jr. Brake wrote:
> On 2/11/2021 17:05, Mathias Nyman wrote:
>> On 1.11.2021 16.06, Alan Stern wrote:
>>> On Sat, Oct 30, 2021 at 12:49:37PM +0800, Walt Jr. Brake wrote:
>>>> This patch make USB 3.1 device cannot be detected, and I report the bug [1]
>>>> to archlinux three month ago. Yesterday I try to fix it myself, and after I
>>>> revert this patch, compile the kernel and test, it works.
>>>>
>>>> [1] https://bugs.archlinux.org/task/71660?project=1&pagenum=2
>>>>
>>>>
>>>> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
>>>> index 22ea1f4f2d66..73f4482d833a 100644
>>>> --- a/drivers/usb/core/hub.h
>>>> +++ b/drivers/usb/core/hub.h
>>>> @@ -148,10 +148,8 @@ static inline unsigned hub_power_on_good_delay(struct
>>>> usb_hub *hub)
>>>>   {
>>>>          unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
>>>>
>>>> -       if (!hub->hdev->parent) /* root hub */
>>>> -               return delay;
>>>> -       else /* Wait at least 100 msec for power to become stable */
>>>> -               return max(delay, 100U);
>>>> +       /* Wait at least 100 msec for power to become stable */
>>>> +       return max(delay, 100U);
>>>>   }
>>> Mathias:
>>>
>>> It looks like the bPwrOn2PwrGood value in xhci-hcd's hub descriptor is
>>> too small for some USB 3.1 devices.
>>>
>>> Can you look into this?
>>>
>>> Alan Stern
>>>
>> At first glance the xhci roothub bPwrOn2PwrGood value looks ok.
>> xhci spec 5.4.8 states software should wait 20ms after asserting PP, before
>> attempting to change the state of the port.
>>
>> xhci driver sets desc->bPwrOn2PwrGood = 10; (2ms interval, so equals 20ms )
>>
>> We should probably get this working immediately, so maybe revert that patch
>> while looking into the rootcause.
>>
>> Walt Jr. Brake, instead of reverting that patch, could you test if changing the
>> xhci roothub bPwrOn2PwrGood value helps.
>>
>> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
>> index a3f875eea751..756231a55602 100644
>> --- a/drivers/usb/host/xhci-hub.c
>> +++ b/drivers/usb/host/xhci-hub.c
>> @@ -257,7 +257,7 @@ static void xhci_common_hub_descriptor(struct xhci_hcd *xhci,
>>   {
>>          u16 temp;
>>   -       desc->bPwrOn2PwrGood = 10;      /* xhci section 5.4.9 says 20ms max */
>> +       desc->bPwrOn2PwrGood = 50;      /* The 20ms in xhci 5.4.8 isn't enough for USB 3.1 */
>>          desc->bHubContrCurrent = 0;
>>            desc->bNbrPorts = ports;
>>
>> Thanks
>> -Mathias
> 
> Mathias:
> 
> Sorry to reply lately. I test with your patch, it works.
> 
> I also test with setting bPwrOn2PwrGood to 45, and it not work.
> 
> Seems that the minimal value should be 50 for this case.
> 

Thanks for testing, and for checking that 90ms wait isn't enough

-Mathias
