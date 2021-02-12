Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290D531A1D9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhBLPi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhBLPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:38:40 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91105C061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:38:00 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id e24so9708820ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FmA1qHg5t4euXl5Xl6ULxBbcKoWMJgzgukOTpoQtTJM=;
        b=dA3Y/gNaXZtZcLKuCXzL8rgzUY/n/j4eb7nWICegND1r0LBD8Pmw6hxBaJY/xcRLxJ
         SSDtCHzRi3H6L7JjDDRuvlePwTgaIQgRBMInsURCtoD54WptnCbJKIfBIErGg24xCzFA
         3jOInCvcSOiJmw3Hy1YKpLkFPAgtAlppRYlNU+U0TFWO8B56PnT+DrAK6z6zQVLKby1a
         FAce+AIQLL+GjodP3No2vG5sl3/4/XSkjnSWVGBJbiNJLZ0H7QIXTSVg9NTW23QUcrpG
         bLfqRFZTMFcEeES8qqt8tW79rFnoSc3PRHiJy/0C9rx4lnZHjmJGQ71eW3rN0OB3L4IW
         rTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FmA1qHg5t4euXl5Xl6ULxBbcKoWMJgzgukOTpoQtTJM=;
        b=HhfsdyCjuj+7rT79coYnLs+EOq8i7pGVoWVHpHZswMPwbkIpuGt4HxXouB4H07xcgU
         Ck315CRav4kmmK6xSq2v6lKQq+COgwpsl4xeK07xHjxYHLrYTsYljSBWdzLClQ/x5Qrr
         qecwD0sRSftx1dkONoAgbDnlxEaHEM2vBuPAduaG6MiSW5bCTr1xLP9kddIpekqIPc4F
         j9LCMtAyJnXYV9Wq4Wey1wKkR2b7LyE1uwF6VdyM1FHcEbQkRm/UnlYQh1MypjFZi6Iz
         OaTbK3dqFzJbHU2JnPc6WJib+lOWIqtebLXKoglf+lJC0BaHOxqTz8AnkxgcN4ebtWh+
         HJqA==
X-Gm-Message-State: AOAM530B+PsdEPd33eNRDL9rF5iKEGdkKD+7YgFAuflyX3KCtP9F7nD8
        Y3rSGglnCGbVF1HXbG7BDwZyDEOGRMV3eG3Y
X-Google-Smtp-Source: ABdhPJwGd+H2kqRqTqq7eiE8shrPVUQiasY2Km3sWlLOgdKrbQb1FiRdfCngCkj6PMyzfsWKhOHOaw==
X-Received: by 2002:a02:ccc2:: with SMTP id k2mr3153230jaq.112.1613144279059;
        Fri, 12 Feb 2021 07:37:59 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o7sm2829889ilj.67.2021.02.12.07.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 07:37:58 -0800 (PST)
Subject: Re: Memory keys and io_uring.
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <877dndzs8c.fsf@linux.ibm.com>
 <b6ed27dc-7dec-aab5-acfc-073a30e49422@kernel.dk>
 <4ed6cbf6-b850-dac5-88c6-03e58dfc6631@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0ec1943b-4004-66bd-5a8f-2daf86de3349@kernel.dk>
