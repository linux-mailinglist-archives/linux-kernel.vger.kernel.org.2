Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6D31A1CB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBLPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhBLPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:34:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51F0C0613D6;
        Fri, 12 Feb 2021 07:34:17 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y18so93146edw.13;
        Fri, 12 Feb 2021 07:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UNX3lpz246BomUWba2beahu+LBvzrxFLklYsnW8U4OA=;
        b=VX+pXyzFwBbC+QOrohYWSqjApdES1ts7nU9FqmgvibyeC+qgsKA9gbZPvvs1OWpGOV
         P0SY3OYvVEBlu1xu6e0dqcWgcFSdXbMwvp86lVwXgfAl5VOA5XchJQ7phxhOVjTp6smJ
         iYqDzq8Jm6ckHZilS5qAdKwHRbjUVG3iKHkdnrHS3kappGL8gZwUcTnfoGVlxWMN2vHd
         8W2tBM3YvQvqRHvQ1mmEYRCfcit3kbHiGWxlPAmdHgxj/VJpwwtRrJuUbpZartxlIt03
         IGC9Url5vr5EdcqP28/nuAlu69sbTBa7xXnu792Z8aVcylulpNQu6gMxMbYnBsUHbih+
         YAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UNX3lpz246BomUWba2beahu+LBvzrxFLklYsnW8U4OA=;
        b=H1GebC0YOt04RJGtS/88qpYtX1WbM+B20+1Jn+98L2+U4T3c5Ml9k50LED3oaRrI72
         9ZzKSPhir32ADqyiCZcQWudfFaU6UPRoaQCR6pZV1qhVTMhHV/me5kYpk76GW4hHQwl6
         r52pda3XqwuewrqvFolzynd//pgYvdSHVC6hy3GJ/wnFxAPWS2PxMFnEctxVbK98OZdZ
         TtowYewUjOloSbZQVpyWxkLtJ221w8GQ2KcI2jzLCkyzrenKBT0/Ii3GGkgfAL5+nSDl
         FNKIxuS/prfdysAKclsREfeyc9e0zA7pAKfGJLymt+O3Hgo9+7UllMsu+jlewzuTPmKj
         U8TQ==
X-Gm-Message-State: AOAM533frQtjpRM+bJQpVF7wrtKQksaMhtrMY4WhtF6hBqyFL1KaioCx
        8Dn+DzmErEbIPtJ7w+4lua7esl2HYcDkGYh+1MuftuQldWA=
X-Google-Smtp-Source: ABdhPJxyyj8R1oxx37vQL9VtNwXX6vrdD5x+tMJvrT8kA4mtANJ8C42/T1YpLLxlmx0zusML5TNp6O4vBU3fLyoxAAs=
X-Received: by 2002:a05:6402:270d:: with SMTP id y13mr3933720edd.149.1613144056092;
 Fri, 12 Feb 2021 07:34:16 -0800 (PST)
MIME-Version: 1.0
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Fri, 12 Feb 2021 16:33:59 +0100
Message-ID: <CAH+2xPCmZNW0ct8XoBmAnd0QK53guv2e4HLn40NvWrEA7pj3qw@mail.gmail.com>
Subject: usb: cdc-acm: BUG kmalloc-128 Poison overwritten
To:     linux-usb@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     Bruno Thomsen <bth@kamstrup.com>,
        Lars Alex Pedersen <laa@kamstrup.com>,
        Bruno Thomsen <bruno.thomsen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been experience random kernel oops in the cdc-acm driver on
imx7 (arm arch). Normally it happens during the first 1-3min runtime
after power-on. Below oops is from 5.8.17 mainline kernel with an
extra patch back-ported in an attempt to fix it:
38203b8385 ("usb: cdc-acm: fix cooldown mechanism")

Output from kconfig_hardened_check in version 2020-10-30-g2f8e7a4dc57a
has been included below oops as it might be related to the hardened kernel.

