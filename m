Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9693D461A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 09:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbhGXHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 03:06:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234216AbhGXHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 03:06:45 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16O7X3O7012869;
        Sat, 24 Jul 2021 03:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : cc :
 subject : in-reply-to : in-reply-to : date : message-id : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=hWzL6bot/NgW+BrZOZpiIOorIhXeuebPKvrSguhEmU0=;
 b=FqSdlA0AaNdiG2IKejJXJXnPcH4eKd1Pw+y+/Z5e/vrA8RYEcQ4VdhrWQPskGukIWUzR
 i8O3OyTw1UnQoqEOCxURhnG/8wImOSLTMoeqJTH97L8cuoqP2V2K98eLi7RbrDBlLrCP
 rx+w6jMV4dfL2ngQU78FCrLmrdUZMiFohM4VTar2A6cBlkx/UBEMYsmZdC92j1reC5zd
 rcPmgJdNntMBus5AIh8ZhLleFK7W+mnyCXifEDf8VTMe5lob19INZ5Yd+K67csPMSi3F
 /4No8YGpUX2PjAfQJ5NMmomCII2CdGgjjC8HgW1DvNVcKo+Gb9LXAo9dcbqg+4lhV/Z0 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a0egwga1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jul 2021 03:46:52 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16O7Xmq0014680;
        Sat, 24 Jul 2021 03:46:52 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a0egwga10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jul 2021 03:46:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16O7iaon020911;
        Sat, 24 Jul 2021 07:46:50 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3a0ag8r1nn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Jul 2021 07:46:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16O7klCl24969544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Jul 2021 07:46:47 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75DDBA4054;
        Sat, 24 Jul 2021 07:46:47 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51951A4060;
        Sat, 24 Jul 2021 07:46:47 +0000 (GMT)
Received: from localhost (unknown [9.171.95.165])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 24 Jul 2021 07:46:47 +0000 (GMT)
From:   Alexander Egorenkov <egorenar@linux.ibm.com>
To:     linux@rasmusvillemoes.dk
Cc:     akpm@linux-foundation.org, bp@alien8.de, corbet@lwn.net,
        gregkh@linuxfoundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        ndesaulniers@google.com, torvalds@linux-foundation.org
Subject: Re: [PATCH v3 1/2] init/initramfs.c: do unpacking asynchronously
In-Reply-To: <20210313212528.2956377-2-linux@rasmusvillemoes.dk>
In-Reply-To: 
Date:   Sat, 24 Jul 2021 09:46:46 +0200
Message-ID: <87sg04p315.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s0dcDnq4s_Hpw55oA75qx1gDsbUkFrux
X-Proofpoint-ORIG-GUID: 2XCI33HcQC5VpPNOsN2bj38KSDHKoVbu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-24_02:2021-07-23,2021-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107240047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since e7cb072eb988 ("init/initramfs.c: do unpacking asynchronously"), we
started seeing the following problem on s390 arch regularly:

[    5.039734] wait_for_initramfs() called before rootfs_initcalls
[    5.042003] cryptomgr_test (155) used greatest stack depth: 11952 bytes =
left
[    5.214115] raid6: vx128x8  gen() 21961 MB/s
[    5.384073] raid6: vx128x8  xor() 14882 MB/s
[    5.384090] raid6: using algorithm vx128x8 gen() 21961 MB/s
[    5.384094] raid6: .... xor() 14882 MB/s, rmw enabled
[    5.384098] raid6: using s390xc recovery algorithm
[    5.386338] iommu: Default domain type: Translated=C2=B7
[    5.387724] SCSI subsystem initialized
[    5.393858] cio: Partition identifier 4.9
[    6.361599] VFS: Disk quotas dquot_6.6.0
[    6.361852] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    6.374790] NET: Registered PF_INET protocol family
[    6.375187] IP idents hash table entries: 262144 (order: 9, 2097152 byte=
s, linear)
[    6.381935] tcp_listen_portaddr_hash hash table entries: 8192 (order: 7,=
 720896 bytes, linear)
