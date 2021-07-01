Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A93B9000
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhGAJuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:50:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235300AbhGAJuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:50:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1619YRd9135616;
        Thu, 1 Jul 2021 05:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : message-id :
 content-type : subject : date : in-reply-to : cc : to : references :
 mime-version; s=pp1; bh=Y1q9QJB8XlAtdjVa/EJHvF33Zx9ZPlu37E0jB4mlreA=;
 b=qmVYZn5bB0l9F9akbTONhnXcf5ZodCPM182Hl0AjSmqdaCBVjBmCM86L91v+IyYdbZpP
 4mTGWGo8gcMPvfdeMVdWiAN/g+ObKYupOtsKFZQFpcprNOMLS3XDH7qATFABtCcAt++Q
 leXGfBDYjrAZVM73lahXsZB73HzOBc2PoCwdc9s6HnhlgbCZ6nRNnZJWIZTn7JJqMyM1
 RhM3c8vpTrdqJEghou/km2JPXqimKl1PgFWM9pba3+s5Xv2Gs/9yEiAwCkRK5AZgeYoc
 byXT1uAHJlexXRWciU5c5rekWIvnFuIpvxrpgHs7OACgzHs8CriSNASff98Ybn1bWnnC ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39h5mq9j4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 05:47:24 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1619ZTh3139362;
        Thu, 1 Jul 2021 05:47:23 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39h5mq9j46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 05:47:23 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1619h2jA020636;
        Thu, 1 Jul 2021 09:47:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 39duv8h74k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 09:47:21 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1619lJa433030502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 09:47:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD765205A;
        Thu,  1 Jul 2021 09:47:18 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.199.58.175])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5206852054;
        Thu,  1 Jul 2021 09:47:17 +0000 (GMT)
From:   Sachin Sant <sachinp@linux.vnet.ibm.com>
Message-Id: <E16E71B3-E941-4522-AFF1-ABDF918FED19@linux.vnet.ibm.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_9AF61830-42DD-4C95-A46F-F31CE06D1BFB"
Subject: Re: [PATCH] sched/fair: Ensure _sum and _avg values stay consistent
Date:   Thu, 1 Jul 2021 15:17:16 +0530
In-Reply-To: <20210624111815.57937-1-odin@uged.al>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
To:     Odin Ugedal <odin@uged.al>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20210624111815.57937-1-odin@uged.al>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XIypw8ZjXqVKAxxV_uYsrJ3UR4Y2pyJQ
X-Proofpoint-GUID: SFlCI0zcDFE6zPA8j8t_2Cw6CKItJGOs
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_06:2021-06-30,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_9AF61830-42DD-4C95-A46F-F31CE06D1BFB
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable



> On 24-Jun-2021, at 4:48 PM, Odin Ugedal <odin@uged.al> wrote:
>=20
> The _sum and _avg values are in general sync together with the PELT
> divider. They are however not always completely in perfect sync,
> resulting in situations where _sum gets to zero while _avg stays
> positive. Such situations are undesirable.
>=20
> This comes from the fact that PELT will increase period_contrib, also
> increasing the PELT divider, without updating _sum and _avg values to
> stay in perfect sync where (_sum =3D=3D _avg * divider). However, such PE=
LT
> change will never lower _sum, making it impossible to end up in a
> situation where _sum is zero and _avg is not.
>=20
> Therefore, we need to ensure that when subtracting load outside PELT,
> that when _sum is zero, _avg is also set to zero. This occurs when
> (_sum < _avg * divider), and the subtracted (_avg * divider) is bigger
> or equal to the current _sum, while the subtracted _avg is smaller than
> the current _avg.
>=20
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Odin Ugedal <odin@uged.al>

Hello Odin, Vincent,

The issue of kernel warning(during boot) seen on Power sever, reported few =
days back is not completely fixed.
I am able to recreate this issue with latest 5.13 kernel(which has this fix)

# git log --oneline kernel/sched/fair.c
a6eaf3850cb1 Merge tag 'sched-urgent-2021-06-30' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/tip/tip
54a728dc5e4f Merge tag 'sched-core-2021-06-28' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tip/tip
1c35b07e6d39 sched/fair: Ensure _sum and _avg values stay consistent  <<=3D=
=3D


[   65.407631] ------------[ cut here ]------------
[   65.407656] cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || cfs_rq->avg.=
runnable_avg
[   65.407666] WARNING: CPU: 18 PID: 6642 at kernel/sched/fair.c:3308 updat=
e_blocked_averages+0x748/0x7a0
[   65.407693] Modules linked in: dm_mod bonding nft_ct nf_conntrack nf_def=
rag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tables nfnetlink sunrpc xfs libcrc=
32c pseries_rng xts uio_pdrv_genirq vmx_crypto uio sch_fq_codel ip_tables e=
xt4 mbcache jbd2 sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp fuse
[   65.407776] CPU: 18 PID: 6642 Comm: gcc Not tainted 5.13.0-05357-gdbe69e=
433722 #1
[   65.407789] NIP:  c0000000001b2e48 LR: c0000000001b2e44 CTR: c0000000007=
2cac0
[   65.407798] REGS: c00000003f2cf660 TRAP: 0700   Not tainted  (5.13.0-053=
57-gdbe69e433722)
[   65.407809] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 48088224 =
 XER: 00000005
