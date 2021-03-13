Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D9D339A85
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 01:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhCMAtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 19:49:13 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62339 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhCMAtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 19:49:00 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12D0mr4I082103;
        Sat, 13 Mar 2021 09:48:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Sat, 13 Mar 2021 09:48:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12D0mrIZ082098
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 Mar 2021 09:48:53 +0900 (JST)
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
Message-ID: <192bdb07-da84-ce96-2e25-7c0df749940a@i-love.sakura.ne.jp>
Date:   Sat, 13 Mar 2021 09:48:52 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/03/12 14:44, Tetsuo Handa wrote:
> And what you are missing in your [PATCH 4,5,6/6] is
> 
>   diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
>   index c4457026d5ad..3c64bd06ab53 100644
>   --- a/drivers/usb/usbip/vhci_sysfs.c
>   +++ b/drivers/usb/usbip/vhci_sysfs.c
>   @@ -423,6 +423,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>           /* end the lock */
>   
>           wake_up_process(vdev->ud.tcp_rx);
>   +       schedule_timeout_uninterruptible(HZ); // Consider being preempted here.
>           wake_up_process(vdev->ud.tcp_tx);
>   
>           rh_port_connect(vdev, speed);
> 
> . wake_up_process(tcp_tx) can call vhci_shutdown_connection() before wake_up_process(tcp_tx) is called.

wake_up_process(tcp_rx) can call vhci_shutdown_connection() before wake_up_process(tcp_tx) is called.

> Since vhci_shutdown_connection() destroys tcp_tx thread and releases tcp_tx memory via kthread_stop_put(tcp_tx),
> wake_up_process(tcp_tx) will access already freed memory. Your patch converted "NULL pointer dereference caused by
> failing to call kthread_stop_put(tcp_tx)" into "use after free caused by succeeding to call kthread_stop_put(tcp_tx)".
> 

And note that

  diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
  index c4457026d5ad..0e1a81d4632c 100644
  --- a/drivers/usb/usbip/vhci_sysfs.c
  +++ b/drivers/usb/usbip/vhci_sysfs.c
  @@ -422,11 +422,11 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
          spin_unlock_irqrestore(&vhci->lock, flags);
          /* end the lock */
  
  -       wake_up_process(vdev->ud.tcp_rx);
  -       wake_up_process(vdev->ud.tcp_tx);
  -
          rh_port_connect(vdev, speed);
  
  +       wake_up_process(vdev->ud.tcp_tx);
  +       wake_up_process(vdev->ud.tcp_rx);
  +
          return count;
   }
   static DEVICE_ATTR_WO(attach);

is as well not sufficient, for you are still missing

  diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
  index c4457026d5ad..c958f89a9196 100644
  --- a/drivers/usb/usbip/vhci_sysfs.c
  +++ b/drivers/usb/usbip/vhci_sysfs.c
  @@ -422,11 +422,13 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
          spin_unlock_irqrestore(&vhci->lock, flags);
          /* end the lock */
  
  -       wake_up_process(vdev->ud.tcp_rx);
  -       wake_up_process(vdev->ud.tcp_tx);
  +       schedule_timeout_uninterruptible(HZ); // Consider being preempted here.
  
          rh_port_connect(vdev, speed);
  
  +       wake_up_process(vdev->ud.tcp_tx);
  +       wake_up_process(vdev->ud.tcp_rx);
  +
          return count;
   }
   static DEVICE_ATTR_WO(attach);

because vhci_port_disconnect() from detach_store() can call usbip_event_add(&vdev->ud, VDEV_EVENT_DOWN)
(same use after free bug regarding tcp_tx and tcp_rx) as soon as all shared states are set up and
spinlocks are released.

What you had better consider first is how to protect event_handler()/usbip_sockfd_store()/attach_store()/detach_store() functions
 from concurrent calls. Please respond to https://lkml.kernel.org/r/3dab66dc-2981-bc88-a370-4b3178dfd390@i-love.sakura.ne.jp
before you try to make further changes.

