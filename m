Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E533A3DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFKIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:05:16 -0400
Received: from first.geanix.com ([116.203.34.67]:60614 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFKIFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:05:15 -0400
Received: from [192.168.100.10] (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id C80E246261A;
        Fri, 11 Jun 2021 08:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1623398595; bh=jlWW/C3JE54PVdquTldghsLZrbd70NGMHdD2G+9nIfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RGyp0HVNtjb2EEk7qKdqFvIue9IfR3gPWhbYRAAsc+N0TBNBeL4IxgToOCmBD7yFA
         1n+9atV6VImN1N2QCpH9HIfF1Y1z1WOZun+sB+n5QFXEM99dZd3STj7FOPtEcvzSEa
         pR7MKAqRk5lfBRugGaCUmTBzPH18l7762gXoDT0yvzY5vhExFAWEJY3i97Qch28G7W
         IR4IOG8BJiELG+3L+vyb1VN4yOxLj9qND4SIA8hVTVwHpHHUER8M0UMej13doe9bFE
         ZY8cmVEO4E4jxphmR/yftfhT/4Gf8/2dppSU03GjyPlIiKyeEaNCgvC6CUXDf0l0GV
         IEAyWVV6IEhEg==
Subject: Re: [PATCH] clk: fix possible circular locking in
 clk_notifier_register()
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210610071758.1560592-1-sean@geanix.com>
 <162335987382.9598.2377065226236202544@swboyd.mtv.corp.google.com>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <697130dd-df27-78e2-1eab-5db47e78f3b0@geanix.com>
Date:   Fri, 11 Jun 2021 10:03:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <162335987382.9598.2377065226236202544@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        URIBL_BLOCKED autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/2021 23.17, Stephen Boyd wrote:

> Quoting Sean Nyekjaer (2021-06-10 00:17:57)

>> Allocating memory with prepare_lock mutex held makes lockdep unhappy

>> when memory pressure makes the system do fs_reclaim on eg. rawnand using

>> clk.

>>

>> Push the allocation outside the lock.

>>

>> [  462.466020] ======================================================

>> [  462.472211] WARNING: possible circular locking dependency detected

>> [  462.478406] 4.19.128-00489-gffc0949c2231 #2 Not tainted

> 

> 4.19 is quite old. Is it happening in mainline? I suppose so given that

> the allocation is still under the prepare lock?


I'm not able to reproduce on 5.10, as the oom killer is quite a lot smarter and

kills my reproducer application...



> 

>> [  462.483641] ------------------------------------------------------

>> [  462.489831] kswapd0/22 is trying to acquire lock:

>> [  462.494553] 882c9532 (&c->commit_sem){++++}, at: make_reservation+0x68/0x41c


[...]


>> [  462.959322]  #0: 11f3c233 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48

> 

> Please consider removing the timestamps on the log. Otherwise I will do

> it myself next time.


Sure will do, they are quite noisy...


> 

>>

>> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

>> ---

>>  drivers/clk/clk.c | 17 ++++++++++-------

>>  1 file changed, 10 insertions(+), 7 deletions(-)

>>

>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c

>> index 65508eb89ec9..c32b71b08ccb 100644

>> --- a/drivers/clk/clk.c

>> +++ b/drivers/clk/clk.c

>> @@ -4340,17 +4340,20 @@ int clk_notifier_register(struct clk *clk, struct notifier_block *nb)

>>         if (!clk || !nb)

>>                 return -EINVAL;

>>  

>> +       /* allocate new clk_notifier */

>> +       cn = kzalloc(sizeof(*cn), GFP_KERNEL);

>> +       if (!cn)

>> +               goto out;

>> +

>>         clk_prepare_lock();

>>  

>>         /* search the list of notifiers for this clk */

>>         list_for_each_entry(cn, &clk_notifier_list, node)

> 

> Isn't this going to overwrite 'cn'?


Yes :(



> 

>> -               if (cn->clk == clk)

>> +               if (cn->clk == clk) {

>> +                       /* if clk is in the notifier list, free new clk_notifier */

>> +                       kfree(cn);

> 

> Ideally we also kfree() outside the lock.


Ok.



> 

>>                         goto found;

>> -

>> -       /* if clk wasn't in the notifier list, allocate new clk_notifier */

>> -       cn = kzalloc(sizeof(*cn), GFP_KERNEL);



[...]



>>  }

>>  EXPORT_SYMBOL_GPL(clk_notifier_register);

>>

> 

> How about this totally untested patch?

> 

[...]

Yes it's also a fix, but i catches another circular dep :(


======================================================


WARNING: possible circular locking dependency detected


4.19.128-00489-gffc0949c2231-dirty #5 Not tainted


------------------------------------------------------


kswapd0/22 is trying to acquire lock:


cf8513b3 (&c->commit_sem){++++}, at: make_reservation+0x68/0x41c





but task is already holding lock:


0a27c3f4 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48


       


which lock already depends on the new lock.


       


the existing dependency chain (in reverse order) is:


       


-> #5 (fs_reclaim){+.+.}:


       fs_reclaim_acquire+0x78/0x88


       __kmalloc+0x48/0x31c


       pcpu_mem_zalloc+0x34/0x8c


       pcpu_create_chunk+0x20/0x270


       pcpu_balance_workfn+0x5dc/0x74c


       process_one_work+0x2a4/0x744


       worker_thread+0x5c/0x554


       kthread+0x120/0x160


       ret_from_fork+0x14/0x20


         (null)


       


-> #4 (pcpu_alloc_mutex){+.+.}:


       __mutex_lock+0x60/0x8dc


       mutex_lock_killable_nested+0x24/0x30


       pcpu_alloc+0x404/0x854


       __alloc_percpu+0x18/0x20


       init_srcu_struct_fields+0x3e4/0x460


       __init_srcu_struct+0x50/0x5c


       srcu_init_notifier_head+0x2c/0x54


       clk_notifier_register+0xd0/0x130


       i2c_imx_probe+0x23c/0x678


       platform_drv_probe+0x50/0xa0


       really_probe+0x2b8/0x3d8


       driver_probe_device+0x64/0x16c


       __driver_attach+0x120/0x144


       bus_for_each_dev+0x7c/0xc4


       driver_attach+0x20/0x28


       bus_add_driver+0x174/0x208


       driver_register+0x90/0x120


       __platform_driver_register+0x38/0x4c


       i2c_adap_imx_init+0x18/0x20


       do_one_initcall+0x8c/0x32c


       kernel_init_freeable+0x300/0x3e4


       kernel_init+0x10/0x114


       ret_from_fork+0x14/0x20


         (null)


       


-> #3 (prepare_lock){+.+.}:


       __mutex_lock+0x60/0x8dc


       mutex_lock_nested+0x24/0x2c


       clk_prepare_lock+0x44/0xec


       clk_prepare+0x20/0x38


       __gpmi_enable_clk+0x34/0xb8


       gpmi_enable_clk+0x14/0x18


       gpmi_select_chip+0x4c/0xa4


       nand_read_oob+0xa0/0x7b8


       part_read_oob+0x40/0x78


       mtd_read+0x10c/0x13c


       ubi_io_read+0xc8/0x354


       ubi_eba_read_leb+0xc8/0x544


       ubi_eba_read_leb_sg+0x70/0x170


       ubi_leb_read_sg+0x7c/0xbc


       ubiblock_do_work+0xcc/0x118


       process_one_work+0x2a4/0x744


       worker_thread+0x5c/0x554


       kthread+0x120/0x160


       ret_from_fork+0x14/0x20


         (null)


       


-> #2 (&le->mutex){++++}:


       down_read+0x3c/0x80


       ubi_eba_read_leb+0x4c/0x544


       ubi_leb_read+0x7c/0xbc


       ubifs_leb_read+0x34/0x80


       ubifs_read_nnode+0x194/0x208


       ubifs_lpt_lookup_dirty+0x1e0/0x294


       ubifs_replay_journal+0x48/0x15a8


       ubifs_mount+0x104c/0x15f0


       mount_fs+0x1c/0xb8


       vfs_kern_mount.part.0+0x58/0x148


       do_mount+0x6a4/0xec8


       ksys_mount+0x90/0xbc


       sys_mount+0x1c/0x24


       ret_fast_syscall+0x0/0x28


       0xbee78b38


       


-> #1 (&c->lp_mutex){+.+.}:


       __mutex_lock+0x60/0x8dc


       mutex_lock_nested+0x24/0x2c


       ubifs_gc_start_commit+0x28/0x32c


       do_commit+0x1cc/0x7e4


       ubifs_run_commit+0x98/0xd0


       grab_empty_leb+0x60/0x98


       ubifs_rcvry_gc_commit+0x10c/0x1d8


       ubifs_mount+0x1308/0x15f0


       mount_fs+0x1c/0xb8


       vfs_kern_mount.part.0+0x58/0x148


       do_mount+0x6a4/0xec8


       ksys_mount+0x90/0xbc


       sys_mount+0x1c/0x24


       ret_fast_syscall+0x0/0x28


       0xbee78b38





-> #0 (&c->commit_sem){++++}:


       lock_acquire+0xd4/0x1f8


       down_read+0x3c/0x80


       make_reservation+0x68/0x41c


       ubifs_jnl_write_data+0x134/0x2b8


       do_writepage+0x88/0x210


       ubifs_writepage+0x1b8/0x274


       shrink_page_list+0x800/0xf68


       shrink_inactive_list+0x1b4/0x4f0


       shrink_node+0x44c/0x9c0


       kswapd+0x3f8/0x928


       kthread+0x120/0x160


       ret_from_fork+0x14/0x20


         (null)





other info that might help us debug this:





Chain exists of:


  &c->commit_sem --> pcpu_alloc_mutex --> fs_reclaim





 Possible unsafe locking scenario:





       CPU0                    CPU1


       ----                    ----


  lock(fs_reclaim);     


                               lock(pcpu_alloc_mutex);


                               lock(fs_reclaim);


  lock(&c->commit_sem); 





 *** DEADLOCK ***





1 lock held by kswapd0/22:


 #0: 0a27c3f4 (fs_reclaim){+.+.}, at: __fs_reclaim_acquire+0x0/0x48