Currently I cannot update to latest mainline kernel as our board
isn't able to boot due to SPI errors on ecspi4 in versions 5.9-5.11rc6.
I am trying to bisect that issue, but I can still apply test patches if
anyone has an idea to why this is happening.

[   55.065305] 8<--- cut here ---
[   55.068392] Unable to handle kernel paging request at virtual
address 6b6b6c03
[   55.075624] pgd = be866494
[   55.078335] [6b6b6c03] *pgd=00000000
[   55.081924] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[   55.087238] Modules linked in: ppp_async crc_ccitt ppp_generic slhc
xt_TCPMSS xt_tcpmss xt_hl nf_log_ipv6 nf_log_ipv4 nf_log_common
xt_policy xt_limit xt_conntrack xt_tcpudp xt_pkttype ip6table_mangle
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_mangle ip6table_filter ip6_tables iptable_filter ip_tables
des_generic md5 sch_fq_codel cdc_mbim cdc_wdm cdc_ncm usbnet mii
cdc_acm usb_storage ip_tunnel xfrm_user xfrm6_tunnel tunnel6
xfrm4_tunnel tunnel4 esp6 esp4 ah6 ah4 xfrm_algo xt_LOG xt_LED
xt_comment x_tables ipv6
[   55.134954] CPU: 0 PID: 82 Comm: kworker/0:2 Tainted: G
   T 5.8.17 #1
