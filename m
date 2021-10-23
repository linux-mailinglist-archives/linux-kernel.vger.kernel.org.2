Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4808D438408
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJWP35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 11:29:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhJWP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 11:29:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2330C60C4A;
        Sat, 23 Oct 2021 15:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635002856;
        bh=uh99HPJZSbkQ3nLWsGLF3LOrZGubgeIJFdhv4IVkivQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kdEmjrMrqODMx4uIhLjzbJuKcKqYkFrjN5GT6PoxrCa0DwCrgZ+1lMopKCbuwmc6d
         yymNnfqBzwOgDge6MPL0zHpZp82xwkKbMzwlLeMGSlNmDvG5CU7vLpTivEKSXkIEnY
         iUfrD8jQdBWcFtpV8Efnf1glNm4j8AP4oNW5QZJDKVtFZPBZAcOw85ea8c+Vu3sRex
         5xNXxwzvqQZUybrwB0ygIcUkbulzY0qt1OghRcczNGsXGYpfvmzvxa1pjK9p9VE++S
         rgAMf1lZT9NBdgp4wf111cwnHx0LivUJ58nh0j0uA3obQ/pc0nEwLv6QtqwdgLIaI1
         wvwwE/DXtrf+A==
Date:   Sat, 23 Oct 2021 18:27:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Kees Cook <keescook@chromium.org>
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
Message-ID: <YXQp4MsT0EEKqMl/@kernel.org>
References: <00000000000062d0fc05cef24c57@google.com>
 <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 05:07:40PM +0200, Dmitry Vyukov wrote:
> On Fri, 22 Oct 2021 at 17:02, syzbot
> <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    64222515138e Merge tag 'drm-fixes-2021-10-22' of git://ano..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=178e86c4b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=be398dd7862f4b36
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b904a1de3ec43711eba5
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com
> 
> +Mike, Jordy for secretmem.c

I was actually the first to report it ;-)

https://lore.kernel.org/all/YXJjuWyY0h+Qaj5U@kernel.org/

and my first reaction was to send a revert the untested commit 110860541f44
("mm/secretmem: use refcount_t instead of atomic_t"). 

Anyway, this should fix it:

From c22a588fab3a0762f0a8c0dbab99343c48b3e27b Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Sat, 23 Oct 2021 18:13:16 +0300
Subject: [PATCH] secretmem: bump initial refcount to fix refcount woes

Commit 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
replaced atomic_t with refcount_t but it dind't take into account that
unlike atomic_inc(), refcount_inc() presumes that "the caller already has a
reference on the object". With that, using 0 as initial count caused
warnings in the refcount code:

