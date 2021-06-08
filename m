Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB673A0187
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbhFHSxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:53:47 -0400
Received: from a4-3.smtp-out.eu-west-1.amazonses.com ([54.240.4.3]:44387 "EHLO
        a4-3.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235483AbhFHSrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1623177946;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=CE3N5hECV6fEAemJRPmDNIY3m+He9VC+83mexYzAuzo=;
        b=FlGSqGBtG6UE5AWCqcI+P0Pzi1zMGhe3Ut7ttZAkmCHacF/tPiUyvZqOaH7DTjKs
        I17RXdSWDb5aZQ4vo2RmkAG4teHM9QaoPqJhop1cxfyh/ylSPkdVyhUcIfTdoAo7CsL
        CqsyWpavY9JUSSZMApokHo7rLCOmqGeW0wO2Ag64=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1623177946;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=CE3N5hECV6fEAemJRPmDNIY3m+He9VC+83mexYzAuzo=;
        b=A2vB8AlODzFmdOV5jCO5u+6d9D8GeMVSPoPGQdg5EChBEABZ3Svp8b4UI3jSnXrv
        Yo4tX4Vo/DjVBMbjXlv9wZrhR7ILuqw5ok0nA/SUioAJG1bboFHWn2tVtzugFsU4mMR
        ztOmWSY1yhpPte28ChwftBGhHehCSTraUtuiIrOE=
To:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-kernel@vger.kernel.org
From:   Martin Raiber <martin@urbackup.org>
Subject: zram: NULL pointer dereference in zs_malloc 5.10.y
Message-ID: <01020179ecf1e5b8-d3aa5ac5-28fd-4260-a953-43445217755c-000000@eu-west-1.amazonses.com>
Date:   Tue, 8 Jun 2021 18:45:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.08-54.240.4.3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just saw this again on 5.10.y, seems to be present since a while (see 
https://bugzilla.kernel.org/show_bug.cgi?id=209153 but ignore the 
unrelated btrfs issues):

Jun  8 04:15:40  kernel: [3557647.536760] BUG: kernel NULL pointer 
dereference, address: 0000000000000000
Jun  8 04:15:40  kernel: [3557647.536785] #PF: supervisor read access in 
kernel mode
Jun  8 04:15:40  kernel: [3557647.536797] #PF: error_code(0x0000) - 
not-present page
Jun  8 04:15:40  kernel: [3557647.536809] PGD 0 P4D 0
Jun  8 04:15:40  kernel: [3557647.536818] Oops: 0000 [#1] SMP PTI
Jun  8 04:15:40  kernel: [3557647.536828] CPU: 0 PID: 3448227 Comm: 
kworker/u256:13 Not tainted 5.10.26 #1
Jun  8 04:15:40  kernel: [3557647.536843] Hardware name: Microsoft 
Corporation Virtual Machine/Virtual Machine, BIOS 090007 05/18/2018
Jun  8 04:15:40  kernel: [3557647.536867] Workqueue: writeback wb_workfn 
(flush-252:1)
Jun  8 04:15:40  kernel: [3557647.537416] RIP: 0010:obj_malloc+0x35/0xf0
Jun  8 04:15:40  kernel: [3557647.537953] Code: 49 89 f1 48 83 ca 01 41 
8b 48 48 49 8b 41 10 49 89 d2 0f af cf 89 ce 41 89 cb c1 fe 0c 41 81 e$
Jun  8 04:15:40  kernel: [3557647.538562] RSP: 0018:ffffc9003a16b830 
EFLAGS: 00010206
Jun  8 04:15:40  kernel: [3557647.538562] RAX: 0000000000000000 RBX: 
ffff88817a6df000 RCX: 02ffff8000000000
Jun  8 04:15:40  kernel: [3557647.538562] RDX: 0000000000000001 RSI: 
000000000003f085 RDI: 000000000fb67d15
Jun  8 04:15:40  kernel: [3557647.538562] RBP: ffff888105d27380 R08: 
ffff888136079680 R09: ffff8881bb656d80
Jun  8 04:15:40  kernel: [3557647.538562] R10: ffff888105d27381 R11: 
0000000000000720 R12: 000000000000280a
Jun  8 04:15:40  kernel: [3557647.538562] R13: ffff888136079680 R14: 
0000000000002800 R15: ffff8881bb656d80
Jun  8 04:15:40  kernel: [3557647.538562] FS: 0000000000000000(0000) 
GS:ffff8897c5e00000(0000) knlGS:0000000000000000
Jun  8 04:15:40  kernel: [3557647.538562] CS:  0010 DS: 0000 ES: 0000 
CR0: 0000000080050033
Jun  8 04:15:40  kernel: [3557647.538562] CR2: 0000000000000000 CR3: 
0000000141d6c004 CR4: 00000000001706f0
Jun  8 04:15:40  kernel: [3557647.538562] Call Trace:
Jun  8 04:15:40  kernel: [3557647.538562]  zs_malloc+0x1d0/0x440
Jun  8 04:15:40  kernel: [3557647.538562] 
zram_bvec_rw.constprop.0.isra.0+0x363/0x610 [zram]
Jun  8 04:15:40  kernel: [3557647.549338] zram_submit_bio+0x199/0x351 [zram]
Jun  8 04:15:40  kernel: [3557647.549637] submit_bio_noacct+0x116/0x4e0
Jun  8 04:15:40  kernel: [3557647.549637] ext4_io_submit+0x49/0x60
Jun  8 04:15:40  kernel: [3557647.549637] ext4_writepages+0x562/0xfc0
Jun  8 04:15:40  kernel: [3557647.549637]  ? 
pagevec_lookup_range_tag+0x24/0x30
Jun  8 04:15:40  kernel: [3557647.549637]  ? write_cache_pages+0xaf/0x3d0
Jun  8 04:15:40  kernel: [3557647.549637]  ? __wb_calc_thresh+0x120/0x120
Jun  8 04:15:40  kernel: [3557647.549637]  ? 
change_mnt_propagation+0x80/0x2b0
Jun  8 04:15:40  kernel: [3557647.554585]  do_writepages+0x34/0xc0
Jun  8 04:15:40  kernel: [3557647.555157]  ? ext4_write_inode+0x13d/0x1c0
Jun  8 04:15:40  kernel: [3557647.555157] 
__writeback_single_inode+0x39/0x2a0
Jun  8 04:15:40  kernel: [3557647.555157] writeback_sb_inodes+0x200/0x470
Jun  8 04:15:40  kernel: [3557647.555157] __writeback_inodes_wb+0x4c/0xe0
Jun  8 04:15:40  kernel: [3557647.555157] wb_writeback+0x1d8/0x290
Jun  8 04:15:40  kernel: [3557647.555157]  wb_workfn+0x2d5/0x4d0
Jun  8 04:15:40  kernel: [3557647.555157]  ? check_preempt_curr+0x4f/0x60
Jun  8 04:15:40  kernel: [3557647.555157]  ? ttwu_do_wakeup+0x17/0x130
Jun  8 04:15:40  kernel: [3557647.555157] process_one_work+0x1b6/0x350
Jun  8 04:15:40  kernel: [3557647.555157] worker_thread+0x53/0x3e0
Jun  8 04:15:40  kernel: [3557647.555157]  ? process_one_work+0x350/0x350
Jun  8 04:15:40  kernel: [3557647.555157]  kthread+0x11b/0x140
Jun  8 04:15:40  kernel: [3557647.555157]  ? __kthread_bind_mask+0x60/0x60
Jun  8 04:15:40  kernel: [3557647.555157]  ret_from_fork+0x22/0x30
Jun  8 04:15:40  kernel: [3557647.562581] Modules linked in: bcache 
crc64 zram dm_cache_smq dm_cache dm_persistent_data dm_bio_prison dm_bufio$
Jun  8 04:15:40  kernel: [3557647.566578] CR2: 0000000000000000
Jun  8 04:15:40  kernel: [3557647.566578] ---[ end trace 
13a49464a5440b1a ]---

No idea how to reproduce -- occurs very rarely.

