Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832B73E43C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhHIKUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232707AbhHIKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628504421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=khcR5qip36FZVs38owIp+mLzByBcI2rs63Ak5IXHYuU=;
        b=Moy2xoYFed0ZBUlGTprrQ/ws42tIraYRwKj/xo9dRez1A98Qedi9GPiFGbSGWiB41cD41J
        hy8IWdkgS9GDDDD4P8MkH1E2lVrWKteGA7z1Yjj/t9nZaq4Xy+MmiXLuWFI52Tj7N8FTxS
        vSFT3AWmfD5/ToCfaTsWn3TTdW30EIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-YUSmRa7tNAOYv-JJGi8qsg-1; Mon, 09 Aug 2021 06:20:18 -0400
X-MC-Unique: YUSmRa7tNAOYv-JJGi8qsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE52610199AA;
        Mon,  9 Aug 2021 10:20:16 +0000 (UTC)
Received: from crecklin.bos.com (unknown [10.22.18.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E46BE60C05;
        Mon,  9 Aug 2021 10:20:15 +0000 (UTC)
From:   Chris von Recklinghausen <crecklin@redhat.com>
To:     pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fix UBSAN splat in test_scanf
Date:   Mon,  9 Aug 2021 06:20:13 -0400
Message-Id: <20210809102013.525671-1-crecklin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with CONFIG_UBSAN_SHIFT=y, the following splat was observed:

[  104.676826] test_scanf: loaded.
[  104.680862] ================================================================================
[  104.690304] UBSAN: shift-out-of-bounds in lib/test_scanf.c:274:51
[  104.697144] shift exponent 32 is too large for 32-bit type 'unsigned int'
[  104.704747] CPU: 18 PID: 1790 Comm: modprobe Tainted: G S                5.14.0-rc4 #1
[  104.713592] Hardware name: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.02.01.0002.082220131453 08/22/2013
[  104.725052] Call Trace:
[  104.727787]  dump_stack_lvl+0x44/0x57
[  104.731888]  ubsan_epilogue+0x5/0x40
[  104.735882]  __ubsan_handle_shift_out_of_bounds.cold.14+0x14/0x98
[  104.742704]  next_test_random+0x3f/0x56 [test_scanf]
[  104.748253]  numbers_list+0x1e91/0x3364 [test_scanf]
[  104.753807]  ? numbers_list_field_width_typemax+0x3859/0x3859 [test_scanf]
[  104.761501]  ? numbers_simple+0x3839/0x388f [test_scanf]
[  104.767436]  ? load_module+0x6ba5/0x7200
[  104.771822]  ? _test+0x152/0x152 [test_scanf]
[  104.776690]  ? hlock_class+0x4e/0x120
[  104.780784]  ? __lock_acquire+0x171d/0x2f80
[  104.785459]  ? lock_is_held_type+0x99/0x100
[  104.790153]  ? find_held_lock+0x3a/0x1c0
[  104.794557]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  104.799529]  ? __kasan_kmalloc+0x7f/0xa0
[  104.803916]  ? kmem_cache_alloc_trace+0x185/0x270
[  104.809172]  ? test_scanf_init+0xe3/0x11cd [test_scanf]
[  104.815010]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  104.820272]  test_scanf_init+0x17e/0x11cd [test_scanf]
[  104.826014]  ? numbers_list+0x3364/0x3364 [test_scanf]
[  104.831757]  ? numbers_list+0x3364/0x3364 [test_scanf]
[  104.837497]  ? rcu_read_lock_sched_held+0xaf/0xe0
[  104.842760]  ? rcu_read_lock_bh_held+0xc0/0xc0
[  104.847730]  ? numbers_list+0x3364/0x3364 [test_scanf]
[  104.853473]  do_one_initcall+0xfb/0x540
[  104.857776]  ? perf_trace_initcall_level+0x490/0x490
[  104.863328]  ? __kasan_kmalloc+0x7f/0xa0
[  104.867714]  ? kmem_cache_alloc_trace+0x185/0x270
[  104.872969]  ? do_init_module+0x4e/0x760
[  104.877350]  ? kasan_unpoison+0x23/0x50
[  104.881650]  do_init_module+0x1f2/0x760
[  104.885945]  load_module+0x6ba5/0x7200
[  104.890174]  ? layout_and_allocate+0x2c00/0x2c00
[  104.895337]  ? ima_read_file+0x150/0x150
[  104.899734]  ? kernel_read_file+0x2f6/0x710
[  104.904415]  ? __x64_sys_fsconfig+0x6a0/0x6a0
[  104.909300]  ? __do_sys_finit_module+0xff/0x180
[  104.914363]  __do_sys_finit_module+0xff/0x180
[  104.919230]  ? __ia32_sys_init_module+0xa0/0xa0
[  104.924294]  ? rcu_read_unlock+0x50/0x50
[  104.928679]  ? kfree+0x2fd/0x3c0
[  104.932316]  do_syscall_64+0x3a/0x80
[  104.936316]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  104.941971] RIP: 0033:0x7f7d8220e52d
[  104.945962] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2b 79 2c 00 f7 d8 64 89 01 48
[  104.966933] RSP: 002b:00007ffd1a1a9448 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  104.975392] RAX: ffffffffffffffda RBX: 00005611e43bde40 RCX: 00007f7d8220e52d
[  104.983360] RDX: 0000000000000000 RSI: 00005611e401d7d6 RDI: 0000000000000003
[  104.991327] RBP: 00005611e401d7d6 R08: 0000000000000000 R09: 0000000000000000
[  104.999294] R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
[  105.007261] R13: 00005611e43bdec0 R14: 0000000000040000 R15: 0000000000000000
[  105.015285] ================================================================================
[  105.026917] test_scanf: all 2545 tests passed
[  105.045896] test_scanf: unloaded.

This is due to n_bits having a value of 0 in next_test_random. Avoid this by
repeatedly calling hweight32(prandom_u32_state(&rnd_state)) % (max_bits + 1)
until n_bits is nonzero.

Signed-off-by: Chris von Recklinghausen <crecklin@redhat.com>
---
 lib/test_scanf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/test_scanf.c b/lib/test_scanf.c
index 84fe09eaf55e..4e3754b916f2 100644
--- a/lib/test_scanf.c
+++ b/lib/test_scanf.c
@@ -269,7 +269,13 @@ static void __init numbers_simple(void)
  */
 static u32 __init next_test_random(u32 max_bits)
 {
-	u32 n_bits = hweight32(prandom_u32_state(&rnd_state)) % (max_bits + 1);
+	u32 n_bits;
+
+	/* shifting a 32 bit unsigned int by 32 is undefined behavior */
+	do {
+		n_bits = hweight32(prandom_u32_state(&rnd_state))
+			% (max_bits + 1);
+	} while (n_bits == 0);
 
 	return prandom_u32_state(&rnd_state) & (UINT_MAX >> (32 - n_bits));
 }
-- 
2.27.0

