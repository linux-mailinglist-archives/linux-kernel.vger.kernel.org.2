Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B781A319963
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBLE7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:59:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56096 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhBLE65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:58:57 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 11C4wAZA035076;
        Fri, 12 Feb 2021 13:58:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Fri, 12 Feb 2021 13:58:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 11C4w91Z035071
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 12 Feb 2021 13:58:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: general protection fault in tomoyo_socket_sendmsg_permission
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+95ce4b142579611ef0a9@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com
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
Message-ID: <99d7fba8-3472-3d6e-e825-9c9c115b5776@i-love.sakura.ne.jp>
Date:   Fri, 12 Feb 2021 13:58:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <954bd943-8b55-36c8-9cba-a35a03213b2c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/02/12 11:22, Tetsuo Handa wrote:
> On 2021/02/12 10:34, Shuah Khan wrote:
>> On 2/10/21 6:14 PM, Tetsuo Handa wrote:
>>> (Dropping LSM ML because this is not a TOMOYO's bug.)
>>>
>>> On 2021/02/11 4:29, Shuah Khan wrote:
>>>> This is a good find. I already replied to the thread to send a complete
>>>> fix.
>>>
>>> As I said at https://lkml.kernel.org/r/f8cae6b1-8f84-0e6a-7d9c-fc4aec68f07b@i-love.sakura.ne.jp ,
>>> the as-is patch is effectively a complete fix. And applying the as-is patch should help spending
>>> syzbot resources for reproducing "general protection fault in tomoyo_socket_sendmsg_permission"
>>> with debug printk() patch applied, which in turn will help you in
>>>
>>>> Right. I would like to get a clear understanding of how this condition
>>>> is triggered. I am not saying this isn't a problem. Understanding how
>>>> it is triggered helps find the best fix.
>>>
>>> part. Therefore, I strongly expect you to apply this version now.
>>>
>>
>> Is there a reproducer for this problem?
> 
> There is no reproducer for "general protection fault in tomoyo_socket_sendmsg_permission" problem, but
> the race condition is explained at https://lkml.kernel.org/r/676d4518-0faa-9fab-15db-0db8d216d7fb@i-love.sakura.ne.jp .
> 

Here is a race window widening patch, and I locally reproduced "general protection fault in tomoyo_socket_sendmsg_permission".

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 8be857a4fa13..a7c68097aa1d 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -286,6 +286,8 @@ struct usbip_device {
 	if (!IS_ERR(__k)) {						   \
 		get_task_struct(__k);					   \
 		wake_up_process(__k);					   \
+	} else {							   \
+		__k = NULL;						   \
 	}								   \
 	__k;								   \
 })
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index be37aec250c2..93e1271d0f5d 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -389,8 +389,12 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	/* end the lock */
 
 	vdev->ud.tcp_rx = kthread_get_run(vhci_rx_loop, &vdev->ud, "vhci_rx");
-	vdev->ud.tcp_tx = kthread_get_run(vhci_tx_loop, &vdev->ud, "vhci_tx");
+	{
+		struct task_struct *tx = kthread_get_run(vhci_tx_loop, &vdev->ud, "vhci_tx");
 
+		schedule_timeout_uninterruptible(HZ);
+		vdev->ud.tcp_tx = tx;
+	}
 	rh_port_connect(vdev, speed);
 
 	return count;


