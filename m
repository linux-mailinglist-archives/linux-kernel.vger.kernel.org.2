Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BE13E8671
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 01:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhHJX0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 19:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhHJX0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 19:26:15 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45914C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:25:53 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id z2so913712iln.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 16:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bZoaI6O41jzGVQVv3zA5uioisseRRe2gwUb7pdILMzk=;
        b=J1THLu5eYNZtHM3lMmUt7+OIXk7EVRLducZPFSwhsbu7Wk4lhibTkc9mfy14DXZFVm
         Ij2B/6k1OdBopiZyqYG5AyQ3vpBHY+5UJvl7PeYTVWvlnJcwN6+I8gSkQSIt0FrKdHOT
         JY0IbEXZ4pbRdu+WUknNYe11HdUNbaAjxFMyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bZoaI6O41jzGVQVv3zA5uioisseRRe2gwUb7pdILMzk=;
        b=YenC4loyMhueQy9ChTITdKT132mK7bViK/BrIVPfJwC6vj72YhCrTs+i2c3Dsq0dke
         rgnNTWqzfJmpCG2KUl7ajUr9w1z0kXb5L+itApomcPmPPrqHYrNI4leJ/FfhIYVan8oS
         kVbP89JReJRs/Fauq1+r/9BBJEe3cgbVeQGAB3wzdqMl6Lvo2hjMS5FhnQQ+IqOw4Rm5
         4WFXWI5p44raM/9j0NVQl1scdXLk0hg3+IovHYtGK5r4CM5azDF5GPIau7Ms5BRUiVWT
         Oxgm9QcJ0J89YoL1kNEf3WBH9aOUr2rsO0dW07y23e6h3Cm0KqB6Ex735cUGi3ulmTZN
         YiXA==
X-Gm-Message-State: AOAM531AbYM1op+xm0lhjEUG83XCc9RKwQ9xx8m6fnzKK4gTtEIjfcfq
        FceGN8GEt/Dmj+IMJ7TT/ds5ig==
X-Google-Smtp-Source: ABdhPJxMNwaUBHMUh5ydhrrgGMfKNzKN3s40bG9zf8K8L6avCCj/BcE/ZK9vDoaT7kTDUxa28SRgsg==
X-Received: by 2002:a92:bf03:: with SMTP id z3mr361512ilh.196.1628637952654;
        Tue, 10 Aug 2021 16:25:52 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v5sm12552039ilu.19.2021.08.10.16.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 16:25:52 -0700 (PDT)
Subject: Re: [PATCH v2] usbip: give back URBs for unsent unlink requests
 during cleanup
To:     Anirudh Rayabharam <mail@anirudhrb.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210806181335.2078-1-mail@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4aaf420d-e85e-212e-3bc4-a70e016de610@linuxfoundation.org>
Date:   Tue, 10 Aug 2021 17:25:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210806181335.2078-1-mail@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 12:13 PM, Anirudh Rayabharam wrote:
> In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> not given back. This sometimes causes usb_kill_urb to wait indefinitely
> for that urb to be given back. syzbot has reported a hung task issue [1]
> for this.
> 
> To fix this, give back the urbs corresponding to unsent unlink requests
> (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> requests (unlink_rx list) are given back. Since the code is almost the
> same, extract it into a new function and call it for both unlink_rx and
> unlink_tx lists.
> 

Let's not do the refactor - let's first fix the problem and then the refactor.

> [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> 
> Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
> 
> Changes in v2:
> Use WARN_ON() instead of BUG() when unlink_list is neither unlink_tx nor
> unlink_rx.
> 
> v1: https://lore.kernel.org/lkml/20210806164015.25263-1-mail@anirudhrb.com/
> 
> ---
>   drivers/usb/usbip/vhci_hcd.c | 45 +++++++++++++++++++++++++-----------
>   1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..67e638f4c455 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
>   	return 0;
>   }
>   
> -static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> +static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
> +		struct list_head *unlink_list)
>   {
>   	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
>   	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
> @@ -953,23 +954,23 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>   	struct vhci_unlink *unlink, *tmp;
>   	unsigned long flags;
>   
> +	if (WARN(unlink_list != &vdev->unlink_tx
> +				&& unlink_list != &vdev->unlink_rx,
> +			"Invalid list passed to __vhci_cleanup_unlink_list\n"))
> +		return;
> +

With this change, this will be only place unlink_rx is used without
vdev->priv_lock hold? Please explain why this is safe.

>   	spin_lock_irqsave(&vhci->lock, flags);
>   	spin_lock(&vdev->priv_lock);
>   
> -	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
> -		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
> -		list_del(&unlink->list);
> -		kfree(unlink);
> -	}
> -
> -	while (!list_empty(&vdev->unlink_rx)) {
> +	list_for_each_entry_safe(unlink, tmp, unlink_list, list) {
>   		struct urb *urb;
>   
> -		unlink = list_first_entry(&vdev->unlink_rx, struct vhci_unlink,
> -			list);
> -
> -		/* give back URB of unanswered unlink request */
> -		pr_info("unlink cleanup rx %lu\n", unlink->unlink_seqnum);
> +		if (unlink_list == &vdev->unlink_tx)
> +			pr_info("unlink cleanup tx %lu\n",
> +					unlink->unlink_seqnum);
> +		else
> +			pr_info("unlink cleanup rx %lu\n",
> +					unlink->unlink_seqnum);
>   
>   		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
>   		if (!urb) {
> @@ -1001,6 +1002,24 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>   	spin_unlock_irqrestore(&vhci->lock, flags);
>   }
>   
> +static inline void vhci_cleanup_unlink_tx(struct vhci_device *vdev)
> +{
> +	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_tx);

With this change, this will be only place unlink_rx is used without
vdev->priv_lock hold? Please explain why this is safe.

> +}
> +

Is there a need for this layer?

> +static inline void vhci_cleanup_unlink_rx(struct vhci_device *vdev)
> +{
> +	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_rx);

With this change, this will be only place unlink_rx is used without
vdev->priv_lock hold? Please explain why this is safe.

> +}
> +
Is there a need for this layer?

> +static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
> +{
> +	/* give back URBs of unsent unlink requests */
> +	vhci_cleanup_unlink_tx(vdev);
> +	/* give back URBs of unanswered unlink requests */
> +	vhci_cleanup_unlink_rx(vdev);
> +}
> +
>   /*
>    * The important thing is that only one context begins cleanup.
>    * This is why error handling and cleanup become simple.
> 

thanks,
-- Shuah
