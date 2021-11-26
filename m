Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC345E6D7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358125AbhKZEbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhKZE3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:29:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA97C0613FB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:06:37 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 71so6982266pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxrYhHc6aKpqxzzlVemaKlJCRKgcCo/zpvcwMEFod1g=;
        b=3V+niI3eAGEI5joOyhomPDevZI7q++8ohy0CwrDueX/T1rts+xnHL3Zch+LcP2J5B4
         Elrcyy2kHzVGkFFJo8IHD2q7z1naXv+/4MtHX4Qbi/XQ7VqlHZFooSUUm6ICLjxTq3Pn
         jZJFl1HzrkARG8yp1mYHVrlDGl4Uc0p5XPNEU67Ot2dsTvrP5wMOJ3qKF22x4eKrbYs3
         8I88SlZPAi8ymtZpCWOWR1Rs+M7zpuKIJeTMAi9WfSXoTZCz2mtEFOL2qCkcuxWxmeXd
         03FAWX5Krb1fHSU/phNtzEQPI7/c/wVnzMJmkkekTW9+mYVCHcABNAbwk5AiXdXZSUb5
         ukQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dxrYhHc6aKpqxzzlVemaKlJCRKgcCo/zpvcwMEFod1g=;
        b=xCR4y05z2cUSbhIWvg/Hf1KIze3U9ib+Hbz0lzK+GRnoBWEvWv5mTETYIvYaa7/Ul8
         qGQXq1H1YyIBahHsv7eViI4ELONZV/WPXGs1TaD190woFpO4krErmmFHqxXMmIH3+WIW
         hPZ9CgYVoEEXP/tpA2mF/EHWxZfVQDQOptRioDOX5pwN/S/3owdDbMTsMNoYC3wQ7uea
         iLjozyhtHJGlixqgsEFDJgztKO07ttVt/HdEFPI2RCIa02gSr0bJVu/WMXZJIv1gKBk5
         AbDeaORTdpBKipoZ2zs+7jLxw+XQajSuW5SAHzDcK+PAbKjf+esgSGwC/Nj0RNZJK4Kx
         NsVg==
X-Gm-Message-State: AOAM530uasd+CL89TETMD/l/EjSlGzQ/elSX3FCP09h0aRVtqlFuMMyQ
        7XmSihjzN73k6+MRuhdMytvTcQ==
X-Google-Smtp-Source: ABdhPJzi55oolxqTbTy0h1eAiBDK69Il6vfa929IKg6Wco4j8PtxJNIhVNBic+MiFM9sOf8no2sKjg==
X-Received: by 2002:a05:6a00:21c4:b0:4a7:ec46:34b7 with SMTP id t4-20020a056a0021c400b004a7ec4634b7mr11126252pfj.15.1637899597210;
        Thu, 25 Nov 2021 20:06:37 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id f4sm5406045pfj.61.2021.11.25.20.06.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Nov 2021 20:06:36 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH] mm: memcg/percpu: account extra objcg space to memory cgroups
Date:   Fri, 26 Nov 2021 12:06:06 +0800
Message-Id: <20211126040606.97836-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to slab memory allocator, for each accounted percpu object
there is an extra space which is used to store obj_cgroup membership.
Charge it too.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/percpu-internal.h | 17 +++++++++++++++++
 mm/percpu.c          | 10 +++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 639662c20c82..030a176b5b8e 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -113,6 +113,23 @@ static inline int pcpu_chunk_map_bits(struct pcpu_chunk *chunk)
 	return pcpu_nr_pages_to_map_bits(chunk->nr_pages);
 }
 
+#ifdef CONFIG_MEMCG_KMEM
+/**
+ * pcpu_obj_full_size - helper to calculate size of each accounted object
+ * @size: size of area to allocate in bytes
+ *
+ * For each accounted object there is an extra space which is used to store
+ * obj_cgroup membership. Charge it too.
+ */
+static inline size_t pcpu_obj_full_size(size_t size)
+{
+	size_t extra_size =
+		size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
+
+	return size * num_possible_cpus() + extra_size;
+}
+#endif /* CONFIG_MEMCG_KMEM */
+
 #ifdef CONFIG_PERCPU_STATS
 
 #include <linux/spinlock.h>
diff --git a/mm/percpu.c b/mm/percpu.c
index 293009cc03ef..f5c9a3faadee 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1635,7 +1635,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	if (!objcg)
 		return true;
 
-	if (obj_cgroup_charge(objcg, gfp, size * num_possible_cpus())) {
+	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size))) {
 		obj_cgroup_put(objcg);
 		return false;
 	}
@@ -1656,10 +1656,10 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 
 		rcu_read_lock();
 		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				size * num_possible_cpus());
+				pcpu_obj_full_size(size));
 		rcu_read_unlock();
 	} else {
-		obj_cgroup_uncharge(objcg, size * num_possible_cpus());
+		obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
 		obj_cgroup_put(objcg);
 	}
 }
@@ -1676,11 +1676,11 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 		return;
 	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
 
-	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
+	obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
 
 	rcu_read_lock();
 	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-			-(size * num_possible_cpus()));
+			-pcpu_obj_full_size(size));
 	rcu_read_unlock();
 
 	obj_cgroup_put(objcg);
-- 
2.11.0

