Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3093FAB3E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbhH2MFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhH2MFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:05:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B631C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:04:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x6so9807371wrv.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXarIEf3Eu82f1SREfiWNMAo02WyNNf/Dn/EQW6j7qo=;
        b=YpNoaAcMPACYo1UEFo4Wx+a1YX+s60Q1T80CX6gT1J7RtsA2koAhHxNxtGgFvxB1Ab
         H0JvNeBALI5Yv/VrPWVei/eb3N0sBgntyGWT2vhEpHpeNsZ9GGAzCqNwhdqD0+SD0eRL
         i0yy/mZUGZOpbEeuCprgtixm+o8kwsJIRjcwNCzjOuTe/DF5hqYPN6dY8OQJgp6Sx+K9
         //x7GQCid8IOP8IcBhp1t2hFt7v5qmihy/X6pMy4qv+DQ4ARJV99cUmgxfBT7iZmXhJr
         C4TkLfWepwB8cGWWb4Wx6yzIVBGlq5EakA+nhPHwzzy6nlY9vRVKyTs9ogQkyrlgR9G9
         FDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YXarIEf3Eu82f1SREfiWNMAo02WyNNf/Dn/EQW6j7qo=;
        b=sR1z8y2vhJ8uRGY3+Q+VTs+1+Exrcpj87UO68vCnvIiRZfo7oQ1sXPphbXJdTby1Rn
         Ys1zsaZctqyPPCWh4EGLsPozZPzg7jLH3OXEj3WfuwHBEn+LONnZho9mwXmL4Y4Ahlk1
         EI5xMN0sLjnfEQveNimLumT0hJwcoJFhanSAdA5f4ZQmYpiC2a+gzzCnefJ+RIZfOk2u
         /svLEJMca5UoGB04uBy4Fq3DiQkbTvLM06fJof9z/iEzGINSgbDZsYXnFTz7UxL7MVER
         D3UuTylWEsu2SJhrcNV46ao4D5g5jW+WTSxQm7lHc4V2dRLLTekH0/MLX3OpvSbmrvNO
         /tPQ==
X-Gm-Message-State: AOAM533K0y6xLJQTEdgkueTy/xS6NlP89nou3zneuhBoTVjoKO1TqLkt
        RoN/WICEoWt7c+C4wSbFnHzs2NelWvjlZA==
X-Google-Smtp-Source: ABdhPJy6NMAdkJqC6wTYPfXWxfng5twSq+N9B8UjcyQ26/ZUAJ574LbuQBXEYcUqwfMdasv5sgQ+qA==
X-Received: by 2002:adf:c149:: with SMTP id w9mr5354194wre.127.1630238697757;
        Sun, 29 Aug 2021 05:04:57 -0700 (PDT)
Received: from localhost.localdomain (p200300d9974e0200c40f2ed5742eced6.dip0.t-ipconnect.de. [2003:d9:974e:200:c40f:2ed5:742e:ced6])
        by smtp.googlemail.com with ESMTPSA id b18sm12309036wrr.89.2021.08.29.05.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 05:04:57 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, 1vier1@web.de,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] ipc/util.c: Cleanup and improve sysvipc_find_ipc()
Date:   Sun, 29 Aug 2021 14:04:50 +0200
Message-Id: <20210829120450.49971-1-manfred@colorfullife.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) sysvipc_find_ipc() is a bit difficult to understand:
> static struct kern_ipc_perm *sysvipc_find_ipc(
>                          (struct ipc_ids *ids, loff_t pos,
>                          loff_t *new_pos)

@pos is not a sequence file position, it is an index in the idr.
@new_pos is the sequence file position.

In addition, there are not commented conversions from pos to idr.

e.g.:
> return sysvipc_find_ipc(&iter->ns->ids[iface->ids], *pos, pos);

The call tries to find the successor to the sequence file entry
with position *pos.
Thus:
> *pos +1 /* +1 for successor */ -1 /* -1 for conversion to idx */
which is shortened to *pos.

2) sysvipc_find_ipc() uses a for loop to find the next entry,
instead of using idr_get_next().

The patch tries to fix both issues.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 75 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index d48d8cfa1f3f..469d369310f1 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -782,28 +782,64 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 	return iter->pid_ns;
 }
 
-/*
- * This routine locks the ipc structure found at least at position pos.
+/**
+ * sysvipc_pos_to_index - convert seqfile pos to idr index
+ * @pos: position
+ *
+ * For the sequence file, pos=0 is used for the header line.
+ * Thus "real" ipc entries start at pos=1, with index = pos-1;
+ *
+ */
+static inline int sysvipc_pos_to_index(int pos)
+{
+	return pos-1;
+}
+
+/**
+ * sysvipc_index_to_pos - convert idr index to seqfile pos
+ * @pos: position
+ *
+ * For the sequence file, pos=0 is used for the header line.
+ * Thus "real" ipc entries start at pos=1, with pos = index+1;
+ */
+static inline int sysvipc_index_to_pos(int idx)
+{
+	return idx+1;
+}
+
+/**
+ * sysvipc_find_ipc - Find and lock the ipc structure based on seq pos
+ * @ids: ipc identifier set
+ * @pos: expected position
+ * @new_pos: actual position of the found ipc structure
+ *
+ * The function finds an ipc structure, based on the sequence file
+ * position @pos. If there is no ipc structure at position @pos, then
+ * the successor is selected.
+ * If a structure is found, then it is locked (both rcu_read_lock() and
+ * ipc_lock_object()) and  @new_pos is set to the position needed to locate
+ * the found ipc structure.
+ * If nothing is found (i.e. EOF), @new_pos is set to the input position.
+ *
+ * The function returns the found ipc structure, or NULL at EOF.
  */
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc = NULL;
-	int max_idx = ipc_get_maxidx(ids);
+	int tmpidx;
+	struct kern_ipc_perm *ipc;
 
-	if (max_idx == -1 || pos > max_idx)
-		goto out;
+	tmpidx = sysvipc_pos_to_index(pos);
 
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
+		*new_pos = sysvipc_index_to_pos(tmpidx);
+	} else {
+		*new_pos = pos;
 	}
-out:
-	*new_pos = pos + 1;
 	return ipc;
 }
 
@@ -817,11 +853,12 @@ static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
 	if (ipc && ipc != SEQ_START_TOKEN)
 		ipc_unlock(ipc);
 
-	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], *pos, pos);
+	/* Next -> search for *pos+1 */
+	return sysvipc_find_ipc(&iter->ns->ids[iface->ids], *pos+1, pos);
 }
 
 /*
- * File positions: pos 0 -> header, pos n -> ipc id = n - 1.
+ * File positions: pos 0 -> header, pos n -> ipc idx = n - 1.
  * SeqFile iterator: iterator value locked ipc pointer or SEQ_TOKEN_START.
  */
 static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
@@ -846,8 +883,8 @@ static void *sysvipc_proc_start(struct seq_file *s, loff_t *pos)
 	if (*pos == 0)
 		return SEQ_START_TOKEN;
 
-	/* Find the (pos-1)th ipc */
-	return sysvipc_find_ipc(ids, *pos - 1, pos);
+	/* Otherwise return the correct ipc structure */
+	return sysvipc_find_ipc(ids, *pos, pos);
 }
 
 static void sysvipc_proc_stop(struct seq_file *s, void *it)
-- 
2.31.1

