Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B28438468
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 19:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJWRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhJWRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 13:05:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22821C061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 10:03:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y7so6500967pfg.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 10:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Z8YVD43JO6IPkj/F0gu+zy8H4BQZhAMG2A4SO23MV9c=;
        b=EvzyrmZ57VEQtC2dE6XGMBnok4CgXu9+lnIWphPelWptRg50Ouru9IRL1H+KdHhmhO
         1QNmPnQ4QzAt5Yp6yj2yd5l5f2vYoZUdRmy2kGPTWvjxJf4ePqt8paTT2XfwxWH3wbWb
         ndM4sFtK3mlu+DVxSyyUnPzCKScXTyphkRwSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Z8YVD43JO6IPkj/F0gu+zy8H4BQZhAMG2A4SO23MV9c=;
        b=0h3H7qIJR7abItVscDJZYOnj5gTOrV+qSvoJm2s0aMf74+hyREtXxFwEpRoWw3gk2B
         xxZ/zjG95Bz6IIEXz/k/ctntU02A+aq0eV5iGKuzmvzsb958AmDJi7sCwbtK6BkmnlrS
         2893x27eoEiNGugu2alv2arJe39K8Kd6hrdKoPKevGCszEbQzYQ6E/Cbdmsp0gVZu0Qk
         OaHtyrb17s72+zq0i+gfjx5GpJeABn/oACRuBmajedG4/7Dz+txYrS/Jwg56MFnZRVaS
         3ioVJR36Z5PBYvC2PIxxrRr9Apu0berzJmNWERHqHTgNuy+THSX8tGzwC//ZlB36y/SL
         aHjg==
X-Gm-Message-State: AOAM531ILHAtSME3Zbgwe2n7IxALTtlwQ1UXdtQZtfH9UDHQepWmiw5A
        D0+D2GiCy+nRlofphp0rwlqlGw==
X-Google-Smtp-Source: ABdhPJxeOExRNh+8e1VGhSdVr/V2ebeRjCyo7npj4uCT51sGnkANN0dITLi9oj692BNtrxKdfmq28A==
X-Received: by 2002:a63:b448:: with SMTP id n8mr5365755pgu.31.1635008593492;
        Sat, 23 Oct 2021 10:03:13 -0700 (PDT)
Received: from [127.0.0.1] (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u12sm7274715pfi.217.2021.10.23.10.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 10:03:13 -0700 (PDT)
Date:   Sat, 23 Oct 2021 10:03:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mike Rapoport <rppt@kernel.org>, Dmitry Vyukov <dvyukov@google.com>
CC:     syzbot <syzbot+b904a1de3ec43711eba5@syzkaller.appspotmail.com>,
        Jordy Zomer <jordy@pwning.systems>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in sys_memfd_secret
User-Agent: K-9 Mail for Android
In-Reply-To: <YXQp4MsT0EEKqMl/@kernel.org>
References: <00000000000062d0fc05cef24c57@google.com> <CACT4Y+aFvuvBew3c6gV9VwE5Fi_4tbPX9Am1xf628ynzKFFLeg@mail.gmail.com> <YXQp4MsT0EEKqMl/@kernel.org>
Message-ID: <088FF23B-CD8E-4E53-B702-53E2C2382062@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On October 23, 2021 8:27:28 AM PDT, Mike Rapoport <rppt@kernel=2Eorg> wrot=
e:
>On Fri, Oct 22, 2021 at 05:07:40PM +0200, Dmitry Vyukov wrote:
>> On Fri, 22 Oct 2021 at 17:02, syzbot
>> <syzbot+b904a1de3ec43711eba5@syzkaller=2Eappspotmail=2Ecom> wrote:
>> >
>> > Hello,
>> >
>> > syzbot found the following issue on:
>> >
>> > HEAD commit:    64222515138e Merge tag 'drm-fixes-2021-10-22' of git:=
//ano=2E=2E
>> > git tree:       upstream
>> > console output: https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D178=
e86c4b00000
>> > kernel config:  https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3Dbe3=
98dd7862f4b36
>> > dashboard link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3Db904a1d=
e3ec43711eba5
>> > compiler:       gcc (Debian 10=2E2=2E1-6) 10=2E2=2E1 20210110, GNU ld=
 (GNU Binutils for Debian) 2=2E35=2E2
>> >
>> > Unfortunately, I don't have any reproducer for this issue yet=2E
>> >
>> > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
>> > Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller=2Eappspotmail=2Eco=
m
>>=20
>> +Mike, Jordy for secretmem=2Ec
>
>I was actually the first to report it ;-)
>
>https://lore=2Ekernel=2Eorg/all/YXJjuWyY0h+Qaj5U@kernel=2Eorg/
>
>and my first reaction was to send a revert the untested commit 110860541f=
44
>("mm/secretmem: use refcount_t instead of atomic_t")=2E=20
>
>Anyway, this should fix it:
>
>From c22a588fab3a0762f0a8c0dbab99343c48b3e27b Mon Sep 17 00:00:00 2001
>From: Mike Rapoport <rppt@linux=2Eibm=2Ecom>
>Date: Sat, 23 Oct 2021 18:13:16 +0300
>Subject: [PATCH] secretmem: bump initial refcount to fix refcount woes
>
>Commit 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
>replaced atomic_t with refcount_t but it dind't take into account that
>unlike atomic_inc(), refcount_inc() presumes that "the caller already has=
 a
