Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB03FF9F8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235929AbhICFVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhICFVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:21:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67DC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 22:20:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b6so6416210wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8CsD/IQR9tP0OgLFxu52jOE54ZhCfnaO0moGXcPDT1o=;
        b=Yvm5jRNHOPfXQE4T8HSPfX0jwf1zcuDmLOcXBgD9+Ptlh3XQc4GW/bDGZhQSuZbNUA
         eIqHA0jbQpt+9WM5ql/2Nysi0JKWVlLXhxNl3UbThLUtryQM+sNBoRTylKg2WZK+mlCH
         ff/Dw9uzWmcst9T6yDwpLjXGhbmGIHZvdFEVc9cjEKlHn+RWFZHePUneqI7MDgfmzXXh
         UKaoQHI0knubzh+FOM+UMFiqdCwOARPsJw/YKhWTB1I0c2HNLmP8nMeIUNNZn+sy6jlT
         A5BNcQcr+Q/jB/gg1SRGbYNtwV3NnGCjb5NbBsjH49YON581TMl5cMVdNuqfA+vD6v+O
         CZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8CsD/IQR9tP0OgLFxu52jOE54ZhCfnaO0moGXcPDT1o=;
        b=WGOozvVgHzlJe2DkZl9D0RI/4pdE5tXO6utmAEA28Yt54Gy1H99T+0Hgg09igPqa26
         qhowN9xWWzfYCJ6MZbx5gtNbqIfcBWI78fxq2Q1mgT6n7M+tp71skQh52LsM4Cikt9oQ
         xSQriq3PGCLj2MFy172u0exeQo5lvy/j5v1dQkef+dLUTm9JSt7h3Cv4yss3m6NcpIC7
         dsVNGQY+TJ2O3ctRMrhmpq0hFBJlvhNwZabViQtAu7mNtHHA8/J9pFtgTbcfglwmrJhd
         nfT053UL01fxOn9WZPvKVrNKuqvo5t8ggk7FD0pm6zRg9HDrSZrPx6909VwZKrdpnRvx
         qnjA==
X-Gm-Message-State: AOAM530zIK4/1ctlz4/kiTd/BcLIMxf+JEGYcZaZ0p1J9saesnSArwwz
        Y8TWag8KoIGw/tfKGIn5PnLCczhgyZFYruuk
X-Google-Smtp-Source: ABdhPJyNHMvht0t5yFk+Ve1fguN4kWKfCMbKGVzJ8iZ0a+8MgUgLhMoxUvdeMqhSJZ/6xucF9AWOjA==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr1757521wrq.213.1630646434158;
        Thu, 02 Sep 2021 22:20:34 -0700 (PDT)
Received: from localhost.localdomain (p200300d997085c0087ad16bce8a07868.dip0.t-ipconnect.de. [2003:d9:9708:5c00:87ad:16bc:e8a0:7868])
        by smtp.googlemail.com with ESMTPSA id m4sm3313987wmc.3.2021.09.02.22.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:20:33 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 2/2] ipc/util.c: Cleanup and improve sysvipc_find_ipc(), V2
Date:   Fri,  3 Sep 2021 07:20:20 +0200
Message-Id: <20210903052020.3265-3-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903052020.3265-1-manfred@colorfullife.com>
References: <20210903052020.3265-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysvipc_find_ipc() can be simplified further:

- It uses a for() loop to locate the next entry in the idr.
  This can be replaced with idr_get_next().

- It receives two parameters (pos - which is actually
  and idr index and not a position, and new_pos, which
  is really a position).
  One parameter is sufficient.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 53 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index d48d8cfa1f3f..bc5000b2457a 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -782,28 +782,37 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 	return iter->pid_ns;
 }
 
-/*
- * This routine locks the ipc structure found at least at position pos.
+/**
+ * sysvipc_find_ipc - Find and lock the ipc structure based on seq pos
+ * @ids: ipc identifier set
+ * @pos: expected position
+ *
+ * The function finds an ipc structure, based on the sequence file
+ * position @pos. If there is no ipc structure at position @pos, then
+ * the successor is selected.
+ * If a structure is found, then it is locked (both rcu_read_lock() and
+ * ipc_lock_object()) and  @pos is set to the position needed to locate
+ * the found ipc structure.
+ * If nothing is found (i.e. EOF), @pos is not modified.
+ *
+ * The function returns the found ipc structure, or NULL at EOF.
  */
-static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
-					      loff_t *new_pos)
+static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t *pos)
 {
-	struct kern_ipc_perm *ipc = NULL;
-	int max_idx = ipc_get_maxidx(ids);
+	int tmpidx;
+	struct kern_ipc_perm *ipc;
 
-	if (max_idx == -1 || pos > max_idx)
-		goto out;
+	/* convert from position to idr index -> "-1" */
+	tmpidx = *pos - 1;
 
-	for (; pos <= max_idx; pos++) {
-		ipc = idr_find(&ids->ipcs_idr, pos);
-		if (ipc != NULL) {
-			rcu_read_lock();
-			ipc_lock_object(ipc);
-			break;
-		}
+	ipc = idr_get_next(&ids->ipcs_idr, &tmpidx);
+	if (ipc != NULL) {
+		rcu_read_lock();
+		ipc_lock_object(ipc);
+
+		/* convert from idr index to position  -> "+1" */
+		*pos = tmpidx + 1;
 	}
-out:
-	*new_pos = pos + 1;
 	return ipc;
 }
 
@@ -817,11 +826,13 @@ static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
 	if (ipc && ipc != SEQ_START_TOKEN)
 		ipc_unlock(ipc);
 
-	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], *pos, pos);
+	/* Next -> search for *pos+1 */
+	(*pos)++;
+	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], pos);
 }
 
 /*
- * File positions: pos 0 -> header, pos n -> ipc id = n - 1.
+ * File positions: pos 0 -> header, pos n -> ipc idx = n - 1.
  * SeqFile iterator: iterator value locked ipc pointer or SEQ_TOKEN_START.
  */
 static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
@@ -846,8 +857,8 @@ static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	/* Find the (pos-1)th ipc */
-	return sysvipc_find_ipc(ids, *pos - 1, pos);
+	/* Otherwise return the correct ipc structure */
+	return sysvipc_find_ipc(ids, pos);
 }
 
 static void sysvipc_proc_stop(struct seq_file *s, void *it)
-- 
2.31.1

