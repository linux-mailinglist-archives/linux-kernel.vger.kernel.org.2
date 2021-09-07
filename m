Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F322402E82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346007AbhIGSrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:47:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44494 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240131AbhIGSrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:47:20 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631040374; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ojzmV1MXvpTwtC591V15dopS3TfjogPAk6P0Foo55aI=;
 b=qUyQH7FlIsOeJummAJlnT92b4djJYoH3UHH9PjDQ7m60nj1HqFzD90Dt8IkrM1Q99T4Z/kbJ
 lCHlZrBVX9HAQo1Pb7zDfW+7a7ioNuYF/LZnVExcbnDwvBNGhBMQuABVTaTBdxd5a21hb7AV
 Bun57uwATgjYxDFJ8cEkOHj2AzY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6137b36c6fc2cf7ad9887b2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Sep 2021 18:46:04
 GMT
Sender: cgoldswo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 026E2C43616; Tue,  7 Sep 2021 18:46:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cgoldswo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2CAF4C4338F;
        Tue,  7 Sep 2021 18:46:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 07 Sep 2021 11:46:02 -0700
From:   Chris Goldsworthy <cgoldswo@codeaurora.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Xing, Zhengjun" <zhengjun.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Laura Abbott <labbott@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [LKP] Re: [mm] 8cc621d2f4: fio.write_iops -21.8% regression
In-Reply-To: <YTeZm71hmcbJp+E2@google.com>
References: <20210520083144.GD14190@xsang-OptiPlex-9020>
 <YKasEeXCr9R5yzCr@google.com>
 <45f761de51d514f77cc48214846c5f8f@codeaurora.org>
 <YK0Us01mBTRWOQIw@google.com> <YK0oQ76zX0uVZCwQ@google.com>
 <5abc4469d16535119818e8e72173398d@codeaurora.org>
 <034fc860-d0d0-0c61-09d2-3c41c4f020c6@intel.com>
 <YTeZm71hmcbJp+E2@google.com>
Message-ID: <d4902ba55d51c5b4a7b9e01414391f0d@codeaurora.org>
X-Sender: cgoldswo@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-07 09:55, Minchan Kim wrote:
> Hi,
> 
> On Fri, Sep 03, 2021 at 03:11:33PM +0800, Xing, Zhengjun wrote:
>> Hi Minchan,
>> 
>>     Do you have time to look at this? I re-test it in  v5.14, the 
>> regression
>> still existed. Thanks.
> 
> Reminding me the issue, again, Xing. That's because the patch
> was not merged yet so let me send it again.
> 
> Andrew?
> 
> From 8caadeb49d82403a08643dfbdb0b7749017c00bb Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Tue, 25 May 2021 08:19:17 -0700
> Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path
> 
> kernel test robot reported the regression of fio.write_iops[1]
> with [2].
> 
> Since lru_add_drain is called frequently, invalidate bh_lrus
> there could increase bh_lrus cache miss ratio, which needs
> more IO in the end.
> 
> This patch moves the bh_lrus invalidation from the hot path(
> e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> lru_add_drain_all, lru_cache_disable).
> 
> [1] 
> https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
> [2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
> Cc: Xing, Zhengjun <zhengjun.xing@intel.com>
> Reviewed-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/swap.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 1958d5feb148..3e25d99a9dbb 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
>  		pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
> 
>  	activate_page_drain(cpu);
> -	invalidate_bh_lrus_cpu(cpu);
>  }
> 
>  /**
> @@ -725,6 +724,17 @@ void lru_add_drain(void)
>  	local_unlock(&lru_pvecs.lock);
>  }
> 
> +static void lru_add_and_bh_lrus_drain(void)
> +{
> +	int cpu;
> +
> +	local_lock(&lru_pvecs.lock);
> +	cpu = smp_processor_id();
> +	lru_add_drain_cpu(cpu);
> +	local_unlock(&lru_pvecs.lock);
> +	invalidate_bh_lrus_cpu(cpu);
> +}
> +
>  void lru_add_drain_cpu_zone(struct zone *zone)
>  {
>  	local_lock(&lru_pvecs.lock);
> @@ -739,7 +749,7 @@ static DEFINE_PER_CPU(struct work_struct,
> lru_add_drain_work);
> 
>  static void lru_add_drain_per_cpu(struct work_struct *dummy)
>  {
> -	lru_add_drain();
> +	lru_add_and_bh_lrus_drain();
>  }
> 
>  /*
> @@ -880,7 +890,7 @@ void lru_cache_disable(void)
>  	 */
>  	__lru_add_drain_all(true);
>  #else
> -	lru_add_drain();
> +	lru_add_and_bh_lrus_drain();
>  #endif
>  }
> 
> --
> 2.31.1.818.g46aad6cb9e-goog

Hi Minchan,

