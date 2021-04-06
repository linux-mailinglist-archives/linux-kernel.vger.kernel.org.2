Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5CF3554B6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbhDFNM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:12:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15614 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbhDFNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:12:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FF7Dq1PJrz19L6S;
        Tue,  6 Apr 2021 21:10:35 +0800 (CST)
Received: from [10.67.102.118] (10.67.102.118) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 6 Apr 2021 21:12:39 +0800
Subject: Re: [PATCH] USB:ohci:fix ohci interruption problem
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kong.kongxinwei@hisilicon.com>, <yisen.zhuang@huawei.com>
References: <1617355679-9417-1-git-send-email-liulongfang@huawei.com>
 <20210402152655.GC1095271@rowland.harvard.edu>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <df7d8692-9c6e-3bb1-2b41-924df36469ce@huawei.com>
Date:   Tue, 6 Apr 2021 21:12:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210402152655.GC1095271@rowland.harvard.edu>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.118]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 2021/4/2 23:26, Alan Stern Ð´µÀ:
> On Fri, Apr 02, 2021 at 05:27:59PM +0800, Longfang Liu wrote:
>> The operating method of the system entering S4 sleep mode:
>> echo disk > /sys/power/state
> 
> This discussion is still not right.
> 
The operating method is:
echo reboot > /sys/power/disk
echo disk > /sys/power/state

>> When OHCI enters the S4 sleep state,
> 
> To start with, you should be talking about hibernation (also known as 
> suspend-to-disk), not S4.  When the system enters hibernation -- for 
> example, when you write "disk" to /sys/power/state -- the controller may 
> go into S4 or it may go into some other power-saving state.
> 
>>  the USB sleep process will call
>> check_root_hub_suspend() and ohci_bus_suspend() instead of
>> ohci_suspend() and ohci_bus_suspend(), this causes the OHCI interrupt
>> to not be closed.
> 
> This isn't true.  The procedure _does_ call ohci_suspend, through the 
> .poweroff callback in hcd-pci.c.  That callback goes to the 
> hcd_pci_suspend routine, which calls suspend_common and then 
> ohci_suspend.
> 
> However, these calls happen after the kernel image has be written to the 
> storage area on the disk.  As a result, any log messages produced during 
> the calls do not get saved, so they don't get reloaded when the system 
> resumes from hibernation, and they aren't present in the log after the 
> system wakes up.  That's why they didn't appear in the log you included 
> in an earlier email.  The only way to observe them is to use a remote > console, such as a network console.
>After adding dump_stack to ohci_suspend, do hibernation test,
.poweroff is not called, but .freeze is called, and these logs are
presented in dmesg:
[root@localhost power]# echo reboot > disk
[root@localhost power]# echo disk > state
[ 1883.631163] PM: hibernation: hibernation entry
[ 1883.701199] Filesystems sync: 0.058 seconds
[ 1883.705443] Freezing user space processes ... (elapsed 0.004 seconds) done.
[ 1883.717094] OOM killer disabled.
[ 1883.730258] PM: hibernation: Preallocating image memory
[ 1889.162453] PM: hibernation: Allocated 1020044 pages for snapshot
[ 1889.168564] PM: hibernation: Allocated 4080176 kbytes in 5.42 seconds (752.80 MB/s)
[ 1889.176215] Freezing remaining freezable tasks ... (elapsed 0.099 seconds) done.
[ 1889.285477] printk: Suspending console(s) (use no_console_suspend to debug)
...
[ 1889.325720] Call trace:
[ 1889.325734]  dump_backtrace+0x0/0x1e0
[ 1889.325742]  show_stack+0x2c/0x48
[ 1889.325766]  dump_stack+0xcc/0x104
[ 1889.325789]  ohci_suspend+0x38/0xd8 [ohci_hcd]
[ 1889.325823]  suspend_common+0xe0/0x160
[ 1889.325835]  hcd_pci_freeze+0x38/0x48
[ 1889.325853]  pci_pm_freeze+0x68/0x110
[ 1889.325881]  dpm_run_callback+0x4c/0x230
[ 1889.325891]  __device_suspend+0x108/0x4d8
[ 1889.325900]  async_suspend+0x34/0xb8
[ 1889.325907]  async_run_entry_fn+0x4c/0x118
[ 1889.325919]  process_one_work+0x1f0/0x4a0
[ 1889.325926]  worker_thread+0x48/0x460
[ 1889.325936]  kthread+0x160/0x168
[ 1889.325947]  ret_from_fork+0x10/0x18
...
[ 1895.297836] Call trace:
[ 1895.297846]  dump_backtrace+0x0/0x1e0
[ 1895.297880]  show_stack+0x2c/0x48
[ 1895.297925]  dump_stack+0xcc/0x104
[ 1895.297973] usb usb3: root hub lost power or was reset
[ 1895.297997]  ohci_resume+0x50/0x1a0 [ohci_hcd]
[ 1895.298057]  resume_common+0xa0/0x120
[ 1895.298071]  hcd_pci_restore+0x24/0x30
[ 1895.298084]  pci_pm_restore+0x64/0xb0
[ 1895.298101]  dpm_run_callback+0x4c/0x230
[ 1895.298113]  device_resume+0xdc/0x1c8
[ 1895.298125]  async_resume+0x30/0x60
[ 1895.298132]  async_run_entry_fn+0x4c/0x118
[ 1895.298141]  process_one_work+0x1f0/0x4a0
[ 1895.298148]  worker_thread+0x48/0x460
[ 1895.298159]  kthread+0x160/0x168
[ 1895.298171]  ret_from_fork+0x10/0x18
...
[ 1900.939779] OOM killer enabled.
[ 1900.942930] Restarting tasks ... done.
[ 1900.962630] PM: hibernation: hibernation exit

