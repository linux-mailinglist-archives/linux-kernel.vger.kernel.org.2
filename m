Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530263B2D13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 12:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhFXK6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 06:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhFXK6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 06:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624532193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RhtPkDlNXgqToqOyeBbPGvedpadGhKqBNxRwGp6bgz8=;
        b=S9GI9Sbpt2sEy9O3X31GqHLTy2zgDtf+Mnwd5JpaJjpabOe9rfMVGwUCKWXIM8PdCcBLj1
        JA3xbdtK6dsO0NH/BjcpSHE8rt7ZIY9WlKSxEijVtRvNTXS8OA6XwkAzpqrV1vYRIlHinX
        b+SSnqFKiKWW4COaTE1/56GfuywtHI4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-0NO1MGmMOgeEytoyFYYa5w-1; Thu, 24 Jun 2021 06:56:32 -0400
X-MC-Unique: 0NO1MGmMOgeEytoyFYYa5w-1
Received: by mail-oi1-f198.google.com with SMTP id k11-20020a54440b0000b02901f3e6a011b4so3471392oiw.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 03:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RhtPkDlNXgqToqOyeBbPGvedpadGhKqBNxRwGp6bgz8=;
        b=J+WDdJUuR7ZOKltHOzpOcm+5iDOkBwHkKzsibP2CA+kH5o9mAcp58aaf1DEi6lGFL8
         WwLVQxak9msYC9yH16KI87XOlOdUNDJaeWjjO0nqEGkVcarVOAZMOKn6Ht86MTN6GVKq
         G635YFGUmdtaClDorit6Q0hbHNYDprb1xhfvtLLvQOy1lpCwcIiMoLUBAcOOjb1s9+aN
         9UqgrfGiV98fNIWOYI25RLJ/je5JQhmcvGl6vkqHkibkOZ7IOdSjFQuquFJ5W35kvBjJ
         ahKAILtfP6bmbrcVK7pnXBvUFhBIF26qNOKHQif9PAPK85kgZAvKj+QBQ7Bflr4r7IDZ
         ydCw==
X-Gm-Message-State: AOAM531hmZCk09RiyvqVCkrJZf/es43DueJBgaqeyOT4OTq1FSS0KjLn
        KqtQw14ewEBgPzyH5Ko9nGKgjDtYVaTJ8koM4odNvnMrXTneAN49tBwSfdPBHcgktfVixaIoHap
        GxSYbvSJyT//N7TJuK4N2OUdKA/5I/uFLxXLC6CLf
X-Received: by 2002:a9d:6a83:: with SMTP id l3mr4083692otq.189.1624532189267;
        Thu, 24 Jun 2021 03:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAzF8ijjywdUV/c/BC1XKdRZGvmRNDaKZiFN4A7m84RWi5Y1AXYYQ4ozmTR1xMCdMpzgUEcumX4k/cjz3s59s=
X-Received: by 2002:a9d:6a83:: with SMTP id l3mr4083669otq.189.1624532188922;
 Thu, 24 Jun 2021 03:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <cki.D6D3395853.YUEH7SJHRT@redhat.com>
In-Reply-To: <cki.D6D3395853.YUEH7SJHRT@redhat.com>
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 24 Jun 2021 12:56:18 +0200
Message-ID: <CA+QYu4pXLd9rGTh5o6BS+E0iA3H2ADArFM=N_yN1WWm_PngWnA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=E2=9D=8C_FAIL=3A_Test_report_for_kernel_5=2E13=2E0=2Drc6_=28mai?=
        =?UTF-8?Q?nline=2Ekernel=2Eorg=2C_cba5e972=29?=
To:     CKI Project <cki-project@redhat.com>, linux-kernel@vger.kernel.org
Cc:     skt-results-master@redhat.com, nathan@kernel.org,
        Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Jianhong Yin <jiyin@redhat.com>, Fine Fan <ffan@redhat.com>,
        Erik Hamera <ehamera@redhat.com>,
        Jan Stancek <jstancek@redhat.com>, bsegall@google.com,
        Juri Lelli <jlelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since this commit (Commit: cba5e97280f5 - Merge tag
'sched_urgent_for_v5.13_rc6') we started to see some problem when
running the LTP "cfs_bandwidth01" test case.

