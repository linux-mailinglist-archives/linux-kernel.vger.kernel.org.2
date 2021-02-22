Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04432106E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 06:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBVFax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 00:30:53 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:58493
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229487AbhBVFau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 00:30:50 -0500
Received: from centos7u5.localdomain (unknown [202.43.158.76])
        by c1app2 (Coremail) with SMTP id AgINCgBXXLhIQTNgOy4UAw--.1517S3;
        Mon, 22 Feb 2021 13:29:45 +0800 (CST)
From:   Zhiyuan Dai <daizhiyuan@phytium.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>
Subject: [PATCH] mm/memory_hotplug: minor coding style tweaks
Date:   Mon, 22 Feb 2021 13:29:44 +0800
Message-Id: <1613971784-24878-1-git-send-email-daizhiyuan@phytium.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AgINCgBXXLhIQTNgOy4UAw--.1517S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1xKr4xXw18Aw4rJr1kKrg_yoW3ZFb_Ka
        yIqwsFgryFvF1S9r4qy34fJrn3Kr109w48uFyxJasIyryDX3sxZF4kJwn3ZryF9347Wr12
        q34DZrWagry7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
        W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GrWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUe2NtDUUUU
X-Originating-IP: [202.43.158.76]
X-CM-SenderInfo: hgdl6xpl1xt0o6sk53xlxphulrpou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch move the pointer location to fix coding style issues,
improve code reading.

Signed-off-by: Zhiyuan Dai <daizhiyuan@phytium.com.cn>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9..a46c297 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -764,7 +764,7 @@ static inline struct zone *default_zone_for_pfn(int nid, unsigned long start_pfn
 	return movable_node_enabled ? movable_zone : kernel_zone;
 }
 
-struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
+struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 		unsigned long nr_pages)
 {
 	if (online_type == MMOP_ONLINE_KERNEL)
-- 
1.8.3.1