[  134.880383][ T7879] vhci_hcd vhci_hcd.0: pdev(2) rhport(0) sockfd(6)
[  134.883465][ T7879] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  134.904750][   T74] vhci_hcd: vhci_device speed not set
[  134.933053][ T7873] vhci_hcd: connection closed
[  134.933212][ T7870] vhci_hcd: connection closed
[  134.933415][ T4488] vhci_hcd: stop threads
[  134.942970][ T4488] vhci_hcd: release socket
[  134.944949][   T14] vhci_hcd: vhci_device speed not set
[  134.947063][ T4488] vhci_hcd: disconnect device
[  134.951508][ T4488] vhci_hcd: stop threads
[  134.953861][ T4488] vhci_hcd: release socket
[  134.957113][ T4488] vhci_hcd: disconnect device
[  135.014433][   T56] usb 15-1: enqueue for inactive port 0
[  135.065119][ T7877] vhci_hcd: connection closed
[  135.065205][ T7880] vhci_hcd: connection closed
[  135.065370][ T4480] vhci_hcd: stop threads
[  135.072854][ T4480] vhci_hcd: release socket
[  135.076490][ T4480] vhci_hcd: disconnect device
[  135.079535][ T4480] vhci_hcd: stop threads
[  135.084024][ T4480] vhci_hcd: release socket
[  135.087979][ T4480] vhci_hcd: disconnect device
[  135.134526][ T6820] vhci_hcd: vhci_device speed not set
[  135.314959][ T6821] vhci_hcd: vhci_device speed not set
[  135.621271][ T7884] vhci_hcd vhci_hcd.0: pdev(4) rhport(0) sockfd(3)
[  135.621290][ T7885] vhci_hcd vhci_hcd.0: pdev(0) rhport(0) sockfd(3)
[  135.625072][ T7884] vhci_hcd vhci_hcd.0: devid(0) speed(5) speed_str(super-speed)
[  135.628665][ T7885] vhci_hcd vhci_hcd.0: devid(0) speed(5) speed_str(super-speed)
[  135.630109][ T7887] vhci_hcd vhci_hcd.0: pdev(1) rhport(0) sockfd(3)
[  135.630116][ T7887] vhci_hcd vhci_hcd.0: devid(0) speed(5) speed_str(super-speed)
[  135.672834][ T7895] vhci_hcd vhci_hcd.0: pdev(0) rhport(0) sockfd(6)
[  135.672863][ T7894] vhci_hcd vhci_hcd.0: pdev(4) rhport(0) sockfd(6)
[  135.675986][ T7895] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  135.678963][ T7894] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  135.681093][ T7896] vhci_hcd vhci_hcd.0: pdev(1) rhport(0) sockfd(6)
[  135.681100][ T7896] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  135.710416][ T7904] vhci_hcd vhci_hcd.0: pdev(5) rhport(0) sockfd(3)
[  135.713445][ T7904] vhci_hcd vhci_hcd.0: devid(0) speed(5) speed_str(super-speed)
[  135.761360][ T7907] vhci_hcd vhci_hcd.0: pdev(5) rhport(0) sockfd(6)
[  135.764612][ T7907] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  135.780607][ T7911] vhci_hcd vhci_hcd.0: pdev(3) rhport(0) sockfd(3)
[  135.783674][ T7911] vhci_hcd vhci_hcd.0: devid(0) speed(5) speed_str(super-speed)
[  135.832151][ T7914] vhci_hcd vhci_hcd.0: pdev(3) rhport(0) sockfd(6)
[  135.835065][ T6821] vhci_hcd: vhci_device speed not set
[  135.835457][ T7914] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  135.855511][   T14] vhci_hcd: vhci_device speed not set
[  135.873043][ T7892] vhci_hcd: connection closed
[  135.873092][ T7899] vhci_hcd: connection closed
[  135.873331][ T4482] vhci_hcd: stop threads
[  135.876115][ T7897] vhci_hcd: connection closed
[  135.876272][ T7888] vhci_hcd: connection closed
[  135.878623][ T7890] vhci_hcd: connection closed
[  135.878927][ T7901] vhci_hcd: connection closed
[  135.878971][ T4482] vhci_hcd: release socket
[  135.878999][ T4482] vhci_hcd: disconnect device
[  135.879077][ T4482] vhci_hcd: stop threads
[  135.879084][ T4482] vhci_hcd: release socket
[  135.879104][ T4482] vhci_hcd: disconnect device
[  135.879262][ T4482] vhci_hcd: stop threads
[  135.904625][ T6821] usb 14-1: new full-speed USB device number 5 using vhci_hcd
[  135.905231][ T4482] vhci_hcd: release socket
[  135.907733][ T7902] vhci_hcd: sendmsg failed!, ret=-32 for 48
[  135.910718][ T4482] vhci_hcd: disconnect device
[  135.924520][ T4482] vhci_hcd: stop threads
[  135.924602][   T14] usb 6-1: new full-speed USB device number 4 using vhci_hcd
[  135.927400][ T4482] vhci_hcd: release socket
[  135.927444][ T4482] vhci_hcd: disconnect device
[  135.927612][ T4482] vhci_hcd: stop threads
[  135.927616][ T4482] vhci_hcd: release socket
[  135.927637][ T4482] vhci_hcd: disconnect device
[  135.927783][ T4482] vhci_hcd: stop threads
[  135.931827][   T14] usb 6-1: enqueue for inactive port 0
[  135.931837][   T14] usb 6-1: enqueue for inactive port 0
[  135.931844][   T14] usb 6-1: enqueue for inactive port 0
[  135.949977][ T7918] vhci_hcd vhci_hcd.0: pdev(2) rhport(0) sockfd(3)
[  135.950493][ T4482] vhci_hcd: release socket
[  135.953289][ T7918] vhci_hcd vhci_hcd.0: devid(0) speed(5) speed_str(super-speed)
[  135.956713][ T4482] vhci_hcd: disconnect device
[  135.962382][ T7908] vhci_hcd: connection closed
[  135.962570][ T7905] vhci_hcd: connection closed
[  135.963301][ T4482] vhci_hcd: stop threads
[  135.963305][ T4482] vhci_hcd: release socket
[  135.963329][ T4482] vhci_hcd: disconnect device
[  135.964679][   T66] usb 17-1: enqueue for inactive port 0
[  135.967048][ T4488] vhci_hcd: stop threads
[  135.967055][ T4488] vhci_hcd: release socket
[  135.996537][ T4488] vhci_hcd: disconnect device
[  136.001837][ T7921] vhci_hcd vhci_hcd.0: pdev(2) rhport(0) sockfd(6)
[  136.005729][ T7921] vhci_hcd vhci_hcd.0: devid(0) speed(2) speed_str(full-speed)
[  136.009523][   T14] vhci_hcd: vhci_device speed not set
[  136.033302][ T7912] vhci_hcd: connection closed
[  136.033417][ T7915] vhci_hcd: connection closed
[  136.041456][ T4479] vhci_hcd: stop threads
[  136.053100][ T4479] vhci_hcd: release socket
[  136.057791][ T4479] vhci_hcd: disconnect device
[  136.061453][ T4479] vhci_hcd: stop threads
[  136.064363][ T4479] vhci_hcd: release socket
[  136.067801][ T4479] vhci_hcd: disconnect device
[  136.193586][ T7922] vhci_hcd: connection closed
[  136.193753][ T7919] vhci_hcd: connection closed
[  136.193834][ T4479] vhci_hcd: stop threads
[  136.194633][ T6805] usb 11-1: SetAddress Request (6) to port 0
[  136.194650][ T6805] usb 11-1: new SuperSpeed Gen 1 USB device number 6 using vhci_hcd
[  136.209426][ T4479] vhci_hcd: release socket
[  136.211891][ T4479] vhci_hcd: disconnect device
[  136.214638][ T4479] vhci_hcd: stop threads
[  136.214638][   T66] usb 17-1: enqueue for inactive port 0
[  136.220796][ T4479] vhci_hcd: release socket
[  136.223414][ T4479] vhci_hcd: disconnect device
[  136.226214][ T7920] BUG: kernel NULL pointer dereference, address: 0000000000000018
[  136.229703][ T7920] #PF: supervisor read access in kernel mode
[  136.250275][ T7920] #PF: error_code(0x0000) - not-present page
[  136.254738][ T7920] PGD 0 P4D 0
[  136.258410][ T7920] Oops: 0000 [#1] PREEMPT SMP
[  136.263059][ T7920] CPU: 5 PID: 7920 Comm: vhci_tx Not tainted 5.11.0-rc7+ #8
[  136.269087][ T7920] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 02/27/2020
[  136.278990][ T7920] RIP: 0010:tomoyo_socket_sendmsg_permission+0x2b/0x120
[  136.283875][ T7920] Code: 48 89 e5 41 57 49 89 f7 41 56 41 55 41 54 53 48 89 fb 48 83 ec 38 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 85 7a 5e ff <4c> 8b 73 18 45 0f b6 66 10 41 80 fc 02 77 32 45 84 e4 75 36 45 31
[  136.297600][ T7920] RSP: 0018:ffffc9001425fc60 EFLAGS: 00010293
[  136.302027][ T7920] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  136.306816][ T7920] RDX: ffff8881305ee280 RSI: ffffffff81d7fe1b RDI: 0000000000000000
[  136.311669][ T7920] RBP: ffffc9001425fcc0 R08: 0000000000000030 R09: 0000000000000000
[  136.315802][ T7920] R10: ffff88813432eb80 R11: 0000000000000000 R12: 0000000000000000
[  136.320276][ T7920] R13: ffffc9001425fdd0 R14: 0000000000000030 R15: ffffc9001425fdd0
[  136.324546][ T7920] FS:  0000000000000000(0000) GS:ffff888236f40000(0000) knlGS:0000000000000000
[  136.329094][ T7920] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  136.333203][ T7920] CR2: 0000000000000018 CR3: 0000000129054005 CR4: 00000000003706e0
[  136.337599][ T7920] Call Trace:
[  136.340429][ T7920]  ? __this_cpu_preempt_check+0x1d/0x30
[  136.344165][ T7920]  tomoyo_socket_sendmsg+0x26/0x30
[  136.347801][ T7920]  security_socket_sendmsg+0x40/0x70
[  136.351378][ T7920]  sock_sendmsg+0x26/0xd0
[  136.354702][ T7920]  kernel_sendmsg+0x44/0x50
[  136.358078][ T7920]  vhci_send_cmd_submit+0x269/0x520
[  136.361674][ T7920]  ? _raw_spin_unlock_irqrestore+0x5a/0x70
[  136.365796][ T7920]  vhci_tx_loop+0x52/0x180
[  136.369274][ T7920]  ? finish_wait+0x90/0x90
[  136.372657][ T7920]  kthread+0x18d/0x1c0
[  136.376299][ T7920]  ? vhci_send_cmd_unlink+0x220/0x220
[  136.380052][ T7920]  ? kthread_insert_work_sanity_check+0x90/0x90
[  136.384729][ T7920]  ret_from_fork+0x22/0x30
[  136.388347][ T7920] Modules linked in:
[  136.391571][ T7920] CR2: 0000000000000018
[  136.394835][ T7920] ---[ end trace 66ee501d798fb2fa ]---
[  136.398442][ T7920] RIP: 0010:tomoyo_socket_sendmsg_permission+0x2b/0x120
[  136.403062][ T7920] Code: 48 89 e5 41 57 49 89 f7 41 56 41 55 41 54 53 48 89 fb 48 83 ec 38 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 e8 85 7a 5e ff <4c> 8b 73 18 45 0f b6 66 10 41 80 fc 02 77 32 45 84 e4 75 36 45 31
[  136.415061][ T2899] usb 9-1: device descriptor read/8, error -110
[  136.415245][ T7920] RSP: 0018:ffffc9001425fc60 EFLAGS: 00010293
[  136.422520][ T7920] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  136.426912][ T7920] RDX: ffff8881305ee280 RSI: ffffffff81d7fe1b RDI: 0000000000000000
[  136.431943][ T7920] RBP: ffffc9001425fcc0 R08: 0000000000000030 R09: 0000000000000000
[  136.434304][   T66] kobject: '17-1' (000000000e8a79ee): kobject_cleanup, parent 0000000000000000
[  136.436148][ T7920] R10: ffff88813432eb80 R11: 0000000000000000 R12: 0000000000000000
[  136.436153][ T7920] R13: ffffc9001425fdd0 R14: 0000000000000030 R15: ffffc9001425fdd0
[  136.436157][ T7920] FS:  0000000000000000(0000) GS:ffff888236f40000(0000) knlGS:0000000000000000
[  136.436161][ T7920] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  136.436165][ T7920] CR2: 0000000000000018 CR3: 0000000129054005 CR4: 00000000003706e0
[  136.436189][ T7920] Kernel panic - not syncing: Fatal exception
[  137.608838][ T7920] Shutting down cpus with NMI
[  149.797229][ T7920] Kernel Offset: disabled
[  149.800911][ T7920] Rebooting in 86400 seconds..
