Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB09A3FF9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhICFVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhICFVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:21:34 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A1C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 22:20:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m2so2716484wmm.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 22:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+2HlSAxZRhswpmGkH1nZUzJIIVQqlBs+L6yFsiWh2Y=;
        b=LXP42dF51c7ooBGQOK1HG25eyDU0tHW+E8d5H+dsJKh+BKws/+60EfFI+34Ou1Mm2F
         i8zwxZ1wXnhoBgRfbH6DkE20duXJW3UAmmkpkZUzb6sj8XOLyHUcbMGzVjkxaAwbd7Jp
         djCOx9wBI4Ya06Dbxr6b5pFuWWaUAWHEBrkjERPluTrXyYpRMD4N9UZYW2b6foijKJqt
         QVmzAPJFVaFlFukp2IIQG8gUG1fz1bFVZ9aIdRM07hRxcEB7PpDfc5Eb4BDTlpgu17Ps
         ZTW1i30b0vqESR656a72dQeX2nsS2t+b+WNbuoq6VPrlEMyVl9Zc1dpegyYh29P4hltf
         BO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+2HlSAxZRhswpmGkH1nZUzJIIVQqlBs+L6yFsiWh2Y=;
        b=QYUi/WhAdgS6ZF2m0PpQPNY/soxtbPfO2c8LK6GYkVBdPCjYbayW+gdi5q/jeo0weJ
         ynI4y3M51Dia1q4alAwePQ/AeC0imazgiEMvZlnzq6ycBXF7dgKMXXU6wcDIfWP+L9bS
         1RqnGBxLlkV7FBX4o7406rkqdfTXQFmVT2CHoRNAmhuPSNHJjJihP6lI6fZ2d9ISFRIq
         yWdLWb5NbH0umAAMANPpXhBaYwreR/1SL9ZQogmyLnZ0RavD2YWtJUFNIxHNB6+e+lpZ
         qXH4MT1BAqJzIHAlUPFzhfmWhXp/6UjGDOK19/wexNQzhMsVuJddBWSrDrQAWw612EdY
         jVJA==
X-Gm-Message-State: AOAM530eCGix9Vpk65R6SNVByJbpdj3DXFc5TRKtFFzx4UDLFpWRQ5rL
        3eCd7LX2xpaKTcLN0ZVKlhj7G85GD6MN9ozo
X-Google-Smtp-Source: ABdhPJwpHUOU+P3rhV1nQ5Gq9r8zWhmohFrYTQ9xjXh5ibt4/YSX3nxQHfi5QC3hLCaGavV5S5D6KQ==
X-Received: by 2002:a05:600c:22c3:: with SMTP id 3mr6544494wmg.133.1630646433416;
        Thu, 02 Sep 2021 22:20:33 -0700 (PDT)
Received: from localhost.localdomain (p200300d997085c0087ad16bce8a07868.dip0.t-ipconnect.de. [2003:d9:9708:5c00:87ad:16bc:e8a0:7868])
        by smtp.googlemail.com with ESMTPSA id m4sm3313987wmc.3.2021.09.02.22.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:20:33 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: ipc: replace costly bailout check in sysvipc_find_ipc()
Date:   Fri,  3 Sep 2021 07:20:19 +0200
Message-Id: <20210903052020.3265-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903052020.3265-1-manfred@colorfullife.com>
References: <20210903052020.3265-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael Aquini <aquini@redhat.com>

sysvipc_find_ipc() was left with a costly way to check if the offset
position fed to it is bigger than the total number of IPC IDs in use.  So
much so that the time it takes to iterate over /proc/sysvipc/* files grows
exponentially for a custom benchmark that creates "N" SYSV shm segments
and then times the read of /proc/sysvipc/shm (milliseconds):

    12 msecs to read   1024 segs from /proc/sysvipc/shm
    18 msecs to read   2048 segs from /proc/sysvipc/shm
    65 msecs to read   4096 segs from /proc/sysvipc/shm
   325 msecs to read   8192 segs from /proc/sysvipc/shm
  1303 msecs to read  16384 segs from /proc/sysvipc/shm
  5182 msecs to read  32768 segs from /proc/sysvipc/shm

The root problem lies with the loop that computes the total amount of ids
in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
"ids->in_use".  That is a quite inneficient way to get to the maximum
index in the id lookup table, specially when that value is already
provided by struct ipc_ids.max_idx.

This patch follows up on the optimization introduced via commit
15df03c879836 ("sysvipc: make get_maxid O(1) again") and gets rid of the
aforementioned costly loop replacing it by a simpler checkpoint based on
ipc_get_maxidx() returned value, which allows for a smooth linear increase
in time complexity for the same custom benchmark:

     2 msecs to read   1024 segs from /proc/sysvipc/shm
     2 msecs to read   2048 segs from /proc/sysvipc/shm
     4 msecs to read   4096 segs from /proc/sysvipc/shm
     9 msecs to read   8192 segs from /proc/sysvipc/shm
    19 msecs to read  16384 segs from /proc/sysvipc/shm
    39 msecs to read  32768 segs from /proc/sysvipc/shm

Link: https://lkml.kernel.org/r/20210809203554.1562989-1-aquini@redhat.com
Signed-off-by: Rafael Aquini <aquini@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <llong@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 ipc/util.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

--- a/ipc/util.c~ipc-replace-costly-bailout-check-in-sysvipc_find_ipc
+++ a/ipc/util.c
@@ -788,21 +788,13 @@ struct pid_namespace *ipc_seq_pid_ns(str
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc;
-	int total, id;
+	struct kern_ipc_perm *ipc = NULL;
+	int max_idx = ipc_get_maxidx(ids);
 
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
-
-	ipc = NULL;
-	if (total >= ids->in_use)
+	if (max_idx == -1 || pos > max_idx)
 		goto out;
 
-	for (; pos < ipc_mni; pos++) {
+	for (; pos <= max_idx; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			rcu_read_lock();
_
