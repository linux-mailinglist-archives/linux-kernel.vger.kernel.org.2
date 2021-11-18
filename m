Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED2455838
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245244AbhKRJu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhKRJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:50:54 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3BC061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:47:54 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso5154748pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgIWauXu0K739ABYOoywpCK7f0d5EcdieFnL2eh++0k=;
        b=6ubepoKH/Uq6R7CtFzzKKnu7PPwJorPegRYZn6AHxnL2wuCMajJN1x/5YOVOZPX8V8
         FoBYm2ndZF3BPKH2roF6VmrIBBZK3DaJOk6Ir9z1BVASFHaqhH2nonkpkp+7W1GMJLSI
         kSksUtJJnhlkxcLN3kfOVBitGFGFEKJeQqr41SASK/dvMnYOkO/4y/ZUVuIqlA+Ca7J0
         aOzl6vPPOuCxiIXxGMgulmKgCr/KT4jGK3dYsnqAjKIY3vh6dljt0NYLgMO13WHQMOVG
         jd8YgvIXVTfqg3ur6N0UwGud7NGyR/vrm2gSjglk64wAAB6aaw7X4JuNnu3GQ4z61SNH
         B7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgIWauXu0K739ABYOoywpCK7f0d5EcdieFnL2eh++0k=;
        b=rikzem4BVriZFr+zjSIC77AjYr0OaVTWYOv25oCsaQ7F4AHhTYZFTEqAR3XDgeY818
         IlfjC2pMLOT+YEkUphtymnnx/jkDIiTmZrUHscpsRJs0zP5kCrfzHPzHB0W3ZuTgXYbI
         g8rHxmGD/xrWWzVPWZS8x/B8tvHgud4GuawssZMfNRAZDMJ97OE1KycQOhAUe/2vqgWH
         VirNf8m4vEptgVox01bGIAS9F2RHIWXbhCtrqwoPfLNyeUNdptTT6BfHVwBYHz4EFUqt
         tlogOJ1rJh1nI58qwKN/t4AhPw/GOqzsH/yEyqtsy5eCXQVTo0eyHqa8EbBf1ZykQzS5
         S24Q==
X-Gm-Message-State: AOAM532/4gNqNihHex42U5gAid9bHQ3GLYD3gCaHAe1bj/XpdzzmKPXN
        z5E96D4WA5VIeDA+eVFt74YBfQ==
X-Google-Smtp-Source: ABdhPJzrUqZ4iic6BC20cy3GqgbjIawo/ele0Zpi4hblgRg1ogkxnrCbzrW3IoGgTbHTGxM9OKX60A==
X-Received: by 2002:a17:90b:1650:: with SMTP id il16mr8723214pjb.242.1637228873546;
        Thu, 18 Nov 2021 01:47:53 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mi18sm2361322pjb.13.2021.11.18.01.47.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Nov 2021 01:47:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        zhengqi.arch@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] locking/rwsem: Optimize down_read_trylock() under highly contended case
