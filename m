Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3858D366C10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241515AbhDUNJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241016AbhDUNGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CB7A61454;
        Wed, 21 Apr 2021 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010359;
        bh=m+3ucLzlwy3goGwBfxWuBS1Xb3CtERzjhfWjyiMGLsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GcyWxQehf0U2srDehXY7o1z7zL25ur5nFZOYSGrhwYXHY6wXKTDChGAj07uKVeuMb
         +X7QGjUQDJFwiQNF/cjkE7ic8Uouw11oTAw5gdZgCmCCHpHqLlyvK4VaIfw0mraSxT
         GNybhK74mEU8hv25tWdDuojPvI204R1UZZMxUDto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 072/190] Revert "net: atm: Reduce the severity of logging in unlink_clip_vcc"
Date:   Wed, 21 Apr 2021 14:59:07 +0200
Message-Id: <20210421130105.1226686-73-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 60f5c4aaae452ae9252128ef7f9ae222aa70c569.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/atm/clip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/atm/clip.c b/net/atm/clip.c
index 294cb9efe3d3..a7972da7235d 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -89,7 +89,7 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 	struct clip_vcc **walk;
 
 	if (!entry) {
-		pr_err("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
+		pr_crit("!clip_vcc->entry (clip_vcc %p)\n", clip_vcc);
 		return;
 	}
 	netif_tx_lock_bh(entry->neigh->dev);	/* block clip_start_xmit() */
@@ -109,10 +109,10 @@ static void unlink_clip_vcc(struct clip_vcc *clip_vcc)
 			error = neigh_update(entry->neigh, NULL, NUD_NONE,
 					     NEIGH_UPDATE_F_ADMIN, 0);
 			if (error)
-				pr_err("neigh_update failed with %d\n", error);
+				pr_crit("neigh_update failed with %d\n", error);
 			goto out;
 		}
-	pr_err("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
+	pr_crit("ATMARP: failed (entry %p, vcc 0x%p)\n", entry, clip_vcc);
 out:
 	netif_tx_unlock_bh(entry->neigh->dev);
 }
-- 
2.31.1