[   20.957833] ------------[ cut here ]------------
[   20.957844] refcount_t: addition on 0; use-after-free.
[   20.957897] WARNING: CPU: 3 PID: 598 at /home/rppt/git/linux/lib/refcount.c:25 refcount_warn_saturate+0xcf/0xf0
[   20.957919] Modules linked in:
[   20.957930] CPU: 3 PID: 598 Comm: secretmemfd Not tainted 5.15.0-rc6+ #432
[   20.957944] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[   20.957948] RIP: 0010:refcount_warn_saturate+0xcf/0xf0
[   20.957957] Code: 01 01 e8 d4 db c3 ff 0f 0b c3 80 3d 39 32 43 01 00 0f 85 6b ff ff ff 48 c7 c7 00 bc c5 af c6 05 25 32 43 01 01 e8 b1 db c3 ff <0f> 0b c3 48 c7 c7 b0 bb c5 af c6 05 10 32 43 01 01 e8 9b db c3 ff
[   20.957962] RSP: 0018:ffffb188c0583f20 EFLAGS: 00010282
[   20.957967] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000027
[   20.957971] RDX: 0000000000000000 RSI: ffff8bfefbb975b0 RDI: ffff8bfefbb975b8
[   20.957974] RBP: ffffb188c0583f48 R08: 0000000000000000 R09: 0000000000000001
[   20.957977] R10: 0000000000000003 R11: ffffb188c0583d38 R12: 0000000000000000
[   20.957980] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   20.957983] FS:  00007f9467b9c740(0000) GS:ffff8bfefbb80000(0000) knlGS:0000000000000000
[   20.957993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.957997] CR2: 00007ffe83be8084 CR3: 00000001100cc003 CR4: 0000000000060ee0
[   20.958001] Call Trace:
[   20.959285]  __x64_sys_memfd_secret+0xa9/0xc0
[   20.959308]  do_syscall_64+0x3a/0x80
[   20.959331]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   20.959352] RIP: 0033:0x7f9467cba89d
[   20.959358] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
[   20.959362] RSP: 002b:00007ffe83bb8148 EFLAGS: 00000206 ORIG_RAX: 00000000000001bf
[   20.959368] RAX: ffffffffffffffda RBX: 0000561f62400d50 RCX: 00007f9467cba89d
[   20.959372] RDX: 0000000000000e11 RSI: 0000000000008000 RDI: 0000000000000000
[   20.959375] RBP: 00007ffe83bb8160 R08: 000000002c06910a R09: 0000000000000000
[   20.959378] R10: 00007f9467d8a1c4 R11: 0000000000000206 R12: 0000561f624008d0
[   20.959381] R13: 00007ffe83bb82b0 R14: 0000000000000000 R15: 0000000000000000
[   20.959386] ---[ end trace 9368244c7159e4de ]---
[   20.960666] ------------[ cut here ]------------
[   20.960675] refcount_t: decrement hit 0; leaking memory.
[   20.960717] WARNING: CPU: 1 PID: 598 at /home/rppt/git/linux/lib/refcount.c:31 refcount_warn_saturate+0x4f/0xf0
[   20.960737] Modules linked in:
[   20.960742] CPU: 1 PID: 598 Comm: secretmemfd Tainted: G        W         5.15.0-rc6+ #432
[   20.960748] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[   20.960751] RIP: 0010:refcount_warn_saturate+0x4f/0xf0
[   20.960759] Code: 00 00 f3 c3 83 fe 03 74 43 83 fe 04 75 1f 80 3d b3 32 43 01 00 75 eb 48 c7 c7 58 bc c5 af c6 05 a3 32 43 01 01 e8 31 dc c3 ff <0f> 0b c3 80 3d 93 32 43 01 00 75 cc 48 c7 c7 88 bc c5 af c6 05 83
[   20.960764] RSP: 0018:ffffb188c0583e40 EFLAGS: 00010286
[   20.960769] RAX: 0000000000000000 RBX: ffff8bfec1f51900 RCX: 0000000000000027
[   20.960772] RDX: 0000000000000000 RSI: ffff8bfefba975b0 RDI: ffff8bfefba975b8
[   20.960775] RBP: 0000000000080003 R08: 0000000000000000 R09: 0000000000000001
[   20.960778] R10: ffff8bfec439da80 R11: ffffb188c0583c58 R12: ffff8bfec4e576a0
[   20.960781] R13: ffff8bfec01a8ca0 R14: ffff8bfecd314300 R15: 0000000000000000
[   20.960784] FS:  0000000000000000(0000) GS:ffff8bfefba80000(0000) knlGS:0000000000000000
[   20.960835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.960840] CR2: 00007f9467c85290 CR3: 0000000080a0c004 CR4: 0000000000060ee0
[   20.960843] Call Trace:
[   20.960849]  secretmem_release+0x26/0x30
[   20.960862]  __fput+0x85/0x240
[   20.960868]  task_work_run+0x67/0xa0
[   20.960890]  do_exit+0x363/0xbb0
[   20.960902]  do_group_exit+0x35/0x90
[   20.960908]  __x64_sys_exit_group+0xf/0x10
[   20.960913]  do_syscall_64+0x3a/0x80
[   20.960922]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   20.960928] RIP: 0033:0x7f9467c852c6
[   20.960933] Code: Unable to access opcode bytes at RIP 0x7f9467c8529c.
[   20.960936] RSP: 002b:00007ffe83bb8168 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   20.960941] RAX: ffffffffffffffda RBX: 00007f9467d8c610 RCX: 00007f9467c852c6
[   20.960944] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
[   20.960947] RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
[   20.960950] R10: 0000000000000003 R11: 0000000000000246 R12: 00007f9467d8c610
[   20.960953] R13: 0000000000000001 R14: 00007f9467d8ffc8 R15: 0000000000000000
[   20.960957] ---[ end trace 9368244c7159e4df ]---

Bump the initial reference count value to 1 to fix this.

Fixes: 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/secretmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1fea68b8d5a6..06fd6407ed03 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -41,11 +41,11 @@ module_param_named(enable, secretmem_enable, bool, 0400);
 MODULE_PARM_DESC(secretmem_enable,
 		 "Enable secretmem and memfd_secret(2) system call");
 
-static refcount_t secretmem_users;
+static refcount_t secretmem_users = REFCOUNT_INIT(1);
 
 bool secretmem_active(void)
 {
-	return !!refcount_read(&secretmem_users);
+	return refcount_read(&secretmem_users) > 1;
 }
 
 static vm_fault_t secretmem_fault(struct vm_fault *vmf)
-- 
2.28.0


-- 
Sincerely yours,
Mike.
