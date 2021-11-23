Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135CE45A229
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbhKWMHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:07:04 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:61282 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbhKWMHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:07:03 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211123120353euoutp01d9645b32ab3230ca0bab8cf13f60918d~6K09C3AN92129521295euoutp01m
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:03:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211123120353euoutp01d9645b32ab3230ca0bab8cf13f60918d~6K09C3AN92129521295euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637669033;
        bh=FS7Slezhj1R8TEUsdbg0azhal0PFMkqE6G9eQc1jI4k=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=g1n/C41azKpHo48lUAjgsGZRR5N7L5OVo9o1BgDvoosdNtoot4uGnHIk/zB2LKX3y
         VaWVyyVtju6o8PIR4VdVQFF7zpX3oKZtDGsW3QJriTfW9NxkCtZPRRzS2/bNRtxxHr
         8LU2yDxmMOdlW2Qe9cnagadnsk6GYhqpJDgmG7Cg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211123120353eucas1p10a8f9f95c59a654067dd0e1786ac98e4~6K08sR6TL0659206592eucas1p19;
        Tue, 23 Nov 2021 12:03:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3A.DA.09887.9A8DC916; Tue, 23
        Nov 2021 12:03:53 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c~6K08MfZDn1866518665eucas1p2n;
        Tue, 23 Nov 2021 12:03:53 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211123120353eusmtrp1020f1964b2297cf03c206ff0bd38de42~6K08Lv2302784527845eusmtrp1K;
        Tue, 23 Nov 2021 12:03:53 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-f9-619cd8a9afe1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C1.5A.09404.8A8DC916; Tue, 23
        Nov 2021 12:03:52 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211123120352eusmtip285bc8509fd0abb8c167e09c3f8d67776~6K07qNeJ02501925019eusmtip2-;
        Tue, 23 Nov 2021 12:03:52 +0000 (GMT)
