Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481AE31A1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhBLPgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:36:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230197AbhBLPfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:35:21 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11CFXxvf001536;
        Fri, 12 Feb 2021 10:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Jbzn9PTKpWYF/8TPV/kOGW0XZ4Y2LoKOXT+5rADtviM=;
 b=HJ3PSRo1YoBrxsCj/045G9nAk4Jtp/vcJ6/0Emm/70ersrCziI8/yVGToncuai1ROqwZ
 ojq+oPnB8sSpIn67Dx1doUlRepqJnXt7MClll6GLp4Ze/zBQjnpGsIe964Zv2Ff3+Tar
 OxeJ1RGo+MIvxIW34yy6MfdOLsdNumP+8V+rXiTudtr6UnZbAZZkG/93YK4lQ7upAkBz
 y8UFThIX77o1LwjE3mK9AG20lcZNOSeRkOQrA9WLEAW33vmX1c4Dmm70D+qyOzBdI57I
 yqo9VOz8itEwPpcdEeggCVtmSz7BZ0yHIB9v8Tq0jBHVAlQYDIgUE/OAqmKDEZvVG00U YA== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36nv9vr7sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 10:34:28 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11CFI1Db010169;
        Fri, 12 Feb 2021 15:33:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 36hjr8bjek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 15:33:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11CFXNmK36634944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Feb 2021 15:33:23 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E17CEA4051;
        Fri, 12 Feb 2021 15:33:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF69AA4040;
        Fri, 12 Feb 2021 15:33:32 +0000 (GMT)
Received: from [9.199.62.96] (unknown [9.199.62.96])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Feb 2021 15:33:32 +0000 (GMT)
Subject: Re: Memory keys and io_uring.
To:     Jens Axboe <axboe@kernel.dk>, Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <877dndzs8c.fsf@linux.ibm.com>
 <b6ed27dc-7dec-aab5-acfc-073a30e49422@kernel.dk>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <4ed6cbf6-b850-dac5-88c6-03e58dfc6631@linux.ibm.com>
Date:   Fri, 12 Feb 2021 21:03:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <b6ed27dc-7dec-aab5-acfc-073a30e49422@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-12_05:2021-02-12,2021-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 8:45 PM, Jens Axboe wrote:
> On 2/11/21 11:59 PM, Aneesh Kumar K.V wrote:
>>
>> Hi,
>>
>> I am trying to estabilish the behaviour we should expect when passing a
>> buffer with memory keys attached to io_uring syscalls. As show  in the
>> blow test
>>
>> /*
>>   * gcc -Wall -O2 -D_GNU_SOURCE -o pkey_uring pkey_uring.c -luring
>>   */
>> #include <stdio.h>
>> #include <fcntl.h>
>> #include <string.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>> #include <sys/mman.h>
>> #include "liburing.h"
>>
>> #define PAGE_SIZE  (64 << 10)
>>
>> int main(int argc, char *argv[])
>> {
>> 	int fd, ret, pkey;
>> 	struct io_uring ring;
>> 	struct io_uring_sqe *sqe;
>> 	struct io_uring_cqe *cqe;
>> 	struct iovec iovec;
>> 	void *buf;
>>
>> 	if (argc < 2) {
>> 		printf("%s: file\n", argv[0]);
>> 		return 1;
>> 	}
>>
>> 	ret = io_uring_queue_init(1, &ring, IORING_SETUP_SQPOLL);
>> 	if (ret < 0) {
>> 		fprintf(stderr, "queue_init: %s\n", strerror(-ret));
>> 		return 1;
>> 	}
>>
>> 	fd = open(argv[1], O_RDONLY | O_DIRECT);
>> 	if (fd < 0) {
>> 		perror("open");
>> 		return 1;
>> 	}
>>
>> 	if (posix_memalign(&buf, PAGE_SIZE, PAGE_SIZE))
>> 		return 1;
>> 	iovec.iov_base = buf;
>> 	iovec.iov_len = PAGE_SIZE;
>>
>> 	//mprotect(buf, PAGE_SIZE, PROT_NONE);
>> 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
>> 	pkey_mprotect(buf, PAGE_SIZE, PROT_READ | PROT_WRITE, pkey);
>>
>>
>> 	sqe = io_uring_get_sqe(&ring);
>> 	if (!sqe) {
>> 		perror("io_uring_get_sqe");
>> 		return 1;
>> 	}
>> 	io_uring_prep_readv(sqe, fd, &iovec, 1, 0);
>>
>> 	ret = io_uring_submit(&ring);
>> 	if (ret != 1) {
>> 		fprintf(stderr, "io_uring_submit: %s\n", strerror(-ret));
>> 		return 1;
>> 	}
>>
>> 	ret = io_uring_wait_cqe(&ring, &cqe);
>>
>> 	if (cqe->res < 0)
>> 		fprintf(stderr, "iouring submit failed %s\n", strerror(-cqe->res));
>> 	else
>> 		fprintf(stderr, "iouring submit success\n");
>>
>> 	io_uring_cqe_seen(&ring, cqe);
>>
>> 	/*
>> 	 * let's access this via a read syscall
>> 	 */
>> 	ret = read(fd, buf, PAGE_SIZE);
>> 	if (ret < 0)
>> 		fprintf(stderr, "read failed : %s\n", strerror(errno));
>>
>> 	close(fd);
>> 	io_uring_queue_exit(&ring);
>>
>> 	return 0;
>> }
>>
>> A read syscall do fail with EFAULT. But we allow read via io_uring
>> syscalls. Is that ok? Considering memory keys are thread-specific we
>> could debate that kernel thread can be considered to be the one that got all access
>> allowed via keys or we could update that access is denied via kernel
>> thread for any key value other than default key (key 0). Other option
>> is to inherit the memory key restrictions when doing
>> io_uring_submit() and use the same when accessing the userspace from
>> kernel thread.
>>
>> Any thoughts here with respect to what should be behaviour?
> 
> It this a powerpc thing? I get -EFAULT on x86 for both reads, io_uring
> and regular syscall. That includes SQPOLL, not using SQPOLL, or
> explicitly setting IOSQE_ASYNC on the sqe.
> 

Interesting, I didn't check x86 because i don't have hardware that 
supports memory keys. I am trying to make ppc64 behavior compatible with 
other archs here.

IIUC, in your test io_wqe/sqe kernel thread did hit access fault when 
touching the buffer on x86? That is different from what Dave explained 
earlier.

With the patch 8c511eff1827 ("powerpc/kuap: Allow kernel thread to 
access userspace after kthread_use_mm") I now have key 0 access  allowed 
but all other keys denied with ppc64. I was planning to change that to 
allow all key access based on reply from Dave.  I would be curious to 
understand what made x86 deny the access and how did kthread inherit the 
key details.



-aneesh

