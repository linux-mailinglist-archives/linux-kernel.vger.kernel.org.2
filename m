Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2AF38C64B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhEUMNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbhEUMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:12:58 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333DDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:11:31 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so1241403wrt.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ml9aXgYWsxmLMe303aemuEkZuwFy+qH+s0r1NMT4fd0=;
        b=G/y47iLV9zx1VyEIaxEgrqDGsn62RsNLQqEpjLroeGdYnN6Qtn3rQH+gX5cZBdaEpv
         wPar/LUQLrM+8TGApiAaIbFAPgBWFuggukQMtECP5+bahU5Di8h4R+lSr5Tiko2/rpuR
         GcvuDNhfGEmZeY/JzKn8m+flnUdGinGHX3ihLFXqpPArO74ezylDdv3b1vrs4M4gl63S
         RynlKm2daNsDvVtfX0ln0DkYJXI/cx/SHvZVJnTOUUhvYs5HK5yUBZyCwHxQKnV0URxL
         7cx15SnBT3Oog83WwenE29Z4icoTrgklovwy91BbMslPQH27KfpWnAZwlzNsydJXa9zs
         aAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ml9aXgYWsxmLMe303aemuEkZuwFy+qH+s0r1NMT4fd0=;
        b=aw8q4nZDoE+7YPlykUgyzGuqIuETZJpnpt/h10rN0GOGMXXFxhtwq3yVsfMaYK58Un
         g8bAhrSJlsfs3Ns5zIU2IbPGtjsjiEhk1pkMzAxVkN3mfSMnRMrg9RJohMZ4eqX8OYII
         onz3b36eXjyN51OCO4MrpSqOnow6i1gOa9en2N6sw8oJkikTlLA7AP353sO6gZHlGV9w
         kb+4H+HW3Z0Bgc9CAd5lCVFTKuvHy3g59nv4+Yo+hZ/ANy6/5h9lVMRbe+BME4t6dN/d
         +DXR2rvHlGJJNQySZkcztIEIgzoB1XatEy/SoV7bfhOZSdQT4zsie1/IMvsWpjc55nNo
         GF0g==
X-Gm-Message-State: AOAM5332/yKlOu2wcUUrpCajNSavYUEMU9oCFiWwTqJY9PULPXqk4WCh
        pT84yxReBPzqlUT6ny788ko=
X-Google-Smtp-Source: ABdhPJyARzQ5c2zgj9Ij37sb3vRqmocu60KNmQ5m0huB27J8Uo/pGQO62NjtYRLFuHqtdGD698zp8Q==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr9037494wri.27.1621599089846;
        Fri, 21 May 2021 05:11:29 -0700 (PDT)
Received: from oliver-Z170M-D3H.cuni.cz ([2001:718:1e03:5128:e010:8b67:85b8:dc89])
        by smtp.gmail.com with ESMTPSA id c64sm3339401wma.15.2021.05.21.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 05:11:29 -0700 (PDT)
From:   glittao@gmail.com
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        faiyazm@codeaurora.org, Oliver Glitta <glittao@gmail.com>
Subject: [RFC 1/3] mm/slub: aggregate objects in cache by stack trace
Date:   Fri, 21 May 2021 14:11:25 +0200
Message-Id: <20210521121127.24653-1-glittao@gmail.com>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Glitta <glittao@gmail.com>

Aggregate objects in slub cache by stack trace in addition to caller
address during alloc_calls and free_calls implementation
in debugfs. Add stack trace to output.

Add all_objects implementation to debugfs to print information
about all objects.

Signed-off-by: Oliver Glitta <glittao@gmail.com>
---
Based on next-20210518 and
https://lore.kernel.org/r/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/

 mm/slub.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e9b84eddc50d..d5ed6ed7d68b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4770,6 +4770,7 @@ EXPORT_SYMBOL(validate_slab_cache);
  */

 struct location {
+	depot_stack_handle_t handle;
 	unsigned long count;
 	unsigned long addr;
 	long long sum_time;
@@ -4822,9 +4823,15 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 {
 	long start, end, pos;
 	struct location *l;
-	unsigned long caddr;
+	unsigned long caddr, chandle;
 	unsigned long age = jiffies - track->when;
+	depot_stack_handle_t handle;

+#ifdef CONFIG_STACKDEPOT
+	handle = READ_ONCE(track->handle);
+#else
+	handle = 0;
+#endif
 	start = -1;
 	end = t->count;

@@ -4839,7 +4846,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 			break;

 		caddr = t->loc[pos].addr;
-		if (track->addr == caddr) {
+		chandle = t->loc[pos].handle;
+		if ((track->addr == caddr) && (handle == chandle)) {

 			l = &t->loc[pos];
 			l->count++;
@@ -4864,6 +4872,8 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,

 		if (track->addr < caddr)
 			end = pos;
+		else if (track->addr == caddr && handle < chandle)
+			end = pos;
 		else
 			start = pos;
 	}
@@ -4886,6 +4896,7 @@ static int add_location(struct loc_track *t, struct kmem_cache *s,
 	l->max_time = age;
 	l->min_pid = track->pid;
 	l->max_pid = track->pid;
+	l->handle = handle;
 	cpumask_clear(to_cpumask(l->cpus));
 	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
 	nodes_clear(l->nodes);
@@ -5837,6 +5848,21 @@ static int slab_debugfs_show(struct seq_file *seq, void *v)
 			seq_printf(seq, " nodes=%*pbl",
 				 nodemask_pr_args(&l->nodes));

+#ifdef CONFIG_STACKDEPOT
+		{
+			depot_stack_handle_t handle;
+			unsigned long *entries;
+			unsigned int nr_entries, j;
+
+			handle = READ_ONCE(l->handle);
+			if (handle) {
+				nr_entries = stack_depot_fetch(handle, &entries);
+				seq_puts(seq, "\n");
+				for (j = 0; j < nr_entries; j++)
+					seq_printf(seq, "\t%pS\n", (void *)entries[j]);
+			}
+		}
+#endif
 		seq_puts(seq, "\n");
 	}

--
2.31.1.272.g89b43f80a5

