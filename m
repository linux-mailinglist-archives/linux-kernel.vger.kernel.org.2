Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4CE32BF0B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577388AbhCCRsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:33766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241128AbhCCOyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:54:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614782049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=jZwwbpIzsL39axnKVFLi78WYtFVUDliH4BfkywVG2Ro=;
        b=gwLpeUwYYlvirMZ/jsjRBKCj0N2rrNmaPjflAguejX7lR2hr5i9Wb7M28Y8uFuXQOVpYnx
        w2nPkqKtqnBiSvB/Qg+1NAo12exRL4KuVn41MuUGiAjBhokdw32440UarfPwPva4D9jKtM
        amdn2Z6Wz8zs6RVFZIe8Vh0GaeD3MYA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 759AEAC24;
        Wed,  3 Mar 2021 14:34:09 +0000 (UTC)
Date:   Wed, 3 Mar 2021 15:34:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: drm/ttm: ttm_bo_release called without lock
Message-ID: <YD+eYcMMcdlXB8PY@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following warning is filling my kernel log buffer
with 5.12-rc1+ kernels:

[  941.070598] WARNING: CPU: 0 PID: 11 at drivers/gpu/drm/ttm/ttm_bo.c:139 ttm_bo_move_to_lru_tail+0x1ba/0x210
[  941.070601] Modules linked in:
[  941.070603] CPU: 0 PID: 11 Comm: kworker/0:1 Kdump: loaded Tainted: G        W         5.12.0-rc1-default+ #81
[  941.070605] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  941.070606] Workqueue: events qxl_gc_work
[  941.070609] RIP: 0010:ttm_bo_move_to_lru_tail+0x1ba/0x210
[  941.070610] Code: 93 e8 02 00 00 48 89 0a e9 00 ff ff ff 48 8b 87 38 01 00 00 be ff ff ff ff 48 8d 78 70 e8 8e 7d 46 00 85 c0 0f 85 6f fe ff ff <0f> 0b 8b 93 fc 02 00 00 85 d2 0f 84 6d fe ff ff 48 89 df 5b 5d 41
[  941.070612] RSP: 0018:ffffbddf4008fd38 EFLAGS: 00010246
[  941.070614] RAX: 0000000000000000 RBX: ffff95ae485bac00 RCX: 0000000000000002
[  941.070615] RDX: 0000000000000000 RSI: ffff95ae485badb0 RDI: ffff95ae40305108
[  941.070616] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[  941.070617] R10: ffffbddf4008fc10 R11: ffffffffa5401580 R12: ffff95ae42a94e90
[  941.070618] R13: ffff95ae485bae70 R14: ffff95ae485bac00 R15: ffff95ae455d1800
[  941.070620] FS:  0000000000000000(0000) GS:ffff95aebf600000(0000) knlGS:0000000000000000
[  941.070621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  941.070622] CR2: 00007f8ffb2f8000 CR3: 0000000102c5e005 CR4: 0000000000370ef0
[  941.070624] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  941.070626] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  941.070627] Call Trace:
[  941.070630]  ttm_bo_release+0x551/0x600
[  941.070635]  qxl_bo_unref+0x3a/0x50
[  941.070638]  qxl_release_free_list+0x62/0xc0
[  941.070643]  qxl_release_free+0x76/0xe0
[  941.070646]  qxl_garbage_collect+0xd9/0x190
[  941.080241]  process_one_work+0x2b0/0x630
[  941.080249]  ? process_one_work+0x630/0x630
[  941.080251]  worker_thread+0x39/0x3f0
[  941.080255]  ? process_one_work+0x630/0x630
[  941.080257]  kthread+0x13a/0x150
[  941.080260]  ? kthread_create_worker_on_cpu+0x70/0x70
[  941.080265]  ret_from_fork+0x1f/0x30
[  941.080277] irq event stamp: 757191
[  941.080278] hardirqs last  enabled at (757197): [<ffffffffa217431f>] vprintk_emit+0x27f/0x2c0
[  941.080280] hardirqs last disabled at (757202): [<ffffffffa21742dc>] vprintk_emit+0x23c/0x2c0
[  941.080281] softirqs last  enabled at (755768): [<ffffffffa300030f>] __do_softirq+0x30f/0x432
[  941.080284] softirqs last disabled at (755763): [<ffffffffa20eb0aa>] irq_exit_rcu+0xea/0xf0

My wild guess is that it might be related to the commit
3d1a88e1051f5d788d789 ("drm/ttm: cleanup LRU handling further").

Does it ring any bell, please?

Best Regards,
Petr
