Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38842926C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243874AbhJKOp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244304AbhJKOpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:45:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74DC061745
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:43:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x8so11454375plv.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVcPbrW7jTXPSod0cAliddkcKMdj7+RC4+UQL16qp2w=;
        b=HKmLQjSKI5121K/arvfpPig0nCIrxGzhYAr3aAiQCJ4m26FnXbMGiSPRb1V4vB25zd
         z4jaO7HfCWEfT6wXpJuPUZ9XgMwaX1nfBGrchKRRVXaMlj56yU/HwBnOfZ57zDaL7Cb+
         ABcz6XAE8d0RhNDoGoTB+K3ihldmFDHZ3mwZ11VULGau+hAiqY6zrBMqBuo6hX7/ATQ1
         W1Ng1sWzOux/pBG0LofXdRLfgxv8xE0kkPQyXByQPoJCVoOWjK001jIe1oR8qF8yQnGB
         1NAcH9IGzqFFuJxWaV1w0xIvWkvVt3avJ0g+DnPW3IOUy893GK5H/MZtudL4hjAexoOj
         x6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nVcPbrW7jTXPSod0cAliddkcKMdj7+RC4+UQL16qp2w=;
        b=4ZmVUK8ivgfVa2WQAKulUYsRsoUoT4UEBUvxwUMucL6SRkvPKVEs4KzhOqfrA9Byzc
         W8IWqLJmdaqElOmVTfv155EMW/rS6QSNw3TdaYaVxc52huRY4WWyDTna9P1s8k1R21eL
         OcNqt+sXhE/xWwCSsJfGLgEopwXdjkT0V7tb+NEf8a7ZBdDBoUdHcl7Z4j/JUvYxSPCV
         XDHqJNkUBYMDjshQX1hLxjZzo4lPm/KThg5I4rYlF/btxTwYIZ6bMh2/dhLBkdGE/TOD
         mDyOoYg20bGte7TaBaDri5GDtv0tLo7d3zubnEoVLkSewvgmWZr/8XsE0rfSj3fnDccs
         T4Zw==
X-Gm-Message-State: AOAM533YteMGq3F/k5X87TLcW/vmEUY4Twe5TUmYskLO8ecPgH8AM3Kh
        X42EihrhvfYK+P/4KdlJW28=
X-Google-Smtp-Source: ABdhPJxkhDzidQh0CsIpV/KbDDV/tXjU/ZIEfEDFVL2VAtEW524XfWmrMGMWLPXrQCB0nBLnnRJ6jA==
X-Received: by 2002:a17:902:f703:b029:12c:982:c9ae with SMTP id h3-20020a170902f703b029012c0982c9aemr25114746plo.20.1633963418417;
        Mon, 11 Oct 2021 07:43:38 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (24.151.64.34.bc.googleusercontent.com. [34.64.151.24])
        by smtp.gmail.com with ESMTPSA id 192sm7528593pfy.121.2021.10.11.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:43:37 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     42.hyeyoo@gmail.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm, slub: Use prefetchw instead of prefetch
Date:   Mon, 11 Oct 2021 14:43:31 +0000
Message-Id: <20211011144331.70084-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
slab_alloc()") introduced prefetch_freepointer() because when other cpu(s)
freed objects into a page that current cpu owns, the freelist link is
hot on cpu(s) which freed objects and possibly very cold on current cpu.

But if freelist link chain is hot on cpu(s) which freed objects,
it's better to invalidate that chain because they're not going to access
again within a short time.

So use prefetchw instead of prefetch. On supported architectures like x86
and arm, it invalidates other copied instances of a cache line when
prefetching it.

Before:

Time: 91.677

 Performance counter stats for 'hackbench -g 100 -l 10000':
        1462938.07 msec cpu-clock                 #   15.908 CPUs utilized
          18072550      context-switches          #   12.354 K/sec
           1018814      cpu-migrations            #  696.416 /sec
            104558      page-faults               #   71.471 /sec
     1580035699271      cycles                    #    1.080 GHz                      (54.51%)
     2003670016013      instructions              #    1.27  insn per cycle           (54.31%)
        5702204863      branch-misses                                                 (54.28%)
      643368500985      cache-references          #  439.778 M/sec                    (54.26%)
       18475582235      cache-misses              #    2.872 % of all cache refs      (54.28%)
      642206796636      L1-dcache-loads           #  438.984 M/sec                    (46.87%)
       18215813147      L1-dcache-load-misses     #    2.84% of all L1-dcache accesses  (46.83%)
      653842996501      dTLB-loads                #  446.938 M/sec                    (46.63%)
        3227179675      dTLB-load-misses          #    0.49% of all dTLB cache accesses  (46.85%)
      537531951350      iTLB-loads                #  367.433 M/sec                    (54.33%)
         114750630      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.37%)
      630135543177      L1-icache-loads           #  430.733 M/sec                    (46.80%)
       22923237620      L1-icache-load-misses     #    3.64% of all L1-icache accesses  (46.76%)

      91.964452802 seconds time elapsed

      43.416742000 seconds user
    1422.441123000 seconds sys

After:

Time: 90.220

 Performance counter stats for 'hackbench -g 100 -l 10000':
        1437418.48 msec cpu-clock                 #   15.880 CPUs utilized
          17694068      context-switches          #   12.310 K/sec
            958257      cpu-migrations            #  666.651 /sec
            100604      page-faults               #   69.989 /sec
     1583259429428      cycles                    #    1.101 GHz                      (54.57%)
     2004002484935      instructions              #    1.27  insn per cycle           (54.37%)
        5594202389      branch-misses                                                 (54.36%)
      643113574524      cache-references          #  447.409 M/sec                    (54.39%)
       18233791870      cache-misses              #    2.835 % of all cache refs      (54.37%)
      640205852062      L1-dcache-loads           #  445.386 M/sec                    (46.75%)
       17968160377      L1-dcache-load-misses     #    2.81% of all L1-dcache accesses  (46.79%)
      651747432274      dTLB-loads                #  453.415 M/sec                    (46.59%)
        3127124271      dTLB-load-misses          #    0.48% of all dTLB cache accesses  (46.75%)
      535395273064      iTLB-loads                #  372.470 M/sec                    (54.38%)
         113500056      iTLB-load-misses          #    0.02% of all iTLB cache accesses  (54.35%)
      628871845924      L1-icache-loads           #  437.501 M/sec                    (46.80%)
       22585641203      L1-icache-load-misses     #    3.59% of all L1-icache accesses  (46.79%)

      90.514819303 seconds time elapsed

      43.877656000 seconds user
    1397.176001000 seconds sys

Link: https://lkml.org/lkml/2021/10/8/598 
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..ce3d8b11215c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -354,7 +354,7 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 
 static void prefetch_freepointer(const struct kmem_cache *s, void *object)
 {
-	prefetch(object + s->offset);
+	prefetchw(object + s->offset);
 }
 
 static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
-- 
2.27.0

