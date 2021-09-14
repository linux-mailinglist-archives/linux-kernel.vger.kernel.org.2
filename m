Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73F140B430
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhINQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:09:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhINQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:09:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEAA722027;
        Tue, 14 Sep 2021 16:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631635686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tm3nfKrorNJOYR1Gj5oiXg79pdiwKsLuuMFX5aMSrFw=;
        b=LjWongcn1o/7+WG0YSOufRMRQF/7QgkZU8WaILHkFTncqDfQZeArSJ+0lCTdHHV3AStzBU
        79W2bZlZ4XXOQc7WWcQ7YBb5UfNADZMTjUB6KYBOqGCCz2tLeZgKUuYoAxb6x0WjrsFgBk
        fCZqp6ZVDVvA9X2Rcv4cRDiyO7N7UtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631635686;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tm3nfKrorNJOYR1Gj5oiXg79pdiwKsLuuMFX5aMSrFw=;
        b=sA4GizOPPMCT6JkprvQVxEuy4xXbmiPs8hYS3RHxVLzngcgpIu5yc2uphoe4LQ9H0Mn4gL
        ea97DKbhwrbY1xAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6F0B13ABE;
        Tue, 14 Sep 2021 16:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Uu/SM+bIQGHsLQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Sep 2021 16:08:06 +0000
Message-ID: <61ab2d0c-3313-aaab-514c-e15b7aa054a0@suse.cz>
Date:   Tue, 14 Sep 2021 18:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] bootconfig: Fix to check the xbc_node is used before free
 it
Content-Language: en-US
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        oliver.sang@intel.com
References: <20210912140820.GD25450@xsang-OptiPlex-9020>
 <163149460533.291098.7342418455457691240.stgit@devnote2>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <163149460533.291098.7342418455457691240.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/13/21 02:56, Masami Hiramatsu wrote:
> Fix to check the xbc_node is used before calling memblock_free()
> because passing NULL to phys_addr() will cause a panic.
> This will happen if user doesn't pass any bootconfig to the
> kernel, because kernel will call xbc_destroy_all() after
> booting.
> 
> Fixes: 40caa127f3c7 ("init: bootconfig: Remove all bootconfig data when the init memory is removed")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

FTR, I got a different issue with 5.15-rc1, bisected to 40caa127f3c7 and
this patch fixed it for me, so:

Tested-by: Vlastimil Babka <vbabka@suse.cz>

The panic I was getting:

 general protection fault, probably for non-canonical address 0x343479726f6d657d: 0000 [#1] SMP NOPTI
 CPU: 10 PID: 446 Comm: udevadm Tainted: G            E     5.15.0-rc1-1.g8787773-default+ #43 openSUSE Tumbleweed (unreleased) d96e60462206b52b95b55ea8102fc1a7d9e8ae9a
 Hardware name: Gigabyte Technology Co., Ltd. X470 AORUS ULTRA GAMING/X470 AORUS ULTRA GAMING-CF, BIOS F60h 02/04/2021
 RIP: 0010:rb_next+0x14/0x50
 Code: 89 c1 89 c6 89 c7 41 89 c0 c3 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 8b 17 48 39 d7 74 43 48 8b 47 08 48 85 c0 74 23 49 89 c0 <48> 8b 40 10 48 85 c0 75 f4 4c 89 c0 31 d2 89 d7 41 89 d0 c3 48 3b
 RSP: 0018:ffffa63741053e00 EFLAGS: 00010202
 RAX: 343479726f6d656d RBX: ffffa63741053e90 RCX: 0000000000000000
 RDX: ffff94fd4eb37f18 RSI: 0000000000000000 RDI: ffff94fd4ebf7e18
 RBP: 0000000000000000 R08: 343479726f6d656d R09: 0000000000000000
 R10: ffffffff89f58b50 R11: 0000000000000000 R12: ffff94f64a7c3f00
 R13: ffff94f640e3b300 R14: ffff94fd4ebf7e00 R15: 0000000000000007
 FS:  00007fd358530180(0000) GS:ffff94fd4ea80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000564bfee24028 CR3: 000000013055c000 CR4: 00000000003506e0
 Call Trace:
  kernfs_fop_readdir+0x12d/0x260
  iterate_dir+0x196/0x1e0
  __x64_sys_getdents64+0x80/0x120
  ? compat_fillonedir+0x160/0x160
  ? syscall_exit_to_user_mode+0x18/0x40
  do_syscall_64+0x5c/0x90
  ? syscall_exit_to_user_mode+0x18/0x40
  ? syscall_exit_to_user_mode+0x18/0x40
  ? do_syscall_64+0x69/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7fd358f04947
 Code: 00 00 0f 05 eb b7 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 f9 a4 0f 00 f7 d8 64 89 02 48
 RSP: 002b:00007fffc0b3ba78 EFLAGS: 00000293 ORIG_RAX: 00000000000000d9
 RAX: ffffffffffffffda RBX: 0000564bfedac480 RCX: 00007fd358f04947
 RDX: 0000000000008000 RSI: 0000564bfedac4b0 RDI: 0000000000000004
 RBP: 0000564bfedac4b0 R08: 0000000000000030 R09: 00007fd358fffa60
 R10: 0000564bfedb44b0 R11: 0000000000000293 R12: fffffffffffffeb0
 R13: 0000564bfedac484 R14: 0000000000000000 R15: 00007fffc0b3bb70
 Modules linked in: btrfs(E) blake2b_generic(E) libcrc32c(E) crc32c_intel(E) xor(E) raid6_pq(E) sg(E) dm_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) msr(E) efivarfs(E)
 ---[ end trace 011b3d281b92632a ]---
