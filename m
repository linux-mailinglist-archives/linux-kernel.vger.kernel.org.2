Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CCA330AE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbhCHKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:11:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63457 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhCHKKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:10:48 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 128AAf1l043839;
        Mon, 8 Mar 2021 19:10:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Mon, 08 Mar 2021 19:10:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 128AAf81043833
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Mar 2021 19:10:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 4/6] usbip: fix stub_dev usbip_sockfd_store() races
 leading to gpf
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        valentina.manea.m@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1615171203.git.skhan@linuxfoundation.org>
 <268a0668144d5ff36ec7d87fdfa90faf583b7ccc.1615171203.git.skhan@linuxfoundation.org>
 <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
Message-ID: <5df3d221-9e78-4cbe-826b-81cbfc4d5888@i-love.sakura.ne.jp>
Date:   Mon, 8 Mar 2021 19:10:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <05aed75a-4a81-ef59-fc4f-6007f18e7839@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/08 16:35, Tetsuo Handa wrote:
> On 2021/03/08 12:53, Shuah Khan wrote:
>> Fix the above problems:
>> - Stop using kthread_get_run() macro to create/start threads.
>> - Create threads and get task struct reference.
>> - Add kthread_create() failure handling and bail out.
>> - Hold usbip_device lock to update local and shared states after
>>   creating rx and tx threads.
>> - Update usbip_device status to SDEV_ST_USED.
>> - Update usbip_device tcp_socket, sockfd, tcp_rx, and tcp_tx
>> - Start threads after usbip_device (tcp_socket, sockfd, tcp_rx, tcp_tx,
>>   and status) is complete.
> 
> No, the whole usbip_sockfd_store() etc. should be serialized using a mutex,
> for two different threads can open same file and write the same content at
> the same moment. This results in seeing SDEV_ST_AVAILABLE and creating two
> threads and overwiting global variables and setting SDEV_ST_USED and starting
> two threads by each of two thread, which will later fail to call kthread_stop()
> on one of two thread because global variables are overwritten.
> 
> kthread_crate() (which involves GFP_KERNEL allocation) can take long time
> enough to hit
> 
>   usbip_sockfd_store() must perform
> 
>       if (sdev->ud.status != SDEV_ST_AVAILABLE) {

Oops. This is

	if (sdev->ud.status == SDEV_ST_AVAILABLE) {

of course.

>         /* misc assignments for attach operation */
>         sdev->ud.status = SDEV_ST_USED;
>       }
> 
>   under a lock, or multiple ud->tcp_{tx,rx} are created (which will later
>   cause a crash like [1]) and refcount on ud->tcp_socket is leaked when
>   usbip_sockfd_store() is concurrently called.
> 
> problem. That's why my patch introduced usbip_event_mutex lock.
> 

And I think that same serialization is required between "rh_port_connect() from attach_store()" and
"rh_port_disconnect() from vhci_shutdown_connection() via usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN)
 from vhci_port_disconnect() from detach_store()", for both vhci_rx_pdu() from vhci_rx_loop() and
vhci_port_disconnect() from detach_store() can queue VDEV_EVENT_DOWN event which can be processed
without waiting for attach_store() to complete.