Below is a part of the call trace, full console log is available on
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-pu=
blic/2021/06/20/324119537/build_aarch64_redhat%3A1361789398/tests/10171670_=
aarch64_1_console.log

[ 3916.859758] LTP: starting cfs_bandwidth01 (cfs_bandwidth01 -i 5)
[ 3918.099939] ------------[ cut here ]------------
[ 3918.101813] rq->tmp_alone_branch !=3D &rq->leaf_cfs_rq_list
[ 3918.101905] WARNING: CPU: 0 PID: 181633 at kernel/sched/fair.c:401
unthrottle_cfs_rq+0x504/0x51c
[ 3918.105454] Modules linked in: n_gsm pps_ldisc ppp_synctty mkiss
ax25 ppp_async ppp_generic serport slcan slip slhc snd_hrtimer snd_seq
snd_seq_device sctp snd_timer snd soundcore authenc pcrypt crypto_user
sha3_generic algif_hash rfkill sunrpc vfat fat virtio_net net_failover
failover fuse drm zram ip_tables x_tables xfs crct10dif_ce ghash_ce
virtio_blk virtio_console qemu_fw_cfg virtio_mmio aes_neon_bs
[ 3918.114509] CPU: 0 PID: 181633 Comm: systemd-udevd Not tainted 5.13.0-rc=
6 #1
[ 3918.116316] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15
[ 3918.118105] pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO BTYPE=3D--)
[ 3918.119745] pc : unthrottle_cfs_rq+0x504/0x51c
[ 3918.120916] lr : unthrottle_cfs_rq+0x504/0x51c
[ 3918.122083] sp : ffff800010003d20
[ 3918.122954] x29: ffff800010003d20 x28: ffff0fb540c3c200 x27: ffff0fb5ff1=
70400
[ 3918.124837] x26: 000000000000743e x25: 000000000000859d x24: ffffc818f03=
b1140
[ 3918.126720] x23: 0000000000000000 x22: ffff0fb5ff170400 x21: 00000000000=
00001
[ 3918.128547] x20: ffff0fb5ff1704c0 x19: 0000000000000009 x18: 00000000000=
00001
[ 3918.130369] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00030
[ 3918.132213] x14: ffffffffffffffff x13: ffff8000900039bf x12: ffff8000100=
039c8
[ 3918.134063] x11: ffffc818f047f5b0 x10: ffffc818f040d2f0 x9 : ffffc818ee2=
0104c
[ 3918.135948] x8 : 00000000000172f8 x7 : ffffc818f03b82b8 x6 : 00000000000=
02e62
[ 3918.137805] x5 : ffff0fb5ff15d450 x4 : 0000000000000001 x3 : ffff479d0f3=
37000
[ 3918.139668] x2 : ffff0fb5ff15d458 x1 : ffff0fb5780cc000 x0 : 00000000000=
0002d
[ 3918.141536] Call trace:
[ 3918.142181]  unthrottle_cfs_rq+0x504/0x51c
[ 3918.143258]  distribute_cfs_runtime+0x1ec/0x2b4
[ 3918.144430]  sched_cfs_period_timer+0xd4/0x250
[ 3918.145589]  __run_hrtimer+0x11c/0x1d0
[ 3918.146572]  __hrtimer_run_queues+0x80/0xf0
[ 3918.147683]  hrtimer_interrupt+0xf4/0x2cc
[ 3918.148754]  arch_timer_handler_virt+0x40/0x50
[ 3918.149952]  handle_percpu_devid_irq+0x98/0x170
[ 3918.151159]  __handle_domain_irq+0x88/0xec
[ 3918.152242]  gic_handle_irq+0x5c/0xdc
[ 3918.153210]  el1_irq+0xc0/0x148
[ 3918.154028]  el0_svc_common.constprop.0+0x48/0x104
[ 3918.155281]  do_el0_svc+0x30/0x9c
[ 3918.156148]  el0_svc+0x2c/0x54
[ 3918.156940]  el0_sync_handler+0x1a4/0x1b0
[ 3918.157940]  el0_sync+0x19c/0x1c0
[ 3918.158782] irq event stamp: 428552
[ 3918.159654] hardirqs last  enabled at (428551):
[<ffffc818ee0dac14>] el0_svc_common.constprop.0+0x44/0x104
[ 3918.162091] hardirqs last disabled at (428552):
[<ffffc818ef03b400>] enter_el1_irq_or_nmi+0x10/0x20
[ 3918.164392] softirqs last  enabled at (428480):
[<ffffc818ee0c6490>] put_cpu_fpsimd_context+0x30/0x70
[ 3918.166740] softirqs last disabled at (428478):
[<ffffc818ee0c6408>] get_cpu_fpsimd_context+0x8/0x60
[ 3918.169065] ---[ end trace 350df9ac4e47440c ]---
[ 3918.170397]
[ 3918.170401] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 3918.170402] WARNING: possible circular locking dependency detected
[ 3918.170404] 5.13.0-rc6 #1 Not tainted


