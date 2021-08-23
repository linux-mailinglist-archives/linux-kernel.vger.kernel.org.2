Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EAB3F534E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhHWWVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:21:19 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4E8C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:20:36 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso35498085otp.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 15:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XLNuiyO0cubs0wSKnZ64iacT0nPi9HeH2VX3WhJVa9s=;
        b=f38ETai0cYaZBAw/rO1nnWwVuz1CF2Mw/JxK05NrCh4O2GFc29TLhLU4Ahk+H6bqGS
         2pluz27ZfIM9HU/aYJ8/j45EAioAumLCfjBVfKGSpBJnibI5ijNqEqbQ0aYTAautEgLv
         N9gUTf7sKYP0D2tYjQkQJLcem6RIpxONBPnyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLNuiyO0cubs0wSKnZ64iacT0nPi9HeH2VX3WhJVa9s=;
        b=OPjcTquPZYsqjgrRZdyzO0YcKoScWxBpGncQtLjBExPC0Vh83KB06hnwfWHtdT9Kve
         fNlc1qUjW6yzICMDUBZgBHsLaVFlJcTPPMvmYO2n6IoSJA37fSr4s0JIlOvxFWKbFm5e
         dUCHfU2dTPxJzYSuf+Sdzkdg2lVTiSyfnQp7QDNvZCgsuMi4XSdtz5ndVQB+7QgwDZgD
         T19cqw4IvVbklpalpufBzRpzXAQ76BmIhI2um7hgX6+Wlsv18B2oAzCdmHWYhlU9SFhz
         TkGRJS41hXpQ2OvAQieAoSe/5Oa7ci9m1ky4dLLoCK7RhBrxWevGsQN/GyhD0ODtw0Hi
         pixQ==
X-Gm-Message-State: AOAM530NBKKluLCmRffIxtp80zqOQ7cINtDqOX5XNIIlfwxID1Vr8Pzn
        Vk8q8Dhf4gDEuXqKxSYJ1sx6lA==
X-Google-Smtp-Source: ABdhPJwJf/JH/tr1Fw7ldmEMxlsLySn+Dxg0fP7oLl6RJ/A1LoqNzHobZpsRhUS2MTX3LT4GBKdVJw==
X-Received: by 2002:a05:6808:d53:: with SMTP id w19mr605807oik.135.1629757235777;
        Mon, 23 Aug 2021 15:20:35 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e11sm1288720oiw.18.2021.08.23.15.20.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 15:20:35 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] usbip: give back URBs for unsent unlink requests
 during cleanup
To:     Anirudh Rayabharam <mail@anirudhrb.com>,
        valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210820190122.16379-1-mail@anirudhrb.com>
 <20210820190122.16379-2-mail@anirudhrb.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8fe11b13-58b4-e696-1727-6bd8226b67f9@linuxfoundation.org>
Date:   Mon, 23 Aug 2021 16:20:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210820190122.16379-2-mail@anirudhrb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 1:01 PM, Anirudh Rayabharam wrote:
> In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
> not given back. This sometimes causes usb_kill_urb to wait indefinitely
> for that urb to be given back. syzbot has reported a hung task issue [1]
> for this.
> 
> To fix this, give back the urbs corresponding to unsent unlink requests
> (unlink_tx list) similar to how urbs corresponding to unanswered unlink
> requests (unlink_rx list) are given back.
> 
> [1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76
> 
> Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
> Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..190bd3d1c1f0 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -957,8 +957,32 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>   	spin_lock(&vdev->priv_lock);
>   
>   	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
> +		struct urb *urb;
> +
> +		/* give back urb of unsent unlink request */
>   		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
> +
> +		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
> +		if (!urb) {
> +			list_del(&unlink->list);
> +			kfree(unlink);
> +			continue;
> +		}
> +
> +		urb->status = -ENODEV;
> +
> +		usb_hcd_unlink_urb_from_ep(hcd, urb);
> +
>   		list_del(&unlink->list);
> +
> +		spin_unlock(&vdev->priv_lock);
> +		spin_unlock_irqrestore(&vhci->lock, flags);
> +
> +		usb_hcd_giveback_urb(hcd, urb, urb->status);
> +
> +		spin_lock_irqsave(&vhci->lock, flags);
> +		spin_lock(&vdev->priv_lock);
> +
>   		kfree(unlink);
>   	}
>   
> 

Looks good.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
