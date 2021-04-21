Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48770366BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239958AbhDUNHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:07:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240750AbhDUNFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:05:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7BB661457;
        Wed, 21 Apr 2021 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010297;
        bh=VRXrU0i3Ic6P5Dh19UvKcB9+YhPl3m8eVgbbZCEvtk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKS7KPxLQQ13N8eXfOicQ8r3TA22JGQuwVtd79txOI1CZCLtAj54Db/eqUWAat7IV
         PNxNsmPPuIJDJcvwMEJOcQFXFSZmGxiIFaMW7C8lBgSXwJpF4I84S/2Q0FQQiptQUm
         yizRYsOOp15fktbCz3C7M6sbaGf4kZObauIgl/pM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 085/190] Revert "audit: fix a memory leak bug"
Date:   Wed, 21 Apr 2021 14:59:20 +0200
Message-Id: <20210421130105.1226686-86-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 70c4cf17e445264453bc5323db3e50aa0ac9e81f.

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

Cc: Wenwen Wang <wang6495@umn.edu>
Cc: Richard Guy Briggs <rgb@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/auditfilter.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 333b3bcfc545..19f908b96000 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1125,24 +1125,22 @@ int audit_rule_change(int type, int seq, void *data, size_t datasz)
 	int err = 0;
 	struct audit_entry *entry;
 
+	entry = audit_data_to_entry(data, datasz);
+	if (IS_ERR(entry))
+		return PTR_ERR(entry);
+
 	switch (type) {
 	case AUDIT_ADD_RULE:
-		entry = audit_data_to_entry(data, datasz);
-		if (IS_ERR(entry))
-			return PTR_ERR(entry);
 		err = audit_add_rule(entry);
 		audit_log_rule_change("add_rule", &entry->rule, !err);
 		break;
 	case AUDIT_DEL_RULE:
-		entry = audit_data_to_entry(data, datasz);
-		if (IS_ERR(entry))
-			return PTR_ERR(entry);
 		err = audit_del_rule(entry);
 		audit_log_rule_change("remove_rule", &entry->rule, !err);
 		break;
 	default:
+		err = -EINVAL;
 		WARN_ON(1);
-		return -EINVAL;
 	}
 
 	if (err || type == AUDIT_DEL_RULE) {
-- 
2.31.1

