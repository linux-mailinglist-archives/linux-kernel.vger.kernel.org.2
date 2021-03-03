Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7332C42B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbhCDALi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:11:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbhCCX5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 18:57:49 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lHaH5-0004Mx-2a; Wed, 03 Mar 2021 22:47:23 +0000
Subject: Re: [PATCH] usb: dwc3: Fix dereferencing of null dwc->usb_psy
To:     Heiko Thiery <heiko.thiery@gmail.com>, raychi@google.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <CAPBYUsCPj12enyMp9AMzFEAgd5MdKh7dYN5DNFpZwofBYnjG8A@mail.gmail.com>
 <20210303212924.19733-1-heiko.thiery@gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <b93ff323-e03c-10b3-c38d-921bc6b2edc0@canonical.com>
Date:   Wed, 3 Mar 2021 22:47:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210303212924.19733-1-heiko.thiery@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2021 21:29, Heiko Thiery wrote:
> Hi all,
> 
>> On Wed, Mar 3, 2021 at 6:00 PM Colin King <colin.king@canonical.com> wrote:
>>>
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Currently the null check logic on dwc->usb_psy is inverted as it allows
>>> calls to power_supply_put with a null dwc->usb_psy causing a null
>>> pointer dereference. Fix this by removing the ! operator.
>>>
>>> Addresses-Coverity: ("Dereference after null check")
>>> Fixes: 59fa3def35de ("usb: dwc3: add a power supply for current control")
>>
>> Acked-by: Ray Chi <raychi@google.com>
>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

Thanks for testing. Much appreciated.

Colin
> 
>>> ---
>>>  drivers/usb/dwc3/core.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index d15f065849cd..94fdbe502ce9 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1628,7 +1628,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>>  assert_reset:
>>>         reset_control_assert(dwc->reset);
>>>
>>> -       if (!dwc->usb_psy)
>>> +       if (dwc->usb_psy)
>>>                 power_supply_put(dwc->usb_psy);
>>>
>>>         return ret;
>>> @@ -1653,7 +1653,7 @@ static int dwc3_remove(struct platform_device *pdev)
>>>         dwc3_free_event_buffers(dwc);
>>>         dwc3_free_scratch_buffers(dwc);
>>>
>>> -       if (!dwc->usb_psy)
>>> +       if (dwc->usb_psy)
>>>                 power_supply_put(dwc->usb_psy);
>>>
>>>         return 0;
>>> --
>>> 2.30.0
>>>
> 
> Thank you.
> 

