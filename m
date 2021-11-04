Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10B4445283
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKDLxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:53:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43692 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhKDLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:53:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 65CD3218B5;
        Thu,  4 Nov 2021 11:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636026638;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bGIzVdWUAD6ygIDdXn0/2szg5H2SacZqUzhjtATZT64=;
        b=z2T1p+tsrV52JLbPZMMxqzGv01xSNU4qIefp/VVpiCF4q1QQEBOgpqBp8cgziSwer/j0Eo
        cPLlwmzs8ZxRwLXtbrNbMzKd8YRAT/UCNYNGcQY8StWWLZyJT2mMnQNDk+WhT5zeWt9dVK
        n8wyETeST7mKBEIDoP5Plpj4rRs79lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636026638;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bGIzVdWUAD6ygIDdXn0/2szg5H2SacZqUzhjtATZT64=;
        b=g/dhwispyDs1HZ0iohxJUXWzZEaTWDxUXj0uVJj+cJYjfHqxnZc2HvC8iKO6lj3a2ukq7Q
        gxvmGvv2hGnzipCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5AAD5A3B8B;
        Thu,  4 Nov 2021 11:50:38 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D9515DA7A9; Thu,  4 Nov 2021 12:50:01 +0100 (CET)
Date:   Thu, 4 Nov 2021 12:50:01 +0100
From:   David Sterba <dsterba@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Qu Wenruo <wqu@suse.com>, linux-mm@kvack.org
Subject: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
Message-ID: <20211104115001.GU20319@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qu Wenruo <wqu@suse.com>, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while validating the kmap related fixes on 32bit we've started to hit crashes
and memory leaks. The suspicion was that the btrfs fix was incomplete or buggy
but by code inspection there's nothing obviously wrong.

The crash I've hit:

[  538.853152] BTRFS: device fsid 26fb6ae8-1679-4ed8-a5b5-57b5acdd1ab8 devid 1 transid 5 /dev/vda scanned by mkfs.btrfs (117)
[  538.868760] BTRFS info (device vda): flagging fs with big metadata feature
[  538.870143] BTRFS info (device vda): setting incompat feature flag for COMPRESS_LZO (0x8)
[  538.871799] BTRFS info (device vda): force lzo compression, level 0
[  538.872990] BTRFS info (device vda): disk space caching is enabled
[  538.874186] BTRFS info (device vda): has skinny extents
[  538.880477] BTRFS info (device vda): checking UUID tree
[  588.203222] BUG: unable to handle page fault for address: 01460012
[  588.205004] #PF: supervisor read access in kernel mode
[  588.206496] #PF: error_code(0x0000) - not-present page
[  588.208221] *pde = 00000000 
[  588.209178] Oops: 0000 [#1] PREEMPT SMP
[  588.210424] CPU: 0 PID: 143 Comm: kworker/u4:5 Not tainted 5.15.0-default+ #4
[  588.212705] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[  588.216108] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
[  588.218077] EIP: copy_compressed_data_to_page+0x14a/0x380 [btrfs]
[  588.225384] EAX: 00000000 EBX: 01460012 ECX: 00000000 EDX: 00000000
[  588.227149] ESI: 00001000 EDI: d3f3f200 EBP: c3767d90 ESP: c3767d64
[  588.228871] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[  588.230722] CR0: 80050033 CR2: 01460012 CR3: 08f6d000 CR4: 00150e90
[  588.232380] Call Trace:
[  588.233099]  lzo_compress_pages+0x148/0x3a0 [btrfs]
[  588.234492]  btrfs_compress_pages+0xc2/0x160 [btrfs]
[  588.235429]  compress_file_range+0x455/0xae0 [btrfs]
[  588.235909]  async_cow_start+0x13/0x40 [btrfs]
[  588.236344]  btrfs_work_helper+0xcb/0x1e0 [btrfs]
[  588.236809]  ? submit_compressed_extents+0xa0/0xa0 [btrfs]
[  588.237320]  process_one_work+0x23c/0x580
[  588.238015]  ? process_one_work+0x1ac/0x580
[  588.238857]  ? worker_thread+0x75/0x3f0
[  588.239712]  ? submit_compressed_extents+0xa0/0xa0 [btrfs]
[  588.240836]  worker_thread+0x16e/0x3f0
[  588.241607]  kthread+0x144/0x170
[  588.242283]  ? process_one_work+0x580/0x580
[  588.242999]  ? set_kthread_struct+0x40/0x40
[  588.243357]  ret_from_fork+0x19/0x24
[  588.243654] Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq
[  588.244621] CR2: 0000000001460012
[  588.244900] ---[ end trace 76c69d1a25a61f8d ]---
[  588.245259] EIP: copy_compressed_data_to_page+0x14a/0x380 [btrfs]
[  588.248681] EAX: 00000000 EBX: 01460012 ECX: 00000000 EDX: 00000000
[  588.249516] ESI: 00001000 EDI: d3f3f200 EBP: c3767d90 ESP: c3767d64
[  588.250515] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[  588.251469] CR0: 80050033 CR2: 01460012 CR3: 08f6d000 CR4: 00150e90
[  588.252238] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[  588.253349] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 143, name: kworker/u4:5
[  588.254498] preempt_count: 0, expected: 0
[  588.255081] RCU nest depth: 0, expected: 0
[  588.255651] INFO: lockdep is turned off.
[  588.256225] irq event stamp: 508952
[  588.256724] hardirqs last  enabled at (508951): [<db21cca7>] rmqueue.isra.0+0x3e7/0xa30
[  588.257773] hardirqs last disabled at (508952): [<db7d1616>] exc_page_fault+0x36/0x200
[  588.258823] softirqs last  enabled at (508546): [<db7df182>] __do_softirq+0x2c2/0x51d
[  588.259987] softirqs last disabled at (508541): [<db02c827>] do_softirq_own_stack+0x37/0x50
[  588.261434] CPU: 0 PID: 143 Comm: kworker/u4:5 Tainted: G      D           5.15.0-default+ #4
[  588.262806] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
[  588.264455] Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
[  588.265269] Call Trace:
[  588.265643]  ? show_stack+0x3d/0x45
[  588.266180]  dump_stack_lvl+0x44/0x57
[  588.266714]  dump_stack+0xd/0x10
[  588.267200]  __might_resched.cold+0x15f/0x189
[  588.267775]  ? wake_up_klogd+0x3a/0xa0
[  588.268288]  __might_sleep+0x4f/0xa0
[  588.268824]  exit_signals+0x1f/0x380
[  588.269349]  ? worker_thread+0x16e/0x3f0
[  588.269886]  do_exit+0x94/0x430
[  588.270337]  ? kthread+0x144/0x170
[  588.270831]  ? process_one_work+0x580/0x580
[  588.271402]  rewind_stack_do_exit+0x11/0x13

Reproducer:

- enable lzo on btrfs
- copy files with compressible contents (/usr was sufficient to trigger it)

$ cat test-lzo
#!/bin/sh

modprobe btrfs
mkfs.btrfs /dev/vda
mount -o compress-force=lzo /dev/vda /mnt

cd /mnt
for i in `seq 5`; do
	cp -a /usr $RANDOM
	dd if=/dev/zero of=zerofill$RANDOM bs=1M count=40000
	sync
	df -h .
done
---

I've was mainly interested to validate v5.15 + 2cf3f8133bda ("btrfs: fix
lzo_decompress_bio() kmap leakage") as this would end up in stable tree.
This does not trigger the crash nor the leaks.

We were testing master branch commit of the day and that showed up the
problems. The folios were my first suspicion so I tested that
separately.  There's a fixup needed, the tested branch was
49f8275c7d9247cf + e66435936756d9bc, no crash or leak.

The rest is about 410 merge commits to the point we started testing so
I'd rather get some hint where to start bisecting as it would probably
need to be manual. The top commit was dcd68326d29b62f303.

I have enabled various debugging config options plus some relevant to
kmap/highmem:

# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_KMAP_LOCAL=y
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_DEBUG_KMAP_LOCAL=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=y
CONFIG_DEBUG_HIGHMEM=y

The test machine is qemu (i386) VM with 2G or memory and 2 CPUs.

For the memory leak part, that's what Qu Wenruo observed when testing
fstests, I don't have exact details here, but basically used memory was
growing after the workload even after unloading btrfs module or dropping
caches.
