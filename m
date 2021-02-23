Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5132310D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbhBWSyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhBWSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:54:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B4C061574;
        Tue, 23 Feb 2021 10:53:24 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v21so3422431wml.4;
        Tue, 23 Feb 2021 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=atJMKQy3hSiMI0Yxa1mhA6pipggyye5S52KzopwkXzA=;
        b=nbk9rSu56uL+4ColLxMk7/Qmd/MMDraweEmAeS94JlX9WFxiekcjugy4e8iXfruzoG
         /drkmvkz1VI9zt3pT38keWvXBCsDSD1129tyB/hdYA4La3sakCbPBtpUysGxCca9KvF0
         1oiJlw3npLhWWDDVF9EmXazzv4U2Ti+lgcgA/9jaDeYy4GySnjuvdP4vOnL8aPJyAc9N
         L/Eiw+cUTZsOkVNKsQQiocBQUcVaCNW9duc1Ir/yXujjNHaIY0MIHT6ITQWSFbxQKSLE
         l7akm8vt69vEDcv+E70QWTf1p06Ianenzv98jFLrScUGIg+5q32GlGFqh0J8ooXvnVNJ
         WF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=atJMKQy3hSiMI0Yxa1mhA6pipggyye5S52KzopwkXzA=;
        b=DHTRQYxZjB+o/3ZzybUFgICaXwS/GUPBkR5KToB82su0dXA9QFyiqRNe9f2+WiDjB8
         LdSaFjRApqZLP0FD4Y0vEsu2xnSgtXdWoYwEJlD48+NwtsD5FT6lxhWz2mYK7g763vny
         qQNGxZ45Srt8f8e20I7lfE7Z5NWR8qA6NO2VFBYDwS7q0cBt0yvMsV6/7ZmGaHi6MYDD
         k6jbFUcjlPZTMl0ZnjQyvUdAw7wdakyyyndOeQ+oYO6ANOXM/gApjJXCAcFzAaDtsdXv
         mdTt3i8M08IG8VBN7ewaHxAGbhmlkNao6mH65Wm6L6lXPA/figzfZITsKaQrlxEiKKhQ
         s30g==
X-Gm-Message-State: AOAM5305ZXQ3HyIk8TX5Mfo8H7cUMG7+cNVc2lco9T4r1cSzfiAUf/9G
        nRI/89Pd+c+QJ/vqfn8XX2UgdKCY3GW//g==
X-Google-Smtp-Source: ABdhPJzFHeyM8QJLcmwUfhj14ZslaMGjuKWnKGSgHhjtAMlA5+16j4VEK9+RcFIg0u76DDXOdWgpjg==
X-Received: by 2002:a05:600c:4f91:: with SMTP id n17mr188058wmq.48.1614106403536;
        Tue, 23 Feb 2021 10:53:23 -0800 (PST)
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net. [2001:470:1f1c:3e6::2])
        by smtp.gmail.com with ESMTPSA id y62sm3788042wmy.9.2021.02.23.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:53:23 -0800 (PST)
Date:   Tue, 23 Feb 2021 18:53:21 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 5.?? regression: strace testsuite OOpses kernel on ia64
Message-ID: <20210223185321.359e34bc@sf>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The crash seems to be related to sock_filter-v test from strace:
    https://github.com/strace/strace/blob/master/tests/seccomp-filter-v.c

Here is an OOps:

[  818.089904] BUG: Bad page map in process sock_filter-v  pte:00000001 pmd:118580001
[  818.089904] page:00000000e6a429c8 refcount:1 mapcount:-1 mapping:0000000000000000 index:0x0 pfn:0x0
[  818.089904] flags: 0x1000(reserved)
[  818.089904] raw: 0000000000001000 a000400000000008 a000400000000008 0000000000000000
[  818.089904] raw: 0000000000000000 0000000000000000 00000001fffffffe
[  818.089904] page dumped because: bad pte
[  818.089904] addr:0000000000000000 vm_flags:04044011 anon_vma:0000000000000000 mapping:0000000000000000 index:0
[  818.095483] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[  818.095483] CPU: 0 PID: 5990 Comm: sock_filter-v Not tainted 5.11.0-00003-gbfa5a4929c90 #57
[  818.095483] Hardware name: hp server rx3600                   , BIOS 04.03                                                            04/08/2008
[  818.095483]
[  818.095483] Call Trace:
[  818.095483]  [<a000000100014a70>] show_stack+0x90/0xc0
[  818.095483]                                 sp=e000000118707bb0 bsp=e0000001187013c0
[  818.095483]  [<a00000010100c2b0>] dump_stack+0x120/0x160
[  818.095483]                                 sp=e000000118707d80 bsp=e000000118701348
[  818.095483]  [<a0000001002e7b40>] print_bad_pte+0x300/0x3a0
[  818.095483]                                 sp=e000000118707d80 bsp=e0000001187012e0
[  818.099483]  [<a0000001002ec190>] unmap_page_range+0xa90/0x11a0
[  818.099483]                                 sp=e000000118707d80 bsp=e000000118701140
[  818.099483]  [<a0000001002ecba0>] unmap_vmas+0xc0/0x100
[  818.099483]                                 sp=e000000118707da0 bsp=e000000118701108
[  818.099483]  [<a000000100302db0>] exit_mmap+0x150/0x320
[  818.099483]                                 sp=e000000118707da0 bsp=e0000001187010d8
[  818.099483]  [<a00000010005dba0>] mmput+0x60/0x200
[  818.099483]                                 sp=e000000118707e20 bsp=e0000001187010b0
[  818.103482]  [<a00000010006e570>] do_exit+0x6f0/0x18a0
[  818.103482]                                 sp=e000000118707e20 bsp=e000000118701038
[  818.103482]  [<a000000100072070>] do_group_exit+0x90/0x2a0
[  818.103482]                                 sp=e000000118707e30 bsp=e000000118700ff0
[  818.103482]  [<a0000001000722a0>] sys_exit_group+0x20/0x40
[  818.103482]                                 sp=e000000118707e30 bsp=e000000118700f98
[  818.107482]  [<a00000010000c5f0>] ia64_trace_syscall+0xf0/0x130
[  818.107482]                                 sp=e000000118707e30 bsp=e000000118700f98
[  818.107482]  [<a000000000040720>] ia64_ivt+0xffffffff00040720/0x400
[  818.107482]                                 sp=e000000118708000 bsp=e000000118700f98
[  818.115482] Disabling lock debugging due to kernel taint
[  818.115482] BUG: Bad rss-counter state mm:000000002eec6412 type:MM_FILEPAGES val:-1
[  818.132256] Unable to handle kernel NULL pointer dereference (address 0000000000000068)
[  818.133904] sock_filter-v-X[5999]: Oops 11012296146944 [1]
[  818.133904] Modules linked in: acpi_ipmi ipmi_si usb_storage e1000 ipmi_devintf ipmi_msghandler rtc_efi
[  818.133904]
[  818.133904] CPU: 0 PID: 5999 Comm: sock_filter-v-X Tainted: G    B             5.11.0-00003-gbfa5a4929c90 #57
[  818.133904] Hardware name: hp server rx3600                   , BIOS 04.03                                                            04/08/2008
[  818.133904] psr : 0000121008026010 ifs : 8000000000000288 ip  : [<a0000001001eaa61>]    Tainted: G    B             (5.11.0-00003-gbfa5a4929c90)
[  818.133904] ip is at bpf_prog_free+0x21/0xe0
[  818.133904] unat: 0000000000000000 pfs : 0000000000000307 rsc : 0000000000000003
[  818.133904] rnat: 0000000000000000 bsps: 0000000000000000 pr  : 00106a5a51665965
[  818.133904] ldrs: 0000000000000000 ccv : 0000000012088904 fpsr: 0009804c8a70033f
[  818.133904] csd : 0000000000000000 ssd : 0000000000000000
[  818.133904] b0  : a000000100d54080 b6  : a000000100d53fe0 b7  : a00000010000cef0
[  818.133904] f6  : 0ffefb0c50daa1b67f89a f7  : 0ffed8b3e4fdb08000000
[  818.133904] f8  : 10017fbd1bc0000000000 f9  : 1000eb95f000000000000
[  818.133904] f10 : 10008ade20716a6c83cc1 f11 : 1003e00000000000002b7
[  818.133904] r1  : a00000010176b300 r2  : a000000200008004 r3  : 0000000000000000
[  818.133904] r8  : 0000000000000008 r9  : e00000011873f800 r10 : e000000102c18600
[  818.133904] r11 : e000000102c19600 r12 : e00000011873f7f0 r13 : e000000118738000
[  818.133904] r14 : 0000000000000068 r15 : a000000200008028 r16 : e000000005606a70
[  818.133904] r17 : e000000102c18600 r18 : e000000104370748 r19 : e000000102c18600
[  818.133904] r20 : e000000102c18600 r21 : e000000005606a78 r22 : a00000010156bd28
[  818.133904] r23 : a00000010147fdf4 r24 : 0000000000004000 r25 : e000000104370750
[  818.133904] r26 : a0000001012f7088 r27 : a000000100d53fe0 r28 : 0000000000000001
[  818.133904] r29 : e00000011873f800 r30 : e00000011873f810 r31 : e00000011873f808
[  818.133904]
[  818.133904] Call Trace:
[  818.133904]  [<a000000100014a70>] show_stack+0x90/0xc0
[  818.133904]                                 sp=e00000011873f420 bsp=e0000001187396d0
[  818.133904]  [<a000000100015170>] show_regs+0x6d0/0xa40
[  818.133904]                                 sp=e00000011873f5f0 bsp=e000000118739660
[  818.133904]  [<a000000100026e90>] die+0x1b0/0x4a0
[  818.133904]                                 sp=e00000011873f610 bsp=e000000118739620
[  818.133904]  [<a000000100059220>] ia64_do_page_fault+0x820/0xb60
[  818.133904]                                 sp=e00000011873f610 bsp=e000000118739580
[  818.133904]  [<a00000010000c8e0>] ia64_leave_kernel+0x0/0x270
[  818.133904]                                 sp=e00000011873f620 bsp=e000000118739580
[  818.133904]  [<a0000001001eaa60>] bpf_prog_free+0x20/0xe0
[  818.133904]                                 sp=e00000011873f7f0 bsp=e000000118739540
[  818.133904]  [<a000000100d54080>] sk_filter_release_rcu+0xa0/0x120
[  818.133904]                                 sp=e00000011873f7f0 bsp=e000000118739510
[  818.133904]  [<a00000010016a7f0>] rcu_core+0x530/0xf20
[  818.133904]                                 sp=e00000011873f7f0 bsp=e0000001187394a8
[  818.133904]  [<a00000010016b200>] rcu_core_si+0x20/0x40
[  818.133904]                                 sp=e00000011873f810 bsp=e000000118739490
[  818.133904]  [<a0000001010279f0>] __do_softirq+0x230/0x640
[  818.133904]                                 sp=e00000011873f810 bsp=e0000001187393a0
[  818.133904]  [<a000000100074770>] irq_exit+0x170/0x200
[  818.133904]                                 sp=e00000011873f810 bsp=e000000118739388
[  818.133904]  [<a000000100013310>] ia64_handle_irq+0x1b0/0x360
[  818.133904]                                 sp=e00000011873f810 bsp=e000000118739308
[  818.133904]  [<a00000010000c8e0>] ia64_leave_kernel+0x0/0x270
[  818.133904]                                 sp=e00000011873f820 bsp=e000000118739308
[  818.133904]  [<a000000101027700>] flush_icache_range+0x80/0xa0
[  818.133904]                                 sp=e00000011873f9f0 bsp=e0000001187392f8
[  818.133904]  [<a0000001002f7ae0>] __access_remote_vm+0x1e0/0x320
[  818.133904]                                 sp=e00000011873f9f0 bsp=e000000118739258
[  818.133904]  [<a0000001002f7c80>] access_process_vm+0x60/0xa0
[  818.133904]                                 sp=e00000011873fa00 bsp=e000000118739210
[  818.133904]  [<a000000100018210>] ia64_sync_user_rbs+0x70/0xe0
[  818.133904]                                 sp=e00000011873fa00 bsp=e0000001187391d0
[  818.133904]  [<a000000100018b00>] do_sync_rbs+0xc0/0x100
[  818.133904]                                 sp=e00000011873fa10 bsp=e000000118739198
[  818.133904]  [<a00000010000cf30>] unw_init_running+0x70/0xa0
[  818.133904]                                 sp=e00000011873fa10 bsp=e000000118739170
[  818.133904]  [<a00000010001ae90>] ia64_ptrace_stop+0x130/0x160
[  818.133904]                                 sp=e00000011873fdf0 bsp=e000000118739158
[  818.133904]  [<a00000010008af60>] ptrace_stop+0xc0/0x880
[  818.133904]                                 sp=e00000011873fdf0 bsp=e000000118739118
[  818.133904]  [<a00000010008b820>] ptrace_do_notify+0x100/0x120
[  818.133904]                                 sp=e00000011873fdf0 bsp=e0000001187390e8
[  818.133904]  [<a00000010008b8d0>] ptrace_notify+0x90/0x260
[  818.133904]                                 sp=e00000011873fe30 bsp=e0000001187390c8
[  818.133904]  [<a00000010001e3d0>] syscall_trace_enter+0xf0/0x2c0
[  818.133904]                                 sp=e00000011873fe30 bsp=e000000118739070
[  818.133904]  [<a00000010000c540>] ia64_trace_syscall+0x40/0x130
[  818.133904]                                 sp=e00000011873fe30 bsp=e000000118739020
[  818.186114] Kernel panic - not syncing: Aiee, killing interrupt handler!
[  818.186114] ---[ end Kernel panic - not syncing: Aiee, killing interrupt handler! ]---

I'm not sure how to interpret it. It looks like 'bpf_prog_free'
frees the memory that is not there anymore, but previous crash
hints at already broken page tables. Maybe VM is already corrupted
by previous strace tests?

I wonder if I can enable a bit more kernel VM debugging to catch the corruption earlier.

-- 

  Sergei