Message-ID: <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
Date:   Tue, 23 Nov 2021 13:03:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211102110204.3334609-4-sean@geanix.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRj123t37y02txX7lTzaoQhJMXZkmho7XIOhMSMT0ZWrGrXWbuXZ
        iBLWGimj2opi84jKlEiMsmjV1ubZLKMxPbx2rGp2x0xeafd69N/5znfOnPP95kdioiq+F5kg
        T2aVciZRInDFbzYNts+5Yi5iAtuzvaVXM/OQ1NjawpM+ry8SSO8cukhIHxy5x5fm3v6MpH0t
        FoF0qK2fCCPps9f20XWdOkRrTFaCri4/JqBrdAfoV2d30gbzLR5tq568hoxyXbyVTUxIZZVz
        Q2Nc4zO65Ipn+Wh3kbUFT0f2PWrkQgI1H/Ql+UiNXEkRdRlBve6NgBvsCPqGDJhDJaJsCD4Z
        Q/46Gk0FGCe6hOCu5hTBiQYQ1HUscGAhFQq2niwnj1PT4UzXdx7Hu0NzQS/uwOOpLWA8nOMM
        GEdFwsWOR06MUWJ43XvOqfeg1sGHwjaeIwyj3iFItzXxHQsBNQ/UVrXAgV2ohVBj7Rdw5imQ
        UVvobAeUnYTKhiHE1ZZB44feP3gcWAw3CA57gzFXg3OGDARdpgqCGzQInh/K/+MIgTemb8MR
        5HDETKiqn8vR4dBXV8V30EC5gdnqzpVwg5ybeRhHC+FolohT+4LWUPkv9v6TZ1g2kmhHvIt2
        xP3aEedo/+eWILwcidkUVVIcqwqSs7sCVEySKkUeFxC7I6kaDf8p4y+DvQ5dsgwE6BGPRHoE
        JCbxEHboChmRcCuzZy+r3LFZmZLIqvRoIolLxEKPH+mMiIpjktntLKtglX+3PNLFK513MrbM
        96mXQlgeUtL5rmYgfHutp2STLNg8GDJGX0hborTfWpfmqlcX86N7y7J8FTNW4gkR9NsjqbVh
        CrXOM+zlmElKezP+MXBJflz9rFWLV2Cymk27iS+zIuIDJvgUh2t/nc4+9ji69OSAT8zlqcTY
        9qDSno0m29IDy+ykXhz90112PHPG6FRPN9TtHfgwuKEt7e36u2nY7NAo5mtBcinv4MxuU8f1
        q4/5Gv+s/bEepxAz2Lrt5fsNqeb+E5l52QdNi6Y1+aV1+6UVR55XRtSOTqbKKvybj/uOujC/
        831m8MqxT6ewFvApf/Fo3+egB/zlnpE5skQD0SOWxfhVrdV3J0hwVTwzzx9Tqpjfkrlg8MID
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7orbsxJNJi1zdJidct0RovTZ04x
        WVzeNYfNYnfTMnaLw+37WC0m73zDaPH+1Cs2i/9nP7A7cHjMW1PtsePuEkaPnnNv2T02repk
        89i8pN7j5rxCj+M3tjN5fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJfR/DCv4NIMxoo5b0+xNDB+qexi5OSQEDCROHBuJnMXIxeHkMBS
        RokT256yQCRkJE5Oa2CFsIUl/lzrYoMoes8o8ev6SUaQBK+AncTnx23sIDaLgKrEtIe/mSDi
        ghInZz4BGyQqkCTR/30XM4gtLBAucXMXRA2zgLjErSfzwWwRgTCJef0gc7iA4k8ZJbZPvwy2
        QEggWeLivfdsIDabgKFE19suMJtTwFxi89sPbBCDzCS6tnYxQtjyEs1bZzNPYBSaheSOWUj2
        zULSMgtJywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBkbnt2M8tOxhXvvqod4iRiYPx
        EKMEB7OSCO+1JbMThXhTEiurUovy44tKc1KLDzGaAgNjIrOUaHI+MDXklcQbmhmYGpqYWRqY
        WpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwbe0KD16x8DGTp24bi83VZf85JKYZLXw/
        oTDvt3LxnSaLYNPkPIGJlSvSz0wRdPf96ZZxPOzD4rUXfrxK3/uoj1HvpuUrOd9Pyw37zPjm
        pDdGrJ0jOD/whzVbw9anR33trplGrfv0VZQ/Zr3RLu2KDdI+SZZXG7YvPda93/zx3BYB/WDD
        li0XVvk6aolHNb15/unlpoCZ38+4yITOit9y6X8Oy4m8k5NqrEtW/TqqFCjSz7q+bGLYhOqC
        VQELuo7whgQdnlHMMHPbbN9FmwKzGQ4cDCmOeGi5/OumHzdVNcX/x51+reC1heOn5IWCza9u
        Te4JVI757FL462tLaDBfnIv7zgN904rsvHWP3ou3VGIpzkg01GIuKk4EAKEhfG1VAwAA
X-CMS-MailID: 20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c
References: <20211102110204.3334609-1-sean@geanix.com>
        <20211102110204.3334609-4-sean@geanix.com>
        <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02.11.2021 12:02, Sean Nyekjaer wrote:
> Prevent MTD access while in a suspended state. Also
> prevent suspending a device which is still currently in use.
>
> Commit 013e6292aaf5 ("mtd: rawnand: Simplify the locking") allows the
> rawnand layer to return errors rather than waiting in a blocking wait.
>
> Tested on a iMX6ULL.
>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

