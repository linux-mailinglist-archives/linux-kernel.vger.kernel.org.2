Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF0531A5C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhBLUDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhBLUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:03:37 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76354C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:02:56 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id m17so438723ioy.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NXYV7LjBvAnOPedDvGO6ZWRL4gmVZGg9fzLCzgAWzpg=;
        b=Sb4Hs27xzfU81Xy9D1d6X0XUOjcq2f7VF9M0cS2YDn4w6JI6+mPUlR7M8n6Iv9RyI5
         go//Gbsuwt0tXXGFMfQje58WPuNJJnrOGZ8wQfJPO7kaSUNfWGD375tMREcZljbsJ077
         ElgOAKa2Eau7uz2mQnbPy3+j1xf5Eb9CAO+Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NXYV7LjBvAnOPedDvGO6ZWRL4gmVZGg9fzLCzgAWzpg=;
        b=kuCqmDfLsznUvVNkrdbXY4Si93kXmm3gLIO1DLr+9wBe48sCfw01tzcY2ticfUXaGw
         ARKqAl551egJ6WxDj/sPaQdN0KOnzYee66uI/wGjS+fZKFJsQdBGCneM/NJtkEmR8iKH
         2uhtMMIFuvddSBeqEmNjq6Zv+vdEk5SBYLkHmSi95+fbczqazYnzEd9gT3+kQSGPZvpH
         lrgx6VDzy4K/B4RXJnZ0f5NR0WpiuyDc4iDYz7hIaOq0aITDxxLktQAvCX9qwk39J3tc
         nxb7RyHmxvnCB5B21cW5/aJg3vuld732KctsqEmkE5BZlS3nsSs6SsAu2X2YYGPzFB2l
         k9/g==
X-Gm-Message-State: AOAM531unLMc9IQfFaLTHKKcFANm0Chnz7zEkn+yKKLRkltPQUaIBua/
        9duk0MwRg+PcRJBnS3f7JWqzjg==
X-Google-Smtp-Source: ABdhPJyEkUlPQiDqtRlq6O3G0735xGdD64HTC8x3FNGWk7f11hpwSShKILeVFBdDgiMx2LjGw4Zbww==
X-Received: by 2002:a05:6638:2047:: with SMTP id t7mr4115705jaj.134.1613160174856;
        Fri, 12 Feb 2021 12:02:54 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id d135sm4582008iog.35.2021.02.12.12.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 12:02:53 -0800 (PST)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <000000000000647eff05b3f7e0d4@google.com>
 <20201113120055.11748-1-hdanton@sina.com>
 <5f71e0c1-d387-6d72-d8e4-edb11cf57f72@linuxfoundation.org>
 <ea4028b7-53f2-aeaf-76e7-69874efcdec5@I-love.SAKURA.ne.jp>
 <2b70d360-a293-4acb-ea6c-2badda5e8b8b@linuxfoundation.org>
 <9bdd3f10-bddb-bd87-d7ad-b4b706477006@i-love.sakura.ne.jp>
 <6b8da36f-a994-7604-77f4-52e29434605f@linuxfoundation.org>
 <5f9ec159-77d8-ffba-21d1-2810e059f998@i-love.sakura.ne.jp>
 <a06093f1-22b3-7d72-bc6c-f99f4e0d0de9@linuxfoundation.org>
 <40617d66-1334-13a0-de9b-bd7cc1155ce5@i-love.sakura.ne.jp>
 <43d8d6bf-53f3-11e6-894d-c257f7f4bd07@linuxfoundation.org>
 <4368349b-fc0c-6da3-a502-2733f953d271@i-love.sakura.ne.jp>
 <92a4c6ae-172d-91cb-b89e-8eb857fdfb3a@linuxfoundation.org>
 <d177302a-3050-41db-cf44-6d614fd0c3a0@i-love.sakura.ne.jp>
 <e5cb1f77-cd4b-9d74-4f28-d613d5478704@linuxfoundation.org>
 <954bd943-8b55-36c8-9cba-a35a03213b2c@i-love.sakura.ne.jp>
 <99d7fba8-3472-3d6e-e825-9c9c115b5776@i-love.sakura.ne.jp>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <4d49e8fd-f89f-efa7-5583-a6ca2272c67a@linuxfoundation.org>
Date:   Fri, 12 Feb 2021 13:02:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <99d7fba8-3472-3d6e-e825-9c9c115b5776@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 9:58 PM, Tetsuo Handa wrote:
> On 2021/02/12 11:22, Tetsuo Handa wrote:
>> On 2021/02/12 10:34, Shuah Khan wrote:
>>> On 2/10/21 6:14 PM, Tetsuo Handa wrote:
>>>> (Dropping LSM ML because this is not a TOMOYO's bug.)
>>>>
>>>> On 2021/02/11 4:29, Shuah Khan wrote:
>>>>> This is a good find. I already replied to the thread to send a complete
>>>>> fix.
>>>>
>>>> As I said at https://lkml.kernel.org/r/f8cae6b1-8f84-0e6a-7d9c-fc4aec68f07b@i-love.sakura.ne.jp ,
>>>> the as-is patch is effectively a complete fix. And applying the as-is patch should help spending
>>>> syzbot resources for reproducing "general protection fault in tomoyo_socket_sendmsg_permission"
>>>> with debug printk() patch applied, which in turn will help you in
>>>>
>>>>> Right. I would like to get a clear understanding of how this condition
>>>>> is triggered. I am not saying this isn't a problem. Understanding how
>>>>> it is triggered helps find the best fix.
>>>>
>>>> part. Therefore, I strongly expect you to apply this version now.
>>>>
>>>
>>> Is there a reproducer for this problem?
>>
>> There is no reproducer for "general protection fault in tomoyo_socket_sendmsg_permission" problem, but
>> the race condition is explained at https://lkml.kernel.org/r/676d4518-0faa-9fab-15db-0db8d216d7fb@i-love.sakura.ne.jp .
>>
> 
> Here is a race window widening patch, and I locally reproduced "general protection fault in tomoyo_socket_sendmsg_permission".
> 
> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index 8be857a4fa13..a7c68097aa1d 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -286,6 +286,8 @@ struct usbip_device {
>   	if (!IS_ERR(__k)) {						   \
>   		get_task_struct(__k);					   \
>   		wake_up_process(__k);					   \
> +	} else {							   \
> +		__k = NULL;						   \
>   	}								   \
>   	__k;								   \
>   })
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index be37aec250c2..93e1271d0f5d 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -389,8 +389,12 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>   	/* end the lock */
>   
>   	vdev->ud.tcp_rx = kthread_get_run(vhci_rx_loop, &vdev->ud, "vhci_rx");
> -	vdev->ud.tcp_tx = kthread_get_run(vhci_tx_loop, &vdev->ud, "vhci_tx");
> +	{
> +		struct task_struct *tx = kthread_get_run(vhci_tx_loop, &vdev->ud, "vhci_tx");
>   
> +		schedule_timeout_uninterruptible(HZ);
> +		vdev->ud.tcp_tx = tx;
> +	}
>   	rh_port_connect(vdev, speed);
>   
>   	return count;
> 

Thank you. This is helpful. I will try to reproduce the problem with
this test code.

thanks,
-- Shuah