[   65.407837] CFAR: c00000000014d520 IRQMASK: 1=20
               GPR00: c0000000001b2e44 c00000003f2cf900 c0000000029bc700 00=
00000000000048=20
               GPR04: 00000000ffff7fff c00000003f2cf5c0 0000000000000027 c0=
000008baa07e18=20
               GPR08: 0000000000000023 0000000000000001 0000000000000027 c0=
00000002876888=20
               GPR12: 0000000000008000 c00000001ec35a80 c0000008baa92580 00=
00000f3a993c3c=20
               GPR16: 0000000000000000 c0000008baa92580 c00000001a53b400 00=
00000000000001=20
               GPR20: 0000000000000000 c0000000029fdfe0 0000000000000000 00=
00000000000012=20
               GPR24: 0000000000000000 c0000008baa92f90 0000000000000001 c0=
000008baa92600=20
               GPR28: 0000000000000012 0000000f3a993c3c c00000001a53b5c0 00=
00000000000001=20
[   65.407984] NIP [c0000000001b2e48] update_blocked_averages+0x748/0x7a0
[   65.407995] LR [c0000000001b2e44] update_blocked_averages+0x744/0x7a0
[   65.408005] Call Trace:
[   65.408010] [c00000003f2cf900] [c0000000001b2e44] update_blocked_average=
s+0x744/0x7a0 (unreliable)
[   65.408025] [c00000003f2cfa20] [c0000000001bdd78] newidle_balance+0x258/=
0x5c0
[   65.408038] [c00000003f2cfab0] [c0000000001be1bc] pick_next_task_fair+0x=
7c/0x4c0
[   65.408051] [c00000003f2cfb10] [c000000000cf223c] __schedule+0x15c/0x17b0
[   65.408063] [c00000003f2cfc50] [c0000000001a6044] do_task_dead+0x64/0x70
[   65.408076] [c00000003f2cfc80] [c0000000001567d8] do_exit+0x868/0xce0
[   65.408089] [c00000003f2cfd50] [c000000000156d24] do_group_exit+0x64/0xe0
[   65.408101] [c00000003f2cfd90] [c000000000156dc4] sys_exit_group+0x24/0x=
30
[   65.408115] [c00000003f2cfdb0] [c0000000000307b0] system_call_exception+=
0x150/0x2d0
[   65.408128] [c00000003f2cfe10] [c00000000000cc5c] system_call_common+0xe=
c/0x278
[   65.408141] --- interrupt: c00 at 0x7fffa163b80c
[   65.408150] NIP:  00007fffa163b80c LR: 00007fffa1597004 CTR: 00000000000=
00000
[   65.408159] REGS: c00000003f2cfe80 TRAP: 0c00   Not tainted  (5.13.0-053=
57-gdbe69e433722)
[   65.408168] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE> =
 CR: 28000222  XER: 00000000
[   65.408199] IRQMASK: 0=20
               GPR00: 00000000000000ea 00007fffdf5cd220 00007fffa1757300 00=
00000000000000=20
               GPR04: 0000000000000000 00007fffdf5cd078 0000000000000000 00=
00000000000000=20
               GPR08: 0000000000000001 0000000000000000 0000000000000000 00=
00000000000000=20
               GPR12: 0000000000000000 00007fffa192a930 0000000000000000 00=
00000000000000=20
               GPR16: 0000000000000000 0000000000000000 0000000000000000 00=
00000000000000=20
               GPR20: 0000000000000000 00007fffa1754ee0 0000000000000004 00=
00000000000001=20
               GPR24: 00007fffa17508a0 0000000000000000 0000000000000000 00=
00000000000001=20
               GPR28: 0000000000000000 0000000000000000 00007fffa1923950 00=
00000000000000=20
[   65.408308] NIP [00007fffa163b80c] 0x7fffa163b80c
[   65.408317] LR [00007fffa1597004] 0x7fffa1597004
[   65.408324] --- interrupt: c00
[   65.408331] Instruction dump:
[   65.408339] 2f890000 409efa3c 4bffa119 4bfffa34 60000000 60000000 e92100=
70 e8610088=20
[   65.408361] 39400001 99490003 4bf9a679 60000000 <0fe00000> e95201ba 2faa=
0000 4bfffc50=20
[   65.408383] ---[ end trace 14708e73bf91cf1c ]=E2=80=94


Let me know if any additional information is required.

I have attached the dmesg log captured after the failure.

Thanks
-Sachin

