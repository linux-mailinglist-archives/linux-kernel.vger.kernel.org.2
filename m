Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038933EE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCQKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCQKos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:44:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2625DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:44:48 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q6-20020a17090a4306b02900c42a012202so1100472pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=QspAW94trZprGCB1fixf21vQlfCFlRs4FPYE7jk2m+Q=;
        b=au1LkU25+cE4xEc1QYxw+rChmMwCu3PhGyEsX/Sv+lzn5c4GA/+CXIcwy7CfBmsb2u
         g43At1dmgA9Iesqa1t07W4RMsQ5cHbsr1BAHEhKWK90q8YkCNcL4h1ulo2LmyADA3wGo
         8MXRa6TFRyGNNadAve8uuLJzTaK0Hr54zAcE+G4smQM0CDsa2dbXrmo9L7JiJ+Ta3U+9
         sMUb1EEP4LmvpSyBpxvPLTZhh4lZKjFCKdhisFfnlFF7csmQEIXNuBpGZC7qQVffP8s/
         1NlUWYpp9U5oQKo9KCvveNGOoEhdBUU2xLpVZiifCRRjSAtDqty37yOOBbk7FYJ5t02i
         sSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=QspAW94trZprGCB1fixf21vQlfCFlRs4FPYE7jk2m+Q=;
        b=h5vwuuct5BuNBocoDpCGx0jSqYav9BthN1M7hqyu5G/tE0oHaUqsgnwedCC0xW2Yg1
         vrzvFN1PgDkeM3cKcabb7lZXIjUW3/FC+p/jfhddCjhLjEwf2/xArVDSWIcjreyMER01
         fgTGuDe4OcwkY+I3uXU5ZM99uMtEg+LYtR4iWNe/p5tq45N/+PvOvyBMWg3NYpqLNQgl
         WSwP/JUDTAdi+Q/NfBA6JDkgPugqDFWEU2ynAbAaqk6jm3DtoEeTu15e55mdYxMV+ZwN
         tOtAi7ALZvaQFLSyx4ygQRQsQ4dTtnlt8r0AmDTNY+5Lfzz437xOJYmzogqbxdxwLIax
         eg+Q==
X-Gm-Message-State: AOAM533HxBOkQNEdAw7EzjpCvMIrW844rlXK9O/y1rm0aFU6vUdkXk1d
        6hU/khqeW0lb907g+wq8Yx4g2TWGo48=
X-Google-Smtp-Source: ABdhPJzvjphxuko2KMq6oGvr48Yr1UWJ/A9mnABdlXJWrxnsuWUwTbgHhXiD+YRtg37oHJAPq8PGSw==
X-Received: by 2002:a17:90b:909:: with SMTP id bo9mr3904206pjb.107.1615977887240;
        Wed, 17 Mar 2021 03:44:47 -0700 (PDT)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id k17sm13281555pfa.68.2021.03.17.03.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:44:46 -0700 (PDT)
Date:   Wed, 17 Mar 2021 20:44:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] Increase page and bit waitqueue hash size
To:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anton Blanchard <anton@ozlabs.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210317075427.587806-1-npiggin@gmail.com>
        <89cb49c0-2736-dd4c-f401-4b88c22cc11f@rasmusvillemoes.dk>
