Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5C378E35
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbhEJNHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350821AbhEJNBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620651633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5e4lF+EcW2CIofgaxbRWvP4S+A1JaPtkxYFkqEG4BFU=;
        b=falXsY2njRXo6wA8fd6aBzyLF3rUUDEOmpU4QyIqr2IfUWmdpxpXVoU4SYL+JvuEU3h7IW
        bT6jNGPgyDCodl7oYUORRQZnJs3whX4bw4lRdBQZMOHYShhQFGWPe9fG+FOSz2USxPNxxJ
        hN5rHf59xDEE7+NCQQUD4kYE0hK0e9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-9vfABsNqObiCvrpTfIZVTA-1; Mon, 10 May 2021 09:00:31 -0400
X-MC-Unique: 9vfABsNqObiCvrpTfIZVTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6E0D5B399;
        Mon, 10 May 2021 13:00:30 +0000 (UTC)
Received: from lithium.homenet.telecomitalia.it (ovpn-115-83.ams2.redhat.com [10.36.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A8D217B83;
        Mon, 10 May 2021 13:00:28 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, dwalsh@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com
Subject: [RFC PATCH 3/3] proc: hide unknown groups in status
Date:   Mon, 10 May 2021 15:00:11 +0200
Message-Id: <20210510130011.1441834-4-gscrivan@redhat.com>
In-Reply-To: <20210510130011.1441834-1-gscrivan@redhat.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when the "shadow" mode is enabled for the user namespace, do not copy
to userspace the groups that are not mapped.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/proc/array.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 7ec59171f197..81dc733773d4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -202,9 +202,17 @@ static inline void task_state(struct seq_file *m, struct pid_namespace *ns,
 
 	seq_puts(m, "\nGroups:\t");
 	group_info = cred->group_info;
-	for (g = 0; g < group_info->ngroups; g++)
+	for (g = 0; g < group_info->ngroups; g++) {
+		gid_t gid = from_kgid(user_ns, group_info->gid[g]);
+
+		if (gid == (gid_t)-1) {
+			if (user_ns->flags & USERNS_SETGROUPS_SHADOW)
+				continue;
+			gid = overflowgid;
+		}
 		seq_put_decimal_ull(m, g ? " " : "",
-				from_kgid_munged(user_ns, group_info->gid[g]));
+				gid);
+	}
 	put_cred(cred);
 	/* Trailing space shouldn't have been added in the first place. */
 	seq_putc(m, ' ');
-- 
2.31.1

