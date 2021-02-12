Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154C731A159
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhBLPQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 10:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhBLPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:15:52 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8FAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:15:12 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id e24so9629942ioc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g5Qd6pYvAFJWK+gEpErCm9aESy14N4Z1oHpZ+sVfQOc=;
        b=ZcR5ap78jvA6h4aOH14zmB9wDCk19/qv8W8niAZWhnr5nTtMlT5d34/JWNHzD3v1AN
         tSzLbKUDQgvxlx/6Zfo2NLgykz9WakzKRsH0XsZdVbetee3kCrE5FcWerGgykKAYs4V1
         gsm7PFrHz00eeKr4SfYWOTy21mM6LE7gmcI/nKHfQ+R7+1VcLAMtuim2BV+nV0NMexb7
         pyy8tRcbD6T5kfxRwbKC86XdXOO3v0HVhyxihLdEbUof0SdGglfQoccXTc5tCeeTYk40
         43gbCcFB5TXZSk6eyEvmhDtLTAlDAXw8Txg1Zwsn5atVic24ktAGhTPNldgKS2PDhBES
         bCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g5Qd6pYvAFJWK+gEpErCm9aESy14N4Z1oHpZ+sVfQOc=;
        b=oj0AOVJ11kW0lN5SfZVMx3EcUiJWsvqi3IkJOJCGX8GhGYd3I6OlX5pR4aMMM2NRML
         tXBeDg6ammpxWo15eHQr1woK106qubTJE25KpMQ16AHKMiV02UnafITIQJoC3SnzE2+h
         QpjY+TFHrfM5A7No5yOcEHxV3FMPCUhIeZlw9BUCKzoUrwSFRaTUFg5H1qjA2Pvl/tng
         klDr8qhk9EB55HXfBQ2YcYDsFaL8r4wxPm9GKlpEbgaG26NMg5RMiQRiaIcGDWllBqH1
         YLoyeNwBM9zYGp3FdaI4Em5VHEkeBibsnXTxcLSvT+hZEjacQriHZKnk4seQc3HxGJ55
         N3JQ==
X-Gm-Message-State: AOAM531tbfYKhBsql9xxcTamxB/x84lvrPyJbWR+7oIDEqwnA8iVwbcX
        QUm4cdHn1i1U59hQLuugrLQq2ll64dAhnOjS
X-Google-Smtp-Source: ABdhPJwvDDD3TWSoAEVShUKZDLa92YwusU8s2w4HHwA6v00UG/7bVDm4Y184knqYvr/k3y56NDnCJA==
X-Received: by 2002:a05:6638:ccc:: with SMTP id e12mr3175973jak.6.1613142911672;
        Fri, 12 Feb 2021 07:15:11 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i19sm4256080ioh.38.2021.02.12.07.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 07:15:11 -0800 (PST)
Subject: Re: Memory keys and io_uring.
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <877dndzs8c.fsf@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b6ed27dc-7dec-aab5-acfc-073a30e49422@kernel.dk>
Date:   Fri, 12 Feb 2021 08:15:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <877dndzs8c.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 11:59 PM, Aneesh Kumar K.V wrote:
> 
> Hi,
> 
> I am trying to estabilish the behaviour we should expect when passing a
> buffer with memory keys attached to io_uring syscalls. As show  in the
> blow test
> 
> /*
>  * gcc -Wall -O2 -D_GNU_SOURCE -o pkey_uring pkey_uring.c -luring
>  */
> #include <stdio.h>
> #include <fcntl.h>
> #include <string.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/mman.h>
> #include "liburing.h"
> 
> #define PAGE_SIZE  (64 << 10)
> 
> int main(int argc, char *argv[])
> {
> 	int fd, ret, pkey;
> 	struct io_uring ring;
> 	struct io_uring_sqe *sqe;
> 	struct io_uring_cqe *cqe;
> 	struct iovec iovec;
> 	void *buf;
> 
> 	if (argc < 2) {
> 		printf("%s: file\n", argv[0]);
> 		return 1;
> 	}
> 
> 	ret = io_uring_queue_init(1, &ring, IORING_SETUP_SQPOLL);
> 	if (ret < 0) {
> 		fprintf(stderr, "queue_init: %s\n", strerror(-ret));
> 		return 1;
> 	}
> 
> 	fd = open(argv[1], O_RDONLY | O_DIRECT);
> 	if (fd < 0) {
> 		perror("open");
> 		return 1;
> 	}
> 
> 	if (posix_memalign(&buf, PAGE_SIZE, PAGE_SIZE))
> 		return 1;
> 	iovec.iov_base = buf;
> 	iovec.iov_len = PAGE_SIZE;
> 
> 	//mprotect(buf, PAGE_SIZE, PROT_NONE);
> 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
> 	pkey_mprotect(buf, PAGE_SIZE, PROT_READ | PROT_WRITE, pkey);
> 
> 
> 	sqe = io_uring_get_sqe(&ring);
> 	if (!sqe) {
> 		perror("io_uring_get_sqe");
> 		return 1;
> 	}
> 	io_uring_prep_readv(sqe, fd, &iovec, 1, 0);
> 
> 	ret = io_uring_submit(&ring);
> 	if (ret != 1) {
> 		fprintf(stderr, "io_uring_submit: %s\n", strerror(-ret));
> 		return 1;
> 	}
> 
> 	ret = io_uring_wait_cqe(&ring, &cqe);
> 
> 	if (cqe->res < 0)
> 		fprintf(stderr, "iouring submit failed %s\n", strerror(-cqe->res));
> 	else
> 		fprintf(stderr, "iouring submit success\n");
> 
> 	io_uring_cqe_seen(&ring, cqe);
> 
> 	/*
> 	 * let's access this via a read syscall
> 	 */
> 	ret = read(fd, buf, PAGE_SIZE);
> 	if (ret < 0)
> 		fprintf(stderr, "read failed : %s\n", strerror(errno));
> 
> 	close(fd);
> 	io_uring_queue_exit(&ring);
> 
> 	return 0;
> }
> 
> A read syscall do fail with EFAULT. But we allow read via io_uring
> syscalls. Is that ok? Considering memory keys are thread-specific we
> could debate that kernel thread can be considered to be the one that got all access
> allowed via keys or we could update that access is denied via kernel
> thread for any key value other than default key (key 0). Other option
> is to inherit the memory key restrictions when doing
> io_uring_submit() and use the same when accessing the userspace from
> kernel thread. 
> 
> Any thoughts here with respect to what should be behaviour?

It this a powerpc thing? I get -EFAULT on x86 for both reads, io_uring
and regular syscall. That includes SQPOLL, not using SQPOLL, or
explicitly setting IOSQE_ASYNC on the sqe.

-- 
Jens Axboe

