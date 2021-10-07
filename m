Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C1E425419
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241585AbhJGNa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:30:28 -0400
Received: from mail-4325.protonmail.ch ([185.70.43.25]:33149 "EHLO
        mail-4325.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbhJGNa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:30:26 -0400
Date:   Thu, 07 Oct 2021 13:28:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.ch;
        s=protonmail; t=1633613310;
        bh=JogLHouAb4PJxnNMQhFoguu1NRzbqJBK2hCAgnz8oa4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=OiVD03SvFdoSyrDxR4t5DnZyu9fOT23rkb6wByu4oFAnqY+LKxsM16bDd7BMOgPbp
         cHCz9xgJAGdOeBC55Ge4tmS2Llm31SNYroFSRNHLauJHU8ncVhREsiep83QsIQAUmk
         72ze2gWc9IdVUZ7Tg4tnU4ZTv53mW1hBpWvSxwQs=
To:     Hillf Danton <hdanton@sina.com>
From:   Jordan Glover <Golden_Miller83@protonmail.ch>
Cc:     Yu Zhao <yuzhao@google.com>, Alexey Gladkov <legion@kernel.org>,
        ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, containers@lists.linux-foundation.org
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: linux 5.14.3: free_user_ns causes NULL pointer dereference
Message-ID: <BCdQdQjRHZ9CJwIhmvKGfnFtMBJuatrZUX5In1gLlPswtrs4HwNONAbJleaeSfOOenMIdc_FPi0wwPIdW5Vodm4Aj-0iCqQY57288M5WFuY=@protonmail.ch>
In-Reply-To: <20211006021219.2010-1-hdanton@sina.com>
References: <1M9_d6wrcu6rdPe1ON0_k0lOxJMyyot3KAb1gdyuwzDPC777XVUWPHoTCEVmcK3fYfgu7sIo3PSaLe9KulUdm4TWVuqlbKyYGxRAjsf_Cpk=@protonmail.ch> <87ee9pa6xw.fsf@disp2133> <OJK-F2NSBlem52GqvCQYzaVxs2x9Csq3qO4QbTG4A4UUNaQpebpAQmyyKzUd70CIo27C4K7CL3bhIzcxulIzYMu067QOMXCFz8ejh3ZtFhE=@protonmail.ch> <U6ByMUZ9LgvxXX6eb0M9aBx8cw8GpgE1qU22LaxaJ_2bOdnGLLJHDgnLL-6cJT7dKdcG_Ms37APSutc3EIMmtpgpP_2kotVLCNRoUq-wTJ8=@protonmail.ch> <878rzw77i3.fsf@disp2133> <o3tuBB58KUQjyQsALqWi0s1tSPlgVPST4PNNjHewIgRB7CUOOVyFSFxSBLCOJdUH3ly21cIjBthNyqQGnDgJD7fjU8NiVHq7i0JcMvYuzUA=@protonmail.ch> <20210929173611.fo5traia77o63gpw@example.org> <hPgvCJ2KbKeauk78uWJEsuKJ5VfMqknPJ_oyOZe6M78-6eG7qnj0t0UKC-joPVowo_nOikIsEWP-ZDioARfI-Cl6zrHjCHPJST3drpi5ALE=@protonmail.ch> <20210930130640.wudkpmn3cmah2cjz@example.org> <20211006021219.2010-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 6th, 2021 at 2:12 AM, Hillf Danton <hdanton@sina.com>=
 wrote:

> Could you please check if it is due to count underflow? Given nothing wro=
ng
>
> on the other side based on the efforts
>
> "We looked through the users of put_ucounts and we don't see any obvious =
buggy
>
> users that would be freeing the data structure early."
>
> Thanks
>
> Hillf
>
> --- linux-5.14.4/kernel/ucount.c
>
> +++ b/kernel/ucount.c
>
> @@ -152,7 +152,10 @@ static void hlist_add_ucounts(struct uco
>
> struct ucounts *get_ucounts(struct ucounts *ucounts)
>
> {
>
> -   if (ucounts && atomic_add_negative(1, &ucounts->count)) {
>
> -   if (!ucounts)
>
> -         return NULL;
>
>
> -   WARN_ON(!atomic_read(&ucounts->count));
>
> -   if (atomic_add_negative(1, &ucounts->count)) {
>
>         put_ucounts(ucounts);
>         ucounts =3D NULL;
>
>
>     }
>
>     --
>

For me above patch changed slightly the printed output. Now the warning
comes from 'cleanup_net' instead of 'free_user_ns'. My system was also
still responsive after the bug occurred which didn't happen previously.
I can't say if this means anything or if this is result of above patch
or instability of my reproducer.

------------[ cut here ]------------
WARNING: CPU: 2 PID: 27643 at kernel/ucount.c:256 dec_ucount+0x43/0x50
Modules linked in: <cut>
CPU: 2 PID: 27643 Comm: kworker/u8:3 Not tainted 5.14.9 #1 0274f3d0712a6dad=
c9a2cf8341ae333de732a31a
Workqueue: netns cleanup_net
RIP: 0010:dec_ucount+0x43/0x50
Code: 14 01 48 8b 02 48 89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b =
41 10 48 8b 88 e8 01 00 00 48 85 c9 75 d9 e9 fd fc ff ff <0f> 0b eb e7 66 0=
f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 f8 48
RSP: 0018:ffffb34fc34cfe30 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffffa448eec5f3b0 RCX: ffffa447cfe1f540
RDX: ffffa447cfe1f580 RSI: ffffffffffffffff RDI: ffffa447c445c780
RBP: ffffa448eec5f380 R08: 0000000000000040 R09: ffffa44a196ac040
R10: 00000000001436be R11: 0000000000000259 R12: ffffb34fc34cfe10
R13: ffffb34fc34cfe40 R14: 00000000ffffffff R15: ffffa448eec5d414
FS:  0000000000000000(0000) GS:ffffa44a19700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000072a95d359030 CR3: 000000000b20e005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cleanup_net+0x2e2/0x370
 process_one_work+0x1e1/0x380
 worker_thread+0x50/0x3a0
 ? rescuer_thread+0x360/0x360
 kthread+0x127/0x150
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
---[ end trace e5fdc3317f00d0e8 ]---
BUG: kernel NULL pointer dereference, address: 00000000000001e8
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 2 PID: 27643 Comm: kworker/u8:3 Tainted: G        W         5.14.9 #1 =
0274f3d0712a6dadc9a2cf8341ae333de732a31a
Workqueue: netns cleanup_net
RIP: 0010:dec_ucount+0x32/0x50
Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 =
89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 0=
0 00 48 85 c9 75 d9 e9 fd fc ff ff 0f 0b eb e7 66
RSP: 0018:ffffb34fc34cfe30 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffffa448eec5f3b0 RCX: ffffa447cfe1f540
RDX: ffffa447cfe1f580 RSI: ffffffffffffffff RDI: ffffa447c445c780
RBP: ffffa448eec5f380 R08: 0000000000000040 R09: ffffa44a196ac040
R10: 00000000001436be R11: 0000000000000259 R12: ffffb34fc34cfe10
R13: ffffb34fc34cfe40 R14: 00000000ffffffff R15: ffffa448eec5d414
FS:  0000000000000000(0000) GS:ffffa44a19700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001e8 CR3: 000000000b20e005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 cleanup_net+0x2e2/0x370
 process_one_work+0x1e1/0x380
 worker_thread+0x50/0x3a0
 ? rescuer_thread+0x360/0x360
 kthread+0x127/0x150
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30
Modules linked in: <cut>
CR2: 00000000000001e8
---[ end trace e5fdc3317f00d0e9 ]---
RIP: 0010:dec_ucount+0x32/0x50
Code: 74 34 89 f6 48 89 f9 4c 8d 04 f5 20 00 00 00 4a 8d 14 01 48 8b 02 48 =
89 c6 48 83 ee 01 78 1c f0 48 0f b1 32 75 f0 48 8b 41 10 <48> 8b 88 e8 01 0=
0 00 48 85 c9 75 d9 e9 fd fc ff ff 0f 0b eb e7 66
RSP: 0018:ffffb34fc34cfe30 EFLAGS: 00010297
RAX: 0000000000000000 RBX: ffffa448eec5f3b0 RCX: ffffa447cfe1f540
RDX: ffffa447cfe1f580 RSI: ffffffffffffffff RDI: ffffa447c445c780
RBP: ffffa448eec5f380 R08: 0000000000000040 R09: ffffa44a196ac040
R10: 00000000001436be R11: 0000000000000259 R12: ffffb34fc34cfe10
R13: ffffb34fc34cfe40 R14: 00000000ffffffff R15: ffffa448eec5d414
FS:  0000000000000000(0000) GS:ffffa44a19700000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000001e8 CR3: 000000000b20e005 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
