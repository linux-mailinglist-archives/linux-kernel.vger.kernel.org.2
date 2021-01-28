Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5163730730C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 10:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbhA1Jmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 04:42:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:39128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhA1Jkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:40:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE443AC97;
        Thu, 28 Jan 2021 09:40:04 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:40:04 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
Message-ID: <20210128094004.erwnszjqcxlsi2kd@beryllium.lan>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
 <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
 <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69575290-200e-b4a1-4269-c71e4c2cc37b@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:18:56PM +0800, Chao Leng wrote:
> It is impossible to return NULL for nvme_next_ns(head, old).

 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 block nvme0n1: no usable path - requeuing I/O
 BUG: kernel NULL pointer dereference, address: 0000000000000068
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 8000000ff67bc067 P4D 8000000ff67bc067 PUD ff9ac9067 PMD 0 
 Oops: 0000 [#1] SMP PTI
 CPU: 23 PID: 15759 Comm: dt.21.15 Kdump: loaded Tainted: G            E       5.3.18-0.gc9fe679-default #1 SLE15-SP2 (unreleased)
 Hardware name: FUJITSU PRIMERGY RX2540 M2/D3289-B1, BIOS V5.0.0.11 R1.18.0 for D3289-B1x                    02/06/2018
 RIP: 0010:nvme_ns_head_make_request+0x1d1/0x430 [nvme_core]
 Code: 54 24 10 0f 84 c9 01 00 00 48 8b 54 24 10 48 83 ea 30 0f 84 ba 01 00 00 48 39 d0 0f 84 01 02 00 00 31 ff eb 05 48 39 d0 74 67 <48> 8b 72 68 83 e6 04 75 13 48 8b 72 68 83 e6 01 75 0a 48 8b 72 10
 RSP: 0018:ffffa69d08017af8 EFLAGS: 00010246
 RAX: ffff92f261d87800 RBX: ffff92fa555b0010 RCX: ffff92fa555bc570
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000001 R08: 0000000000001000 R09: 0000000000001000
 R10: ffffa69d080179a8 R11: ffff92f264f0c1c0 R12: ffff92f264f7f000
 R13: ffff92fa555b0000 R14: 0000000000000001 R15: 0000000000000000
 FS:  00007f3962bae700(0000) GS:ffff92f29ffc0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000068 CR3: 0000000fd69a2002 CR4: 00000000003606e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  generic_make_request+0x121/0x300
  ? submit_bio+0x42/0x1c0
  submit_bio+0x42/0x1c0
  ext4_io_submit+0x49/0x60 [ext4]
  ext4_writepages+0x625/0xe90 [ext4]
  ? do_writepages+0x4b/0xe0
  ? ext4_mark_inode_dirty+0x1d0/0x1d0 [ext4]
  do_writepages+0x4b/0xe0
  ? __generic_file_write_iter+0x192/0x1c0
  ? __filemap_fdatawrite_range+0xcb/0x100
  __filemap_fdatawrite_range+0xcb/0x100
  ? ext4_file_write_iter+0x128/0x3c0 [ext4]
  file_write_and_wait_range+0x5e/0xb0
  __generic_file_fsync+0x22/0xb0
  ext4_sync_file+0x1f7/0x3c0 [ext4]
  do_fsync+0x38/0x60
  __x64_sys_fsync+0x10/0x20
  do_syscall_64+0x5b/0x1e0
entry_SYSCALL_64_after_hwframe+0x44/0xa9

You can't see exactly where it dies but I followed the assembly to
nvme_round_robin_path(). Maybe it's not the initial nvme_next_ns(head,
old) which returns NULL but nvme_next_ns() is returning NULL eventually
(list_next_or_null_rcu()).

And I have positive feedback, this patch fixes the above problem.

