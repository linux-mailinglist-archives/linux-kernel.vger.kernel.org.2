Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3038E34CC6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhC2JCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:02:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14177 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhC2IiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 04:38:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F85WM5YzzzmbFw;
        Mon, 29 Mar 2021 16:35:43 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:38:11 +0800
Subject: Re: [RFC PATCH] USB:ohci:fix ohci interruption problem
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <tanxiaofei@huawei.com>, <liudongdong3@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1616748896-9415-1-git-send-email-liulongfang@huawei.com>
 <20210326152821.GA832251@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <e8d6fb1c-5a9b-426a-4844-add67aac768f@huawei.com>
Date:   Mon, 29 Mar 2021 16:38:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210326152821.GA832251@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/26 23:28, Alan Stern wrote:
> On Fri, Mar 26, 2021 at 04:54:56PM +0800, Longfang Liu wrote:
>> When OHCI enters the S4 sleep state, the USB sleep process will call
>> check_root_hub_suspend() and ohci_bus_suspend() instead of
>> ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
>> to not be closed.
> 
> What on earth are you talking about?  This isn't true at all.
> 
> Can you provide more information about your system?  Are you using a 
> PCI-based OHCI controller or a platform device (and if so, which one)?  
> Can you post system logs to back up your statements?
> The system is UOS, the kernel version is kernel4.19, and the driver
used is ohci-pci.c based on PCI.

By adding the log in ohci_suspend, and then viewing the dmesg after sleep,
I can confirm that the system does not call ohci_suspend in S4 sleep mode.

The operating method of the system entering S4 sleep mode:
echo disk > /sys/power/state

The operating method of the system entering S3 sleep mode:
echo mem > /sys/power/state

> The proper order of calls is ohci_bus_suspend, then 
> check_root_hub_suspended, then ohci_suspend.  Often the first one is 
> called some time before the other two.
> 
In order to eliminate the impact of the kernel version difference, I tested
the S4 sleep mode and S3 sleep mode again on CentorOS + kernel 5.10,
and the log is as follows, from the comparison of the two logs below,
ohci_suspend is called in S3 sleep mode, but it is not called in S4 sleep mode.

The log of the process that the system enters the S4 sleep state and then wakes up:
[root@localhost power]# echo disk > state
[  830.420877] PM: hibernation: hibernation entry
[  830.432867] Filesystems sync: 0.002 seconds
[  830.437069] Freezing user space processes ... (elapsed 0.004 seconds) done.
[  830.448224] OOM killer disabled.
[  830.478507] PM: hibernation: Preallocating image memory
[  846.853709] PM: hibernation: Allocated 3393843 pages for snapshot
[  846.859795] PM: hibernation: Allocated 13575372 kbytes in 16.36 seconds (829.79 MB/s)
[  846.867600] Freezing remaining freezable tasks ... (elapsed 0.106 seconds) done.
[  846.983667] printk: Suspending console(s) (use no_console_suspend to debug)
...
[  852.972918] PM: hibernation: debug: Waiting for 5 seconds.
[  870.518511] ohci-pci 0000:7a:00.0: [LLF] ohci_resume enter OK!
[  870.518520] usb usb3: root hub lost power or was reset
[  870.518532] CPU: 7 PID: 22239 Comm: kworker/u257:14 Kdump: loaded Tainted: G           O      5.10.0-rc4+ #3
[  870.518539] usb usb4: root hub lost power or was reset
[  870.518571] Workqueue: events_unbound async_run_entry_fn
[  870.518583] Call trace:
[  870.518593]  dump_backtrace+0x0/0x1e0
[  870.518602]  show_stack+0x2c/0x48
[  870.518616]  dump_stack+0xcc/0x104
[  870.518628]  ohci_resume+0x50/0x1a0
[  870.518641]  resume_common+0xa0/0x120
[  870.518653]  hcd_pci_restore+0x24/0x30
[  870.518661] usb usb1: root hub lost power or was reset
[  870.518672]  pci_pm_restore+0x64/0xb0
[  870.518686]  dpm_run_callback+0x4c/0x230
[  870.518696]  device_resume+0xdc/0x1c8
[  870.518707]  async_resume+0x30/0x60
[  870.518714]  async_run_entry_fn+0x4c/0x118
[  870.518722]  process_one_work+0x1f0/0x4a0
[  870.518730]  worker_thread+0x48/0x460
[  870.518739]  kthread+0x160/0x168
[  870.518747]  ret_from_fork+0x10/0x18
...
[  873.544050] OOM killer enabled.
[  873.547190] Restarting tasks ... done.
[  873.557365] PM: hibernation: hibernation exit

