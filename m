Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E343F59AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhHXIKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:10:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34152 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233910AbhHXIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629792606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=MGsYtJMGFLyprrQTnd9PIheslLOcxb8mNsq/26oD5hU=;
        b=Z/+Vuh0uVr2LYZpi7GNsKeudV+OE9y5fNmNJCzyIQ2zIH18eF6FOgB+xuQ8XcgItnJBz05
        J7q5OM1YQ9NYVbcgm0AFquWZqISJ0hKPSKNkUPsQ2ZYD+yRgsB458NhemaG1EzSqf26JLL
        ISP2RyR0Ra4Tw9kNymWk3v4FDVegD0M=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-AnvXHUbuM0WVd2uIJYgA3w-1; Tue, 24 Aug 2021 04:10:04 -0400
X-MC-Unique: AnvXHUbuM0WVd2uIJYgA3w-1
Received: by mail-oo1-f70.google.com with SMTP id f2-20020a4a2202000000b0028c8a8074deso8709092ooa.20
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=MGsYtJMGFLyprrQTnd9PIheslLOcxb8mNsq/26oD5hU=;
        b=QsGJQsejBLXNQcrnopXz+tAKB4vDwW9EP2L6mspoGdl1Ko4wAmZejN2X8/U54HLNwX
         YbPOnMKa0Vfvt4bfLsEZZZRaOX4VnGgJosB2p1BljCe8OdEVpUJgokO26Dca43Ag7P9Q
         luDSjJE6EfuXW66E+jLNM5q++4jAyHDNyP50c7cD/Drv717Ofm2TjqwpLJTu1GRWg90O
         TmBdqdHLHSZnSjFUIF9lO76krz6Z4gdjFfGgOnYWqTBtjyTLjnnngDD+VnHzHiPxMRdz
         7Ov/o5ROR0MKvpBX+v12xdCLOzvjd7c7D1atOrZ1C8dCoSF31wnFLNzGgq7fDB/KXJjx
         2eDA==
X-Gm-Message-State: AOAM530dMkKUsDyk+YfqCFI2o++gu2zq5ytacuENnl4Ubl1nCgkiD8gb
        pfQqoZcoGK07MzqRnyrqQsklCzzzU2kIzpze+rV5UfjCji6hUeRycGweaWd3e5o46xCYoEI6pvn
        l0QDqKOf09iuTXcrJh078vVN923V0WqgcDdGJzSx0
X-Received: by 2002:a4a:4484:: with SMTP id o126mr5638512ooa.90.1629792603775;
        Tue, 24 Aug 2021 01:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxci/jOnkRlZu88z946maUn/riomVLmMlqTthjrndr8zN4dHsF1vDuVBgRRoP1wMnEnJWQy1EqPXmpRxAELDps=
X-Received: by 2002:a4a:4484:: with SMTP id o126mr5638501ooa.90.1629792603519;
 Tue, 24 Aug 2021 01:10:03 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 24 Aug 2021 10:09:52 +0200
Message-ID: <CA+QYu4q-sNwhHLOwCQLc=bFwXidH=g-Pnc=eUn_UXm4wm3TURA@mail.gmail.com>
Subject: BUG: sleeping function called from invalid context at mm/page_alloc.c:5169
To:     linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Memory Management <mm-qe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since commit "002c0aef1090 - Merge tag 'block-5.14-2021-08-20'" we
started to see the following call trace when booting up, it seems to
be reproducible only on ppc64le.

