Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297FF44D468
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhKKJy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:54:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232705AbhKKJyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:54:19 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9ILV2015501;
        Thu, 11 Nov 2021 09:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8pZIhOaptc+rrXvs2m9iAXyA/DdA1brzyOBk7W7ZQoU=;
 b=fq2AAROFWhnjfiV8/DP8wwIXAezTUKZQgm4aiVx2kPm4zwuXfcRgm7eM787kw3sgBC16
 HA+6XsBBCeFnsjJ3F68EAh/XPyVJVx0qrPw0QQ92QiGwgwmS8HqovKuM3yecs/axDco/
 Wt5gh8CxUo7BgbeIvKf1OPKW7DOEx8sRSV+p1wlTtwxGvxxEXzBUDtLF7l+avaJo67Un
 loodDCs+f7eDPAo3sw5r2p741KSsBytA5bvPwQbsJKSqWzd36r8R3Q4KrOZ6isBYBhrv
 JNYGDOqJQx5F6cOP+0yxDgUJY6p4gIEonSdvd/57U8ztuzLiSmRwpdJaYZCRXUvzBsOd XA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90e6gnx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:26 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AB9JExI016913;
        Thu, 11 Nov 2021 09:50:25 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90e6gnvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:25 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9n9jv027422;
        Thu, 11 Nov 2021 09:50:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3c5hbauqqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:22 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AB9oHXe393980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 09:50:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E89E4C050;
        Thu, 11 Nov 2021 09:50:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B1EE4C052;
        Thu, 11 Nov 2021 09:50:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 09:50:16 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     thuth@redhat.com, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, heiko.carstens@de.ibm.com,
        david@redhat.com, ultrachin@163.com, akpm@linux-foundation.org,
        vbabka@suse.cz, brookxu.cn@gmail.com, xiaoggchen@tencent.com,
        linuszeng@tencent.com, yihuilu@tencent.com, mhocko@suse.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        ebiederm@xmission.com, tglx@linutronix.de
Subject: [RFC v1 0/4] Two alternatives for mm async teardown
Date:   Thu, 11 Nov 2021 10:50:03 +0100
Message-Id: <20211111095008.264412-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cso5TOn-YzL3IuwdDtEVWK4uf--7NkJ7
X-Proofpoint-ORIG-GUID: XwhSuJ8eJFcsOzNvyPOT5JeaUisYPj3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxlogscore=672 phishscore=0 impostorscore=0
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series proposes two possible ways for enabling asynchronous mm
teardown.

The first approach, in patch 1, is simply to provide an arch hook in
exit_mm. This has no functional change for archs that don't explicitly
use the hook, and leaves the hard part to arch code (including
accounting, if any).

The second approach, in patches 2 to 4, adds a new syscall to allow an
mm to be asynchronously torn down in the context of another process
(similarly to how process_mrelease works). It also adds an OOM notifier
to prevent the OOM killer from killing processes while the teardown is
in progress.


Claudio Imbrenda (4):
  exit: add arch mmput hook in exit_mm
  kernel/fork.c: implement new process_mmput_async syscall
  mm: wire up the process_mmput_async syscall
  kernel/fork.c: process_mmput_async: stop OOM while freeing memory

 arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |   2 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   2 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
 arch/s390/kernel/syscalls/syscall.tbl       |   2 +
 arch/sh/kernel/syscalls/syscall.tbl         |   2 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
 include/asm-generic/mmu_context.h           |   4 +
 include/linux/mm_types.h                    |   1 +
 include/linux/syscalls.h                    |   1 +
 include/uapi/asm-generic/unistd.h           |   5 +-
 kernel/exit.c                               |   2 +-
 kernel/fork.c                               | 131 +++++++++++++++++++-
 kernel/sys_ni.c                             |   1 +
 25 files changed, 173 insertions(+), 5 deletions(-)

-- 
2.31.1

