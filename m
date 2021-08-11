Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560953E9A94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhHKVv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 17:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhHKVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 17:51:55 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEDC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:51:31 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id h1so5531431iol.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NDY3e3hvMMuACrvyJvVS5tnQjqvXWCGs0aykP4KiZr0=;
        b=iZfzWcgiTCal7Yu0bEFP447h2yN6WRcbTDrrdtt4Dzlrf59ZpwDgEag0juTP4Gy85H
         XLKrjm5KTtLonpXyz/kKW+GYvc94ioyB3rpy8dYsziEwq/swAC+s7NFWUaKGAtjuwEkU
         f35M8KhWI9PFAFSP4jekGxiLmxeQRFagop7Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NDY3e3hvMMuACrvyJvVS5tnQjqvXWCGs0aykP4KiZr0=;
        b=mckh2XXlrcV5S1AGVQcnWR8JJ8oIBHIfnD/0UhYnt1GyQ7zFKQWubulTJ8eSCgzrRO
         AmvzmkGVhWbefmHPrNt24TANagGo95ZU2n8hN5u0vA98UzWV/EJyFH8CJQFQ8IvBMe90
         wdDgLqVgdTDMT1h+2mbB3R4rt6mzahEeEIlX1gusqFC3eI2ZVpYxsQlIdby1TKYjn0Li
         52uQpIiXohOueTj0Djv4PMtA/L4K1fA0T+bXehvEn/MfGr55kjhhjDXMnja1/mR7Yp5E
         +x1Y6sZZN1V/8yvsJVAA04IXM449jKHW13W8L03rsubTDc5mwOHtuKUQmd1FolFWK0t6
         e1Dg==
X-Gm-Message-State: AOAM531cPHSyLPKbP6RCgouTKb5czMsCuMlDdfnmb2Yurf0MZDvi1zJ6
        Tf0duIKNvPefELQOFJuYqrXr7Q==
X-Google-Smtp-Source: ABdhPJyweaj8KxWG6YukyZ9RSua4HrYmFmG+Of0+/O01uqaZBEqoLmUWi67vphDUuR0PkkkZJ91dxA==
X-Received: by 2002:a02:a40f:: with SMTP id c15mr874383jal.38.1628718690324;
        Wed, 11 Aug 2021 14:51:30 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a11sm284402ilf.79.2021.08.11.14.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 14:51:29 -0700 (PDT)
Subject: Re: [PATCH v2] usbip: give back URBs for unsent unlink requests
 during cleanup
To:     Anirudh Rayabharam <mail@anirudhrb.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210806181335.2078-1-mail@anirudhrb.com>
 <4aaf420d-e85e-212e-3bc4-a70e016de610@linuxfoundation.org>
 <YRPXnzpyHETZ9bn2@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4af0d8b6-c0c8-9e49-68ed-90bac5e16966@linuxfoundation.org>
Date:   Wed, 11 Aug 2021 15:51:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YRPXnzpyHETZ9bn2@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 7:58 AM, Anirudh Rayabharam wrote:
> On Tue, Aug 10, 2021 at 05:25:51PM -0600, Shuah Khan wrote:
>> On 8/6/21 12:13 PM, Anirudh Rayabharam wrote:
>>> In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
>>> not given back. This sometimes causes usb_kill_urb to wait indefinitely
>>> for that urb to be given back. syzbot has reported a hung task issue [1]
>>> for this.
>>>
>>> To fix this, give back the urbs corresponding to unsent unlink requests
>>> (unlink_tx list) similar to how urbs corresponding to unanswered unlink
>>> requests (unlink_rx list) are given back. Since the code is almost the
>>> same, extract it into a new function and call it for both unlink_rx and
>>> unlink_tx lists.
>>>
>>
>> Let's not do the refactor - let's first fix the problem and then the refactor.
> 
> Sure, I will make it a two patch series where the first one fixes the
> problem and the second one does the refactor.
> 
>>
>>> [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
>>>
>>> Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
>>> Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
>>> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
>>> ---
>>>
>>> Changes in v2:
>>> Use WARN_ON() instead of BUG() when unlink_list is neither unlink_tx nor
>>> unlink_rx.
>>>
>>> v1: https://lore.kernel.org/lkml/20210806164015.25263-1-mail@anirudhrb.com/
>>>
>>> ---
>>>    drivers/usb/usbip/vhci_hcd.c | 45 +++++++++++++++++++++++++-----------
>>>    1 file changed, 32 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index 4ba6bcdaa8e9..67e638f4c455 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>>>    	return 0;
>>>    }
>>> -static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>>> +static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
>>> +		struct list_head *unlink_list)
>>>    {
>>>    	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
>>>    	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
>>> @@ -953,23 +954,23 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>>>    	struct vhci_unlink *unlink, *tmp;
>>>    	unsigned long flags;
>>> +	if (WARN(unlink_list != &vdev->unlink_tx
>>> +				&& unlink_list != &vdev->unlink_rx,
>>> +			"Invalid list passed to __vhci_cleanup_unlink_list\n"))
>>> +		return;
>>> +
>>
>> With this change, this will be only place unlink_rx is used without
>> vdev->priv_lock hold? Please explain why this is safe.
> 
> Well, this doesn't read or modify the contents of unlink_rx and unlink_tx.
> So, it looks safe to me. Let me know if I'm missing something here.
> 
>>
>>>    	spin_lock_irqsave(&vhci->lock, flags);
>>>    	spin_lock(&vdev->priv_lock);
>>> -	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
>>> -		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
>>> -		list_del(&unlink->list);
>>> -		kfree(unlink);
>>> -	}
>>> -
>>> -	while (!list_empty(&vdev->unlink_rx)) {
>>> +	list_for_each_entry_safe(unlink, tmp, unlink_list, list) {
>>>    		struct urb *urb;
>>> -		unlink = list_first_entry(&vdev->unlink_rx, struct vhci_unlink,
>>> -			list);
>>> -
>>> -		/* give back URB of unanswered unlink request */
>>> -		pr_info("unlink cleanup rx %lu\n", unlink->unlink_seqnum);
>>> +		if (unlink_list == &vdev->unlink_tx)
>>> +			pr_info("unlink cleanup tx %lu\n",
>>> +					unlink->unlink_seqnum);
>>> +		else
>>> +			pr_info("unlink cleanup rx %lu\n",
>>> +					unlink->unlink_seqnum);
>>>    		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
>>>    		if (!urb) {
>>> @@ -1001,6 +1002,24 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>>>    	spin_unlock_irqrestore(&vhci->lock, flags);
>>>    }
>>> +static inline void vhci_cleanup_unlink_tx(struct vhci_device *vdev)
>>> +{
>>> +	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_tx);
>>
>> With this change, this will be only place unlink_rx is used without
>> vdev->priv_lock hold? Please explain why this is safe.
>>
>>> +}
>>> +
>>
>> Is there a need for this layer?
>>
>>> +static inline void vhci_cleanup_unlink_rx(struct vhci_device *vdev)
>>> +{
>>> +	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_rx);
>>
>> With this change, this will be only place unlink_rx is used without
>> vdev->priv_lock hold? Please explain why this is safe.
>>
>>> +}
>>> +
>> Is there a need for this layer?
> 
> I added these wrappers purely for convenience. There is no other purpose.
> Would you prefer this patch without the wrappers?
> 

Yes. Prefer it without the wrappers. When you take the wrappers
out, I think the unlink_rx could be within spinlock hold easily.

thanks,
-- Shuah