> In fact, that's pretty much the only way to debug problems that occur 
> during a hibernation transition.
> 
>> At this time, if just one device interrupt is reported. Since rh_state
>> has been changed to OHCI_RH_SUSPENDED after ohci_bus_suspend(), the
>> driver will not process and close this device interrupt.
> 
> That's not true either.  The ohci_irq routine does indeed process 
> interrupts even when rh_state is set to OHCI_RH_SUSPENDED.  How else 
> could it handle a device's wakeup request?
> 
>> It will cause
>> the entire system to be stuck during sleep, causing the device to
>> fail to respond.
> 
> During hibernation, the system is powered off.  Obviously the kernel is 
> not capable of handling interrupts at this time.
> 
> Also, why would a device interrupt be reported at this time?  What 
> causes the interrupt request?
> 
>> When the abnormal interruption reaches 100,000 times, the system will
>> forcibly close the interruption and make the device unusable.
>>
>> Because the root cause of the problem is that ohci_suspend is not
>> called to perform normal interrupt shutdown operations when the system
>> enters S4 sleep mode.
>>
>> Therefore, our solution is to specify freeze interface in this mode to
>> perform normal suspend_common() operations, and call ohci_suspend()
>> after check_root_hub_suspend() is executed through the suspend_common()
>> operation.
> 
> No.  The freeze interface does not need to power-down the controller.  
> All it needs to do is make sure that no communication between the 
> computer and the attached USB devices takes place, and this is handled 
> by ohci_bus_suspend.
> 
> Furthermore, it is a mistake for the freeze routine to change anything 
> unless the thaw routine reverses the change.  Your patch leaves the thaw 
> callback pointer set to NULL.
> 
>> After using this solution, it is verified by the stress test of sleep
>> wake up in S4 mode for a long time that this problem no longer occurs.
> 
> Something else must be happeneing, something you don't understand.
> 
> Alan Stern
> 
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/usb/core/hcd-pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
>> index 1547aa6..c5844a3 100644
>> --- a/drivers/usb/core/hcd-pci.c
>> +++ b/drivers/usb/core/hcd-pci.c
>> @@ -509,6 +509,11 @@ static int resume_common(struct device *dev, int event)
>>  
>>  #ifdef	CONFIG_PM_SLEEP
>>  
>> +static int hcd_pci_freeze(struct device *dev)
>> +{
>> +	return suspend_common(dev, device_may_wakeup(dev));
>> +}
>> +
>>  static int hcd_pci_suspend(struct device *dev)
>>  {
>>  	return suspend_common(dev, device_may_wakeup(dev));
>> @@ -605,7 +610,7 @@ const struct dev_pm_ops usb_hcd_pci_pm_ops = {
>>  	.suspend_noirq	= hcd_pci_suspend_noirq,
>>  	.resume_noirq	= hcd_pci_resume_noirq,
>>  	.resume		= hcd_pci_resume,
>> -	.freeze		= check_root_hub_suspended,
>> +	.freeze		= hcd_pci_freeze,
>>  	.freeze_noirq	= check_root_hub_suspended,
>>  	.thaw_noirq	= NULL,
>>  	.thaw		= NULL,
>> -- 
>> 2.8.1
>>
> .
> 
Thanks,
Longfang.