>reference on the object"=2E With that, using 0 as initial count caused
>warnings in the refcount code:
>
>[   20=2E957833] ------------[ cut here ]------------
>[   20=2E957844] refcount_t: addition on 0; use-after-free=2E
>[   20=2E957897] WARNING: CPU: 3 PID: 598 at /home/rppt/git/linux/lib/ref=
count=2Ec:25 refcount_warn_saturate+0xcf/0xf0
>[   20=2E957919] Modules linked in:
>[   20=2E957930] CPU: 3 PID: 598 Comm: secretmemfd Not tainted 5=2E15=2E0=
-rc6+ #432
>[   20=2E957944] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1=2E10=2E2-1ubuntu1 04/01/2014
>[   20=2E957948] RIP: 0010:refcount_warn_saturate+0xcf/0xf0
>[   20=2E957957] Code: 01 01 e8 d4 db c3 ff 0f 0b c3 80 3d 39 32 43 01 00=
 0f 85 6b ff ff ff 48 c7 c7 00 bc c5 af c6 05 25 32 43 01 01 e8 b1 db c3 ff=
 <0f> 0b c3 48 c7 c7 b0 bb c5 af c6 05 10 32 43 01 01 e8 9b db c3 ff
>[   20=2E957962] RSP: 0018:ffffb188c0583f20 EFLAGS: 00010282
>[   20=2E957967] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000=
000000027
>[   20=2E957971] RDX: 0000000000000000 RSI: ffff8bfefbb975b0 RDI: ffff8bf=
efbb975b8
>[   20=2E957974] RBP: ffffb188c0583f48 R08: 0000000000000000 R09: 0000000=
000000001
>[   20=2E957977] R10: 0000000000000003 R11: ffffb188c0583d38 R12: 0000000=
000000000
>[   20=2E957980] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000=
000000000
>[   20=2E957983] FS:  00007f9467b9c740(0000) GS:ffff8bfefbb80000(0000) kn=
lGS:0000000000000000
>[   20=2E957993] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   20=2E957997] CR2: 00007ffe83be8084 CR3: 00000001100cc003 CR4: 0000000=
000060ee0
>[   20=2E958001] Call Trace:
>[   20=2E959285]  __x64_sys_memfd_secret+0xa9/0xc0
>[   20=2E959308]  do_syscall_64+0x3a/0x80
>[   20=2E959331]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>[   20=2E959352] RIP: 0033:0x7f9467cba89d
>[   20=2E959358] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa=
 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 f5 0c 00 f7 d8 64 89 01 48
>[   20=2E959362] RSP: 002b:00007ffe83bb8148 EFLAGS: 00000206 ORIG_RAX: 00=
000000000001bf
>[   20=2E959368] RAX: ffffffffffffffda RBX: 0000561f62400d50 RCX: 00007f9=
467cba89d
>[   20=2E959372] RDX: 0000000000000e11 RSI: 0000000000008000 RDI: 0000000=
000000000
>[   20=2E959375] RBP: 00007ffe83bb8160 R08: 000000002c06910a R09: 0000000=
000000000
>[   20=2E959378] R10: 00007f9467d8a1c4 R11: 0000000000000206 R12: 0000561=
f624008d0
>[   20=2E959381] R13: 00007ffe83bb82b0 R14: 0000000000000000 R15: 0000000=
000000000
>[   20=2E959386] ---[ end trace 9368244c7159e4de ]---
>[   20=2E960666] ------------[ cut here ]------------
>[   20=2E960675] refcount_t: decrement hit 0; leaking memory=2E
>[   20=2E960717] WARNING: CPU: 1 PID: 598 at /home/rppt/git/linux/lib/ref=
count=2Ec:31 refcount_warn_saturate+0x4f/0xf0
>[   20=2E960737] Modules linked in:
>[   20=2E960742] CPU: 1 PID: 598 Comm: secretmemfd Tainted: G        W   =
      5=2E15=2E0-rc6+ #432
