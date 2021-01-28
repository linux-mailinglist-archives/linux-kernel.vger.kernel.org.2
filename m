Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19E307358
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhA1KCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:02:33 -0500
Received: from mail.netline.ch ([148.251.143.178]:39202 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhA1KCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:02:11 -0500
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 05:02:10 EST
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id 2BE462A6042;
        Thu, 28 Jan 2021 10:53:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KohtHMM_GZh1; Thu, 28 Jan 2021 10:53:46 +0100 (CET)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id D85C02A6016;
        Thu, 28 Jan 2021 10:53:46 +0100 (CET)
Received: from daenzer by kaveri with local (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1l53zm-0000dq-A5; Thu, 28 Jan 2021 10:53:46 +0100
From:   =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ttm: Use __GFP_NOWARN for huge pages in ttm_pool_alloc_page
Date:   Thu, 28 Jan 2021 10:53:46 +0100
Message-Id: <20210128095346.2421-1-michel@daenzer.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michel Dänzer <mdaenzer@redhat.com>

Without __GFP_NOWARN, attempts at allocating huge pages can trigger
dmesg splats like below (which are essentially noise, since TTM falls
back to normal pages if it can't get a huge one).

[ 9556.710241] clinfo: page allocation failure: order:9, mode:0x194dc2(GFP_HIGHUSER|__GFP_RETRY_MAYFAIL|__GFP_NORETRY|__GFP_ZERO|__GFP_NOMEMALLOC), nodemask=(null),cpuset=user.slice,mems_allowed=0
[ 9556.710259] CPU: 1 PID: 470821 Comm: clinfo Tainted: G            E     5.10.10+ #4
[ 9556.710264] Hardware name: Micro-Star International Co., Ltd. MS-7A34/B350 TOMAHAWK (MS-7A34), BIOS 1.OR 11/29/2019
[ 9556.710268] Call Trace:
[ 9556.710281]  dump_stack+0x6b/0x83
[ 9556.710288]  warn_alloc.cold+0x7b/0xdf
[ 9556.710297]  ? __alloc_pages_direct_compact+0x137/0x150
[ 9556.710303]  __alloc_pages_slowpath.constprop.0+0xc1b/0xc50
[ 9556.710312]  __alloc_pages_nodemask+0x2ec/0x320
[ 9556.710325]  ttm_pool_alloc+0x2e4/0x5e0 [ttm]
[ 9556.710332]  ? kvmalloc_node+0x46/0x80
[ 9556.710341]  ttm_tt_populate+0x37/0xe0 [ttm]
[ 9556.710350]  ttm_bo_handle_move_mem+0x142/0x180 [ttm]
[ 9556.710359]  ttm_bo_validate+0x11d/0x190 [ttm]
[ 9556.710391]  ? drm_vma_offset_add+0x2f/0x60 [drm]
[ 9556.710399]  ttm_bo_init_reserved+0x2a7/0x320 [ttm]
[ 9556.710529]  amdgpu_bo_do_create+0x1b8/0x500 [amdgpu]
[ 9556.710657]  ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
[ 9556.710663]  ? get_page_from_freelist+0x11f9/0x1450
[ 9556.710789]  amdgpu_bo_create+0x40/0x270 [amdgpu]
[ 9556.710797]  ? _raw_spin_unlock+0x16/0x30
[ 9556.710927]  amdgpu_gem_create_ioctl+0x123/0x310 [amdgpu]
[ 9556.711062]  ? amdgpu_gem_force_release+0x150/0x150 [amdgpu]
[ 9556.711098]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[ 9556.711133]  drm_ioctl+0x20f/0x3a0 [drm]
[ 9556.711267]  ? amdgpu_gem_force_release+0x150/0x150 [amdgpu]
[ 9556.711276]  ? preempt_count_sub+0x9b/0xd0
[ 9556.711404]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[ 9556.711411]  __x64_sys_ioctl+0x83/0xb0
[ 9556.711417]  do_syscall_64+0x33/0x80
[ 9556.711421]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: bf9eee249ac2 ("drm/ttm: stop using GFP_TRANSHUGE_LIGHT")
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index 8c762a03ad8a..a264760cb2cd 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -84,7 +84,7 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
 	 * put_page() on a TTM allocated page is illegal.
 	 */
 	if (order)
-		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY |
+		gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
 			__GFP_KSWAPD_RECLAIM;
 
 	if (!pool->use_dma_alloc) {
-- 
2.30.0