I believe that was the first iteration of your patch - there was some 
further feedback, such that this was the last version you submitted:

 From 8d58e7ade3ed6c080995dec1395b1e130b3d16b3 Mon Sep 17 00:00:00 2001
 From: Minchan Kim <minchan@kernel.org>
Date: Tue, 25 May 2021 08:19:17 -0700
Subject: [PATCH] mm: fs: invalidate bh_lrus for only cold path

kernel test robot reported the regression of fio.write_iops[1]
with [2].

Since lru_add_drain is called frequently, invalidate bh_lrus
there could increase bh_lrus cache miss ratio, which needs
more IO in the end.

This patch moves the bh_lrus invalidation from the hot path(
e.g., zap_page_range, pagevec_release) to cold path(i.e.,
lru_add_drain_all, lru_cache_disable).

[1] 
https://lore.kernel.org/lkml/20210520083144.GD14190@xsang-OptiPlex-9020/
[2] 8cc621d2f45d, mm: fs: invalidate BH LRU during page migration
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
  fs/buffer.c                 |  8 ++++++--
  include/linux/buffer_head.h |  4 ++--
  mm/swap.c                   | 19 ++++++++++++++++---
  3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 673cfbef9eec..bdaffed39030 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1487,12 +1487,16 @@ void invalidate_bh_lrus(void)
  }
  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);

-void invalidate_bh_lrus_cpu(int cpu)
+/*
+ * It's called from workqueue context so we need a bh_lru_lock to close
+ * the race with preemption/irq.
+ */
+void invalidate_bh_lrus_cpu(void)
  {
      struct bh_lru *b;

      bh_lru_lock();
-    b = per_cpu_ptr(&bh_lrus, cpu);
+    b = this_cpu_ptr(&bh_lrus);
      __invalidate_bh_lrus(b);
      bh_lru_unlock();
  }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e7e99da31349..b04d34bab124 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -194,7 +194,7 @@ void __breadahead_gfp(struct block_device *,
sector_t block, unsigned int size,
  struct buffer_head *__bread_gfp(struct block_device *,
                  sector_t block, unsigned size, gfp_t gfp);
  void invalidate_bh_lrus(void);
-void invalidate_bh_lrus_cpu(int cpu);
+void invalidate_bh_lrus_cpu(void);
  bool has_bh_in_lru(int cpu, void *dummy);
  struct buffer_head *alloc_buffer_head(gfp_t gfp_flags);
  void free_buffer_head(struct buffer_head * bh);
@@ -408,7 +408,7 @@ static inline int inode_has_buffers(struct inode
*inode) { return 0; }
  static inline void invalidate_inode_buffers(struct inode *inode) {}
  static inline int remove_inode_buffers(struct inode *inode) { return 1; 
}
  static inline int sync_mapping_buffers(struct address_space *mapping)
{ return 0; }
-static inline void invalidate_bh_lrus_cpu(int cpu) {}
+static inline void invalidate_bh_lrus_cpu(void) {}
  static inline bool has_bh_in_lru(int cpu, void *dummy) { return 0; }
  #define buffer_heads_over_limit 0

diff --git a/mm/swap.c b/mm/swap.c
index 1958d5feb148..4d9ec3c3c5a9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -642,7 +642,6 @@ void lru_add_drain_cpu(int cpu)
          pagevec_lru_move_fn(pvec, lru_lazyfree_fn);

      activate_page_drain(cpu);
-    invalidate_bh_lrus_cpu(cpu);
  }

  /**
@@ -725,6 +724,20 @@ void lru_add_drain(void)
      local_unlock(&lru_pvecs.lock);
  }

+/*
+ * It's called from per-cpu workqueue context in SMP case so
+ * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
+ * the same cpu. It shouldn't be a problem in !SMP case since
+ * the core is only one and the locks will disable preemption.
+ */
+static void lru_add_and_bh_lrus_drain(void)
+{
+    local_lock(&lru_pvecs.lock);
+    lru_add_drain_cpu(smp_processor_id());
+    local_unlock(&lru_pvecs.lock);
+    invalidate_bh_lrus_cpu();
+}
+
  void lru_add_drain_cpu_zone(struct zone *zone)
  {
      local_lock(&lru_pvecs.lock);
@@ -739,7 +752,7 @@ static DEFINE_PER_CPU(struct work_struct,
lru_add_drain_work);

  static void lru_add_drain_per_cpu(struct work_struct *dummy)
  {
-    lru_add_drain();
+    lru_add_and_bh_lrus_drain();
  }

  /*
@@ -880,7 +893,7 @@ void lru_cache_disable(void)
       */
      __lru_add_drain_all(true);
  #else
-    lru_add_drain();
+    lru_add_and_bh_lrus_drain();
  #endif
  }

-- 
The Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
