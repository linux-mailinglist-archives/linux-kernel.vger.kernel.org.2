Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC1136794C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhDVFaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:30:10 -0400
Received: from relay.sw.ru ([185.231.240.75]:60940 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhDVFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=bqxfK+ICkPqElZ+XBPs+YGuSjhGSZ+ehPejQMG/PDoM=; b=i1ReVZFMoBYlhqGdU5M
        nblOp+/0k/vDiq0fzKWx4lHq3UVKQUAURfKMQ8gxQYOaGKNZCCEYVoNOQgeMk7awz9/2Y2d7BvL63
        nIZ6E/LTD1TmhrDmDPxLRa9B01IizHdeq7maaOLD2u1ms8gB106frBMGJUJlSOepl150Y7RKcpQ=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZRu8-0019OH-4o; Thu, 22 Apr 2021 08:29:32 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] tools/cgroup/slabinfo.py: updated to work on current kernel
To:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>
Message-ID: <cec1a75e-43b4-3d64-2084-d9f98fda037f@virtuozzo.com>
Date:   Thu, 22 Apr 2021 08:29:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

slabinfo.py script does not work with actual kernel version.
First, it was unable to recognise SLUB susbsytem,
when I specified it manually, it was failed again with
AttributeError: 'struct page' has no member 'obj_cgroups'
... and then again with
  File "tools/cgroup/memcg_slabinfo.py", line 221, in main
    memcg.kmem_caches.address_of_(),
AttributeError: 'struct mem_cgroup' has no member 'kmem_caches'

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 tools/cgroup/memcg_slabinfo.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo.py
index c4225ed..1600b17 100644
--- a/tools/cgroup/memcg_slabinfo.py
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -128,9 +128,9 @@ OO_MASK = ((1 << OO_SHIFT) - 1)
 
     cfg['nr_nodes'] = prog['nr_online_nodes'].value_()
 
-    if prog.type('struct kmem_cache').members[1][1] == 'flags':
+    if prog.type('struct kmem_cache').members[1].name == 'flags':
         cfg['allocator'] = 'SLUB'
-    elif prog.type('struct kmem_cache').members[1][1] == 'batchcount':
+    elif prog.type('struct kmem_cache').members[1].name == 'batchcount':
         cfg['allocator'] = 'SLAB'
     else:
         err('Can\'t determine the slab allocator')
@@ -193,7 +193,7 @@ OO_MASK = ((1 << OO_SHIFT) - 1)
         # look over all slab pages, belonging to non-root memcgs
         # and look for objects belonging to the given memory cgroup
         for page in for_each_slab_page(prog):
-            objcg_vec_raw = page.obj_cgroups.value_()
+            objcg_vec_raw = page.memcg_data.value_()
             if objcg_vec_raw == 0:
                 continue
             cache = page.slab_cache
@@ -202,7 +202,7 @@ OO_MASK = ((1 << OO_SHIFT) - 1)
             addr = cache.value_()
             caches[addr] = cache
             # clear the lowest bit to get the true obj_cgroups
-            objcg_vec = Object(prog, page.obj_cgroups.type_,
+            objcg_vec = Object(prog, 'struct obj_cgroup **',
                                value=objcg_vec_raw & ~1)
 
             if addr not in stats:
-- 
1.8.3.1