[    6.382234] TCP established hash table entries: 131072 (order: 8, 104857=
6 bytes, linear)
[    6.383133] TCP bind hash table entries: 65536 (order: 10, 5242880 bytes=
, vmalloc)
[    6.385373] TCP: Hash tables configured (established 131072 bind 65536)
[    6.394770] MPTCP token hash table entries: 16384 (order: 8, 1572864 byt=
es, linear)
[    6.395586] UDP hash table entries: 8192 (order: 8, 1572864 bytes, linea=
r)
[    6.396531] UDP-Lite hash table entries: 8192 (order: 8, 1572864 bytes, =
linear)
[    6.405284] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    6.405821] Trying to unpack rootfs image as initramfs...
[    6.407794] alg: No test for crc32be (crc32be-vx)
[    6.436676] Initialise system trusted keyrings
[    6.436980] workingset: timestamp_bits=3D45 max_order=3D22 bucket_order=
=3D0
[    6.500365] zbud: loaded
[    6.516137] fuse: init (API version 7.34)
[    6.517210] SGI XFS with ACLs, security attributes, realtime, quota, fat=
al assert, debug enabled
[    6.544339] xor: automatically using best checksumming function   xc=C2=
=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7
[    6.544363] Key type asymmetric registered
[    6.544389] Asymmetric key parser 'x509' registered
[    6.544448] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[    6.545893] io scheduler mq-deadline registered
[    6.545927] io scheduler kyber registered
[    6.545933] blkcg_policy_register: BLKCG_MAX_POLS too small
[    6.599433] rootfs image is not initramfs (broken padding); looks like a=
n initrd
[    6.669373] Freeing initrd memory: 24828K

It is very hard to reproduce, i haven't managed to do it yet and working
on it, but it occurs regularly, nearly every day once but only on a particu=
lar
test machine with our nightly s390 CI test runs.

Although the initramfs corruption is hard to reproduce,
the message 'wait_for_initramfs() called before rootfs_initcalls'
appears regularly on each boot at least since 2021-06-24 which we just
noticed a couple of days ago.

Appending 'initramfs_async=3D0' to the kernel command-line doesn't seem to
help with the 'wait_for_initramfs' message and i can still see it.

[    0.890962] wait_for_initramfs() called before rootfs_initcalls
[    1.060846] raid6: vx128x8  gen() 22394 MB/s
[    1.230783] raid6: vx128x8  xor() 14998 MB/s
[    1.230795] raid6: using algorithm vx128x8 gen() 22394 MB/s
[    1.230797] raid6: .... xor() 14998 MB/s, rmw enabled
[    1.230799] raid6: using s390xc recovery algorithm
[    1.231122] iommu: Default domain type: Translated
[    1.231331] SCSI subsystem initialized
[    1.231804] cio: Partition identifier 3.4
[    1.355331] PCI host bridge to bus 0000:00
[    1.355340] pci_bus 0000:00: root bus resource [bus 00]
[    1.355363] PCI host bridge to bus 0001:00
[    1.355364] pci_bus 0001:00: root bus resource [bus 00]
[    1.355490] pci 0000:00:00.0: [8086:0a54] type 00 class 0x010802
[    1.355541] pci 0000:00:00.0: reg 0x10: [mem 0xffffc00000000000-0xffffc0=
0000003fff 64bit]
[    1.355611] pci 0000:00:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[    1.355625] pci 0000:00:00.0: enabling Extended Tags
[    1.355921] pci 0000:00:00.0: Adding to iommu group 0
[    1.632566] VFS: Disk quotas dquot_6.6.0
[    1.632624] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 byte=
s)
[    1.634327] NET: Registered PF_INET protocol family
[    1.634395] IP idents hash table entries: 65536 (order: 7, 524288 bytes,=
 linear)
[    1.635112] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3,=
 32768 bytes, linear)
[    1.635129] TCP established hash table entries: 32768 (order: 6, 262144 =
bytes, linear)
[    1.635296] TCP bind hash table entries: 32768 (order: 7, 524288 bytes, =
linear)
[    1.635498] TCP: Hash tables configured (established 32768 bind 32768)
[    1.635834] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes,=
 linear)
[    1.635852] UDP hash table entries: 2048 (order: 4, 65536 bytes, linear)
[    1.635882] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes, li=
near)
[    1.636249] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.636419] Trying to unpack rootfs image as initramfs...
[    1.676907] Freeing initrd memory: 26056K

Regards
Alex