In-Reply-To: <89cb49c0-2736-dd4c-f401-4b88c22cc11f@rasmusvillemoes.dk>
MIME-Version: 1.0
Message-Id: <1615977781.fijkhk7ep5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Rasmus Villemoes's message of March 17, 2021 8:12 pm:
> On 17/03/2021 08.54, Nicholas Piggin wrote:
>=20
>> +#if CONFIG_BASE_SMALL
>> +static const unsigned int page_wait_table_bits =3D 4;
>>  static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cachel=
ine_aligned;
>=20
>> =20
>> +	if (!CONFIG_BASE_SMALL) {
>> +		page_wait_table =3D alloc_large_system_hash("page waitqueue hash",
>> +							sizeof(wait_queue_head_t),
>> +							0,
>=20
> So, how does the compiler not scream at you for assigning to an array,
> even if it's inside an if (0)?
>=20

Argh, because I didn't test small. Sorry I had the BASE_SMALL setting in=20
another patch and thought it would be a good idea to mash them together.=20
In hindsight probably not even if it did build.

Thanks,
Nick

--
[PATCH v3] Increase page and bit waitqueue hash size

The page waitqueue hash is a bit small (256 entries) on very big systems. A
16 socket 1536 thread POWER9 system was found to encounter hash collisions
and excessive time in waitqueue locking at times. This was intermittent and
hard to reproduce easily with the setup we had (very little real IO
capacity). The theory is that sometimes (depending on allocation luck)
important pages would happen to collide a lot in the hash, slowing down pag=
e
locking, causing the problem to snowball.

An small test case was made where threads would write and fsync different
pages, generating just a small amount of contention across many pages.

Increasing page waitqueue hash size to 262144 entries increased throughput
by 182% while also reducing standard deviation 3x. perf before the increase=
:

  36.23%  [k] _raw_spin_lock_irqsave                -      -
              |
              |--34.60%--wake_up_page_bit
              |          0
              |          iomap_write_end.isra.38
              |          iomap_write_actor
              |          iomap_apply
              |          iomap_file_buffered_write
              |          xfs_file_buffered_aio_write
              |          new_sync_write

  17.93%  [k] native_queued_spin_lock_slowpath      -      -
              |
              |--16.74%--_raw_spin_lock_irqsave
              |          |
              |           --16.44%--wake_up_page_bit
              |                     iomap_write_end.isra.38
              |                     iomap_write_actor
              |                     iomap_apply
              |                     iomap_file_buffered_write
              |                     xfs_file_buffered_aio_write

This patch uses alloc_large_system_hash to allocate a bigger system hash
that scales somewhat with memory size. The bit/var wait-queue is also
changed to keep code matching, albiet with a smaller scale factor.

This hash could be made per-node, which may help reduce remote accesses
on well localised workloads, but that adds some complexity with indexing
and hotplug, so until we get a less artificial workload to test with,
keep it simple.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/sched/wait_bit.c | 25 ++++++++++++++++++-------
 mm/filemap.c            | 16 ++++++++++++++--
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 02ce292b9bc0..3cc5fa552516 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -2,19 +2,20 @@
 /*
  * The implementation of the wait_bit*() and related waiting APIs:
  */
+#include <linux/memblock.h>
 #include "sched.h"
=20
-#define WAIT_TABLE_BITS 8
-#define WAIT_TABLE_SIZE (1 << WAIT_TABLE_BITS)
-
-static wait_queue_head_t bit_wait_table[WAIT_TABLE_SIZE] __cacheline_align=
ed;
+#define BIT_WAIT_TABLE_SIZE (1 << BIT_WAIT_TABLE_BITS)
+#define BIT_WAIT_TABLE_BITS bit_wait_table_bits
+static unsigned int bit_wait_table_bits __ro_after_init;
+static wait_queue_head_t *bit_wait_table __ro_after_init;
=20
 wait_queue_head_t *bit_waitqueue(void *word, int bit)
 {
 	const int shift =3D BITS_PER_LONG =3D=3D 32 ? 5 : 6;
 	unsigned long val =3D (unsigned long)word << shift | bit;
=20
-	return bit_wait_table + hash_long(val, WAIT_TABLE_BITS);
+	return bit_wait_table + hash_long(val, BIT_WAIT_TABLE_BITS);
 }
 EXPORT_SYMBOL(bit_waitqueue);
=20
@@ -152,7 +153,7 @@ EXPORT_SYMBOL(wake_up_bit);
=20
 wait_queue_head_t *__var_waitqueue(void *p)
 {
-	return bit_wait_table + hash_ptr(p, WAIT_TABLE_BITS);
+	return bit_wait_table + hash_ptr(p, BIT_WAIT_TABLE_BITS);
 }
 EXPORT_SYMBOL(__var_waitqueue);
=20
@@ -246,6 +247,16 @@ void __init wait_bit_init(void)
 {
 	int i;
=20
-	for (i =3D 0; i < WAIT_TABLE_SIZE; i++)
+	bit_wait_table =3D alloc_large_system_hash("bit waitqueue hash",
+						sizeof(wait_queue_head_t),
+						0,
+						22,
+						0,
+						&bit_wait_table_bits,
+						NULL,
+						0,
+						0);
+
+	for (i =3D 0; i < BIT_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(bit_wait_table + i);
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index 43700480d897..df5a3ef4031b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -34,6 +34,7 @@
 #include <linux/security.h>
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
+#include <linux/memblock.h>
 #include <linux/memcontrol.h>
 #include <linux/cleancache.h>
 #include <linux/shmem_fs.h>
@@ -990,9 +991,10 @@ EXPORT_SYMBOL(__page_cache_alloc);
  * at a cost of "thundering herd" phenomena during rare hash
  * collisions.
  */
-#define PAGE_WAIT_TABLE_BITS 8
 #define PAGE_WAIT_TABLE_SIZE (1 << PAGE_WAIT_TABLE_BITS)
-static wait_queue_head_t page_wait_table[PAGE_WAIT_TABLE_SIZE] __cacheline=
_aligned;
+#define PAGE_WAIT_TABLE_BITS page_wait_table_bits
+static unsigned int page_wait_table_bits __ro_after_init;
+static wait_queue_head_t *page_wait_table __ro_after_init;
=20
 static wait_queue_head_t *page_waitqueue(struct page *page)
 {
@@ -1003,6 +1005,16 @@ void __init pagecache_init(void)
 {
 	int i;
=20
+	page_wait_table =3D alloc_large_system_hash("page waitqueue hash",
+						sizeof(wait_queue_head_t),
+						0,
+						21,
+						0,
+						&page_wait_table_bits,
+						NULL,
+						0,
+						0);
+
 	for (i =3D 0; i < PAGE_WAIT_TABLE_SIZE; i++)
 		init_waitqueue_head(&page_wait_table[i]);
=20
--=20
2.23.0

> Rasmus
>=20