[    4.112119] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid:
1240, name: systemd-udevd
[    4.112150] 1 lock held by systemd-udevd/1240:
[    4.112173]  #0: c0000000026f41e0 (ftrace_lock){+.+.}-{3:3}, at:
ftrace_process_locs.isra.0+0x278/0x530
[    4.112230] irq event stamp: 40788
[    4.112241] hardirqs last  enabled at (40787): [<c0000000004ce300>]
bad_range+0x1d0/0x200
[    4.112281] hardirqs last disabled at (40788): [<c0000000000b09e4>]
patch_instruction+0x3b4/0x510
[    4.112322] softirqs last  enabled at (36242): [<c0000000011e7c1c>]
__do_softirq+0x60c/0x67c
[    4.112364] softirqs last disabled at (36233): [<c000000000165544>]
__irq_exit_rcu+0x234/0x240
[    4.112395] CPU: 56 PID: 1240 Comm: systemd-udevd Not tainted 5.14.0-rc6 #1
[    4.112432] Call Trace:
[    4.112451] [c00000004495f4d0] [c000000000971054]
dump_stack_lvl+0x98/0xe0 (unreliable)
[    4.112485] [c00000004495f510] [c0000000001a920c] ___might_sleep+0x2dc/0x300
[    4.112516] [c00000004495f5a0] [c0000000004cef8c]
prepare_alloc_pages.constprop.0+0x19c/0x280
[    4.112563] [c00000004495f5f0] [c0000000004d86bc] __alloc_pages+0x9c/0x350
[    4.112601] [c00000004495f670] [c00000000050ca0c] alloc_pages+0xcc/0x190
[    4.112643] [c00000004495f6c0] [c00000000008ed0c]
pte_fragment_alloc+0xdc/0x2e0
[    4.112682] [c00000004495f720] [c00000000049d620]
__pte_alloc_kernel+0x40/0xf0
[    4.112723] [c00000004495f770] [c00000000009d4dc]
__map_kernel_page+0x5dc/0x6d0
[    4.112765] [c00000004495f810] [c0000000000b09cc]
patch_instruction+0x39c/0x510
[    4.112807] [c00000004495f8b0] [c000000000077ab4] ftrace_make_nop+0x164/0x730
[    4.112849] [c00000004495f9b0] [c0000000003060ec]
ftrace_process_locs.isra.0+0x39c/0x530
[    4.112893] [c00000004495fa90] [c00000000029ab1c] load_module+0x322c/0x3cb0
[    4.112935] [c00000004495fca0] [c00000000029b8e4]
__do_sys_finit_module+0xc4/0x130
[    4.112977] [c00000004495fdb0] [c00000000002dd5c]
system_call_exception+0x11c/0x2f0
[    4.113021] [c00000004495fe10] [c00000000000c1f0]
system_call_vectored_common+0xf0/0x280
[    4.113064] --- interrupt: 3000 at 0x7fffb67ebeac
[    4.113099] NIP:  00007fffb67ebeac LR: 0000000000000000 CTR: 0000000000000000
[    4.113135] REGS: c00000004495fe80 TRAP: 3000   Not tainted  (5.14.0-rc6)
[    4.113170] MSR:  900000000000f033 <SF,HV,EE,PR,FP,ME,IR,DR,RI,LE>
CR: 48224244  XER: 00000000
[    4.113232] IRQMASK: 0
               GPR00: 0000000000000161 00007ffff63902d0
00007fffb68f6f00 0000000000000006
               GPR04: 00007fffb69cb678 0000000000000000
0000000000000006 0000000000000000
               GPR08: 0000000000000000 0000000000000000
0000000000000000 0000000000000000
               GPR12: 0000000000000000 00007fffb5627810
0000000020000000 0000000000000000
               GPR16: 0000000000000000 00000000000f4240
00007ffff6390828 000000011b8846e0
               GPR20: 0000000000000000 0000000124033bf0
00007fffb6d209d0 0000000124034070
               GPR24: 0000000000000000 0000000124032440
0000000000000007 00007fffb69cb678
               GPR28: 000000012402bd10 0000000000020000
00000001240342c0 0000000124032440
[    4.113534] NIP [00007fffb67ebeac] 0x7fffb67ebeac
[    4.113558] LR [0000000000000000] 0x0
[    4.113588] --- interrupt: 3000


More logs can be found checking out dmesg logs on:
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/08/21/357093404/build_ppc64le_redhat%3A1522897150/tests/Boot_test/10527926_ppc64le_2_dmesg.log
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-public/2021/08/23/357988779/build_ppc64le_redhat%3A1526871701/tests/Reboot_test/10534932_ppc64le_2_dmesg.log

Thank you,
Bruno Goncalves

