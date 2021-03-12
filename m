Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 022A9338581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhCLFoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:44:22 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63749 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCLFoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:44:16 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 12C5i6ZY032644;
        Fri, 12 Mar 2021 14:44:07 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Fri, 12 Mar 2021 14:44:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 12C5i5DX032592
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Mar 2021 14:44:06 +0900 (JST)
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
Message-ID: <afd1341b-2ed1-f781-d6c8-6064fea3aeb8@i-love.sakura.ne.jp>
Date:   Fri, 12 Mar 2021 14:44:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8dc1e893-4338-90ff-ea61-de727cad1d11@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I cloned git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git as you are testing changes there.

> commit 09e4522c87ff54c655c09f318a68b012eda8eb01 (HEAD -> usbip_test, origin/usbip_test)
> Author: Shuah Khan <skhan@linuxfoundation.org>
> Date:   Thu Mar 11 11:18:25 2021 -0700
>
>    usbip: fix vhci races in connection tear down
>
>    - Change vhci_device_reset() to reset tcp_socket and sockfd.
>      if !in_disconnect

How it can happen? vhci_device_reset() can be called only after vhci_shutdown_connection()
completed, and vhci_shutdown_connection() from subsequent requests cannot be called until
vhci_device_reset() completes. I consider it as a dead code which should be removed by
my "[PATCH v4 05/12] usb: usbip: don't reset tcp_socket at vhci_device_reset()".

And what you are missing in your [PATCH 4,5,6/6] is

  diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
  index c4457026d5ad..3c64bd06ab53 100644
  --- a/drivers/usb/usbip/vhci_sysfs.c
  +++ b/drivers/usb/usbip/vhci_sysfs.c
  @@ -423,6 +423,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
          /* end the lock */
  
          wake_up_process(vdev->ud.tcp_rx);
  +       schedule_timeout_uninterruptible(HZ); // Consider being preempted here.
          wake_up_process(vdev->ud.tcp_tx);
  
          rh_port_connect(vdev, speed);

. wake_up_process(tcp_tx) can call vhci_shutdown_connection() before wake_up_process(tcp_tx) is called.
Since vhci_shutdown_connection() destroys tcp_tx thread and releases tcp_tx memory via kthread_stop_put(tcp_tx),
wake_up_process(tcp_tx) will access already freed memory. Your patch converted "NULL pointer dereference caused by
failing to call kthread_stop_put(tcp_tx)" into "use after free caused by succeeding to call kthread_stop_put(tcp_tx)".

