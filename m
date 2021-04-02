Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB683529DB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:39:23 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:32977
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229722AbhDBKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:39:23 -0400
Received: from i-ujjfgxi5.pek3.qingcloud.com (unknown [139.198.0.165])
        by mailapp1 (Coremail) with SMTP id A7CowAD3_xdA9GZgBXctAA--.3316S2;
        Fri, 02 Apr 2021 18:39:17 +0800 (CST)
From:   Neil Sun <neilsun@yunify.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Sun <neilsun@yunify.com>
Subject: [PATCH] mm/vmscan.c: drop_slab_node with task's memcg
Date:   Fri,  2 Apr 2021 18:38:54 +0800
Message-Id: <1617359934-7812-1-git-send-email-neilsun@yunify.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: A7CowAD3_xdA9GZgBXctAA--.3316S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urWrCFWkJFWDWFWDGrW5Awb_yoW8Cr48pa
        y7GFy5JrsYgr1vqrn8Xa1kZ3ySk39rAF1DCF1DZw17C343Cry3Cr1Fyw18ZFyxCayDWF42
        kr1Fy3srZwn8AF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfU5WlkUUUUU
X-CM-SenderInfo: xqhlz21xq653pqli5hhfrp/1tbiAQAAClhaKs7qXwAAsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes shrink_slab() with task's memcg in drop_slab_node(),
so we can free reclaimable slab objects belongs to memcg /lxc/i-vbe1u8o7
with following command:

cgexec -g memory:/lxc/i-vbe1u8o7 sysctl vm.drop_caches=2

Test with following steps:

root@i-yl0pwrt8:~# free -h
              total        used        free      shared  buff/cache   available
Mem:           62Gi       265Mi        62Gi       1.0Mi       290Mi        61Gi
Swap:          31Gi          0B        31Gi
root@i-yl0pwrt8:~# (cd /tmp && /root/generate_slab_cache)
root@i-yl0pwrt8:~# free -h
              total        used        free      shared  buff/cache   available
Mem:           62Gi       266Mi        60Gi       1.0Mi       2.2Gi        61Gi
Swap:          31Gi          0B        31Gi
root@i-yl0pwrt8:~# cgcreate -g memory:/lxc/i-vbe1u8o7
root@i-yl0pwrt8:~# cgexec -g memory:/lxc/i-vbe1u8o7 /root/generate_slab_cache
root@i-yl0pwrt8:~# free -h
              total        used        free      shared  buff/cache   available
Mem:           62Gi       267Mi        58Gi       1.0Mi       4.1Gi        61Gi
Swap:          31Gi          0B        31Gi
root@i-yl0pwrt8:~# cgexec -g memory:/lxc/i-vbe1u8o7 sysctl vm.drop_caches=2
vm.drop_caches = 2
root@i-yl0pwrt8:~# free -h
              total        used        free      shared  buff/cache   available
Mem:           62Gi       268Mi        60Gi       1.0Mi       2.2Gi        61Gi
Swap:          31Gi          0B        31Gi
root@i-yl0pwrt8:~# sysctl vm.drop_caches=2
vm.drop_caches = 2
root@i-yl0pwrt8:~# free -h
              total        used        free      shared  buff/cache   available
Mem:           62Gi       267Mi        62Gi       1.0Mi       290Mi        61Gi
Swap:          31Gi          0B        31Gi

Signed-off-by: Neil Sun <neilsun@yunify.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 562e87cb..81d770a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -702,7 +702,7 @@ void drop_slab_node(int nid)
 			return;
 
 		freed = 0;
-		memcg = mem_cgroup_iter(NULL, NULL, NULL);
+		memcg = mem_cgroup_from_task(current);
 		do {
 			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
-- 
2.7.4