Date:   Fri, 12 Feb 2021 08:37:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4ed6cbf6-b850-dac5-88c6-03e58dfc6631@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/21 8:33 AM, Aneesh Kumar K.V wrote:
> On 2/12/21 8:45 PM, Jens Axboe wrote:
>> On 2/11/21 11:59 PM, Aneesh Kumar K.V wrote:
>>>
>>> Hi,
>>>
>>> I am trying to estabilish the behaviour we should expect when passing a
>>> buffer with memory keys attached to io_uring syscalls. As show  in the
>>> blow test
>>>
>>> /*
>>>   * gcc -Wall -O2 -D_GNU_SOURCE -o pkey_uring pkey_uring.c -luring
>>>   */
>>> #include <stdio.h>
>>> #include <fcntl.h>
>>> #include <string.h>
>>> #include <stdlib.h>
>>> #include <unistd.h>
>>> #include <sys/mman.h>
>>> #include "liburing.h"
>>>
>>> #define PAGE_SIZE  (64 << 10)
>>>
>>> int main(int argc, char *argv[])
>>> {
>>> 	int fd, ret, pkey;
>>> 	struct io_uring ring;
>>> 	struct io_uring_sqe *sqe;
>>> 	struct io_uring_cqe *cqe;
>>> 	struct iovec iovec;
>>> 	void *buf;
>>>
>>> 	if (argc < 2) {
>>> 		printf("%s: file\n", argv[0]);
>>> 		return 1;
>>> 	}
>>>
>>> 	ret = io_uring_queue_init(1, &ring, IORING_SETUP_SQPOLL);
>>> 	if (ret < 0) {
>>> 		fprintf(stderr, "queue_init: %s\n", strerror(-ret));
>>> 		return 1;
>>> 	}
>>>
>>> 	fd = open(argv[1], O_RDONLY | O_DIRECT);
>>> 	if (fd < 0) {
>>> 		perror("open");
>>> 		return 1;
>>> 	}
>>>
>>> 	if (posix_memalign(&buf, PAGE_SIZE, PAGE_SIZE))
>>> 		return 1;
>>> 	iovec.iov_base = buf;
>>> 	iovec.iov_len = PAGE_SIZE;
>>>
>>> 	//mprotect(buf, PAGE_SIZE, PROT_NONE);
>>> 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
>>> 	pkey_mprotect(buf, PAGE_SIZE, PROT_READ | PROT_WRITE, pkey);
>>>
>>>
>>> 	sqe = io_uring_get_sqe(&ring);
>>> 	if (!sqe) {
>>> 		perror("io_uring_get_sqe");
>>> 		return 1;
>>> 	}
>>> 	io_uring_prep_readv(sqe, fd, &iovec, 1, 0);
>>>
>>> 	ret = io_uring_submit(&ring);
>>> 	if (ret != 1) {
>>> 		fprintf(stderr, "io_uring_submit: %s\n", strerror(-ret));
>>> 		return 1;
>>> 	}
>>>
>>> 	ret = io_uring_wait_cqe(&ring, &cqe);
>>>
>>> 	if (cqe->res < 0)
>>> 		fprintf(stderr, "iouring submit failed %s\n", strerror(-cqe->res));
>>> 	else
>>> 		fprintf(stderr, "iouring submit success\n");
>>>
>>> 	io_uring_cqe_seen(&ring, cqe);
>>>
>>> 	/*
>>> 	 * let's access this via a read syscall
>>> 	 */
>>> 	ret = read(fd, buf, PAGE_SIZE);
>>> 	if (ret < 0)
>>> 		fprintf(stderr, "read failed : %s\n", strerror(errno));
>>>
>>> 	close(fd);
>>> 	io_uring_queue_exit(&ring);
>>>
>>> 	return 0;
>>> }
>>>
>>> A read syscall do fail with EFAULT. But we allow read via io_uring
>>> syscalls. Is that ok? Considering memory keys are thread-specific we
>>> could debate that kernel thread can be considered to be the one that got all access
>>> allowed via keys or we could update that access is denied via kernel
>>> thread for any key value other than default key (key 0). Other option
>>> is to inherit the memory key restrictions when doing
>>> io_uring_submit() and use the same when accessing the userspace from
>>> kernel thread.
>>>
>>> Any thoughts here with respect to what should be behaviour?
>>
>> It this a powerpc thing? I get -EFAULT on x86 for both reads, io_uring
>> and regular syscall. That includes SQPOLL, not using SQPOLL, or
>> explicitly setting IOSQE_ASYNC on the sqe.
>>
> 
> Interesting, I didn't check x86 because i don't have hardware that 
> supports memory keys. I am trying to make ppc64 behavior compatible with 
> other archs here.
> 
> IIUC, in your test io_wqe/sqe kernel thread did hit access fault when 
> touching the buffer on x86? That is different from what Dave explained 
> earlier.

Yes, all four methods (task inline, task_work, SQPOLL, io-wq offload)
return -EFAULT for me on x86.

> With the patch 8c511eff1827 ("powerpc/kuap: Allow kernel thread to 
> access userspace after kthread_use_mm") I now have key 0 access  allowed 
> but all other keys denied with ppc64. I was planning to change that to 
> allow all key access based on reply from Dave.  I would be curious to 
> understand what made x86 deny the access and how did kthread inherit the 
> key details.

I'm not very familiar with the memory protection for pkeys and how it's
done on various archs, so not going to be of much help there... But
io_uring assumes the right mm for any of these accesses, so if it's tied
to that, then it should work as it does on x86.

-- 
Jens Axboe

