Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8031C3C6068
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhGLQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:27:24 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:45336
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233609AbhGLQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:27:20 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B36104049F;
        Mon, 12 Jul 2021 16:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1626107070;
        bh=nzUQ5PQkQlYn/Cllz//w9vdJHqABUsXTabedhTI0/K4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=RY1+fQlFVSitDYQDBfHlgiutDVkphMnUDk0iOZpE5+aFNj6+ACLQJ4F1C753bqkBU
         MNqz1azyPoK47wkwzwja8fRoWEZzg067AKndURsdKknu8gm/87UL//adRoZwhIhgnI
         21kj8EclG039FiMUtKy0rKU4oimdaq7omQzD1CT/5McMqfEovGzPrIOhK/I9D4rOKn
         fhh7r9w+eovE9+euRyz9q1Ryhn9KBcCcluwkSdbotPAIQoHVDnX4i11K7Sx3PaWghX
         PBnB5IDjav+f1c9KGEw9pOoEC/wqkw92GsteVnxa8EOBO/Ri2u07mHu3LuyJSeOF7m
         vyxjfDS9+ZOAA==
From:   Colin King <colin.king@canonical.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Abhi Das <adas@redhat.com>, cluster-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gfs2: Fix memory leak of object lsi on error return path
Date:   Mon, 12 Jul 2021 17:24:30 +0100
Message-Id: <20210712162430.104913-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the case where IS_ERR(lsi->si_sc_inode) is true the error exit path
to free_local does not kfree the allocated object lsi leading to a memory
leak. Fix this by kfree'ing lst before taking the error exit path.

Addresses-Coverity: ("Resource leak")
Fixes: 97fd734ba17e ("gfs2: lookup local statfs inodes prior to journal recovery")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/gfs2/ops_fstype.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 5f4504dd0875..bd3b3be1a473 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -677,6 +677,7 @@ static int init_statfs(struct gfs2_sbd *sdp)
 			error = PTR_ERR(lsi->si_sc_inode);
 			fs_err(sdp, "can't find local \"sc\" file#%u: %d\n",
 			       jd->jd_jid, error);
+			kfree(lsi);
 			goto free_local;
 		}
 		lsi->si_jid = jd->jd_jid;
-- 
2.31.1