[   55.142526] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   55.148304] Workqueue: events acm_softint [cdc_acm]
[   55.153196] PC is at kobject_get+0x10/0xa4
[   55.157302] LR is at usb_get_dev+0x14/0x1c
[   55.161402] pc : [<8047c06c>]    lr : [<80560448>]    psr: 20000193
[   55.167671] sp : bca39ea8  ip : 00007374  fp : bf6cbd80
[   55.172899] r10: 00000000  r9 : bdd92284  r8 : bdd92008
[   55.178128] r7 : 6b6b6b6b  r6 : fffffffe  r5 : 60000113  r4 : 6b6b6be3
[   55.184658] r3 : 6b6b6b6b  r2 : 00000111  r1 : 00000000  r0 : 6b6b6be3
[   55.191191] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[   55.198417] Control: 10c5387d  Table: bcf0c06a  DAC: 00000051
[   55.204168] Process kworker/0:2 (pid: 82, stack limit = 0x9bdd2a89)
[   55.210439] Stack: (0xbca39ea8 to 0xbca3a000)
[   55.214805] 9ea0:                   bf6cbd80 80769a50 6b6b6b6b
80560448 bdeb0500 8056bfe8
[   55.222991] 9ec0: 00000002 b76da000 00000000 bdeb0500 bdd92448
bca38000 bdeb0510 8056d69c
[   55.231177] 9ee0: bca38000 00000000 80c050fc 00000000 bca39f44
09d42015 00000000 00000001
[   55.239363] 9f00: bdd92448 bdd92438 bdd92000 7f1158c4 bdd92448
bca2ee00 bf6cbd80 bf6cef00
[   55.247549] 9f20: 00000000 00000000 00000000 801412d8 bf6cbd98
80c03d00 bca2ee00 bf6cbd80
[   55.255735] 9f40: bca2ee14 bf6cbd98 80c03d00 00000008 bca38000
80141568 00000000 80c446ae
[   55.263921] 9f60: 00000000 bc9ed880 bc9f0700 bca38000 bc117eb4
80141524 bca2ee00 bc9ed8a4
[   55.272107] 9f80: 00000000 80147cc8 00000000 bc9f0700 80147b84
00000000 00000000 00000000
[   55.280292] 9fa0: 00000000 00000000 00000000 80100148 00000000
00000000 00000000 00000000
[   55.288477] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   55.296662] 9fe0: 00000000 00000000 00000000 00000000 00000013
00000000 00000000 00000000
[   55.304860] [<8047c06c>] (kobject_get) from [<80560448>]
(usb_get_dev+0x14/0x1c)
[   55.312271] [<80560448>] (usb_get_dev) from [<8056bfe8>]
(usb_hcd_unlink_urb+0x50/0xd8)
[   55.320286] [<8056bfe8>] (usb_hcd_unlink_urb) from [<8056d69c>]
(usb_kill_urb.part.0+0x44/0xd0)
[   55.329004] [<8056d69c>] (usb_kill_urb.part.0) from [<7f1158c4>]
(acm_softint+0x4c/0x10c [cdc_acm])
[   55.338082] [<7f1158c4>] (acm_softint [cdc_acm]) from [<801412d8>]
(process_one_work+0x19c/0x3e8)
[   55.346969] [<801412d8>] (process_one_work) from [<80141568>]
(worker_thread+0x44/0x4dc)
[   55.355072] [<80141568>] (worker_thread) from [<80147cc8>]
(kthread+0x144/0x180)
[   55.362481] [<80147cc8>] (kthread) from [<80100148>]
(ret_from_fork+0x14/0x2c)
[   55.369706] Exception stack(0xbca39fb0 to 0xbca39ff8)
[   55.374764] 9fa0:                                     00000000
00000000 00000000 00000000
[   55.382949] 9fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   55.391133] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   55.397757] Code: e92d4010 e2504000 e24dd008 0a00000e (e5d43020)
[   55.403857] ---[ end trace 1ec2a82c3635d550 ]---
[   55.408479] note: kworker/0:2[82] exited with preempt_count 1
[   60.237377] =============================================================================
[   60.245593] BUG kmalloc-128 (Tainted: G      D         T): Poison overwritten
[   60.252737] -----------------------------------------------------------------------------
[   60.252737]
[   60.262402] INFO: 0xa0093f52-0xa0093f52 @offset=1296. First byte
0x6c instead of 0x6b
[   60.270249] INFO: Allocated in usb_alloc_urb+0x24/0x58 age=1380 cpu=0 pid=82
[   60.277326] INFO: Freed in acm_disconnect+0x124/0x194 [cdc_acm]
age=521 cpu=0 pid=1566
[   60.285250] INFO: Slab 0xccf60d34 objects=21 used=21 fp=0x00000000
flags=0x10200
[   60.292651] INFO: Object 0xf99f52f8 @offset=1280 fp=0x2bebcd84
[   60.292651]
[   60.299970] Redzone d4df7357: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.308673] Redzone 4d860a97: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.317376] Redzone baac8314: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.326079] Redzone 96f8eac1: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.334782] Redzone ec38f6ed: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.343484] Redzone b3fb9a18: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.352187] Redzone 74064318: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.360890] Redzone 2dff267e: bb bb bb bb bb bb bb bb bb bb bb bb
bb bb bb bb  ................
[   60.369593] Object f99f52f8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  kkkkkkkkkkkkkkkk
[   60.378209] Object a0093f52: 6c 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  lkkkkkkkkkkkkkkk
[   60.386825] Object b7794eec: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  kkkkkkkkkkkkkkkk
[   60.395441] Object 0b027fa1: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  kkkkkkkkkkkkkkkk
[   60.404057] Object 61e1d5ae: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  kkkkkkkkkkkkkkkk
[   60.412673] Object cabf4fee: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  kkkkkkkkkkkkkkkk
[   60.421289] Object fd09753d: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b  kkkkkkkkkkkkkkkk
[   60.429905] Object a9fe4019: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b a5  kkkkkkkkkkkkkkk.
[   60.438521] Redzone 6e67d9d1: bb bb bb bb
           ....
[   60.446182] Padding 57758010: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[   60.454885] Padding a6aa7e4a: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[   60.463588] Padding d58391c3: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[   60.472291] Padding cf07eeb7: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[   60.480994] Padding ead255cb: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a
5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
[   60.489697] Padding c6e3c745: 5a 5a 5a 5a 5a 5a 5a 5a
           ZZZZZZZZ
