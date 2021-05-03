Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41953710A0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 05:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbhECDFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 23:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhECDFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 23:05:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15783C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 20:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=t69o0s6rTqY95QN4u9EFAKr5fAm3ffbxrmbQ9tZrGew=; b=s0W/VGlkGi0pKc2akLRmE06361
        UOmDy5Jl6p2Jq4RRfK6/PfdkWF1GBa1jSwRSH8jHkpdqXhCkD1iHzXXRH2jLmC09TBIdXfjKse5AG
        xTv7ViqdHbRhBL3yw7FiX6N3/7q5SIXekC0fjRdZV0feLHHhVJUlPpxAK4griiTTKXbZm+JJD7WXT
        ATRbhUrlmkj9TVgUaHXc7e1Xc1LeJbX8uY9q7Txx+411a0vzzK6e7qiXdG8YcaxWMeoTpUR16RnjU
        qP80sKToIcGV6nwId2/aRa42A/Zrp1ddMclsRkbSUIWQaVRGJbE30f2uUhzfhtL0B378zkxLBCRy0
        IY7NslOw==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldOsA-00EZWz-9K; Mon, 03 May 2021 03:03:57 +0000
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in udf_statfs
To:     syzbot <syzbot+7fbfe5fed73ebb675748@syzkaller.appspotmail.com>,
        jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <000000000000683df205c1359d10@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <272c7c70-9ea0-b7d0-5fa7-01f0c5650bd8@infradead.org>
Date:   Sun, 2 May 2021 20:03:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000683df205c1359d10@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all--

On 4/30/21 12:28 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    e77a830c Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c63e6dd00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c0a6882014fd3d45
> dashboard link: https://syzkaller.appspot.com/bug?extid=7fbfe5fed73ebb675748
> compiler:       Debian clang version 11.0.1-2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17612825d00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132cb56dd00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7fbfe5fed73ebb675748@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 3974
> UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/09/19 18:44 (1000)
> ================================================================================
> UBSAN: array-index-out-of-bounds in fs/udf/super.c:2524:12
> index 0 is out of range for type '__le32 [0]'


Is this just due to (from fs/udf/ecma_167.h) the "[0]" struct items?
Do they need to be "[]" instead?  Will that satisfy USBAN?


/* Logical Volume Integrity Descriptor (ECMA 167r3 3/10.10) */
struct logicalVolIntegrityDesc {
	struct tag		descTag;
	struct timestamp	recordingDateAndTime;
	__le32			integrityType;
	struct extent_ad	nextIntegrityExt;
	uint8_t			logicalVolContentsUse[32];
	__le32			numOfPartitions;
	__le32			lengthOfImpUse;
	__le32			freeSpaceTable[0]; // <<<<<<<<<<<<<<<<
	__le32			sizeTable[0]; // <<<<<<<<<<<<<<<<<<<
	uint8_t			impUse[0]; // <<<<<<<<<<<<<<<<<<<<<<<
} __packed;


(I ask because I cannot reproduce the problem -- maybe a bad GCC
version?)


> CPU: 1 PID: 8363 Comm: syz-executor557 Not tainted 5.12.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  ubsan_epilogue lib/ubsan.c:148 [inline]
>  __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:288
>  udf_count_free fs/udf/super.c:2524 [inline]
>  udf_statfs+0x49f/0xd70 fs/udf/super.c:2408
>  statfs_by_dentry fs/statfs.c:66 [inline]
>  vfs_statfs+0x136/0x310 fs/statfs.c:90
>  user_statfs fs/statfs.c:105 [inline]
>  __do_sys_statfs fs/statfs.c:195 [inline]
>  __se_sys_statfs+0xe5/0x210 fs/statfs.c:192
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x444579
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc428d7b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000444579
> RDX: 0000000000402b43 RSI: 0000000000000000 RDI: 00000000200001c0
> RBP: 0000000000403e10 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffc428d7a20 R11: 0000000000000246 R12: 0000000000403ea0
> R13: 0000000000000000 R14: 00000000004b2018 R15: 00000000004004a0
> ================================================================================
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 8363 Comm: syz-executor557 Not tainted 5.12.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  panic+0x2e1/0x850 kernel/panic.c:231
>  ubsan_epilogue lib/ubsan.c:162 [inline]
>  __ubsan_handle_out_of_bounds+0x12b/0x130 lib/ubsan.c:288
>  udf_count_free fs/udf/super.c:2524 [inline]
>  udf_statfs+0x49f/0xd70 fs/udf/super.c:2408
>  statfs_by_dentry fs/statfs.c:66 [inline]
>  vfs_statfs+0x136/0x310 fs/statfs.c:90
>  user_statfs fs/statfs.c:105 [inline]
>  __do_sys_statfs fs/statfs.c:195 [inline]
>  __se_sys_statfs+0xe5/0x210 fs/statfs.c:192
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x444579
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc428d7b58 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
> RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 0000000000444579
> RDX: 0000000000402b43 RSI: 0000000000000000 RDI: 00000000200001c0
> RBP: 0000000000403e10 R08: 0000000000000000 R09: 0000000000000000
> R10: 00007ffc428d7a20 R11: 0000000000000246 R12: 0000000000403ea0
> R13: 0000000000000000 R14: 00000000004b2018 R15: 00000000004004a0
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
> ---

thanks.
-- 
~Randy