>[   20=2E960748] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1=2E10=2E2-1ubuntu1 04/01/2014
>[   20=2E960751] RIP: 0010:refcount_warn_saturate+0x4f/0xf0
>[   20=2E960759] Code: 00 00 f3 c3 83 fe 03 74 43 83 fe 04 75 1f 80 3d b3=
 32 43 01 00 75 eb 48 c7 c7 58 bc c5 af c6 05 a3 32 43 01 01 e8 31 dc c3 ff=
 <0f> 0b c3 80 3d 93 32 43 01 00 75 cc 48 c7 c7 88 bc c5 af c6 05 83
>[   20=2E960764] RSP: 0018:ffffb188c0583e40 EFLAGS: 00010286
>[   20=2E960769] RAX: 0000000000000000 RBX: ffff8bfec1f51900 RCX: 0000000=
000000027
>[   20=2E960772] RDX: 0000000000000000 RSI: ffff8bfefba975b0 RDI: ffff8bf=
efba975b8
>[   20=2E960775] RBP: 0000000000080003 R08: 0000000000000000 R09: 0000000=
000000001
>[   20=2E960778] R10: ffff8bfec439da80 R11: ffffb188c0583c58 R12: ffff8bf=
ec4e576a0
>[   20=2E960781] R13: ffff8bfec01a8ca0 R14: ffff8bfecd314300 R15: 0000000=
000000000
>[   20=2E960784] FS:  0000000000000000(0000) GS:ffff8bfefba80000(0000) kn=
lGS:0000000000000000
>[   20=2E960835] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>[   20=2E960840] CR2: 00007f9467c85290 CR3: 0000000080a0c004 CR4: 0000000=
000060ee0
>[   20=2E960843] Call Trace:
>[   20=2E960849]  secretmem_release+0x26/0x30
>[   20=2E960862]  __fput+0x85/0x240
>[   20=2E960868]  task_work_run+0x67/0xa0
>[   20=2E960890]  do_exit+0x363/0xbb0
>[   20=2E960902]  do_group_exit+0x35/0x90
>[   20=2E960908]  __x64_sys_exit_group+0xf/0x10
>[   20=2E960913]  do_syscall_64+0x3a/0x80
>[   20=2E960922]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>[   20=2E960928] RIP: 0033:0x7f9467c852c6
>[   20=2E960933] Code: Unable to access opcode bytes at RIP 0x7f9467c8529=
c=2E
>[   20=2E960936] RSP: 002b:00007ffe83bb8168 EFLAGS: 00000246 ORIG_RAX: 00=
000000000000e7
>[   20=2E960941] RAX: ffffffffffffffda RBX: 00007f9467d8c610 RCX: 00007f9=
467c852c6
>[   20=2E960944] RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000=
000000000
>[   20=2E960947] RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffff=
fffffff80
>[   20=2E960950] R10: 0000000000000003 R11: 0000000000000246 R12: 00007f9=
467d8c610
>[   20=2E960953] R13: 0000000000000001 R14: 00007f9467d8ffc8 R15: 0000000=
000000000
>[   20=2E960957] ---[ end trace 9368244c7159e4df ]---
>
>Bump the initial reference count value to 1 to fix this=2E
>
>Fixes: 110860541f44 ("mm/secretmem: use refcount_t instead of atomic_t")
>Reported-by: syzbot+b904a1de3ec43711eba5@syzkaller=2Eappspotmail=2Ecom
>Signed-off-by: Mike Rapoport <rppt@linux=2Eibm=2Ecom>

Excellent, thanks!

Reviewed-by: Kees Cook <keescook@chromium=2Eorg>

-Kees

>---
> mm/secretmem=2Ec | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/mm/secretmem=2Ec b/mm/secretmem=2Ec
>index 1fea68b8d5a6=2E=2E06fd6407ed03 100644
>--- a/mm/secretmem=2Ec
>+++ b/mm/secretmem=2Ec
>@@ -41,11 +41,11 @@ module_param_named(enable, secretmem_enable, bool, 04=
00);
> MODULE_PARM_DESC(secretmem_enable,
> 		 "Enable secretmem and memfd_secret(2) system call");
>=20
>-static refcount_t secretmem_users;
>+static refcount_t secretmem_users =3D REFCOUNT_INIT(1);
>=20
> bool secretmem_active(void)
> {
>-	return !!refcount_read(&secretmem_users);
>+	return refcount_read(&secretmem_users) > 1;
> }
>=20
> static vm_fault_t secretmem_fault(struct vm_fault *vmf)

--=20
Kees Cook