[   60.497709] CPU: 0 PID: 1 Comm: systemd Tainted: G    B D         T 5.8.17 #1
[   60.504846] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   60.510619] [<8010eb74>] (unwind_backtrace) from [<8010b5c8>]
(show_stack+0x10/0x14)
[   60.518379] [<8010b5c8>] (show_stack) from [<804765ec>]
(dump_stack+0x8c/0xa0)
[   60.525617] [<804765ec>] (dump_stack) from [<8026b508>]
(check_bytes_and_report+0xcc/0xe8)
[   60.533895] [<8026b508>] (check_bytes_and_report) from [<8026cde8>]
(check_object+0x248/0x2ac)
[   60.542519] [<8026cde8>] (check_object) from [<8026de04>]
(alloc_debug_processing+0xc4/0x188)
[   60.551055] [<8026de04>] (alloc_debug_processing) from [<8026e4fc>]
(___slab_alloc.constprop.0+0x634/0x6dc)
[   60.560808] [<8026e4fc>] (___slab_alloc.constprop.0) from
[<8026e5e4>] (__slab_alloc.constprop.0+0x40/0x48)
[   60.570560] [<8026e5e4>] (__slab_alloc.constprop.0) from
[<8026ed14>] (kmem_cache_alloc+0x1a8/0x290)
[   60.579704] [<8026ed14>] (kmem_cache_alloc) from [<801dc7c8>]
(push_stack+0x2c/0xf0)
[   60.587459] [<801dc7c8>] (push_stack) from [<801e3b34>]
(check_cond_jmp_op+0xf0/0x780)
[   60.595388] [<801e3b34>] (check_cond_jmp_op) from [<801e8094>]
(do_check+0xcac/0x1220)
[   60.603315] [<801e8094>] (do_check) from [<801e8848>]
(do_check_common+0x240/0x300)
[   60.610983] [<801e8848>] (do_check_common) from [<801e9c90>]
(bpf_check+0x1388/0x154c)
[   60.618913] [<801e9c90>] (bpf_check) from [<801d55c4>]
(bpf_prog_load+0x664/0x9d4)
[   60.626496] [<801d55c4>] (bpf_prog_load) from [<801d62b0>]
(__do_sys_bpf+0x3e8/0x1840)
[   60.634426] [<801d62b0>] (__do_sys_bpf) from [<80100060>]
(ret_fast_syscall+0x0/0x54)
[   60.642260] Exception stack(0xbc101fa8 to 0xbc101ff0)
[   60.647320] 1fa0:                   00000000 0000000f 00000005
7e9004e8 00000070 00000000
[   60.655507] 1fc0: 00000000 0000000f 0000003a 00000182 072ddbc0
0000003a 0000000f 07281b38
[   60.663689] 1fe0: 7e9004e0 7e9004d0 70799fdb 70611692
[   60.668750] FIX kmalloc-128: Restoring 0xa0093f52-0xa0093f52=0x6b
[   60.668750]
[   60.676323] FIX kmalloc-128: Marking all objects used


-----------------------------------8<-------------------------------------------------------

