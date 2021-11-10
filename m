Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270D144BF08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKJKuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhKJKuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:50:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976A1C061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:47:36 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c4so2327032pfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=db8Lxv//rDZhbTGsiXr1X6OXBhWQflsGL19DVygSefs=;
        b=OZnG6tVimQAZ1QfXdgZAr5LGnO2SfB0K8lIkgreVW46F/CY1fILLXIDT0m7jcDR7KJ
         EMf1tEdj1ozAh3Nb4yiV8hbXtRkVVFr+ssNUB8RCWF/+Pn2mQxqYqk1YmxXd7KJLR4wy
         4//k0z6eYg3d6lvZu1B6XPs5LegJeyozQoiJvhPduvP1tdt83cIEAjzh7CHSsAibvDT0
         wEd2QzxMNg2AuCOV15mK9pcKYe2TLI5vcO1nn+fB+JiSDTzguUNFuNrMexavxQJrDH1F
         21qM82+XjGicFYVj2ksAMIDGSlVIp1JSBT/4fQdinIt8FyIFdr/gwLD1RA75PMacMRml
         NLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=db8Lxv//rDZhbTGsiXr1X6OXBhWQflsGL19DVygSefs=;
        b=4XMgXN4wYu4g8dhmki9ydJUhP9KKtQZBSsUrYyzfIW9P6fjUzkAWX6QofzRFV+NTtg
         cTBX8YAmfIRXWx4nQ6ALajRR71k+wKhKujFAkqArYQbAak69RVE+KdDy8XGLqUUIyvQ/
         NpLFd7VCOxUNe90/ilv1ym0t5TZXQ1IjzGNvXx+SEhWJL4o/WR5QfKX98+JJ/mZD8uQ0
         9xnStuCyzCpF/0+E70owEk1MBX0fyVB5BTIi8iQvX2DnTbnKGUuFlsgz/ZjCOlEgSOGU
         MBYdGJ4/nR67CvcoWpIeQilrUzeyl5ZuGBGGc9Jr8ALuoXtqNf1vyeO6lFjLuQHE3Rck
         0X8w==
X-Gm-Message-State: AOAM5314oVpMsI6xzCUEW5AUFkDm3nkBBmCQHfEs/8EUcyR4tQ+WgMRl
        n9Gm1y7kVkK0tjeVHmswN65lJofFoeE1Cw==
X-Google-Smtp-Source: ABdhPJwUAxi9GHqwvVWvJo7nt+sFYWJ/w7nQLH+SXsPx4XftYLwzRnTouLt/ePMipUFNtBtlAGmykA==
X-Received: by 2002:a05:6a00:cd0:b0:49f:b198:97a5 with SMTP id b16-20020a056a000cd000b0049fb19897a5mr15272114pfv.80.1636541255663;
        Wed, 10 Nov 2021 02:47:35 -0800 (PST)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id mm22sm5392720pjb.28.2021.11.10.02.47.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:47:34 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: mm: unnecessary COW phenomenon
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YWe7x5DK0sMDskYE@t490s>
Date:   Wed, 10 Nov 2021 02:47:33 -0800
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0480D692-D9B2-429A-9A88-9BBA1331AC3A@gmail.com>
References: <FFA0057D-1A17-4DF4-9550-A8CDEE9E0CE0@gmail.com>
 <YWe7x5DK0sMDskYE@t490s>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 13, 2021, at 10:10 PM, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Wed, Oct 13, 2021 at 03:42:08PM -0700, Nadav Amit wrote:
>> Andrea, Peter, others,
>=20
> Hi, Nadav,
>=20
>>=20
>> I encountered many unnecessary COW operations on my development =
kernel
>> (based on Linux 5.13), which I did not see a report about and I am =
not
>> sure how to solve. An advice would be appreciated.
>>=20
>> Commit 09854ba94c6aa ("mm: do_wp_page() simplification=E2=80=9D) =
prevents the reuse of
>> a page on write-protect fault if page_count(page) !=3D 1. In that =
case,
>> wp_page_reuse() is not used and instead the page is COW'd by =
wp_page_copy
>> (). wp_page_copy() is obviously much more expensive, not only because =
of the
>> copying, but also because it requires a TLB flush and potentially a =
TLB
>> shootodwn.
>>=20
>> The scenario I encountered happens when I use userfaultfd, but =
presumably it
>> might happen regardless of userfaultfd (perhaps swap device with
>> SWP_SYNCHRONOUS_IO). It involves two page faults: one that maps a new
>> anonymous page as read-only and a second write-protect fault that =
happens
>> shortly after on the same page. In this case the page count is almost =
always
>> elevated and therefore a COW is needed.
>>=20

[ snip ]

>>=20
>> It turns out that the elevated page count is due to the caching of =
the page in
>> the local LRU cache (by lru_cache_add() which is called by
>> lru_cache_add_inactive_or_unevictable() in the case userfaultfd). =
Since the
>> first fault happened shortly before the second write-protect fault, =
the LRU
>> cache was still not drained, so the page count was not decreased and =
a COW is
>> needed.
>>=20
>> Calling lru_add_drain() during this flow resolves the issue most of =
the time.
>> Obviously, it needs to be called on the core that allocated (i.e., =
faulted
>> in) the page initially to work. It is possible to do it conditionally =
only if
>> the page-count is greater than 1.
>=20
> I agree with your analysis.  I didn't even notice the lru_cache_add() =
can cause
> it very likely to trigger the COW in your uffd use case (and also for =
swap),
> but that's indeed something could happen with the current page reuse =
logic in
> do_wp_page(), afaiu.

Just an update for the record based on an offline correspondence with =
Andrea
and Peter, who were very helpful (thanks!)

I could not come up with a non-hacky solution just for this problem. =
While it
is possible to drain the LRU conditionally, it is admittedly a hack with =
some
downsides.

The aforementioned issue - unnecessary TLB flush (or even shootdown) on =
COW
operations - is not limited to userfaultfd and not even to
SWP_SYNCHRONOUS_IO. It seems that whenever the swap is set on very
low-latency device (e.g., pmem, zram), the unnecessary COW might happen =
and
impact performance negatively.

I created a small test to verify the impact of the phenomenon (the test =
code
is below). The swap is set on an emulated pmem device and then run with:

	./forceswap 2 100000 1

The benchmark runs 100k rounds in which a page is accessed first for =
read,
then for write, and then the page is paged out using MADV_PAGEOUT. The =
two
accesses cause a page-fault. The test only measures the time of the =
second
access, which should include the wp page-fault. I also measured the =
delta
in =E2=80=9Cnr_tlb_remote_flush" from /proc/vmstat.

The results are:

				cycles/op	nr_tlb_remote_flush
-------------------------------------------------------------------
v5.8		bcf876870b95	1606		300000
mainline	cb690f5238d7	10534		399935


As shown, the write-protect fault in mainline takes ~6.5x, which
is explained by the COW operation that is exhibited in the extra
TLB shootdown (nr_tlb_remote_flush). On bare-metal this overhead
should be lower, yet if the number of threads is higher the
overhead would increase.

I tried also to collect the number of IOs, but for some reason
they do not show on /sys/dev/block/X/stat for pmem.

[ Some config details:
  KVM VM running on Haswell.
  host: max-freq; kvm_intel's ple_gap=3D0; 2MB pages.
  VM: mitigations=3Doff idle=3Dpoll. Kernel compiled with
  CONFIG_DEBUG_TLBFLUSH=3Dy. CONFIG_BLK_DEV_PMEM=3Dy	]

-- >8 --

#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>
#include <errno.h>
#include <sys/types.h>
#include <unistd.h>

#define PAGE_SIZE		(4096)
#define MAX_THREADS		(50)

volatile int stop =3D 0;
unsigned long nops;

void* thread_start(void *arg)
{
	while (!stop) {
		asm volatile ("pause" ::: "memory");
	}

	return (void*)NULL;
}

static inline uint64_t rdtscp()
{
	uint64_t rax, rdx, aux;

	asm volatile ("rdtscp\n" : "=3Da" (rax), "=3Dd" (rdx), "=3Dc" =
(aux) : : );
	return (rdx << 32) + rax;
}

int main(int argc, char *argv[])
{
	int r, nthreads, npages, j;
	unsigned long i;
	pthread_attr_t attr;
	pthread_t thread_ids[MAX_THREADS];
	void *res;
	volatile char *p, c;
	uint64_t time =3D 0;

	if (argc < 4) {
		fprintf(stderr, "usage: %s [nthreads] [nops] =
[npages]\n", argv[0]);
		exit(-1);
	}

	r =3D pthread_attr_init(&attr);
	if (r !=3D 0) {
		fprintf(stderr, "error setting attributes %d\n", r);
		exit(-1);
	}

	nthreads =3D atoi(argv[1]);
	nops =3D strtoull(argv[2], NULL, 0);
	npages =3D atoi(argv[3]);

	for (i =3D 0; i < nthreads - 1; i++) {
		r =3D pthread_create(&thread_ids[i], &attr, =
&thread_start, NULL);
		if (r !=3D 0) {
			fprintf(stderr, "error creating thread %d\n", =
r);
			exit(-1);
		}
	}

	p =3D (volatile char*)mmap(0, PAGE_SIZE * npages, =
PROT_READ|PROT_WRITE,
				 MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);

	if (p =3D=3D MAP_FAILED) {
		perror("mmap");
		exit(-1);
	}

	for (i =3D 0; i < nops; i++) {
		if (madvise((void *)p, PAGE_SIZE * npages, =
MADV_PAGEOUT)) {
			perror("madvise");
			exit(-1);
		}

		for (j =3D 0; j < npages; j++) {
			c =3D p[j * PAGE_SIZE];
			c++;
			time -=3D rdtscp();
			p[j * PAGE_SIZE] =3D c;
			time +=3D rdtscp();
		}
	}
	stop =3D 1;
	for (i =3D 0; i < nthreads - 1; i++) {
		r =3D pthread_join(thread_ids[i], &res);
		if (r !=3D 0) {
			fprintf(stderr, "error join\n");
			exit(-1);
		}
	}
	printf("time: %ld\n", time/nops);
	return 0;
}

