Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A442322D04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbhBWO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 09:58:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43014 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232790AbhBWO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:58:36 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NEYRlX036099;
        Tue, 23 Feb 2021 09:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=rkMhQThGrY4uHe8KJrhTYuMBDoaxEgqyhGr+X3tFqrA=;
 b=r1yNcKTsbgc75q2VDF63Lu7RRWEjhb0Y5kbcayNocJefM8Ym0UI2WtOR7tfEuboY7qWl
 eA/SRvLdnH4KsXwTewyEoL2+kEuX6mg7tyoveaZ1jWTdOb+kh48PmXlebGpRTlDtQ7Az
 BgIF1AXaxOE1D6OdexfGQU3OTUr7jZ/xcbqiAGfGtmLgme141VOOivji9FrfDt2ye8rN
 DB/yCmqzylA3QZ2hytf1sgxUB8tZurs4UyNRwskOeABano5YSZU9NegsKNtiNeh0vdn0
 G0DY7cHCa4xlcSNWqBk/wpMP3iWqmYGf9OK7LDq9qBVyUDVmensswfzoafl4S1HlPOb6 OA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36w3a115ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 09:57:48 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11NEq7R9024324;
        Tue, 23 Feb 2021 14:57:45 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 36tt282q28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 14:57:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11NEvgkm58261850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 14:57:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3259942047;
        Tue, 23 Feb 2021 14:57:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA56E42045;
        Tue, 23 Feb 2021 14:57:41 +0000 (GMT)
Received: from thinkpad (unknown [9.171.72.176])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 23 Feb 2021 14:57:41 +0000 (GMT)
Date:   Tue, 23 Feb 2021 15:57:40 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [RFC] linux-next panic in hugepage_subpool_put_pages()
Message-ID: <20210223155740.553df3ee@thinkpad>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=775 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

LTP triggered a panic on s390 in hugepage_subpool_put_pages() with
linux-next 5.12.0-20210222, see below.

It crashes on the spin_lock(&spool->lock) at the beginning, because the
passed-in *spool points to 0000004e00000000, which is not addressable
memory. It rather looks like some flags and not a proper address. I suspect
some relation to the recent rework in that area, e.g. commit f1280272ae4d
("hugetlb: use page.private for hugetlb specific page flags").

__free_huge_page() calls hugepage_subpool_put_pages() and takes *spool from
hugetlb_page_subpool(page), which was changed by that commit to use
page[1]->private now.

What I do not understand is how __free_huge_page() would be called at all
in the call trace below (set_max_huge_pages -> alloc_pool_huge_page ->
__free_huge_page -> hugepage_subpool_put_pages). From the code it seems
that this should not be possible, so I must be missing something.

BTW, the workload of the failing LTP test futex_wake04 is not really
related, the crash happens already during environment setup when it
writes to /proc/sys/vm/nr_hugepages, before starting its actual workload.
It is very hard to reproduce though, so I could not do a proper bisect
so far. Running futex_wake04 alone also never triggered it, I only hit
it very rarely when it was run with ./runltp -f syscalls. Looks like
some kind of race.

[ 4013.255629] LTP: starting futex_wake04
[ 4013.299623] futex_wake04 (865156): drop_caches: 3
[ 4013.300137] Unable to handle kernel pointer dereference in virtual kernel address space
[ 4013.300140] Failing address: 0000004e00000000 TEID: 0000004e00000403
[ 4013.300143] Fault in home space mode while using kernel ASCE.
[ 4013.300148] AS:000000014e264007 R3:0000000000000024 
[ 4013.300172] Oops: 003b ilc:2 [#1] SMP 
[ 4013.300177] Modules linked in: quota_v2 quota_tree tun overlay ntfs exfat vfat fat loop sctp udp_tunnel ip6_udp_tunnel vfio_pci irqbypass vfio_virqfd dm_service_time scsi_debug vfio_ap kvm vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc dm_multipath dm_mod scsi_dh_rdac scsi_dh_emc scsi_dh_alua vfio_ccw vfio_mdev mdev vfio_iommu_type1 vfio eadm_sch sch_fq_codel configfs ip_tables x_tables ghash_s390 prng aes_s390 des_s390 libdes sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4 [last unloaded: init_module]
[ 4013.300273] CPU: 4 PID: 865156 Comm: futex_wake04 Tainted: G           OE     5.12.0-20210222.rc0.git0.abaf6f60176f.300.fc33.s390x+next #1
[ 4013.300278] Hardware name: IBM 2827 H43 738 (LPAR)
[ 4013.300280] Krnl PSW : 0704c00180000000 000000014d00c36c (hugepage_subpool_put_pages.part.0+0x2c/0x138)
[ 4013.300302]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
[ 4013.300307] Krnl GPRS: 0000000000000000 0000000000000000 0000004e00000000 0000000000000005
[ 4013.300311]            0000000000001000 0000037203deffc0 00000380092a7b80 0000000100000000
[ 4013.300314]            3ffff00000010000 000000014e2db208 0000000000000001 0000004e00000000
[ 4013.300317]            0000000081b81f00 000000014d88fde0 00000380092a7a30 00000380092a79e8
[ 4013.300327] Krnl Code: 000000014d00c35e: e3e0f0980024        stg     %r14,152(%r15)
                          000000014d00c364: a7180000            lhi     %r1,0
                         #000000014d00c368: 583003ac            l       %r3,940
                         >000000014d00c36c: ba132000            cs      %r1,%r3,0(%r2)
                          000000014d00c370: a7740076            brc     7,000000014d00c45c
                          000000014d00c374: e310b0100004        lg      %r1,16(%r11)
                          000000014d00c37a: a71fffff            cghi    %r1,-1
                          000000014d00c37e: a784000a            brc     8,000000014d00c392
[ 4013.300351] Call Trace:
[ 4013.300353]  [<000000014d00c36c>] hugepage_subpool_put_pages.part.0+0x2c/0x138 
[ 4013.300358]  [<000000014d00c546>] __free_huge_page+0xce/0x310 
[ 4013.300361]  [<000000014d00a45a>] alloc_pool_huge_page+0x102/0x120 
[ 4013.300365]  [<000000014d00b2ae>] set_max_huge_pages+0x13e/0x350 
[ 4013.300368]  [<000000014d00b728>] hugetlb_sysctl_handler_common+0xd8/0x110 
[ 4013.300372]  [<000000014d00dc20>] hugetlb_sysctl_handler+0x48/0x58 
[ 4013.300376]  [<000000014d12bd08>] proc_sys_call_handler+0x138/0x238 
[ 4013.300381]  [<000000014d058ade>] new_sync_write+0x10e/0x198 
[ 4013.300386]  [<000000014d059644>] vfs_write.part.0+0x12c/0x238 
[ 4013.300390]  [<000000014d05b8b8>] ksys_write+0x68/0xf8 
[ 4013.300394]  [<000000014cd71eda>] do_syscall+0x82/0xd0 
[ 4013.300399]  [<000000014d8671bc>] __do_syscall+0xb4/0xc8 
[ 4013.300404]  [<000000014d87304a>] system_call+0x72/0x98 
[ 4013.300409] Last Breaking-Event-Address:
[ 4013.300410]  [<040000008a220f00>] 0x40000008a220f00