[+] Config file to check: configs/platform-v7a/tqma7/kernelconfig
[+] Detected architecture: ARM
[+] Detected kernel version: 5.8
=========================================================================================================================
option name                                  | desired val | decision
|       reason       |   check result
=========================================================================================================================
CONFIG_BUG                                   |      y      |defconfig
|  self_protection   |   OK
CONFIG_SLUB_DEBUG                            |      y      |defconfig
|  self_protection   |   OK
CONFIG_GCC_PLUGINS                           |      y      |defconfig
|  self_protection   |   OK
CONFIG_STACKPROTECTOR_STRONG                 |      y      |defconfig
|  self_protection   |   OK
CONFIG_STRICT_KERNEL_RWX                     |      y      |defconfig
|  self_protection   |   OK
CONFIG_STRICT_MODULE_RWX                     |      y      |defconfig
|  self_protection   |   OK
CONFIG_REFCOUNT_FULL                         |      y      |defconfig
|  self_protection   |   OK: version >= 5.5
CONFIG_IOMMU_SUPPORT                         |      y      |defconfig
|  self_protection   |   FAIL: "is not set"
CONFIG_CPU_SW_DOMAIN_PAN                     |      y      |defconfig
|  self_protection   |   OK
CONFIG_STACKPROTECTOR_PER_TASK               |      y      |defconfig
|  self_protection   |   OK
CONFIG_HARDEN_BRANCH_PREDICTOR               |      y      |defconfig
|  self_protection   |   OK
CONFIG_BUG_ON_DATA_CORRUPTION                |      y      |   kspp
|  self_protection   |   OK
CONFIG_DEBUG_WX                              |      y      |   kspp
|  self_protection   |   OK
CONFIG_SCHED_STACK_END_CHECK                 |      y      |   kspp
|  self_protection   |   OK
CONFIG_SLAB_FREELIST_HARDENED                |      y      |   kspp
|  self_protection   |   OK
CONFIG_SLAB_FREELIST_RANDOM                  |      y      |   kspp
|  self_protection   |   OK
CONFIG_SHUFFLE_PAGE_ALLOCATOR                |      y      |   kspp
|  self_protection   |   OK
CONFIG_FORTIFY_SOURCE                        |      y      |   kspp
|  self_protection   |   OK
CONFIG_DEBUG_LIST                            |      y      |   kspp
|  self_protection   |   OK
CONFIG_DEBUG_SG                              |      y      |   kspp
|  self_protection   |   OK
CONFIG_DEBUG_CREDENTIALS                     |      y      |   kspp
|  self_protection   |   OK
CONFIG_DEBUG_NOTIFIERS                       |      y      |   kspp
|  self_protection   |   OK
CONFIG_INIT_ON_ALLOC_DEFAULT_ON              |      y      |   kspp
|  self_protection   |   OK
CONFIG_GCC_PLUGIN_LATENT_ENTROPY             |      y      |   kspp
|  self_protection   |   OK
CONFIG_GCC_PLUGIN_RANDSTRUCT                 |      y      |   kspp
|  self_protection   |   OK
CONFIG_HARDENED_USERCOPY                     |      y      |   kspp
|  self_protection   |   OK
CONFIG_HARDENED_USERCOPY_FALLBACK            | is not set  |   kspp
|  self_protection   |   OK
CONFIG_MODULE_SIG                            |      y      |   kspp
|  self_protection   |   FAIL: "is not set"
CONFIG_MODULE_SIG_ALL                        |      y      |   kspp
|  self_protection   |   FAIL: not found
CONFIG_MODULE_SIG_SHA512                     |      y      |   kspp
|  self_protection   |   FAIL: not found
CONFIG_MODULE_SIG_FORCE                      |      y      |   kspp
|  self_protection   |   FAIL: not found
CONFIG_INIT_STACK_ALL_ZERO                   |      y      |   kspp
|  self_protection   |   FAIL: not found
CONFIG_INIT_ON_FREE_DEFAULT_ON               |      y      |   kspp
|  self_protection   |   FAIL: "is not set"
CONFIG_SYN_COOKIES                           |      y      |   kspp
|  self_protection   |   OK
CONFIG_DEFAULT_MMAP_MIN_ADDR                 |    32768    |   kspp
|  self_protection   |   OK
CONFIG_SECURITY_DMESG_RESTRICT               |      y      |  clipos
|  self_protection   |   OK
CONFIG_DEBUG_VIRTUAL                         |      y      |  clipos
|  self_protection   |   OK
CONFIG_STATIC_USERMODEHELPER                 |      y      |  clipos
|  self_protection   |   FAIL: "is not set"
CONFIG_EFI_DISABLE_PCI_DMA                   |      y      |  clipos
|  self_protection   |   FAIL: not found
CONFIG_SLAB_MERGE_DEFAULT                    | is not set  |  clipos
|  self_protection   |   OK
CONFIG_RANDOM_TRUST_BOOTLOADER               | is not set  |  clipos
|  self_protection   |   OK
CONFIG_RANDOM_TRUST_CPU                      | is not set  |  clipos
|  self_protection   |   OK: not found
CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE     | is not set  |  clipos
|  self_protection   |   OK
CONFIG_UBSAN_BOUNDS                          |      y      |    my
|  self_protection   |   FAIL: CONFIG_UBSAN_TRAP not "y"
CONFIG_SLUB_DEBUG_ON                         |      y      |    my
|  self_protection   |   OK
CONFIG_RESET_ATTACK_MITIGATION               |      y      |    my
|  self_protection   |   FAIL: not found
CONFIG_SECURITY                              |      y      |   kspp
|  security_policy   |   OK
CONFIG_SECURITY_YAMA                         |      y      |   kspp
|  security_policy   |   OK
CONFIG_SECURITY_WRITABLE_HOOKS               | is not set  |    my
|  security_policy   |   OK: not found
CONFIG_SECURITY_LOCKDOWN_LSM                 |      y      |  clipos
|  security_policy   |   FAIL: "is not set"
CONFIG_SECURITY_LOCKDOWN_LSM_EARLY           |      y      |  clipos
|  security_policy   |   FAIL: not found
CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY|      y      |  clipos
|  security_policy   |   FAIL: not found
CONFIG_SECURITY_SAFESETID                    |      y      |    my
|  security_policy   |   FAIL: "is not set"
CONFIG_SECURITY_LOADPIN                      |      y      |    my
|  security_policy   |   FAIL: "is not set"
CONFIG_SECURITY_LOADPIN_ENFORCE              |      y      |    my
|  security_policy   |   FAIL: CONFIG_SECURITY_LOADPIN not "y"
CONFIG_SECCOMP                               |      y      |defconfig
| cut_attack_surface |   OK
CONFIG_SECCOMP_FILTER                        |      y      |defconfig
| cut_attack_surface |   OK
CONFIG_ACPI_CUSTOM_METHOD                    | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_COMPAT_BRK                            | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_DEVKMEM                               | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_COMPAT_VDSO                           | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_BINFMT_MISC                           | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_INET_DIAG                             | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_KEXEC                                 | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_PROC_KCORE                            | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_LEGACY_PTYS                           | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_HIBERNATION                           | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_IA32_EMULATION                        | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_X86_X32                               | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_MODIFY_LDT_SYSCALL                    | is not set  |   kspp
| cut_attack_surface |   OK: not found
CONFIG_OABI_COMPAT                           | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_MODULES                               | is not set  |   kspp
| cut_attack_surface |   FAIL: "y"
CONFIG_DEVMEM                                | is not set  |   kspp
| cut_attack_surface |   OK
CONFIG_IO_STRICT_DEVMEM                      |      y      |   kspp
| cut_attack_surface |   OK: CONFIG_DEVMEM "is not set"
CONFIG_STRICT_DEVMEM                         |      y      |   kspp
| cut_attack_surface |   OK: CONFIG_DEVMEM "is not set"
CONFIG_ZSMALLOC_STAT                         | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_PAGE_OWNER                            | is not set
|grsecurity| cut_attack_surface |   OK
CONFIG_DEBUG_KMEMLEAK                        | is not set
|grsecurity| cut_attack_surface |   OK
CONFIG_BINFMT_AOUT                           | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_KPROBES                               | is not set
|grsecurity| cut_attack_surface |   OK
CONFIG_UPROBES                               | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_GENERIC_TRACER                        | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_PROC_VMCORE                           | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_PROC_PAGE_MONITOR                     | is not set
|grsecurity| cut_attack_surface |   FAIL: "y"
CONFIG_USELIB                                | is not set
|grsecurity| cut_attack_surface |   OK
CONFIG_CHECKPOINT_RESTORE                    | is not set
|grsecurity| cut_attack_surface |   FAIL: "y"
CONFIG_USERFAULTFD                           | is not set
|grsecurity| cut_attack_surface |   OK
CONFIG_HWPOISON_INJECT                       | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_MEM_SOFT_DIRTY                        | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_DEVPORT                               | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_DEBUG_FS                              | is not set
|grsecurity| cut_attack_surface |   FAIL: "y"
CONFIG_NOTIFIER_ERROR_INJECTION              | is not set
|grsecurity| cut_attack_surface |   OK
CONFIG_X86_PTDUMP                            | is not set
|grsecurity| cut_attack_surface |   OK: not found
CONFIG_DRM_LEGACY                            | is not set
|maintainer| cut_attack_surface |   OK: not found
CONFIG_FB                                    | is not set
|maintainer| cut_attack_surface |   OK
CONFIG_VT                                    | is not set
|maintainer| cut_attack_surface |   FAIL: "y"
CONFIG_AIO                                   | is not set
|grapheneos| cut_attack_surface |   FAIL: "y"
CONFIG_STAGING                               | is not set  |  clipos
| cut_attack_surface |   OK
CONFIG_KSM                                   | is not set  |  clipos
| cut_attack_surface |   OK
CONFIG_KALLSYMS                              | is not set  |  clipos
| cut_attack_surface |   FAIL: "y"
CONFIG_X86_VSYSCALL_EMULATION                | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_MAGIC_SYSRQ                           | is not set  |  clipos
| cut_attack_surface |   OK
CONFIG_KEXEC_FILE                            | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_USER_NS                               | is not set  |  clipos
| cut_attack_surface |   FAIL: "y"
CONFIG_X86_MSR                               | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_X86_CPUID                             | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_IO_URING                              | is not set  |  clipos
| cut_attack_surface |   FAIL: "y"
CONFIG_X86_IOPL_IOPERM                       | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_ACPI_TABLE_UPGRADE                    | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS              | is not set  |  clipos
| cut_attack_surface |   OK: not found
CONFIG_LDISC_AUTOLOAD                        | is not set  |  clipos
| cut_attack_surface |   OK
CONFIG_EFI_TEST                              | is not set  | lockdown
| cut_attack_surface |   OK: not found
CONFIG_BPF_SYSCALL                           | is not set  | lockdown
| cut_attack_surface |   FAIL: "y"
CONFIG_MMIOTRACE_TEST                        | is not set  | lockdown
| cut_attack_surface |   OK: not found
CONFIG_TRIM_UNUSED_KSYMS                     |      y      |    my
| cut_attack_surface |   FAIL: "is not set"
CONFIG_MMIOTRACE                             | is not set  |    my
| cut_attack_surface |   OK: not found
CONFIG_LIVEPATCH                             | is not set  |    my
| cut_attack_surface |   OK: not found
CONFIG_IP_DCCP                               | is not set  |    my
| cut_attack_surface |   OK
CONFIG_IP_SCTP                               | is not set  |    my
| cut_attack_surface |   OK
CONFIG_FTRACE                                | is not set  |    my
| cut_attack_surface |   OK
CONFIG_VIDEO_VIVID                           | is not set  |    my
| cut_attack_surface |   OK: not found
CONFIG_INPUT_EVBUG                           | is not set  |    my
| cut_attack_surface |   OK
CONFIG_INTEGRITY                             |      y      |    my
|userspace_hardening |   FAIL: "is not set"
CONFIG_VMSPLIT_3G                            |      y      |defconfig
|userspace_hardening |   FAIL: "is not set"
CONFIG_ARCH_MMAP_RND_BITS                    |     16      |    my
|userspace_hardening |   FAIL: "15"

[+] Config check is finished: 'OK' - 94 / 'FAIL' - 31
