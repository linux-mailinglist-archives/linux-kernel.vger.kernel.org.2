Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9D4113B2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237077AbhITLoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbhITLoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:44:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF796C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:42:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c21so59739039edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 04:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=tRyvP8kAohWOhTbj8XJo+OAGUC8teOghfTwRq3zcqq8=;
        b=js+ZTj3G0+JMiUFXm1UYBo5ErpL49RbgKsBbzvq2zAP3XrD2RIgiNc8zoDiUECm0tw
         Fxx3jYBkx5kxrTyFJPC0aMR6MldDSvpQ865voyqRGqsc0TaZABYFHoNQffvPe7fiaSM7
         ORmw6sJOBBPWvzOgvlUAZIWn3yJaz7YCEBtME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tRyvP8kAohWOhTbj8XJo+OAGUC8teOghfTwRq3zcqq8=;
        b=CDIvCSlAPSVeHzI956kc08bW0ZKJejsvMPpM4GAGTizOaVxNDgtIYxbEnZcKrRWXCw
         TtXDxQvafPLaIFEbg53nQzlMEe4KXApGbqcT+zcv0pNCEhV61tPjDoqn6mU7bIeHRJCg
         6vKoZQuw33QBAznU9CA4DmC/EBsLntC/Z7tYez/+vbSCu0B7m9V+8avFhrBRiwDZa9tS
         OKAv0LVetQcQea9h+qqc175C9JStwfJI7r0Z6TgShNarFgG9ielWigMF1b7KQhh7LWau
         MxKCQBAo5TM+jRtP0o9wOlWzb6CNFY3xbOfeqykIjzeuteMdpYUgUBZNl7Rwk+RkoV7Q
         8vSA==
X-Gm-Message-State: AOAM530mLNRxB7FqAQyZNDM2E0YD/V7CaGlaRRrJDVA3KTQmmBPahwU9
        zCsxnEjdGjvRKYwaA4F20QVy11zCTwzmwl8Dtje1nA==
X-Google-Smtp-Source: ABdhPJwjlvvxOiXye/4MnDqtz5U+MvN1JleKsL9PFS2n9//axbMHRtMc3w05vF54rouiGxr+LAX/S4Oqx5sqhRpRk3E=
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr27588123ejb.351.1632138172484;
 Mon, 20 Sep 2021 04:42:52 -0700 (PDT)
MIME-Version: 1.0
From:   Igor Raits <igor@gooddata.com>
Date:   Mon, 20 Sep 2021 13:42:41 +0200
Message-ID: <CA+9S74g77kMvkB7X44bipuN0WfMpHJO6Dgors4HhvLPiDhq5NA@mail.gmail.com>
Subject: rq->tmp_alone_branch != &rq->leaf_cfs_rq_list + RIP: 0010:enqueue_task_fair+0x268/0x6a0
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We've upgraded our systems from 5.10.x@CentOS7 to 5.14.x@CentOS8 and
we have seen VMs crashing on what's mentioned in the subject.

This backtrace was generated on 5.14.1 and we are yet about to try the
latest kernel from 5.14.x series but I did not spot anything in the
commits that would potentially fix the issue.

Any help would be greatly appreciated!

Backtrace is following, and I have a VM's memory dump (ready to be
used for "crash" utility, just let me know what to look for).

