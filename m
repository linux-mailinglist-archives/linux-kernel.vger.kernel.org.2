Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE367457BF9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 07:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhKTGOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 01:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhKTGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 01:14:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A850DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 22:11:12 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id iq11so9499955pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 22:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nY9MaSoEn1LB+2x/gMzNbsFxhn8Zrur3BCpU+fYZm1c=;
        b=ixdgaZOgcTRDEkxgjsOwWEOzBvaaKOBbzI4XVwbcOuniYIdeq6J8OcQb70J5eOTrjE
         5Ep9t0ynol9yCeuh1rZ5kUCSiVhoS1/SJ69XFHwQPQccZZO3cUlGtNHXE/fB5DLqSwpM
         H4eyrtcAOZ48rWpyiI1UbBGg2Pa5QDdOj5wYYvVjuGPSMIXxEPMwoZVZBnwV6P/TiXM5
         4a9nEx+sI4FRtB7yP3+56tcIJfRGd8JxsaRrYu0Avk1lj8C1nwvdzomzPJIJotagJppa
         H7aEqqX/YAUDRX4CX++axDXTrdrndJqL/mIfE+a5wnsBLFWvgC8g/1PsAMNkO08CFaC+
         aWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nY9MaSoEn1LB+2x/gMzNbsFxhn8Zrur3BCpU+fYZm1c=;
        b=EwTeu4SaqHW4fwa39Vfi0Ud1Vtdnq+e/RLgeV7L5iqirCQdnkiGv2wZ/EjVdHXxHlF
         p2MrQAaMmgfVabSd9PQI5LAOO+Hwap/oB1aZNFgrcTJdmJtSpDd+tS6cdUtxAntefS85
         HitNBXmht667ycCf8HNAw7XzNHQ4oqefb0sYW+g82YpDVC/OMMFnfRo9xeJCgsQQjP9L
         ArXBVgMQmEA01PxPDXOWgP9JiOdPea95Q75k811veKaf2OIpUZqN9+klrocPZpeHRACK
         beSMesM/hlpsLnA/j1QDKf5nH6eqi7Zx7Cfmm0Rsz6jrGW9SvJCNAuTaYbwbYeh4Yi/7
         ++0g==
X-Gm-Message-State: AOAM5311JhGsaqPY5eYUabF05tzfvuskt5aw4HWjOYhlK6kom+gOC9J8
        /tPMisoPb3gpvAzQ8rOMugA=
X-Google-Smtp-Source: ABdhPJy9o+XaqK5kmmU5XKE7b3/Z/IrlvjGedjet3VARHUljVQtztiyAwMqlWFs5hulGRnw9UEG2oQ==
X-Received: by 2002:a17:902:a40f:b0:143:d470:d66d with SMTP id p15-20020a170902a40f00b00143d470d66dmr41395035plq.52.1637388672021;
        Fri, 19 Nov 2021 22:11:12 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id t1sm1142873pgj.89.2021.11.19.22.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Nov 2021 22:11:11 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [syzbot] KCSAN: data-race in flush_tlb_batched_pending /
 try_to_unmap_one
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YZZn4CPEK7pP4ohN@elver.google.com>
Date:   Fri, 19 Nov 2021 22:11:10 -0800
Cc:     syzbot <syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Mel Gorman <mgorman@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D32C44CD-2010-48C1-A213-9059A9D62C56@gmail.com>
References: <00000000000020805d05d110dc77@google.com>
 <YZZn4CPEK7pP4ohN@elver.google.com>
To:     Marco Elver <elver@google.com>,
        "Huang, Ying" <ying.huang@intel.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 18, 2021, at 6:49 AM, Marco Elver <elver@google.com> wrote:
>=20
> On Thu, Nov 18, 2021 at 06:20AM -0800, syzbot wrote:
>> Hello,
>>=20
>> syzbot found the following issue on:
>>=20
>> HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of =
git://git..
>> git tree:       upstream
>> console output: =
https://syzkaller.appspot.com/x/log.txt?x=3D13160026b00000
>> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3Da70237460d215073
>> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3Daa5bebed695edaccf0df
>> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils =
for Debian) 2.35.2
>>=20
>> Unfortunately, I don't have any reproducer for this issue yet.
>>=20
>> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
>> Reported-by: syzbot+aa5bebed695edaccf0df@syzkaller.appspotmail.com
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> BUG: KCSAN: data-race in flush_tlb_batched_pending / try_to_unmap_one
>>=20
>> write to 0xffff8881072cfbbc of 1 bytes by task 17406 on cpu 1:
>> flush_tlb_batched_pending+0x5f/0x80 mm/rmap.c:691
>> madvise_free_pte_range+0xee/0x7d0 mm/madvise.c:594
>> walk_pmd_range mm/pagewalk.c:128 [inline]
>> walk_pud_range mm/pagewalk.c:205 [inline]
>> walk_p4d_range mm/pagewalk.c:240 [inline]
>> walk_pgd_range mm/pagewalk.c:277 [inline]
>> __walk_page_range+0x981/0x1160 mm/pagewalk.c:379
>> walk_page_range+0x131/0x300 mm/pagewalk.c:475
>> madvise_free_single_vma mm/madvise.c:734 [inline]
>> madvise_dontneed_free mm/madvise.c:822 [inline]
>> madvise_vma mm/madvise.c:996 [inline]
>> do_madvise+0xe4a/0x1140 mm/madvise.c:1202
>> __do_sys_madvise mm/madvise.c:1228 [inline]
>> __se_sys_madvise mm/madvise.c:1226 [inline]
>> __x64_sys_madvise+0x5d/0x70 mm/madvise.c:1226
>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>> do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
>> entry_SYSCALL_64_after_hwframe+0x44/0xae
>>=20
>> write to 0xffff8881072cfbbc of 1 bytes by task 71 on cpu 0:
>> set_tlb_ubc_flush_pending mm/rmap.c:636 [inline]
>> try_to_unmap_one+0x60e/0x1220 mm/rmap.c:1515
>> rmap_walk_anon+0x2fb/0x470 mm/rmap.c:2301
>> try_to_unmap+0xec/0x110
>> shrink_page_list+0xe91/0x2620 mm/vmscan.c:1719
>> shrink_inactive_list+0x3fb/0x730 mm/vmscan.c:2394
>> shrink_list mm/vmscan.c:2621 [inline]
>> shrink_lruvec+0x3c9/0x710 mm/vmscan.c:2940
>> shrink_node_memcgs+0x23e/0x410 mm/vmscan.c:3129
>> shrink_node+0x8f6/0x1190 mm/vmscan.c:3252
>> kswapd_shrink_node mm/vmscan.c:4022 [inline]
>> balance_pgdat+0x702/0xd30 mm/vmscan.c:4213
>> kswapd+0x200/0x340 mm/vmscan.c:4473
>> kthread+0x2c7/0x2e0 kernel/kthread.c:327
>> ret_from_fork+0x1f/0x30
>>=20
>> value changed: 0x01 -> 0x00
>>=20
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 0 PID: 71 Comm: kswapd0 Not tainted 5.16.0-rc1-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 01/01/2011
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Reading 3ea277194daae, I can't quite determine if this is safe and
> expected.
>=20
> Per this observed write/write race, depending on interleaving
> tlb_flush_batched can randomly be true or false after
> set_tlb_ubc_flush_pending().
>=20
> Is this safe?
>=20

I do not think it is safe and I am not the only one.

=
https://lore.kernel.org/linux-mm/20210131001132.3368247-21-namit@vmware.co=
m/

Perhaps Huang has the cycles to fix it.

Regards,
Nadav=