The log of the process that the system enters the S3 sleep state and then wakes up
[root@localhost power]# echo mem > state
[ 1217.524876] PM: suspend entry (deep)
[ 1217.529798] Filesystems sync: 0.001 seconds
[ 1217.538676] Freezing user space processes ... (elapsed 0.004 seconds) done.
[ 1217.550158] OOM killer disabled.
[ 1217.553401] Freezing remaining freezable tasks ... (elapsed 0.069 seconds) done.
[ 1217.630565] printk: Suspending console(s) (use no_console_suspend to debug)
...
[ 1217.728377] ohci-pci 0000:7a:00.0: [LLF] ohci_suspend enter OK!
[ 1217.728384] CPU: 17 PID: 22400 Comm: kworker/u257:21 Kdump: loaded Tainted: G           O      5.10.0-rc4+ #3
[ 1217.728399] Workqueue: events_unbound async_run_entry_fn
[ 1217.728403] Call trace:
[ 1217.728407]  dump_backtrace+0x0/0x1e0
[ 1217.728409]  show_stack+0x2c/0x48
[ 1217.728416]  dump_stack+0xcc/0x104
[ 1217.728422]  ohci_suspend+0x38/0xd8
[ 1217.728429]  suspend_common+0xe0/0x160
[ 1217.728431]  hcd_pci_suspend+0x38/0x48
[ 1217.728435]  pci_pm_suspend+0x98/0x1d0
[ 1217.728445]  dpm_run_callback+0x4c/0x230
[ 1217.728447]  __device_suspend+0x108/0x4d8
[ 1217.728448]  async_suspend+0x34/0xb8
[ 1217.728450]  async_run_entry_fn+0x4c/0x118
[ 1217.728452]  process_one_work+0x1f0/0x4a0
[ 1217.728453]  worker_thread+0x48/0x460
[ 1217.728458]  kthread+0x160/0x168
[ 1217.728463]  ret_from_fork+0x10/0x18
...
[ 1223.696839] PM: suspend debug: Waiting for 5 second(s).
[ 1228.748466] ohci-pci 0000:7a:00.0: [LLF] ohci_resume enter OK!
[ 1228.748469] CPU: 17 PID: 22400 Comm: kworker/u257:21 Kdump: loaded Tainted: G           O      5.10.0-rc4+ #3
[ 1228.748474] Workqueue: events_unbound async_run_entry_fn
[ 1228.748475] Call trace:
[ 1228.748477]  dump_backtrace+0x0/0x1e0
[ 1228.748478]  show_stack+0x2c/0x48
[ 1228.748481]  dump_stack+0xcc/0x104
[ 1228.748483]  ohci_resume+0x50/0x1a0
[ 1228.748486]  resume_common+0xa0/0x120
[ 1228.748488]  hcd_pci_resume+0x24/0x30
[ 1228.748491]  pci_pm_resume+0x64/0xb0
[ 1228.748493]  dpm_run_callback+0x4c/0x230
[ 1228.748496] hns3 0000:7d:00.2: Start to resume
[ 1228.748498]  device_resume+0xdc/0x1c8
[ 1228.748501]  async_resume+0x30/0x60
[ 1228.748503] hns3 0000:7d:00.3: Start to resume
[ 1228.748505] hns3 0000:7d:00.2: In reset process RoCE client uninit.
[ 1228.748506]  async_run_entry_fn+0x4c/0x118
[ 1228.748508]  process_one_work+0x1f0/0x4a0
[ 1228.748509]  worker_thread+0x48/0x460
[ 1228.748511]  kthread+0x160/0x168
[ 1228.748513]  ret_from_fork+0x10/0x18
...
[ 1231.823014] OOM killer enabled.
[ 1231.826156] Restarting tasks ... done.
[ 1231.836001] PM: suspend exit


>> At this time, if just one device interrupt is reported. Since rh_state
>> has been changed to OHCI_RH_SUSPENDED after ohci_bus_suspend(), the
>> driver will not process and close this device interrupt. It will cause
>> the entire system to be stuck during sleep, causing the device to
>> fail to respond.
>>
>> When the abnormal interruption reaches 100,000 times, the system will
>> forcibly close the interruption and make the device unusable.
>>
>> Since the problem is that the interrupt is not closed, we copied the
>> interrupt shutdown operation of ohci_suspend() into ohci_bus_suspend()
>> during the S4 sleep period. We found that this method can solve this
>> problem.
>>
>> At present, we hope to be able to call ohci_suspend() directly during
>> the sleep process of S4. Do you have any suggestions for this
>> modification?
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/host/ohci-hub.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
>> index 634f3c7..d468cef 100644
>> --- a/drivers/usb/host/ohci-hub.c
>> +++ b/drivers/usb/host/ohci-hub.c
>> @@ -315,6 +315,14 @@ static int ohci_bus_suspend (struct usb_hcd *hcd)
>>  		del_timer_sync(&ohci->io_watchdog);
>>  		ohci->prev_frame_no = IO_WATCHDOG_OFF;
>>  	}
>> +
>> +	spin_lock_irqsave(&ohci->lock, flags);
>> +	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
>> +	(void)ohci_readl(ohci, &ohci->regs->intrdisable);
>> +
>> +	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
>> +	spin_unlock_irqrestore(&ohci->lock, flags);
> 
> This is completely wrong.  The hardware certainly remains accessible 
> when the root hub stops running.  The HW_ACCESSIBLE flag should not be 
> cleared here.
> 
> And if the Master Interrupt Enable bit is cleared, how will the driver 
> ever learn if a remote wakeup request (such as a plug or unplug event) 
> occurs?
> 
> Alan Stern
> 
This modification method is only a temporary verification method.
The normal modification method we hope is to enable ohci_suspend()
in the sleep process of S4 mode.
Thanks,
Longfang.
>> +
>>  	return rc;
>>  }
>>  
>> @@ -326,7 +334,10 @@ static int ohci_bus_resume (struct usb_hcd *hcd)
>>  	if (time_before (jiffies, ohci->next_statechange))
>>  		msleep(5);
>>  
>> -	spin_lock_irq (&ohci->lock);
>> +	spin_lock_irq(&ohci->lock);
>> +	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
>> +	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
>> +	ohci_readl(ohci, &ohci->regs->intrenable);
>>  
>>  	if (unlikely(!HCD_HW_ACCESSIBLE(hcd)))
>>  		rc = -ESHUTDOWN;
>> -- 
>> 2.8.1
>>
> .
> 
