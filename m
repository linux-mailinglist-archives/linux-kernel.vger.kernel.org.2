Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88B8356AB3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbhDGLAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351882AbhDGK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 06:59:58 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 03:59:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so26936633ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwLQH7itFSm2lWvSOLebZG+fQhoRmoJAI/Qf0ZUUORM=;
        b=dREGV77BLNS5nloGPFiVCgMW2mQcYjeIXB2Nri9Lml4uu4+3Lxjx3GaXWm8uIflOoL
         6Soo0N4Q5UPPDDtUC9BIK9O81Tqs9Qv7+RDZJU92KLSuTda69A/gdvT/VGdte/SYSH+u
         zdZw1PnlXVF097eedirfhZiGkob343J3V7UDKnFQoGdU0vnSKo78HDj53KplQqlX4VpE
         RpmNt/r+p3eMO3HW7TxvESFC/ACaTYiJGBXNR+OFVHNlfzzAvxYDBvFvjaJmnKMV6F8A
         Y+iiUkavjIfBlUaRyzL6NaCTSn2yP51blSbrIdX83LMyo9aMMOXiCP2AJz/gyoxSMCt5
         yRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwLQH7itFSm2lWvSOLebZG+fQhoRmoJAI/Qf0ZUUORM=;
        b=kdniJ9Wz7eszj3PHgbfs6lGGTNp9tnR738a7osvEmWSFN2VDsSoUNY2Jm52M1B6ax/
         svhqxs9Hl+ll5oNr6wT2sWONe36Kh8fKB3waIA4bON73uO8suRe3bXogya0+v6+MhCFS
         tnzeV6DBiK6GLF/Fk3hzJqn/GVhIvL8Eh0wjomRUatp4QV4OfqFyTRP8evFbfPRLnsqT
         kPQMXOikLyqCyp1ZYabz+PDJ1P/DCAnJi1VCvcvCPUt1LmpUG5TEaG0UhdI/VfuKk7sq
         t9Jcmku4IL9jk8e6k0Ac412J4+OplyFdyhEUSv36OCw8+tVd1Bgm+l7Jgr21cGcr8G0h
         gBJw==
X-Gm-Message-State: AOAM531N2YYVr0lQUR0mGzje7j8fjnkD/maA3Xfq9ObpC1iTih4VZKVO
        k5Ljj5znJBPxo+TdXLyxQBx4ajSZVBygVncT
X-Google-Smtp-Source: ABdhPJwDRGzDGZdPhpP/iJmSGA40c0/2e5T0qX1y2it4MmTkeME4OsLEudIHAKZ5ra3ehPqpPJXRUQ==
X-Received: by 2002:a17:906:64f:: with SMTP id t15mr265145ejb.411.1617793186774;
        Wed, 07 Apr 2021 03:59:46 -0700 (PDT)
Received: from localhost.localdomain (p200300d997084700e354cc664d363e54.dip0.t-ipconnect.de. [2003:d9:9708:4700:e354:cc66:4d36:3e54])
        by smtp.googlemail.com with ESMTPSA id w2sm1977062eju.71.2021.04.07.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 03:59:46 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [RFC] [PATCH] ipc/util.c: Use binary search for max_idx
Date:   Wed,  7 Apr 2021 12:59:26 +0200
Message-Id: <20210407105926.198404-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If semctl(), msgctl() and shmctl() are called with IPC_INFO, SEM_INFO,
MSG_INFO or SHM_INFO, then the return value is the index of the highest
used entry in the kernel's internal array recording information about
all SysV objects of the requested type for the current namespace.
(This information can be used with repeated ..._STAT or ..._STAT_ANY
operations to obtain information about all SysV objects on the system.)

If the current highest used entry is destroyed, then the new highest
used entry is determined by looping over all possible values.
With the introduction of IPCMNI_EXTEND_SHIFT, this could be a
loop over 16 million entries.

As there is no get_last() function for idr structures:
Implement a "get_last()" using a binary search.

As far as I see, ipc is the only user that needs get_last(), thus
implement it in ipc/util.c and not in a central location.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 44 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index cfa0045e748d..0121bf6b2617 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -64,6 +64,7 @@
 #include <linux/memory.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/log2.h>
 
 #include <asm/unistd.h>
 
@@ -450,6 +451,40 @@ static void ipc_kht_remove(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 				       ipc_kht_params);
 }
 
+/**
+ * ipc_get_maxusedidx - get highest in-use index
+ * @ids: ipc identifier set
+ * @limit: highest possible index.
+ *
+ * The function determines the highest in use index value.
+ * ipc_ids.rwsem needs to be owned by the caller.
+ * If no ipc object is allocated, then -1 is returned.
+ */
+static int ipc_get_maxusedidx(struct ipc_ids *ids, int limit)
+{
+	void *val;
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
+		val = idr_get_next(&ids->ipcs_idr, &tmpidx);
+		if (val)
+			retval |= (1<<i);
+	}
+	retval--;
+	return retval;
+}
+
 /**
  * ipc_rmid - remove an ipc identifier
  * @ids: ipc identifier set
@@ -468,11 +503,10 @@ void ipc_rmid(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	ipcp->deleted = true;
 
 	if (unlikely(idx == ids->max_idx)) {
-		do {
-			idx--;
-			if (idx == -1)
-				break;
-		} while (!idr_find(&ids->ipcs_idr, idx));
+
+		idx = ids->max_idx-1;
+		if (idx >= 0)
+			idx = ipc_get_maxusedidx(ids, idx);
 		ids->max_idx = idx;
 	}
 }
-- 
2.29.2

