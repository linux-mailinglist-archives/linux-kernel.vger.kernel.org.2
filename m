Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685303396CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhCLSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhCLSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:43:04 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:43:03 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r7so3516946ilb.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RzyG8WNK+n+PA4HkSryeYxoXrjHZwQvUJZnWM65b7jk=;
        b=PtL9UnVp5IewSgsRWwK17TxRaICLLCcod2mE0ZRlXvjqjEX/sRk1U00Ih2/yjJkzKD
         ctzMhCeWjnCLaN8mr6rckXpJ/TlZhGuyYxJvPxXtO2hQJdeTI1hn5YDcXOvKebavCnXB
         okN4tHz7kdTzMeYYpucHnv3yIZIVdpyuN9XY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RzyG8WNK+n+PA4HkSryeYxoXrjHZwQvUJZnWM65b7jk=;
        b=Jb8hZ5D5RNFveGyBgweaCOUdZEDyTHxIP3QsKdsJpNr+xesMM+k81iK5/VpztCn1X5
         AEe/Kp/tdg85I7r6WgdYpiE4SUiQP7gms999nkthe8QdoY4K1ZMakev2SbNNUgipwD97
         h5Cj9ZL6e9jP53nXsLii6kNdqE3sVbyEj8Hyo9Tvkn+dJEsRx9A6QwnxIyfpY4zuyWu4
         s/xzciVcGqArUlQH5eHXO5IKjN0DQoP20GdFt2hsZsA9TAVvj8SGgYrUCIfluZZuw2pv
         oSIzdZYIpKfthQ3NwfjoPk6MlM2Wiblx8FNBZr5aWs9WTf2VECAVb5iV67w5Zf98QSDf
         jW8w==
X-Gm-Message-State: AOAM530+osmvSNxflSN/PUIX0lHZvZZnO+GNGS7vAIcWHLSZKWIBaYF5
        2XWS4bGfls4f6GJhCk+dWAXJb3GSipCOZg==
X-Google-Smtp-Source: ABdhPJydvBD7fKk74/zHdNkNXjloYb88pr9lKSDcjI96Zxp9+Yx2N/b27QdDm73GjKJr+YXW/8LurQ==
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr3784956ilt.111.1615574583407;
        Fri, 12 Mar 2021 10:43:03 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s14sm3319816ilj.83.2021.03.12.10.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:43:03 -0800 (PST)
Subject: Re: [PATCH] usbip: fix vhci races in connection tear down
To:     Johan Hovold <johan@kernel.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210312022737.44122-1-skhan@linuxfoundation.org>
 <YEtGMMjOg3pHTSma@hovoldconsulting.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d2c0b3b-07fb-8f59-d7b4-81d7d992636c@linuxfoundation.org>
Date:   Fri, 12 Mar 2021 11:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEtGMMjOg3pHTSma@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 3:45 AM, Johan Hovold wrote:
> On Thu, Mar 11, 2021 at 07:27:37PM -0700, Shuah Khan wrote:
>> vhci_shutdown_connection() references connection state (tcp_socket,
>> tcp_rx, tcp_tx, sockfd) saved in usbpip_device without holding the
>> lock.
>>
>> Current connection tear down sequence:
>> Step 1: shutdown the socket
>> Step 2: stop rx thread and reset tcp_rx pointer
>> Step 3: stop tx thread and reset tcp_tx pointer
>> Step 4: Reset tcp_socket and sockfd
>>
>> There are several race windows between these steps. In addition, device
>> reset routine (vhci_device_reset) resets tcp_socket and sockfd holding
>> the lock.
>>
>> Fix these races:
>> - Introduce in_disconnect flag to ensure vhci_shutdown_connection() runs
>>    only once.
>> - Change attach_store() to initialize in_disconnect to false while
>>    initializing connection status (tcp_socket, tcp_rx, tcp_tx, sockfd)
>> - Change vhci_shutdown_connection() to check in_disconnect and bail
>>    out if disconnect is in progress.
>> - Change vhci_shutdown_connection() to
>>    -- hold lock to save connection state pointers and unlock.
>>    -- Shutdown the socket and stop threads.
>>    -- Hold lock to clear connection status and in_disconnect flag.
>> - Change vhci_device_reset() to reset tcp_socket and sockfd.
>>    if !in_disconnect
>>
>> Tested syzbot and the reproducer did not trigger any issue.
>>
>> Reported-and-tested-by: syzbot+a93fba6d384346a761e3@syzkaller.appspotmail.com
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>>   drivers/usb/usbip/usbip_common.h |  1 +
>>   drivers/usb/usbip/vhci_hcd.c     | 55 +++++++++++++++++++++++---------
>>   drivers/usb/usbip/vhci_sysfs.c   |  4 +++
>>   3 files changed, 45 insertions(+), 15 deletions(-)
> 
>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>> index 3209b5ddd30c..c1917efe5737 100644
>> --- a/drivers/usb/usbip/vhci_hcd.c
>> +++ b/drivers/usb/usbip/vhci_hcd.c
>> @@ -1007,31 +1007,54 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
>>   static void vhci_shutdown_connection(struct usbip_device *ud)
>>   {
>>   	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
>> +	unsigned long flags;
>> +	struct socket *socket;
>> +	struct task_struct *tcp_rx = NULL;
>> +	struct task_struct *tcp_tx = NULL;
>> +	int sockfd = 0;
>> +
>> +	spin_lock_irqsave(&ud->lock, flags);
>> +	if (vdev->ud.in_disconnect) {
>> +		pr_info("%s: Disconnect in progress for sockfd %d\n",
>> +			__func__, ud->sockfd);
> 
> Looks like you forgot to remove all you debug printks like this one
> before submitting.
> 

Some printks were already in there and helped with debug. Yes I added
a few more when I submitted for syzbot testing.

I will clean them up i v2.

thanks,
-- Shuah