This patch landed recently in linux-next as commit 9d6abd489e70 ("mtd: 
core: protect access to MTD devices while in suspend"). I found that it 
triggers the following warning on my test systems:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 1606 Comm: reboot Not tainted 5.16.0-rc1+ #4165
Hardware name: linux,dummy-virt (DT)
Call trace:
  dump_backtrace+0x0/0x1ac
  show_stack+0x18/0x24
  dump_stack_lvl+0x8c/0xb8
  dump_stack+0x18/0x34
  register_lock_class+0x4a0/0x4cc
  __lock_acquire+0x78/0x20cc
  lock_acquire.part.0+0xe0/0x230
  lock_acquire+0x68/0x84
  down_write+0x64/0xe0
  physmap_flash_shutdown+0x60/0x140
  platform_shutdown+0x28/0x40
  device_shutdown+0x160/0x340
  __do_sys_reboot+0x1f8/0x2a0
  __arm64_sys_reboot+0x28/0x34
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0x60/0x11c
  do_el0_svc_compat+0x1c/0x50
  el0_svc_compat+0x4c/0x100
  el0t_32_sync_handler+0x90/0x140
  el0t_32_sync+0x1a4/0x1a8
Flash device refused suspend due to active operation (state 20)
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x1, magic = 0x0, owner 
= 0xffff588b4547c740, curr 0xffff588b4547c740, list not empty
WARNING: CPU: 1 PID: 1606 at kernel/locking/rwsem.c:1322 
up_write+0x144/0x1a0
Modules linked in: bluetooth ecdh_generic ecc rfkill ipv6
CPU: 1 PID: 1606 Comm: reboot Not tainted 5.16.0-rc1+ #4165
Hardware name: linux,dummy-virt (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : up_write+0x144/0x1a0
lr : up_write+0x144/0x1a0
sp : ffff8000109ebbd0
x29: ffff8000109ebbd0 x28: ffff588b4547c740 x27: 0000000000000000
x26: ffffce0238d56470 x25: 0000000000000008 x24: ffffce0239bba030
x23: ffff588b451938b0 x22: 0000000000000000 x21: ffff588b44046c80
x20: ffffce02397a2000 x19: ffff588b451938b0 x18: 0000000000000030
x17: 0000000000000000 x16: 0000000000000000 x15: ffffffffffffffff
x14: 0000000000000005 x13: ffffce02397c5198 x12: 0000000000000390
x11: 0000000000000130 x10: ffffce023981d198 x9 : 00000000fffff000
x8 : ffffce02397c5198 x7 : ffffce023981d198 x6 : 0000000000000000
x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff588b4547c740
Call trace:
  up_write+0x144/0x1a0
  physmap_flash_shutdown+0x13c/0x140
  platform_shutdown+0x28/0x40
  device_shutdown+0x160/0x340
  __do_sys_reboot+0x1f8/0x2a0
  __arm64_sys_reboot+0x28/0x34
  invoke_syscall+0x48/0x114
  el0_svc_common.constprop.0+0x60/0x11c
  do_el0_svc_compat+0x1c/0x50
  el0_svc_compat+0x4c/0x100
  el0t_32_sync_handler+0x90/0x140
  el0t_32_sync+0x1a4/0x1a8
irq event stamp: 2541
hardirqs last  enabled at (2541): [<ffffce02382d94c8>] 
_raw_spin_unlock_irq+0x44/0x90
hardirqs last disabled at (2540): [<ffffce02382d98cc>] 
_raw_spin_lock_irq+0xac/0xb0
softirqs last  enabled at (2278): [<ffffce0237210470>] _stext+0x470/0x5e8
softirqs last disabled at (2273): [<ffffce023729d904>] 
__irq_exit_rcu+0x180/0x1ac
---[ end trace d06160a193b668c2 ]---
Flash device refused suspend due to active operation (state 20)


Reverting $subject patch on top of linux-next hides the warning. The 
above log has been gathered on QEMU/arm64 'virt' machine, during the 
reboot operation. If you need more information how to reproduce it, let 
me know.


> ---
>   drivers/mtd/mtdcore.c   | 115 +++++++++++++++++++++++++++++++++++-----
>   include/linux/mtd/mtd.h |  81 +++++++++++++++++++++++-----
>   2 files changed, 169 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 153229198947..f02b602b3fa9 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -777,6 +777,8 @@ static void mtd_set_dev_defaults(struct mtd_info *mtd)
>   	INIT_LIST_HEAD(&mtd->partitions);
>   	mutex_init(&mtd->master.partitions_lock);
>   	mutex_init(&mtd->master.chrdev_lock);
> +	init_waitqueue_head(&mtd->master.resume_wq);
> +	init_rwsem(&mtd->master.suspend_lock);
>   }
>   
>   static ssize_t mtd_otp_size(struct mtd_info *mtd, bool is_user)
> @@ -1267,7 +1269,9 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>   
>   	adjinstr.addr += mst_ofs;
>   
> +	mtd_start_access(master);
>   	ret = master->_erase(master, &adjinstr);
> +	mtd_end_access(master);
>   
>   	if (adjinstr.fail_addr != MTD_FAIL_ADDR_UNKNOWN) {
>   		instr->fail_addr = adjinstr.fail_addr - mst_ofs;
> @@ -1289,6 +1293,7 @@ int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
>   	      void **virt, resource_size_t *phys)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	*retlen = 0;
>   	*virt = NULL;
> @@ -1301,8 +1306,12 @@ int mtd_point(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
>   	if (!len)
>   		return 0;
>   
> +	mtd_start_access(master);
>   	from = mtd_get_master_ofs(mtd, from);
> -	return master->_point(master, from, len, retlen, virt, phys);
> +	ret = master->_point(master, from, len, retlen, virt, phys);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_point);
>   
> @@ -1310,6 +1319,7 @@ EXPORT_SYMBOL_GPL(mtd_point);
>   int mtd_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_unpoint)
>   		return -EOPNOTSUPP;
> @@ -1317,7 +1327,12 @@ int mtd_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
>   		return -EINVAL;
>   	if (!len)
>   		return 0;
> -	return master->_unpoint(master, mtd_get_master_ofs(mtd, from), len);
> +
> +	mtd_start_access(master);
> +	ret =  master->_unpoint(master, mtd_get_master_ofs(mtd, from), len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_unpoint);
>   
> @@ -1372,6 +1387,7 @@ int mtd_read(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
>   	};
>   	int ret;
>   
> +	/* mtd_read_oob_std handles mtd access protection */
>   	ret = mtd_read_oob(mtd, from, &ops);
>   	*retlen = ops.retlen;
>   
> @@ -1388,6 +1404,7 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
>   	};
>   	int ret;
>   
> +	/* mtd_write_oob_std handles mtd access protection */
>   	ret = mtd_write_oob(mtd, to, &ops);
>   	*retlen = ops.retlen;
>   
> @@ -1464,11 +1481,13 @@ static int mtd_read_oob_std(struct mtd_info *mtd, loff_t from,
>   	int ret;
>   
>   	from = mtd_get_master_ofs(mtd, from);
> +	mtd_start_access(master);
>   	if (master->_read_oob)
>   		ret = master->_read_oob(master, from, ops);
>   	else
>   		ret = master->_read(master, from, ops->len, &ops->retlen,
>   				    ops->datbuf);
> +	mtd_end_access(master);
>   
>   	return ret;
>   }
> @@ -1480,11 +1499,13 @@ static int mtd_write_oob_std(struct mtd_info *mtd, loff_t to,
>   	int ret;
>   
>   	to = mtd_get_master_ofs(mtd, to);
> +	mtd_start_access(master);
>   	if (master->_write_oob)
>   		ret = master->_write_oob(master, to, ops);
>   	else
>   		ret = master->_write(master, to, ops->len, &ops->retlen,
>   				     ops->datbuf);
> +	mtd_end_access(master);
>   
>   	return ret;
>   }
> @@ -1992,12 +2013,18 @@ int mtd_get_fact_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
>   			   struct otp_info *buf)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_get_fact_prot_info)
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> -	return master->_get_fact_prot_info(master, len, retlen, buf);
> +
> +	mtd_start_access(master);
> +	ret = master->_get_fact_prot_info(master, len, retlen, buf);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_get_fact_prot_info);
>   
> @@ -2005,13 +2032,19 @@ int mtd_read_fact_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
>   			   size_t *retlen, u_char *buf)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	*retlen = 0;
>   	if (!master->_read_fact_prot_reg)
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> -	return master->_read_fact_prot_reg(master, from, len, retlen, buf);
> +
> +	mtd_start_access(master);
> +	ret = master->_read_fact_prot_reg(master, from, len, retlen, buf);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_read_fact_prot_reg);
>   
> @@ -2019,12 +2052,18 @@ int mtd_get_user_prot_info(struct mtd_info *mtd, size_t len, size_t *retlen,
>   			   struct otp_info *buf)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_get_user_prot_info)
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> -	return master->_get_user_prot_info(master, len, retlen, buf);
> +
> +	mtd_start_access(master);
> +	ret =  master->_get_user_prot_info(master, len, retlen, buf);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_get_user_prot_info);
>   
> @@ -2032,13 +2071,19 @@ int mtd_read_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len,
>   			   size_t *retlen, u_char *buf)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	*retlen = 0;
>   	if (!master->_read_user_prot_reg)
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> -	return master->_read_user_prot_reg(master, from, len, retlen, buf);
> +
> +	mtd_start_access(master);
> +	ret = master->_read_user_prot_reg(master, from, len, retlen, buf);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_read_user_prot_reg);
>   
> @@ -2053,7 +2098,11 @@ int mtd_write_user_prot_reg(struct mtd_info *mtd, loff_t to, size_t len,
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> +
> +	mtd_start_access(master);
>   	ret = master->_write_user_prot_reg(master, to, len, retlen, buf);
> +	mtd_end_access(master);
> +
>   	if (ret)
>   		return ret;
>   
> @@ -2068,24 +2117,36 @@ EXPORT_SYMBOL_GPL(mtd_write_user_prot_reg);
>   int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_lock_user_prot_reg)
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> -	return master->_lock_user_prot_reg(master, from, len);
> +
> +	mtd_start_access(master);
> +	ret = master->_lock_user_prot_reg(master, from, len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_lock_user_prot_reg);
>   
>   int mtd_erase_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_erase_user_prot_reg)
>   		return -EOPNOTSUPP;
>   	if (!len)
>   		return 0;
> -	return master->_erase_user_prot_reg(master, from, len);
> +
> +	mtd_start_access(master);
> +	ret = master->_erase_user_prot_reg(master, from, len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
>   
> @@ -2093,6 +2154,7 @@ EXPORT_SYMBOL_GPL(mtd_erase_user_prot_reg);
>   int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_lock)
>   		return -EOPNOTSUPP;
> @@ -2106,13 +2168,18 @@ int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
>   	}
>   
> -	return master->_lock(master, mtd_get_master_ofs(mtd, ofs), len);
> +	mtd_start_access(master);
> +	ret = master->_lock(master, mtd_get_master_ofs(mtd, ofs), len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_lock);
>   
>   int mtd_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_unlock)
>   		return -EOPNOTSUPP;
> @@ -2126,13 +2193,18 @@ int mtd_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
>   	}
>   
> -	return master->_unlock(master, mtd_get_master_ofs(mtd, ofs), len);
> +	mtd_start_access(master);
> +	ret = master->_unlock(master, mtd_get_master_ofs(mtd, ofs), len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_unlock);
>   
>   int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_is_locked)
>   		return -EOPNOTSUPP;
> @@ -2146,13 +2218,18 @@ int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>   		len = (u64)mtd_div_by_eb(len, mtd) * master->erasesize;
>   	}
>   
> -	return master->_is_locked(master, mtd_get_master_ofs(mtd, ofs), len);
> +	mtd_start_access(master);
> +	ret = master->_is_locked(master, mtd_get_master_ofs(mtd, ofs), len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_is_locked);
>   
>   int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (ofs < 0 || ofs >= mtd->size)
>   		return -EINVAL;
> @@ -2162,13 +2239,18 @@ int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs)
>   	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>   		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>   
> -	return master->_block_isreserved(master, mtd_get_master_ofs(mtd, ofs));
> +	mtd_start_access(master);
> +	ret = master->_block_isreserved(master, mtd_get_master_ofs(mtd, ofs));
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_block_isreserved);
>   
>   int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (ofs < 0 || ofs >= mtd->size)
>   		return -EINVAL;
> @@ -2178,7 +2260,11 @@ int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs)
>   	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>   		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>   
> -	return master->_block_isbad(master, mtd_get_master_ofs(mtd, ofs));
> +	mtd_start_access(master);
> +	ret = master->_block_isbad(master, mtd_get_master_ofs(mtd, ofs));
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_block_isbad);
>   
> @@ -2197,7 +2283,10 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
>   	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
>   		ofs = (loff_t)mtd_div_by_eb(ofs, mtd) * master->erasesize;
>   
> +	mtd_start_access(master);
>   	ret = master->_block_markbad(master, mtd_get_master_ofs(mtd, ofs));
> +	mtd_end_access(master);
> +
>   	if (ret)
>   		return ret;
>   
> diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> index 88227044fc86..b074106e2d8e 100644
> --- a/include/linux/mtd/mtd.h
> +++ b/include/linux/mtd/mtd.h
> @@ -231,6 +231,8 @@ struct mtd_master {
>   	struct mutex partitions_lock;
>   	struct mutex chrdev_lock;
>   	unsigned int suspended : 1;
> +	wait_queue_head_t resume_wq;
> +	struct rw_semaphore suspend_lock;
>   };
>   
>   struct mtd_info {
> @@ -476,10 +478,47 @@ static inline u32 mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
>   	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
>   }
>   
> +static inline void mtd_start_access(struct mtd_info *master)
> +{
> +	WARN_ON_ONCE(master != mtd_get_master(master));
> +
> +	/*
> +	 * Don't take the suspend_lock on devices that don't
> +	 * implement the suspend hook. Otherwise, lockdep will
> +	 * complain about nested locks when trying to suspend MTD
> +	 * partitions or MTD devices created by gluebi which are
> +	 * backed by real devices.
> +	 */
> +	if (!master->_suspend)
> +		return;
> +
> +	/*
> +	 * Wait until the device is resumed. Should we have a
> +	 * non-blocking mode here?
> +	 */
> +	while (1) {
> +		down_read(&master->master.suspend_lock);
> +		if (!master->master.suspended)
> +			return;
> +
> +		up_read(&master->master.suspend_lock);
> +		wait_event(master->master.resume_wq, !master->master.suspended);
> +	}
> +}
> +
> +static inline void mtd_end_access(struct mtd_info *master)
> +{
> +	if (!master->_suspend)
> +		return;
> +
> +	up_read(&master->master.suspend_lock);
> +}
> +
>   static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
>   				     loff_t ofs, size_t len)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> +	int ret;
>   
>   	if (!master->_max_bad_blocks)
>   		return -ENOTSUPP;
> @@ -487,8 +526,12 @@ static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
>   	if (mtd->size < (len + ofs) || ofs < 0)
>   		return -EINVAL;
>   
> -	return master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
> -				       len);
> +	mtd_start_access(master);
> +	ret = master->_max_bad_blocks(master, mtd_get_master_ofs(mtd, ofs),
> +				      len);
> +	mtd_end_access(master);
> +
> +	return ret;
>   }
>   
>   int mtd_wunit_to_pairing_info(struct mtd_info *mtd, int wunit,
> @@ -546,30 +589,40 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
>   static inline int mtd_suspend(struct mtd_info *mtd)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
> -	int ret;
> -
> -	if (master->master.suspended)
> -		return 0;
> +	int ret = 0;
>   
> -	ret = master->_suspend ? master->_suspend(master) : 0;
> -	if (ret)
> +	if (!master->_suspend)
>   		return ret;
>   
> -	master->master.suspended = 1;
> -	return 0;
> +	down_write(&master->master.suspend_lock);
> +	if (!master->master.suspended) {
> +		ret = master->_suspend(master);
> +		if (!ret)
> +			master->master.suspended = 1;
> +	}
> +	up_write(&master->master.suspend_lock);
> +
> +	return ret;
>   }
>   
>   static inline void mtd_resume(struct mtd_info *mtd)
>   {
>   	struct mtd_info *master = mtd_get_master(mtd);
>   
> -	if (!master->master.suspended)
> +	if (!master->_suspend)
>   		return;
>   
> -	if (master->_resume)
> -		master->_resume(master);
> +	down_write(&master->master.suspend_lock);
> +	if (master->master.suspended) {
> +		if (master->_resume)
> +			master->_resume(master);
> +
> +		master->master.suspended = 0;
>   
> -	master->master.suspended = 0;
> +		/* The MTD dev has been resumed, wake up all waiters. */
> +		wake_up_all(&master->master.resume_wq);
> +	}
> +	up_write(&master->master.suspend_lock);
>   }
>   
>   static inline uint32_t mtd_div_by_eb(uint64_t sz, struct mtd_info *mtd)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