This is a call trace from aarch64, but this also happens on other arches.
Here is the console log from x86_64:
https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/datawarehouse-pu=
blic/2021/06/20/324119545/build_x86_64_redhat%3A1361789429/tests/10170701_x=
86_64_1_console.log

Thank you,
Bruno Goncalves

On Mon, Jun 21, 2021 at 7:54 AM CKI Project <cki-project@redhat.com> wrote:
>
>
> Hello,
>
> We ran automated tests on a recent commit from this kernel tree:
>
>        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git
>             Commit: cba5e97280f5 - Merge tag 'sched_urgent_for_v5.13_rc6'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>
> The results of these automated tests are provided below.
>
>     Overall result: FAILED (see details below)
>              Merge: OK
>            Compile: OK
>  Selftests compile: FAILED
>              Tests: FAILED
>
> All kernel binaries, config files, and logs are available for download he=
re:
>
>   https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?p=
refix=3Ddatawarehouse-public/2021/06/20/324119537
>
> One or more kernel tests failed:
>
>     aarch64:
>      =E2=9D=8C LTP
>      =E2=9D=8C CIFS Connectathon
>
>     x86_64:
>      =E2=9D=8C xfstests - nfsv4.2
>      =E2=9D=8C power-management: cpupower/sanity test
>      =E2=9D=8C storage: software RAID testing
>
> We hope that these logs can help you find the problem quickly. For the fu=
ll
> detail on our testing procedures, please scroll to the bottom of this mes=
sage.
>
> Please reply to this email if you have any questions about the tests that=
 we
