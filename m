Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F744374F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhKBUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 16:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbhKBUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 16:31:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D65C061714;
        Tue,  2 Nov 2021 13:29:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id u11so683144plf.3;
        Tue, 02 Nov 2021 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ASvQxlxAVGYLBZy3FRlgidRj0lB1RSeDDIKlWnkx2iQ=;
        b=bztVHwVFpXxe662jLU5Ha8INsXKDbOrNo4owUkA3pngVscqRCwaeIeQOVyU0HIe4mG
         3bht0HD3gMDI3V8X2RJhayc6ai3Xh7Gt3AyjSbMYn2XUzaqXktozk3e9MleXSE+yZ6ia
         mJ3zaJ1V65szqLeT6OS4t4oio9x4GZgR/zEh9h/7M+dP+Ej81zLAeGdBafDqPVATRDmz
         YZJLm54vCQdCc2fVbrJ1SXK8lmi2DWAHWs/Erx58kX9PTx0YSYH3fNNaMSFTGSvOIXRI
         6deU39OuqPkorqBafEFsGjNaKtCB+PfQUIfpmmxfuigGRoUyTCzCjigCcC/aFpSHmXrZ
         S+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ASvQxlxAVGYLBZy3FRlgidRj0lB1RSeDDIKlWnkx2iQ=;
        b=efti5z2KaekbN/bNf4CLQ2J5tSy3uu++Ox9dsPQtif5y+EO+J24Scnt5uBJgkJbEkA
         FpZC+JlpuugNs4yocRo4o3blwP5Z/GeXFY7MSgkmhP9dJUdcmMJrhc1F9yRssug0wNO0
         /snpnFh7Q21yXB2T4kmqo3lECw1BHXtKrJ+3byHXarskW86V3pWSPAZkd/1gsJV0vtzD
         2uP3LhWANt2c711XUgbfjDM4LyKnjllCHVaaKoDr7vkoo6xWnHBb05SHtQZHk0Szi/aW
         HyXP1XM+FMI3UiNbZ9mJQSPWLZfdvP9W7VR6hc82OdIUwItgucxvnllKvd9TxvtCm6/b
         QUZA==
X-Gm-Message-State: AOAM5310mrCvAzIt/mRZGtPr+nhZEt5VaRQGlmorv08vxdq2dHnfDu6G
        wZhGlFpXgA+m2+JPky4miyA=
X-Google-Smtp-Source: ABdhPJwQWOSRDMVpCoA0MibNGqmhIadvvk+nBvXOFjIlvs3rLi+GvnIzMJAYxZYj9fT8T4AqxjlDvw==
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr9366166pjp.195.1635884948422;
        Tue, 02 Nov 2021 13:29:08 -0700 (PDT)
Received: from [192.168.50.189] (67.218.130.61.16clouds.com. [67.218.130.61])
        by smtp.gmail.com with ESMTPSA id rj2sm12pjb.32.2021.11.02.13.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 13:29:08 -0700 (PDT)
Message-ID: <62d0ac30-f2b9-f58c-cb1e-215ccb455753@gmail.com>
Date:   Wed, 3 Nov 2021 04:29:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v2] usb: core: reduce power-on-good delay time of root hub
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
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
From:   "Walt Jr. Brake" <mr.yming81@gmail.com>
In-Reply-To: <3cf46eaf-5443-30df-6d72-b92a6a518afc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/2021 17:05, Mathias Nyman wrote:
> On 1.11.2021 16.06, Alan Stern wrote:
>> On Sat, Oct 30, 2021 at 12:49:37PM +0800, Walt Jr. Brake wrote:
>>> This patch make USB 3.1 device cannot be detected, and I report the bug [1]
>>> to archlinux three month ago. Yesterday I try to fix it myself, and after I
>>> revert this patch, compile the kernel and test, it works.
>>>
>>> [1] https://bugs.archlinux.org/task/71660?project=1&pagenum=2
>>>
>>>
>>> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
>>> index 22ea1f4f2d66..73f4482d833a 100644
>>> --- a/drivers/usb/core/hub.h
>>> +++ b/drivers/usb/core/hub.h
>>> @@ -148,10 +148,8 @@ static inline unsigned hub_power_on_good_delay(struct
>>> usb_hub *hub)
>>>   {
>>>          unsigned delay = hub->descriptor->bPwrOn2PwrGood * 2;
>>>
>>> -       if (!hub->hdev->parent) /* root hub */
>>> -               return delay;
>>> -       else /* Wait at least 100 msec for power to become stable */
>>> -               return max(delay, 100U);
>>> +       /* Wait at least 100 msec for power to become stable */
>>> +       return max(delay, 100U);
>>>   }
>> Mathias:
>>
>> It looks like the bPwrOn2PwrGood value in xhci-hcd's hub descriptor is
>> too small for some USB 3.1 devices.
>>
>> Can you look into this?
>>
>> Alan Stern
>>
> At first glance the xhci roothub bPwrOn2PwrGood value looks ok.
> xhci spec 5.4.8 states software should wait 20ms after asserting PP, before
> attempting to change the state of the port.
>
> xhci driver sets desc->bPwrOn2PwrGood = 10; (2ms interval, so equals 20ms )
>
> We should probably get this working immediately, so maybe revert that patch
> while looking into the rootcause.
>
> Walt Jr. Brake, instead of reverting that patch, could you test if changing the
> xhci roothub bPwrOn2PwrGood value helps.
>
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index a3f875eea751..756231a55602 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -257,7 +257,7 @@ static void xhci_common_hub_descriptor(struct xhci_hcd *xhci,
>   {
>          u16 temp;
>   
> -       desc->bPwrOn2PwrGood = 10;      /* xhci section 5.4.9 says 20ms max */
> +       desc->bPwrOn2PwrGood = 50;      /* The 20ms in xhci 5.4.8 isn't enough for USB 3.1 */
>          desc->bHubContrCurrent = 0;
>   
>          desc->bNbrPorts = ports;
>
> Thanks
> -Mathias

Mathias:

Sorry to reply lately. I test with your patch, it works.

I also test with setting bPwrOn2PwrGood to 45, and it not work.

Seems that the minimal value should be 50 for this case.

