Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9412836A59A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 09:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhDYHyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhDYHxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 03:53:03 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D736BC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:52:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so1551024wmg.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 00:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TZ794c1czbFaz1DBCk5cud8qffi0zVdnLWwZEp2YHM8=;
        b=RUjvJkv5zRnynT9vkWV9PGXxMJR3x0dvzVjvQ5QzNrWnU6/jyMhOa/YQqGsMe1dMu1
         4ZzGcwpyA6seMEp/FusJEN1H/Ko0yrv/u44bTSkmPSwGsLqL2AbpcwjNRzMKtOX+th8R
         Y2I8/azwTed3G1ceAhRrtALqoSJUXjY2QSAn3amuhE3LHUogIRrje8WnEut9fWO5VMSM
         C5gxu054ss4wyzloJH0W/zLPu2wo2em4vqQ1wkmL+PEGEaONtlVjNUHrTEVd91iaFNwZ
         JUU4ipPfr1tDbh7SI1N9/mw5wQCx9hu8I3QvVxjth4h01TtVQrhc+L2gle+RUL55VxnA
         Nmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZ794c1czbFaz1DBCk5cud8qffi0zVdnLWwZEp2YHM8=;
        b=BRVB76suz+azhjqCNkEFXkrR6N+CJ0+8fQvCLk+oLpzoGHPAkDAK6eZRw0E1pRWIEe
         9GzN8mzVzxIJh0LHqehi81TxBKdYxNZzF3QUB6rcoNgSiwk12Ur/ToouGB/igqd4Xt7H
         7JBs3gAs2BLWSaWSpzHxxaGGS1AE8z1txH/al4zut3ibjHbDaJWOznPSZgy9igoNDkiF
         ANZsHOLeajZjV1QHOBwYxHUQ97QUDmnCSRUUuR+xwlqYVrA++6vmb0LcaTWycdJoY8Ma
         riIfJmS+K+5lU357H15vnZfJK1gm5vINSkZCOQaxGwHX6Gpxsz5KDEOzzTzj7fljxjMT
         iPPQ==
X-Gm-Message-State: AOAM533RWrKtnBF/o+F3oFKB7idbRwWdyZJ69EuueW8U9X3YsvTHFS/k
        SOPnttq4tVgVL/uYWFLcZ0aMUhVS1UNS7Q==
X-Google-Smtp-Source: ABdhPJw0IITqP7a7V1xdvpyicdLTzL1iyiyHND2KDALDOdBnBLhbz6uMNK1SY+A30ej5Ndk+qxmJVA==
X-Received: by 2002:a1c:2c85:: with SMTP id s127mr12863500wms.83.1619337142437;
        Sun, 25 Apr 2021 00:52:22 -0700 (PDT)
Received: from localhost.localdomain (p200300d9971998009e1ae620ab52a3b7.dip0.t-ipconnect.de. [2003:d9:9719:9800:9e1a:e620:ab52:a3b7])
        by smtp.googlemail.com with ESMTPSA id n3sm12780169wmi.7.2021.04.25.00.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 00:52:22 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     1vier1@web.de, Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] ipc/util.c: Use binary search for max_idx
Date:   Sun, 25 Apr 2021 09:52:08 +0200
Message-Id: <20210425075208.11777-2-manfred@colorfullife.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210425075208.11777-1-manfred@colorfullife.com>
References: <20210425075208.11777-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If semctl(), msgctl() and shmctl() are called with IPC_INFO, SEM_INFO,
MSG_INFO or SHM_INFO, then the return value is the index of the highest
used index in the kernel's internal array recording information about
all SysV objects of the requested type for the current namespace.
(This information can be used with repeated ..._STAT or ..._STAT_ANY
operations to obtain information about all SysV objects on the system.)

There is a cache for this value. But when the cache needs up be updated,
then the highest used index is determined by looping over all possible
values. With the introduction of IPCMNI_EXTEND_SHIFT, this could be a
loop over 16 million entries. And due to /proc/sys/kernel/*next_id,
the index values do not need to be consecutive.

With <write 16000000 to msg_next_id>, msgget(), msgctl(,IPC_RMID) in
a loop, I have observed a performance increase of around factor 13000.

As there is no get_last() function for idr structures:
Implement a "get_last()" using a binary search.

As far as I see, ipc is the only user that needs get_last(), thus
implement it in ipc/util.c and not in a central location.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 ipc/util.h |  3 +++
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index cfa0045e748d..23cf5b5450ff 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -64,6 +64,7 @@
 #include <linux/memory.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/log2.h>
 
 #include <asm/unistd.h>
 
@@ -450,6 +451,41 @@ static void ipc_kht_remove(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 				       ipc_kht_params);
 }
 
+/**
+ * ipc_search_maxidx - search the highest assigned index
+ * @ids: ipc identifier set
+ * @limit: known upper limit for highest assigned index
+ *
+ * The function determines the highest assigned index in @ids. It is intended
+ * to be called when ids->max_idx needs to be updated.
+ * Updating ids->max_idx is necessary when the current highest index ipc
+ * object is deleted.
+ * If no ipc object is allocated, then -1 is returned.
+ *
+ * ipc_ids.rwsem needs to be owned by the caller.
+ */
+static int ipc_search_maxidx(struct ipc_ids *ids, int limit)
+{
+	int tmpidx;
+	int i;
+	int retval;
+
+	i = ilog2(limit+1);
+
+	retval = 0;
+	for (; i >= 0; i--) {
+		tmpidx = retval | (1<<i);
+		/*
+		 * "0" is a possible index value, thus search using
+		 * e.g. 15,7,3,1,0 instead of 16,8,4,2,1.
+		 */
+		tmpidx = tmpidx-1;
+		if (idr_get_next(&ids->ipcs_idr, &tmpidx))
+			retval |= (1<<i);
+	}
+	return retval - 1;
+}
+
 /**
  * ipc_rmid - remove an ipc identifier
  * @ids: ipc identifier set
@@ -468,11 +504,9 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	ipcp->deleted = true;
 
 	if (unlikely(idx == ids->max_idx)) {
-		do {
-			idx--;
-			if (idx == -1)
-				break;
-		} while (!idr_find(&ids->ipcs_idr, idx));
+		idx = ids->max_idx-1;
+		if (idx >= 0)
+			idx = ipc_search_maxidx(ids, idx);
 		ids->max_idx = idx;
 	}
 }
diff --git a/ipc/util.h b/ipc/util.h
index 5766c61aed0e..317c8fe15383 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -145,6 +145,9 @@ int ipcperms(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp, short flg);
  * ipc_get_maxidx - get the highest assigned index
  * @ids: ipc identifier set
  *
+ * The function returns the highest assinged index for @ids. The function
+ * doesn't scan the idr tree, it uses a cached value.
+ *
  * Called with ipc_ids.rwsem held for reading.
  */
 static inline int ipc_get_maxidx(struct ipc_ids *ids)
-- 
2.30.2