> ran or if you have any suggestions on how to make future tests more effec=
tive.
>
>         ,-.   ,-.
>        ( C ) ( K )  Continuous
>         `-',-.`-'   Kernel
>           ( I )     Integration
>            `-'
> _________________________________________________________________________=
_____
>
> Compile testing
> ---------------
>
> We compiled the kernel for 4 architectures:
>
>     aarch64:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     ppc64le:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     s390x:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>     x86_64:
>       make options: make -j24 INSTALL_MOD_STRIP=3D1 targz-pkg
>
>
> We built the following selftests:
>
>   x86_64:
>       net: OK
>       bpf: fail
>       install and packaging: OK
>
> You can find the full log (build-selftests.log) in the artifact storage a=
bove.
>
>
> Hardware testing
> ----------------
> We booted each kernel and ran the following tests:
>
>   aarch64:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 ACPI table test
>        =E2=9C=85 ACPI enabled test
>        =E2=9D=8C LTP
>        =E2=9D=8C CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking socket: fuzz
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking: igmp conformance test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking cki netfilter test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - transp=
ort
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tunnel
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Libkcapi AF_ALG test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: update pci ids test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA PCM loopback test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA Control (mixer) Userspace Element=
 test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 kdump - kexec_boot
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 i2c: i2cdetect sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Firmware test suite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kaslr
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>
>   ppc64le:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking socket: fuzz
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking cki netfilter test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tunnel
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Libkcapi AF_ALG test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: update pci ids test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA PCM loopback test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA Control (mixer) Userspace Element=
 test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kaslr
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>
>   s390x:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 kdump - sysrq-c
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 kdump - file-load
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Podman system integration test - as r=
oot
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Podman system integration test - as u=
ser
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 selinux-policy: serge-testsuite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 3:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking cki netfilter test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - transp=
ort
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tunnel
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Libkcapi AF_ALG test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 kdump - kexec_boot
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kaslr
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>
>     Host 4:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - ext4
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - xfs
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: swraid mdadm raid_module test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Podman system integration test - as r=
oot
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Podman system integration test - as u=
ser
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 selinux-policy: serge-testsuite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>     Host 5:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Boot test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 LTP
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 CIFS Connectathon
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 POSIX pjd-fstest suites
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory: fork_mem
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: memfd_create
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 AMTU (Abstract Machine Test Utility)
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking bridge: sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking cki netfilter test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - transp=
ort
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tunnel
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Libkcapi AF_ALG test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 kdump - kexec_boot
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kaslr
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>
>   x86_64:
>     Host 1:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 ACPI table test
>        =E2=9C=85 LTP
>        =E2=9C=85 CIFS Connectathon
>        =E2=9C=85 POSIX pjd-fstest suites
>        =E2=9C=85 Loopdev Sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 jvm - jcstress tests
>        =E2=9C=85 Memory: fork_mem
>        =E2=9C=85 Memory function: memfd_create
>        =E2=9C=85 AMTU (Abstract Machine Test Utility)
>        =E2=9C=85 Networking bridge: sanity
>        =E2=9C=85 Ethernet drivers sanity
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking socket: fuzz
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking: igmp conformance test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route: pmtu
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - local
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking route_func - forward
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking TCP: keepalive test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking UDP: socket
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking cki netfilter test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: geneve basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: gre basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 L2TP basic test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking tunnel: vxlan basic
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - transp=
ort
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Networking ipsec: basic netns - tunnel
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 Libkcapi AF_ALG test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: sanity smoke test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 pciutils: update pci ids test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA PCM loopback test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 ALSA Control (mixer) Userspace Element=
 test
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 storage: SCSI VPD
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 trace: ftrace/tracer
>        =E2=9A=A1=E2=9A=A1=E2=9A=A1 kdump - kexec_boot
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xarray-idr-radixtree-test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 i2c: i2cdetect sanity
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Firmware test suite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Memory function: kaslr
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 audit: audit testsuite test
>
>     Host 2:
>
>        =E2=9A=A1 Internal infrastructure issues prevented one or more tes=
ts (marked
>        with =E2=9A=A1=E2=9A=A1=E2=9A=A1) from running on this architectur=
e.
>        This is not the fault of the kernel that was tested.
>
>        =E2=9C=85 Boot test
>        =E2=9C=85 xfstests - ext4
>        =E2=9C=85 xfstests - xfs
>        =E2=9D=8C xfstests - nfsv4.2
>        =E2=9D=8C power-management: cpupower/sanity test
>        =E2=9D=8C storage: software RAID testing
>        =E2=9C=85 Storage: swraid mdadm raid_module test
>         =E2=9D=8C Podman system integration test - as root
>         =E2=9C=85 Podman system integration test - as user
>         =E2=9C=85 CPU: Idle Test
>         =E2=9C=85 xfstests - btrfs
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 xfstests - cifsv3.11
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMI driver test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 IPMItool loop stress test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 selinux-policy: serge-testsuite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage blktests
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - filesystem fio test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage block - queue scheduler test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvme - tcp
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage nvdimm ndctl test suite
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 Storage: lvm device-mapper test
>         =E2=9A=A1=E2=9A=A1=E2=9A=A1 stress: stress-ng
>
>   Test sources: https://gitlab.com/cki-project/kernel-tests
>     Pull requests are welcome for new tests or improvements to existing t=
ests!
>
> Aborted tests
> -------------
> Tests that didn't complete running successfully are marked with =E2=9A=A1=
=E2=9A=A1=E2=9A=A1.
> If this was caused by an infrastructure issue, we try to mark that
> explicitly in the report.
>
> Waived tests
> ------------
> If the test run included waived tests, they are marked with . Such tests =
are
> executed but their results are not taken into account. Tests are waived w=
hen
> their results are not reliable enough, e.g. when they're just introduced =
or are
> being fixed.
>
> Testing timeout
> ---------------
> We aim to provide a report within reasonable timeframe. Tests that haven'=
t
> finished running yet are marked with =E2=8F=B1.
>
>

