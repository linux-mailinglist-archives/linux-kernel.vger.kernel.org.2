Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B8D332A48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCIPWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhCIPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:22:10 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C2EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:22:10 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id x10so3131171oor.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoPQVAsO1/BRWQi43DglY9jwq7xcpyNkrO9LH7otNqI=;
        b=KAKFia4hzKePc8UqdDn3dmtVS0e7iUN+b186Sq6q5mDQat7Y++4d9kevhDvMnUBptJ
         xIUwfRuG6i75+UR4mvlLzcknPZKaTtvzNltRynsnNw4DGdniaB9tKXBC3Szp41ts1xPM
         tFHuQniceQfgtPec69BXvT9tW0TBkeldxwuHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoPQVAsO1/BRWQi43DglY9jwq7xcpyNkrO9LH7otNqI=;
        b=X7ozGYmYBE6ISBgls6zn45j92t4dXXbAe8y/lu1sBGYT8jSdgkQjgjmBKdyuYa1tgh
         GfJQE64b5xOdOiJdH7H3F6MxUshrqw5puUXQiHONleDFtyNbfRC7+dm8gQA8xAVDHQiK
         mySW4dn1qI65iexlA1Kd4NieezfbFnDWS5cnApL/NCGKigzlHdBGi9xHdOQ6UaxI0OVu
         feNl/TdXmijiCq3xF/4VpALvCx4SG08GNaKayPvGUb+vC/hIc5EBhdRwRTRezXO8T0Hn
         oyVUDE7fc7g4Su9bLyrUxLsnXlwgF8/H2liZY+wmBvWbZtFrmG2iXVFxzbe7/VaeFqsg
         juaQ==
X-Gm-Message-State: AOAM533W/zYqn9W6rJqmYGHPwzUzN60UKUr27cm7f6pXKeh6rGPyS1b+
        VgtnFQL5VLnYXjMlys6e2kYTfg==
X-Google-Smtp-Source: ABdhPJw8homz7geYVFxGqPxohdWt9Rf3oNCuI49U55qoeHKW1BOctm1PX3t6wZS/BBFZXjhpowmTZg==
X-Received: by 2002:a4a:d88a:: with SMTP id b10mr22435740oov.29.1615303329581;
        Tue, 09 Mar 2021 07:22:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z8sm2165142otp.14.2021.03.09.07.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 07:22:09 -0800 (PST)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
 <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
 <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3d5c78b3-36cd-065f-4a55-728d6210a25d@linuxfoundation.org>
Date:   Tue, 9 Mar 2021 08:22:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3305d1a1-12e2-087b-30f5-10f4bf8eaf83@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/21 9:27 AM, Shuah Khan wrote:
> On 3/8/21 3:10 AM, Tetsuo Handa wrote:
>> On 2021/03/08 16:35, Tetsuo Handa wrote:
>>> On 2021/03/08 12:53, Shuah Khan wrote:
>>>> Fix the above problems:
>>>> - Stop using kthread_get_run() macro to create/start threads.
>>>> - Create threads and get task struct reference.
>>>> - Add kthread_create() failure handling and bail out.
>>>> - Hold usbip_device lock to update local and shared states after
>>>>    creating rx and tx threads.
>>>> - Update usbip_device status to SDEV_ST_USED.
>>>> - Update usbip_device tcp_socket, sockfd, tcp_rx, and tcp_tx
>>>> - Start threads after usbip_device (tcp_socket, sockfd, tcp_rx, tcp_tx,
>>>>    and status) is complete.
>>>
>>> No, the whole usbip_sockfd_store() etc. should be serialized using a 
>>> mutex,
>>> for two different threads can open same file and write the same 
>>> content at
>>> the same moment. This results in seeing SDEV_ST_AVAILABLE and 
>>> creating two
>>> threads and overwiting global variables and setting SDEV_ST_USED and 
>>> starting
>>> two threads by each of two thread, which will later fail to call 
>>> kthread_stop()
>>> on one of two thread because global variables are overwritten.
>>>
>>> kthread_crate() (which involves GFP_KERNEL allocation) can take long 
>>> time
>>> enough to hit
>>>
>>>    usbip_sockfd_store() must perform
>>>
>>>        if (sdev->ud.status != SDEV_ST_AVAILABLE) {
>>
>> Oops. This is
>>
>>     if (sdev->ud.status == SDEV_ST_AVAILABLE) {
>>
>> of course.
>>
>>>          /* misc assignments for attach operation */
>>>          sdev->ud.status = SDEV_ST_USED;
>>>        }
>>>
>>>    under a lock, or multiple ud->tcp_{tx,rx} are created (which will 
>>> later
>>>    cause a crash like [1]) and refcount on ud->tcp_socket is leaked when
>>>    usbip_sockfd_store() is concurrently called.
>>>
>>> problem. That's why my patch introduced usbip_event_mutex lock.
>>>
>>
>> And I think that same serialization is required between 
>> "rh_port_connect() from attach_store()" and
>> "rh_port_disconnect() from vhci_shutdown_connection() via 
>> usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN)
>>   from vhci_port_disconnect() from detach_store()", for both 
>> vhci_rx_pdu() from vhci_rx_loop() and
>> vhci_port_disconnect() from detach_store() can queue VDEV_EVENT_DOWN 
>> event which can be processed
>> without waiting for attach_store() to complete.
>>
> 
> Yes. We might need synchronization between events, threads, and shutdown
> in usbip_host side and in connection polling and threads in vhci.
> 
> I am also looking at the shutdown sequences closely as well since the
> local state is referenced without usbip_device lock in these paths.
> 
> I am approaching these problems as peeling the onion an expression so
> we can limit the changes and take a spot fix approach. We have the
> goal to address these crashes and not introduce regressions.
> 
> I don't seem to be able to reproduce these problems consistently in my
> env. with the reproducer. I couldn't reproduce them in normal case at
> all. Hence, the this cautious approach that reduces the chance of
> regressions and if we see regressions, they can fixed easily.
> 
> https://syzkaller.appspot.com/text?tag=ReproC&x=14801034d00000
> 
> If this patch series fixes the problems you are seeing, I would like
> get these fixes in and address the other two potential race conditions
> in another round of patches. I also want to soak these in the next
> for a few weeks.
> 
> Please let me know if these patches fix the problems you are seeing in 
> your env.
> 

Can you verify these patches in your environment and see if you are
seeing any problems? I want to first see where we are with these
fixes.

thanks,
-- Shuah
