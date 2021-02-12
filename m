Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3538C319A11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 08:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBLHAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 02:00:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36810 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhBLHA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 02:00:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11C6eoiS150341;
        Fri, 12 Feb 2021 01:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=+TP7sP/ni7v6Ho3/L0taKftX1AIspyrtwn+pdk1k/DI=;
 b=M6J14FsgNtyYzijBEOd+vc2ijQrVPW/2C4W6yqhH4tUQXtpA0SMgsEjrQ6CC+YG6NAA4
 GyKHDQJf7TJdyaNptyO8KZWZMTtWPjkP2r7z90lcn95EuDJZjA+qF/FcctUdT9UbOgJR
 +MKmpOvspFIb+3NVieFZ6W3GcDN5qBXypb2bSHxz+1lZNbxjjvQOs3PIqnjfNBjHhL+i
 vz1hQy4grCC3dBfclKen1QDvkXtIKDGTvXPZVvLIq+BWk/7qvmXMiy9LLU57fPxzvojN
 rCOfWb3mt9HjAt4hkzkU3OTaEHjE+B0ap5GULGmXgPpRw0Se8yd3AJs3tIbn1eB8rA5g MA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nma80j1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 01:59:38 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11C6o8L5031418;
        Fri, 12 Feb 2021 06:59:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 36hjra3aca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 06:59:37 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11C6xaLf30802198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 06:59:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2458AE063;
        Fri, 12 Feb 2021 06:59:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E49ECAE05F;
        Fri, 12 Feb 2021 06:59:34 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.62.96])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 06:59:34 +0000 (GMT)
X-Mailer: emacs 27.1 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>, Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Memory keys and io_uring.
Date:   Fri, 12 Feb 2021 12:29:31 +0530
Message-ID: <877dndzs8c.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_01:2021-02-12,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0 phishscore=0
 mlxlogscore=869 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am trying to estabilish the behaviour we should expect when passing a
buffer with memory keys attached to io_uring syscalls. As show  in the
blow test

/*
 * gcc -Wall -O2 -D_GNU_SOURCE -o pkey_uring pkey_uring.c -luring
 */
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include "liburing.h"

#define PAGE_SIZE  (64 << 10)

int main(int argc, char *argv[])
{
	int fd, ret, pkey;
	struct io_uring ring;
	struct io_uring_sqe *sqe;
	struct io_uring_cqe *cqe;
	struct iovec iovec;
	void *buf;

	if (argc < 2) {
		printf("%s: file\n", argv[0]);
		return 1;
	}

	ret = io_uring_queue_init(1, &ring, IORING_SETUP_SQPOLL);
	if (ret < 0) {
		fprintf(stderr, "queue_init: %s\n", strerror(-ret));
		return 1;
	}

	fd = open(argv[1], O_RDONLY | O_DIRECT);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	if (posix_memalign(&buf, PAGE_SIZE, PAGE_SIZE))
		return 1;
	iovec.iov_base = buf;
	iovec.iov_len = PAGE_SIZE;

	//mprotect(buf, PAGE_SIZE, PROT_NONE);
	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
	pkey_mprotect(buf, PAGE_SIZE, PROT_READ | PROT_WRITE, pkey);


	sqe = io_uring_get_sqe(&ring);
	if (!sqe) {
		perror("io_uring_get_sqe");
		return 1;
	}
	io_uring_prep_readv(sqe, fd, &iovec, 1, 0);

	ret = io_uring_submit(&ring);
	if (ret != 1) {
		fprintf(stderr, "io_uring_submit: %s\n", strerror(-ret));
		return 1;
	}

	ret = io_uring_wait_cqe(&ring, &cqe);

	if (cqe->res < 0)
		fprintf(stderr, "iouring submit failed %s\n", strerror(-cqe->res));
	else
		fprintf(stderr, "iouring submit success\n");

	io_uring_cqe_seen(&ring, cqe);

	/*
	 * let's access this via a read syscall
	 */
	ret = read(fd, buf, PAGE_SIZE);
	if (ret < 0)
		fprintf(stderr, "read failed : %s\n", strerror(errno));

	close(fd);
	io_uring_queue_exit(&ring);

	return 0;
}

A read syscall do fail with EFAULT. But we allow read via io_uring
syscalls. Is that ok? Considering memory keys are thread-specific we
could debate that kernel thread can be considered to be the one that got all access
allowed via keys or we could update that access is denied via kernel
thread for any key value other than default key (key 0). Other option
is to inherit the memory key restrictions when doing
io_uring_submit() and use the same when accessing the userspace from
kernel thread. 

Any thoughts here with respect to what should be behaviour?

-aneesh
