Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0768A33E994
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCQGVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:21:44 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62204 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCQGVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:21:18 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12H6LARl044515;
        Wed, 17 Mar 2021 15:21:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp);
 Wed, 17 Mar 2021 15:21:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav102.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12H6LA87044512
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Mar 2021 15:21:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 0/6] usbip fixes to crashes found by syzbot
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org
Cc:     valentina.manea.m@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <YEkQ4qS7tkwmjzDn@kroah.com>
 <5baf6b94-72c4-6e69-65a5-35c5cfb8ca0e@i-love.sakura.ne.jp>
 <YEoTw7CoK7Ob0YR+@kroah.com>
 <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
 <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
 <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
 <9e089560-388a-a82d-4841-8092578b9d5d@i-love.sakura.ne.jp>
Message-ID: <465479ca-544e-3703-cf4e-30f5be04fa11@i-love.sakura.ne.jp>
Date:   Wed, 17 Mar 2021 15:21:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9e089560-388a-a82d-4841-8092578b9d5d@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah, this driver is getting more and more cryptic and buggy.
Please explain the strategy for serialization before you write patches.

> - Fix attach_store() to check usbip_event_happened() before
>   waking up threads.

No, this helps nothing.

> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index c4b4256e5dad3..f0a770adebd97 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -418,6 +418,15 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>  	spin_unlock_irqrestore(&vhci->lock, flags);
>  	/* end the lock */
>  
> +	if (usbip_event_happened(&vdev->ud)) {
> +		/*
> +		 * something went wrong - event handler shutting
> +		 * the connection and doing reset - bail out
> +		 */
> +		dev_err(dev, "Event happended - handler is active\n");
> +		return -EAGAIN;
> +	}
> +

detach_store() can queue shutdown event as soon as reaching "/* end the lock */" line
but attach_store() might be preempted immediately after verifying that
usbip_event_happened() was false (i.e. at this location) in order to wait for
shutdown event posted by detach_store() to be processed.

>  	wake_up_process(vdev->ud.tcp_rx);
>  	wake_up_process(vdev->ud.tcp_tx);
>  