> ---
>=20
> Reports and discussion can be found here:
>=20
> https://lore.kernel.org/lkml/2ED1BDF5-BC0C-47CD-8F33-9A46C738F8CF@linux.v=
net.ibm.com/
> https://lore.kernel.org/lkml/CA+G9fYsMXELmjGUzw4SY1bghTYz_PeR2diM6dRp2J37=
bBZzMSA@mail.gmail.com/
>=20
> kernel/sched/fair.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bfaa6e1f6067..def48bc2e90b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3688,15 +3688,15 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cf=
s_rq)
>=20
> 		r =3D removed_load;
> 		sub_positive(&sa->load_avg, r);
> -		sub_positive(&sa->load_sum, r * divider);
> +		sa->load_sum =3D sa->load_avg * divider;
>=20
> 		r =3D removed_util;
> 		sub_positive(&sa->util_avg, r);
> -		sub_positive(&sa->util_sum, r * divider);
> +		sa->util_sum =3D sa->util_avg * divider;
>=20
> 		r =3D removed_runnable;
> 		sub_positive(&sa->runnable_avg, r);
> -		sub_positive(&sa->runnable_sum, r * divider);
> +		sa->runnable_sum =3D sa->runnable_avg * divider;
>=20
> 		/*
> 		 * removed_runnable is the unweighted version of removed_load so we
> --=20
> 2.32.0
>=20



--Apple-Mail=_9AF61830-42DD-4C95-A46F-F31CE06D1BFB
Content-Disposition: attachment;
	filename=5.13-dmesg-log.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="5.13-dmesg-log.txt"
Content-Transfer-Encoding: quoted-printable

[    0.000000] crashkernel: memory value expected
[    0.000000] hash-mmu: Page sizes from device-tree:
[    0.000000] hash-mmu: base_shift=3D12: shift=3D12, sllp=3D0x0000, =
avpnm=3D0x00000000, tlbiel=3D1, penc=3D0
[    0.000000] hash-mmu: base_shift=3D12: shift=3D16, sllp=3D0x0000, =
avpnm=3D0x00000000, tlbiel=3D1, penc=3D7
[    0.000000] hash-mmu: base_shift=3D12: shift=3D24, sllp=3D0x0000, =
avpnm=3D0x00000000, tlbiel=3D1, penc=3D56
[    0.000000] hash-mmu: base_shift=3D16: shift=3D16, sllp=3D0x0110, =
avpnm=3D0x00000000, tlbiel=3D1, penc=3D1
[    0.000000] hash-mmu: base_shift=3D16: shift=3D24, sllp=3D0x0110, =
avpnm=3D0x00000000, tlbiel=3D1, penc=3D8
[    0.000000] hash-mmu: base_shift=3D24: shift=3D24, sllp=3D0x0100, =
avpnm=3D0x00000001, tlbiel=3D0, penc=3D0
[    0.000000] hash-mmu: base_shift=3D34: shift=3D34, sllp=3D0x0120, =
avpnm=3D0x000007ff, tlbiel=3D0, penc=3D3
[    0.000000] Enabling pkeys with max key count 31
[    0.000000] Activating Kernel Userspace Execution Prevention
[    0.000000] Activating Kernel Userspace Access Prevention
[    0.000000] Page orders: linear mapping =3D 24, virtual =3D 16, io =3D =
16, vmemmap =3D 24
[    0.000000] Using 1TB segments
[    0.000000] hash-mmu: Initializing hash mmu with SLB
[    0.000000] Linux version 5.13.0-05357-gdbe69e433722 =
(root@ltc-zzci-4.aus.stglabs.ibm.com) (gcc (GCC) 8.4.1 20200928 (Red Hat =
8.4.1-1), GNU ld version 2.30-93.el8) #1 SMP Thu Jul 1 04:24:02 EDT 2021
[    0.000000] Found initrd at 0xc00000000d500000:0xc00000001365b29d
[    0.000000] Using pSeries machine description
[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] Partition configured for 40 cpus.
[    0.000000] CPU maps initialized for 8 threads per core
[    0.000000]  (thread shift is 3)
[    0.000000] Allocated 4800 bytes for 40 pacas
[    0.000000] -----------------------------------------------------
[    0.000000] phys_mem_size     =3D 0x8c0000000
[    0.000000] dcache_bsize      =3D 0x80
[    0.000000] icache_bsize      =3D 0x80
[    0.000000] cpu_features      =3D 0x0001c07b8f5f9187
[    0.000000]   possible        =3D 0x000ffbfbcf5fb187
[    0.000000]   always          =3D 0x0000000380008181
[    0.000000] cpu_user_features =3D 0xdc0065c2 0xeff00000
[    0.000000] mmu_features      =3D 0x7c006e01
[    0.000000] firmware_features =3D 0x0000009fc45bfc57
[    0.000000] vmalloc start     =3D 0xc008000000000000
[    0.000000] IO start          =3D 0xc00a000000000000
[    0.000000] vmemmap start     =3D 0xc00c000000000000
[    0.000000] hash-mmu: ppc64_pft_size    =3D 0x1c
[    0.000000] hash-mmu: htab_hash_mask    =3D 0x1fffff
[    0.000000] -----------------------------------------------------
[    0.000000] numa:   NODE_DATA [mem 0x8bfe9af80-0x8bfe9ffff]
[    0.000000] rfi-flush: fallback displacement flush available
[    0.000000] rfi-flush: mttrig type flush available
[    0.000000] rfi-flush: patched 13 locations (mttrig type flush)
[    0.000000] count-cache-flush: flush disabled.
[    0.000000] link-stack-flush: software flush enabled.
[    0.000000] entry-flush: patched 61 locations (mttrig type flush)
[    0.000000] uaccess-flush: patched 1 locations (mttrig type flush)
[    0.000000] stf-barrier: eieio barrier available
[    0.000000] stf-barrier: patched 61 entry locations (eieio barrier)
[    0.000000] stf-barrier: patched 13 exit locations (eieio barrier)
[    0.000000] lpar: H_BLOCK_REMOVE supports base psize:0 psize:0 block =
size:8
[    0.000000] lpar: H_BLOCK_REMOVE supports base psize:0 psize:2 block =
size:8
[    0.000000] lpar: H_BLOCK_REMOVE supports base psize:0 psize:10 block =
size:8
[    0.000000] lpar: H_BLOCK_REMOVE supports base psize:2 psize:2 block =
size:8
[    0.000000] lpar: H_BLOCK_REMOVE supports base psize:2 psize:10 block =
size:8
[    0.000000] PPC64 nvram contains 15360 bytes
[    0.000000] barrier-nospec: using ORI speculation barrier
[    0.000000] barrier-nospec: patched 385 locations
[    0.000000] Top of RAM: 0x8c0000000, Total RAM: 0x8c0000000
[    0.000000] Memory hole size: 0MB
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x00000008bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x00000008bfffffff]
[    0.000000] Initmem setup node 0 [mem =
0x0000000000000000-0x00000008bfffffff]
[    0.000000] percpu: Embedded 10 pages/cpu s605976 r0 d49384 u1048576
[    0.000000] pcpu-alloc: s605976 r0 d49384 u1048576 alloc=3D1*1048576
[    0.000000] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] =
06 [0] 07=20
[    0.000000] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] =
14 [0] 15=20
[    0.000000] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] =
22 [0] 23=20
[    0.000000] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] =
30 [0] 31=20
[    0.000000] pcpu-alloc: [0] 32 [0] 33 [0] 34 [0] 35 [0] 36 [0] 37 [0] =
38 [0] 39=20
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: =
572880
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: =
BOOT_IMAGE=3D/vmlinuz-5.13.0-05357-gdbe69e433722 =
root=3DUUID=3Da95e51fa-8962-4cb2-8189-8c8cd8d653c9 ro crashkernel=3Dauto =
biosdevname=3D0
[    0.000000] Dentry cache hash table entries: 8388608 (order: 10, =
67108864 bytes, linear)
[    0.000000] Inode-cache hash table entries: 4194304 (order: 9, =
33554432 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 36290240K/36700160K available (13376K kernel =
code, 5440K rwdata, 4096K rodata, 4992K init, 2863K bss, 409920K =
reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=3D128, Order=3D0-3, MinObjects=3D0, =
CPUs=3D40, Nodes=3D2
[    0.000000] ftrace: allocating 33136 entries in 13 pages
[    0.000000] ftrace: allocated 13 pages with 3 groups
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=3D2048 to =
nr_cpu_ids=3D40.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay =
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, =
nr_cpu_ids=3D40
[    0.000000] NR_IRQS: 512, nr_irqs: 512, preallocated irqs: 16
[    0.000000] pic: no ISA interrupt controller
[    0.000000] rcu: 	Offload RCU callbacks from CPUs: (none).
[    0.000000] random: get_random_u64 called from =
start_kernel+0x834/0xa90 with crng_init=3D0
[    0.000000] time_init: decrementer frequency =3D 512.000000 MHz
[    0.000000] time_init: processor frequency   =3D 2900.000000 MHz
[    0.000002] time_init: 56 bit decrementer (max: 7fffffffffffff)
[    0.000040] clocksource: timebase: mask: 0xffffffffffffffff =
max_cycles: 0x761537d007, max_idle_ns: 440795202126 ns
[    0.000106] clocksource: timebase mult[1f40000] shift[24] registered
[    0.000149] clockevent: decrementer mult[83126f] shift[24] cpu[0]
[    0.000205] Console: colour dummy device 80x25
[    0.000237] printk: console [hvc0] enabled
[    0.000266] printk: bootconsole [udbg0] disabled
[    0.000324] pid_max: default: 40960 minimum: 320
[    0.000372] LSM: Security Framework initializing
[    0.000387] Yama: becoming mindful.
[    0.000399] SELinux:  Initializing.
[    0.000521] Mount-cache hash table entries: 131072 (order: 4, 1048576 =
bytes, linear)
[    0.000599] Mountpoint-cache hash table entries: 131072 (order: 4, =
1048576 bytes, linear)
[    0.001300] POWER9 performance monitor hardware support registered
[    0.001335] rcu: Hierarchical SRCU implementation.
[    0.002406] smp: Bringing up secondary CPUs ...
[    0.017195] smp: Brought up 1 node, 40 CPUs
[    0.017206] numa: Node 0 CPUs: 0-39
[    0.017214] Big cores detected but using small core scheduling
[    0.018638] devtmpfs: initialized
[    0.022718] clocksource: jiffies: mask: 0xffffffff max_cycles: =
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.022727] futex hash table entries: 16384 (order: 5, 2097152 bytes, =
linear)
[    0.023011] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.023112] audit: initializing netlink subsys (disabled)
[    0.023179] audit: type=3D2000 audit(1625128776.020:1): =
state=3Dinitialized audit_enabled=3D0 res=3D1
[    0.023234] thermal_sys: Registered thermal governor 'fair_share'
[    0.023236] thermal_sys: Registered thermal governor 'step_wise'
[    0.023339] cpuidle: using governor menu
[    0.023407] RTAS daemon started
[    0.023543] pstore: Registered nvram as persistent store backend
[    0.024150] EEH: pSeries platform initialized
[    0.029601] PCI: Probing PCI hardware
[    0.029605] EEH: No capable adapters found: recovery disabled.
[    0.029609] PCI: Probing PCI hardware done
[    0.029704] pseries-rng: Registering arch random hook.
[    0.030975] Kprobes globally optimized
[    0.031162] HugeTLB registered 16.0 MiB page size, pre-allocated 0 =
pages
[    0.031167] HugeTLB registered 16.0 GiB page size, pre-allocated 0 =
pages
[    0.065972] wait_for_initramfs() called before rootfs_initcalls
[    0.069388] iommu: Default domain type: Translated=20
[    0.069440] vgaarb: loaded
[    0.069515] SCSI subsystem initialized
[    0.069549] usbcore: registered new interface driver usbfs
[    0.069559] usbcore: registered new interface driver hub
[    0.069575] usbcore: registered new device driver usb
[    0.069657] EDAC MC: Ver: 3.0.0
[    0.069874] NetLabel: Initializing
[    0.069877] NetLabel:  domain hash size =3D 128
[    0.069880] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    0.069894] NetLabel:  unlabeled traffic allowed by default
[    0.070078] clocksource: Switched to clocksource timebase
[    0.080481] VFS: Disk quotas dquot_6.6.0
[    0.080504] VFS: Dquot-cache hash table entries: 8192 (order 0, 65536 =
bytes)
[    0.082731] NET: Registered PF_INET protocol family
[    0.082877] IP idents hash table entries: 262144 (order: 5, 2097152 =
bytes, linear)
[    0.085639] tcp_listen_portaddr_hash hash table entries: 32768 =
(order: 3, 524288 bytes, linear)
[    0.085703] TCP established hash table entries: 524288 (order: 6, =
4194304 bytes, linear)
[    0.086557] TCP bind hash table entries: 65536 (order: 4, 1048576 =
bytes, linear)
[    0.086650] TCP: Hash tables configured (established 524288 bind =
65536)
[    0.086700] UDP hash table entries: 32768 (order: 4, 1048576 bytes, =
linear)
[    0.086799] UDP-Lite hash table entries: 32768 (order: 4, 1048576 =
bytes, linear)
[    0.086963] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.086972] PCI: CLS 0 bytes, default 128
[    0.087015] Trying to unpack rootfs image as initramfs...
[    0.087662] IOMMU table initialized, virtual merging enabled
[    0.101220] hv-24x7: read 1530 catalog entries, created 509 event =
attrs (0 failures), 275 descs
[    0.101890] random: fast init done
[    0.104385] Initialise system trusted keyrings
[    0.104442] workingset: timestamp_bits=3D38 max_order=3D20 =
bucket_order=3D0
[    0.105898] zbud: loaded
[    0.127277] NET: Registered PF_ALG protocol family
[    0.127282] Key type asymmetric registered
[    0.127285] Asymmetric key parser 'x509' registered
[    0.127294] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 248)
[    0.127350] io scheduler mq-deadline registered
[    0.127356] io scheduler kyber registered
[    0.128111] atomic64_test: passed
[    0.128154] shpchp: Standard Hot Plug PCI Controller Driver version: =
0.4
[    0.128499] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.128752] Non-volatile memory driver v1.3
[    0.128784] Linux agpgart interface v0.103
[    0.128946] tpm_ibmvtpm 30000003: CRQ initialization completed
[    1.200907] rdac: device handler registered
[    1.200975] hp_sw: device handler registered
[    1.200978] emc: device handler registered
[    1.201039] alua: device handler registered
[    1.201138] libphy: Fixed MDIO Bus: probed
[    1.201183] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) =
Driver
[    1.201195] ehci-pci: EHCI PCI platform driver
[    1.201205] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.201215] ohci-pci: OHCI PCI platform driver
[    1.201226] uhci_hcd: USB Universal Host Controller Interface driver
[    1.201263] usbcore: registered new interface driver =
usbserial_generic
[    1.201271] usbserial: USB Serial support registered for generic
[    1.201333] mousedev: PS/2 mouse device common for all mice
[    1.201439] rtc-generic rtc-generic: registered as rtc0
[    1.201550] rtc-generic rtc-generic: setting system clock to =
2021-07-01T08:39:37 UTC (1625128777)
[    1.201639] xcede: xcede_record_size =3D 10
[    1.201642] xcede: Record 0 : hint =3D 1, latency =3D 0x400 tb ticks, =
Wake-on-irq =3D 1
[    1.201647] xcede: Record 1 : hint =3D 2, latency =3D 0x3e8000 tb =
ticks, Wake-on-irq =3D 0
[    1.201652] cpuidle: Skipping the 2 Extended CEDE idle states
[    1.201656] cpuidle: Fixed up CEDE exit latency to 1 us
[    1.202109] pseries_idle_driver registered
[    1.202203] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: =
max_sync_size new:65536 old:0
[    1.202209] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: =
max_sync_sg new:510 old:0
[    1.202215] nx_compress_pseries ibm,compression-v1: nx842_OF_upd: =
max_sg_len new:4080 old:0
[    1.202451] alg: No test for 842 (842-nx)
[    1.202499] hid: raw HID events driver (C) Jiri Kosina
[    1.202603] usbcore: registered new interface driver usbhid
[    1.202606] usbhid: USB HID core driver
[    1.202627] drop_monitor: Initializing network drop monitor service
[    1.202688] Initializing XFRM netlink socket
[    1.202774] NET: Registered PF_INET6 protocol family
[    1.203059] Segment Routing with IPv6
[    1.203076] NET: Registered PF_PACKET protocol family
[    1.203082] mpls_gso: MPLS GSO support
[    1.204026] Running MSI bitmap self-tests ...
[    1.205583] registered taskstats version 1
[    1.205597] Loading compiled-in X.509 certificates
[    1.540712] Freeing initrd memory: 99648K
[    1.543608] alg: No test for pkcs1pad(rsa,sha1) =
(pkcs1pad(rsa-generic,sha1))
[    1.544279] Loaded X.509 cert 'Build time autogenerated kernel key: =
2bba0209abfc79c0306841f3505f786c172fa1b0'
[    1.544400] zswap: loaded using pool lzo/zbud
[    1.544520] pstore: Using crash dump compression: deflate
[    1.546192] Freeing unused kernel image (initmem) memory: 4992K
[    1.590239] Run /init as init process
[    1.590244]   with arguments:
[    1.590245]     /init
[    1.590247]   with environment:
[    1.590248]     HOME=3D/
[    1.590249]     TERM=3Dlinux
[    1.590250]     BOOT_IMAGE=3D/vmlinuz-5.13.0-05357-gdbe69e433722
[    1.590251]     crashkernel=3Dauto
[    1.590252]     biosdevname=3D0
[    1.598752] systemd[1]: systemd 239 (239-45.el8) running in system =
mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP =
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS =
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dlegacy)
[    1.598975] systemd[1]: Detected architecture ppc64-le.
[    1.598981] systemd[1]: Running in initial RAM disk.
[    1.650496] systemd[1]: Set hostname to =
<ltc-zzci-4.aus.stglabs.ibm.com>.
[    1.710918] random: systemd: uninitialized urandom read (16 bytes =
read)
[    1.710999] systemd[1]: Listening on udev Kernel Socket.
[    1.711220] random: systemd: uninitialized urandom read (16 bytes =
read)
[    1.711306] systemd[1]: Listening on udev Control Socket.
[    1.711427] random: systemd: uninitialized urandom read (16 bytes =
read)
[    1.711440] systemd[1]: Reached target Slices.
[    1.711637] systemd[1]: Listening on Journal Socket (/dev/log).
[    1.711754] systemd[1]: Reached target Timers.
[    1.711867] systemd[1]: Reached target Local File Systems.
[    1.769510] fuse: init (API version 7.33)
[    1.953986] synth uevent: /devices/vio: failed to send uevent
[    1.953998] vio vio: uevent: failed to send synthetic uevent
[    1.954079] synth uevent: /devices/vio/4000: failed to send uevent
[    1.954083] vio 4000: uevent: failed to send synthetic uevent
[    1.954099] synth uevent: /devices/vio/4001: failed to send uevent
[    1.954103] vio 4001: uevent: failed to send synthetic uevent
[    1.954118] synth uevent: /devices/vio/4002: failed to send uevent
[    1.954122] vio 4002: uevent: failed to send synthetic uevent
[    1.954137] synth uevent: /devices/vio/4004: failed to send uevent
[    1.954141] vio 4004: uevent: failed to send synthetic uevent
[    1.986172] ibmveth: IBM Power Virtual Ethernet Driver 1.06
[    1.987465] ibmveth 30000002 net0: renamed from eth0
[    1.988322] ibmvscsi 30000068: SRP_VERSION: 16.a
[    1.988426] ibmvscsi 30000068: Maximum ID: 64 Maximum LUN: 32 Maximum =
Channel: 3
[    1.988433] scsi host0: IBM POWER Virtual SCSI Adapter 1.5.9
[    1.988582] ibmvscsi 30000068: partner initialization complete
[    1.988618] ibmvscsi 30000068: host srp version: 16.a, host partition =
ltc-zzci-vios1 (100), OS 3, max io 262144
[    1.988672] ibmvscsi 30000068: Client reserve enabled
[    1.988679] ibmvscsi 30000068: sent SRP login
[    1.988710] ibmvscsi 30000068: SRP_LOGIN succeeded
[    2.021106] scsi 0:0:1:0: Direct-Access     AIX      VDASD            =
0001 PQ: 0 ANSI: 3
[    2.057643] scsi 0:0:1:0: Attached scsi generic sg0 type 0
[    2.072743] sd 0:0:1:0: [sda] 139466752 4096-byte logical blocks: =
(571 GB/532 GiB)
[    2.072783] sd 0:0:1:0: [sda] Write Protect is off
[    2.072788] sd 0:0:1:0: [sda] Mode Sense: 17 00 00 08
[    2.072822] sd 0:0:1:0: [sda] Cache data unavailable
[    2.072827] sd 0:0:1:0: [sda] Assuming drive cache: write through
[    2.161746]  sda: sda1 sda2 sda3 sda4 < sda5 >
[    2.162697] sd 0:0:1:0: [sda] Attached SCSI disk
[    2.619863] EXT4-fs (sda5): mounted filesystem with ordered data =
mode. Opts: (null). Quota mode: none.
[    3.164023] printk: systemd: 15 output lines suppressed due to =
ratelimiting
[    3.507303] SELinux:  Runtime disable is deprecated, use selinux=3D0 =
on the kernel cmdline.
[    3.507312] SELinux:  Disabled at runtime.
[    3.660100] audit: type=3D1404 audit(1625128779.950:2): enforcing=3D0 =
old_enforcing=3D0 auid=3D4294967295 ses=3D4294967295 enabled=3D0 =
old-enabled=3D1 lsm=3Dselinux res=3D1
[    4.203691] systemd[1]: systemd 239 (239-45.el8) running in system =
mode. (+PAM +AUDIT +SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP =
+LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS =
+KMOD +IDN2 -IDN +PCRE2 default-hierarchy=3Dlegacy)
[    4.203904] systemd[1]: Detected architecture ppc64-le.
[    4.209939] systemd[1]: Set hostname to =
<ltc-zzci-4.aus.stglabs.ibm.com>.
[    4.240883] random: crng init done
[    4.240889] random: 7 urandom warning(s) missed due to ratelimiting
[    5.445640] systemd[1]: systemd-journald.service: Succeeded.
[    5.446405] systemd[1]: initrd-switch-root.service: Succeeded.
[    5.446757] systemd[1]: Stopped Switch Root.
[    5.447376] systemd[1]: systemd-journald.service: Service has no =
hold-off time (RestartSec=3D0), scheduling restart.
[    5.447489] systemd[1]: systemd-journald.service: Scheduled restart =
job, restart counter is at 1.
[    5.447582] systemd[1]: Stopped Journal Service.
[    5.448412] systemd[1]: Starting Journal Service...
[    5.602303] synth uevent: /devices/vio: failed to send uevent
[    5.602314] vio vio: uevent: failed to send synthetic uevent
[    5.602560] synth uevent: /devices/vio/4000: failed to send uevent
[    5.602565] vio 4000: uevent: failed to send synthetic uevent
[    5.602580] synth uevent: /devices/vio/4001: failed to send uevent
[    5.602584] vio 4001: uevent: failed to send synthetic uevent
[    5.602597] synth uevent: /devices/vio/4002: failed to send uevent
[    5.602601] vio 4002: uevent: failed to send synthetic uevent
[    5.602615] synth uevent: /devices/vio/4004: failed to send uevent
[    5.602619] vio 4004: uevent: failed to send synthetic uevent
[    5.621109] Adding 41942976k swap on /dev/sda3.  Priority:-2 =
extents:1 across:41942976k FS
[    5.624915] EXT4-fs (sda5): re-mounted. Opts: (null). Quota mode: =
none.
[    6.331259] pseries_rng: Registering IBM pSeries RNG driver
[    7.532889] SGI XFS with ACLs, security attributes, quota, no debug =
enabled
[    7.534521] XFS (sda2): Mounting V5 Filesystem
[    7.598310] XFS (sda2): Ending clean mount
[    7.611036] xfs filesystem being mounted at /boot supports timestamps =
until 2038 (0x7fffffff)
[    8.126320] RPC: Registered named UNIX socket transport module.
[    8.126329] RPC: Registered udp transport module.
[    8.126333] RPC: Registered tcp transport module.
[    8.126336] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   16.172919] device-mapper: uevent: version 1.0.3
[   16.173009] device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) =
initialised: dm-devel@redhat.com
[   65.407631] ------------[ cut here ]------------
[   65.407656] cfs_rq->avg.load_avg || cfs_rq->avg.util_avg || =
cfs_rq->avg.runnable_avg
[   65.407666] WARNING: CPU: 18 PID: 6642 at kernel/sched/fair.c:3308 =
update_blocked_averages+0x748/0x7a0
[   65.407693] Modules linked in: dm_mod bonding nft_ct nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 ip_set rfkill nf_tables nfnetlink sunrpc =
xfs libcrc32c pseries_rng xts uio_pdrv_genirq vmx_crypto uio =
sch_fq_codel ip_tables ext4 mbcache jbd2 sd_mod t10_pi sg ibmvscsi =
ibmveth scsi_transport_srp fuse
[   65.407776] CPU: 18 PID: 6642 Comm: gcc Not tainted =
5.13.0-05357-gdbe69e433722 #1
[   65.407789] NIP:  c0000000001b2e48 LR: c0000000001b2e44 CTR: =
c00000000072cac0
[   65.407798] REGS: c00000003f2cf660 TRAP: 0700   Not tainted  =
(5.13.0-05357-gdbe69e433722)
[   65.407809] MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: =
48088224  XER: 00000005
[   65.407837] CFAR: c00000000014d520 IRQMASK: 1=20
               GPR00: c0000000001b2e44 c00000003f2cf900 c0000000029bc700 =
0000000000000048=20
               GPR04: 00000000ffff7fff c00000003f2cf5c0 0000000000000027 =
c0000008baa07e18=20
               GPR08: 0000000000000023 0000000000000001 0000000000000027 =
c000000002876888=20
               GPR12: 0000000000008000 c00000001ec35a80 c0000008baa92580 =
0000000f3a993c3c=20
               GPR16: 0000000000000000 c0000008baa92580 c00000001a53b400 =
0000000000000001=20
               GPR20: 0000000000000000 c0000000029fdfe0 0000000000000000 =
0000000000000012=20
               GPR24: 0000000000000000 c0000008baa92f90 0000000000000001 =
c0000008baa92600=20
               GPR28: 0000000000000012 0000000f3a993c3c c00000001a53b5c0 =
0000000000000001=20
[   65.407984] NIP [c0000000001b2e48] =
update_blocked_averages+0x748/0x7a0
[   65.407995] LR [c0000000001b2e44] update_blocked_averages+0x744/0x7a0
[   65.408005] Call Trace:
[   65.408010] [c00000003f2cf900] [c0000000001b2e44] =
update_blocked_averages+0x744/0x7a0 (unreliable)
[   65.408025] [c00000003f2cfa20] [c0000000001bdd78] =
newidle_balance+0x258/0x5c0
[   65.408038] [c00000003f2cfab0] [c0000000001be1bc] =
pick_next_task_fair+0x7c/0x4c0
[   65.408051] [c00000003f2cfb10] [c000000000cf223c] =
__schedule+0x15c/0x17b0
[   65.408063] [c00000003f2cfc50] [c0000000001a6044] =
do_task_dead+0x64/0x70
[   65.408076] [c00000003f2cfc80] [c0000000001567d8] do_exit+0x868/0xce0
[   65.408089] [c00000003f2cfd50] [c000000000156d24] =
do_group_exit+0x64/0xe0
[   65.408101] [c00000003f2cfd90] [c000000000156dc4] =
sys_exit_group+0x24/0x30
[   65.408115] [c00000003f2cfdb0] [c0000000000307b0] =
system_call_exception+0x150/0x2d0
[   65.408128] [c00000003f2cfe10] [c00000000000cc5c] =
system_call_common+0xec/0x278
[   65.408141] --- interrupt: c00 at 0x7fffa163b80c
[   65.408150] NIP:  00007fffa163b80c LR: 00007fffa1597004 CTR: =
0000000000000000
[   65.408159] REGS: c00000003f2cfe80 TRAP: 0c00   Not tainted  =
(5.13.0-05357-gdbe69e433722)
[   65.408168] MSR:  800000000280f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000222  XER: 00000000
[   65.408199] IRQMASK: 0=20
               GPR00: 00000000000000ea 00007fffdf5cd220 00007fffa1757300 =
0000000000000000=20
               GPR04: 0000000000000000 00007fffdf5cd078 0000000000000000 =
0000000000000000=20
               GPR08: 0000000000000001 0000000000000000 0000000000000000 =
0000000000000000=20
               GPR12: 0000000000000000 00007fffa192a930 0000000000000000 =
0000000000000000=20
               GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
               GPR20: 0000000000000000 00007fffa1754ee0 0000000000000004 =
0000000000000001=20
               GPR24: 00007fffa17508a0 0000000000000000 0000000000000000 =
0000000000000001=20
               GPR28: 0000000000000000 0000000000000000 00007fffa1923950 =
0000000000000000=20
[   65.408308] NIP [00007fffa163b80c] 0x7fffa163b80c
[   65.408317] LR [00007fffa1597004] 0x7fffa1597004
[   65.408324] --- interrupt: c00
[   65.408331] Instruction dump:
[   65.408339] 2f890000 409efa3c 4bffa119 4bfffa34 60000000 60000000 =
e9210070 e8610088=20
[   65.408361] 39400001 99490003 4bf9a679 60000000 <0fe00000> e95201ba =
2faa0000 4bfffc50=20
[   65.408383] ---[ end trace 14708e73bf91cf1c ]---

--Apple-Mail=_9AF61830-42DD-4C95-A46F-F31CE06D1BFB--

