Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18B3E4DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 22:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbhHIUgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 16:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233281AbhHIUgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628541371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cXIr/OvsNk3nnyoDdR3LnMpkUZOM2oN0kZNFXKx0yAU=;
        b=fVFZWDwx5EiNKSWG74Zsix39eKshb7k+4IJgpCG9NDGda7wXwITrQfa9aodqMz7h59jSA4
        KUdBw/xukE7of29P3C42ro/aWG/uZqxp0/m6C0xMADQ0FeJkpjNWLbKume2ml9McL6ioyf
        FCuGVhaO92SyVa13fitUPerHpyt1mLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-YocsSu31PyCrS5JpVDdU0w-1; Mon, 09 Aug 2021 16:36:09 -0400
X-MC-Unique: YocsSu31PyCrS5JpVDdU0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3383801B3C;
        Mon,  9 Aug 2021 20:36:08 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.3.128.6])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A27AC5B4BC;
        Mon,  9 Aug 2021 20:36:07 +0000 (UTC)
From:   Rafael Aquini <aquini@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Waiman Long <llong@redhat.com>
Subject: [PATCH] ipc: replace costly bailout check in sysvipc_find_ipc()
Date:   Mon,  9 Aug 2021 16:35:54 -0400
Message-Id: <20210809203554.1562989-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysvipc_find_ipc() was left with a costly way to check if the offset
position fed to it is bigger than the total number of IPC IDs in use.
So much so that the time it takes to iterate over /proc/sysvipc/* files
grows exponentially for a custom benchmark that creates "N" SYSV shm
segments and then times the read of /proc/sysvipc/shm (milliseconds):

    12 msecs to read   1024 segs from /proc/sysvipc/shm
    18 msecs to read   2048 segs from /proc/sysvipc/shm
    65 msecs to read   4096 segs from /proc/sysvipc/shm
   325 msecs to read   8192 segs from /proc/sysvipc/shm
  1303 msecs to read  16384 segs from /proc/sysvipc/shm
  5182 msecs to read  32768 segs from /proc/sysvipc/shm

The root problem lies with the loop that computes the total amount of ids
in use to check if the "pos" feeded to sysvipc_find_ipc() grew bigger than
"ids->in_use". That is a quite inneficient way to get to the maximum index
in the id lookup table, specially when that value is already provided by
struct ipc_ids.max_idx.

This patch follows up on the optimization introduced via commit 15df03c879836
("sysvipc: make get_maxid O(1) again") and gets rid of the aforementioned
costly loop replacing it by a simpler checkpoint based on ipc_get_maxidx()
returned value, which allows for a smooth linear increase in time complexity
for the same custom benchmark:

     2 msecs to read   1024 segs from /proc/sysvipc/shm
     2 msecs to read   2048 segs from /proc/sysvipc/shm
     4 msecs to read   4096 segs from /proc/sysvipc/shm
     9 msecs to read   8192 segs from /proc/sysvipc/shm
    19 msecs to read  16384 segs from /proc/sysvipc/shm
    39 msecs to read  32768 segs from /proc/sysvipc/shm

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
 ipc/util.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 0027e47626b7..d48d8cfa1f3f 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -788,21 +788,13 @@ struct pid_namespace *ipc_seq_pid_ns(struct seq_file *s)
 static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
 					      loff_t *new_pos)
 {
-	struct kern_ipc_perm *ipc;
-	int total, id;
-
-	total = 0;
-	for (id = 0; id < pos && total < ids->in_use; id++) {
-		ipc = idr_find(&ids->ipcs_idr, id);
-		if (ipc != NULL)
-			total++;
-	}
+	struct kern_ipc_perm *ipc = NULL;
+	int max_idx = ipc_get_maxidx(ids);
 
-	ipc = NULL;
-	if (total >= ids->in_use)
+	if (max_idx == -1 || pos > max_idx)
 		goto out;
 
-	for (; pos < ipc_mni; pos++) {
+	for (; pos <= max_idx; pos++) {
 		ipc = idr_find(&ids->ipcs_idr, pos);
 		if (ipc != NULL) {
 			rcu_read_lock();
-- 
2.26.3