------------[ cut here ]------------
rq->tmp_alone_branch != &rq->leaf_cfs_rq_list
WARNING: CPU: 5 PID: 1832 at kernel/sched/fair.c:379
enqueue_task_fair+0x268/0x6a0
Modules linked in: xt_multiport(E) veth(E) vport_vxlan(E) vxlan(E)
ip6_udp_tunnel(E) udp_tunnel(E) openvswitch(E) nf_conncount(E)
ip_set_list_set(E) ip_set_hash_net(E) xt_NFLOG(E) xt_physdev(E)
xt_state(E) nfnetlink_log(E) rbd(E) libceph(E) nf_conntrack_netlink(E)
dns_resolver(E) xt_nat(E) xt_statistic(E) xt_addrtype(E) ipt_REJECT(E)
nf_reject_ipv4(E) ip_set_hash_ip(E) xt_set(E) ip_set(E) ip_vs_sh(E)
ip_vs_wrr(E) ip_vs_rr(E) ip_vs(E) nbd(E) udp_diag(E) tcp_diag(E)
inet_diag(E) br_netfilter(E) bridge(E) stp(E) llc(E) xt_MASQUERADE(E)
xt_conntrack(E) xt_comment(E) nft_counter(E) xt_mark(E) nft_compat(E)
nft_chain_nat(E) nf_nat(E) nf_conntrack(E) nf_defrag_ipv6(E)
nf_defrag_ipv4(E) nf_tables(E) libcrc32c(E) nfnetlink(E)
binfmt_misc(E) nls_utf8(E) isofs(E) overlay(E) dummy(E)
intel_rapl_msr(E) intel_rapl_common(E) nfit(E) libnvdimm(E)
kvm_intel(E) kvm(E) irqbypass(E) rapl(E) cirrus(E) drm_kms_helper(E)
syscopyarea(E) sysfillrect(E) sysimgblt(E) fb_sys_fops(E) drm(E)
i2c_i801(E)
pcspkr(E) i2c_smbus(E) virtio_balloon(E) iptable_filter(E)
auth_rpcgss(E) ip_tables(E) ext4(E) mbcache(E) jbd2(E) sr_mod(E)
cdrom(E) sg(E) crct10dif_pclmul(E) crc32_pclmul(E) crc32c_intel(E)
ahci(E) libahci(E) libata(E) serio_raw(E) ghash_clmulni_intel(E)
virtio_net(E) net_failover(E) virtio_blk(E) failover(E) sunrpc(E)
dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
CPU: 5 PID: 1832 Comm: imudp(w0) Tainted: G            E
5.14.1-1.gdc.el8.x86_64 #1
Hardware name: RDO OpenStack Compute/RHEL-AV, BIOS 1.14.0-1.el8s 04/01/2014
RIP: 0010:enqueue_task_fair+0x268/0x6a0
Code: 60 09 00 00 0f 84 0f ff ff ff 80 3d ed 24 a5 01 00 0f 85 02 ff
ff ff 48 c7 c7 b0 42 93 95 c6 05 d9 24 a5 01 01 e8 63 4c 8d 00 <0f> 0b
e9 e8 fe ff ff 44 8b 85 80 01 00 00 45 85 c0 0f 85 bf fe ff
RSP: 0018:ffff9fdec1467d20 EFLAGS: 00010082
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8b1543d57b48
RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8b1543d57b40
RBP: ffff8b1543c2c400 R08: 0000000000000000 R09: ffff9fdec1467b68
R10: ffff9fdec1467b60 R11: ffffffff95fe3b68 R12: 0000000000000000
R13: ffff8b1543c2c380 R14: ffff9fdec1467de0 R15: ffff8b1543c2c380
FS:  00007f5719e3a700(0000) GS:ffff8b1543d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f58b902b934 CR3: 000000010542a002 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
enqueue_task+0x48/0x140
ttwu_do_activate+0x4c/0xc0
try_to_wake_up+0x1ba/0x460
wake_up_q+0x4a/0x90
futex_wake+0x14f/0x180
do_futex+0xeb/0x1e0
__x64_sys_futex+0x81/0x1c0
? __audit_syscall_exit+0x276/0x2d0
do_syscall_64+0x38/0x90
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f571e4af9cb
Code: 83 e1 fc f0 41 0f b1 09 75 f2 83 e2 03 80 f3 81 83 fa 02 0f 84
7e 01 00 00 45 31 d2 ba 01 00 00 00 89 de b8 ca 00 00 00 0f 05 <48> 3d
00 f0 ff ff 0f 87 49 01 00 00 48 83 c4 28 31 c0 5b 5d 41 5c
RSP: 002b:00007f5719e37030 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 0000000000000081 RCX: 00007f571e4af9cb
RDX: 0000000000000001 RSI: 0000000000000081 RDI: 000055f8816b4e00
RBP: 0000000000000000 R08: 000055f8816b4dd8 R09: 000055f8816b4df8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001e1a
R13: 00000000000000ca R14: 0000000000000080 R15: 000055f8816b4e00
---[ end trace 2fd9018c83b28c91 ]---