Date:   Thu, 18 Nov 2021 17:44:55 +0800
Message-Id: <20211118094455.9068-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found that a process with 10 thousnads threads has been encountered
a regression problem from Linux-v4.14 to Linux-v5.4. It is a kind of
workload which will concurrently allocate lots of memory in different
threads sometimes. In this case, we will see the down_read_trylock()
with a high hotspot. Therefore, we suppose that rwsem has a regression
at least since Linux-v5.4. In order to easily debug this problem, we
write a simply benchmark to create the similar situation lile the
following.

  ```c++
  #include <sys/mman.h>
  #include <sys/time.h>
  #include <sys/resource.h>
  #include <sched.h>

  #include <cstdio>
  #include <cassert>
  #include <thread>
  #include <vector>
  #include <chrono>

  volatile int mutex;

  void trigger(int cpu, char* ptr, std::size_t sz)
  {
  	cpu_set_t set;
  	CPU_ZERO(&set);
  	CPU_SET(cpu, &set);
  	assert(pthread_setaffinity_np(pthread_self(), sizeof(set), &set) == 0);

  	while (mutex);

  	for (std::size_t i = 0; i < sz; i += 4096) {
  		*ptr = '\0';
  		ptr += 4096;
  	}
  }

  int main(int argc, char* argv[])
  {
  	std::size_t sz = 100;

  	if (argc > 1)
  		sz = atoi(argv[1]);

  	auto nproc = std::thread::hardware_concurrency();
  	std::vector<std::thread> thr;
  	sz <<= 30;
  	auto* ptr = mmap(nullptr, sz, PROT_READ | PROT_WRITE, MAP_ANON |
			 MAP_PRIVATE, -1, 0);
  	assert(ptr != MAP_FAILED);
  	char* cptr = static_cast<char*>(ptr);
  	auto run = sz / nproc;
  	run = (run >> 12) << 12;

  	mutex = 1;

  	for (auto i = 0U; i < nproc; ++i) {
  		thr.emplace_back(std::thread([i, cptr, run]() { trigger(i, cptr, run); }));
  		cptr += run;
  	}

  	rusage usage_start;
  	getrusage(RUSAGE_SELF, &usage_start);
  	auto start = std::chrono::system_clock::now();

  	mutex = 0;

  	for (auto& t : thr)
  		t.join();

  	rusage usage_end;
  	getrusage(RUSAGE_SELF, &usage_end);
  	auto end = std::chrono::system_clock::now();
  	timeval utime;
  	timeval stime;
  	timersub(&usage_end.ru_utime, &usage_start.ru_utime, &utime);
  	timersub(&usage_end.ru_stime, &usage_start.ru_stime, &stime);
  	printf("usr: %ld.%06ld\n", utime.tv_sec, utime.tv_usec);
  	printf("sys: %ld.%06ld\n", stime.tv_sec, stime.tv_usec);
  	printf("real: %lu\n",
  	       std::chrono::duration_cast<std::chrono::milliseconds>(end -
  	       start).count());

  	return 0;
  }
  ```

The functionality of above program is simply which creates `nproc`
threads and each of them are trying to touch memory (trigger page
fault) on different CPU. Then we will see the similar profile by
`perf top`.

  25.55%  [kernel]                  [k] down_read_trylock
  14.78%  [kernel]                  [k] handle_mm_fault
  13.45%  [kernel]                  [k] up_read
   8.61%  [kernel]                  [k] clear_page_erms
   3.89%  [kernel]                  [k] __do_page_fault

The highest hot instruction, which accounts for about 92%, in
down_read_trylock() is cmpxchg like the following.

  91.89 │      lock   cmpxchg %rdx,(%rdi)

Sice the problem is found by migrating from Linux-v4.14 to Linux-v5.4,
so we easily found that the commit ddb20d1d3aed ("locking/rwsem: Optimize
down_read_trylock()") caused the regression. The reason is that the
commit assumes the rwsem is not contended at all. But it is not always
true for mmap lock which could be contended with thousands threads.
So most threads almost need to run at least 2 times of "cmpxchg" to
acquire the lock. The overhead of atomic operation is higher than
non-atomic instructions, which caused the regression.

By using the above benchmark, the real executing time on a x86-64 system
before and after the patch were:

                  Before Patch  After Patch
   # of Threads      real          real     reduced by
   ------------     ------        ------    ----------
         1          65,373        65,206       ~0.0%
         4          15,467        15,378       ~0.5%
        40           6,214         5,528      ~11.0%

For the uncontended case, the new down_read_trylock() is the same as
before. For the contended cases, the new down_read_trylock() is faster
than before. The more contended, the more fast.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/locking/rwsem.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a43265..ef2b2a3f508c 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1249,17 +1249,14 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 
 	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
 
-	/*
-	 * Optimize for the case when the rwsem is not locked at all.
-	 */
-	tmp = RWSEM_UNLOCKED_VALUE;
-	do {
+	tmp = atomic_long_read(&sem->count);
+	while (!(tmp & RWSEM_READ_FAILED_MASK)) {
 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
-					tmp + RWSEM_READER_BIAS)) {
+						    tmp + RWSEM_READER_BIAS)) {
 			rwsem_set_reader_owned(sem);
 			return 1;
 		}
-	} while (!(tmp & RWSEM_READ_FAILED_MASK));
+	}
 	return 0;
 }
 
-- 
2.11.0

