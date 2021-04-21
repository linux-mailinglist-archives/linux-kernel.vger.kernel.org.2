Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F4366BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhDUNFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238604AbhDUNEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:04:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 403D76144C;
        Wed, 21 Apr 2021 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010248;
        bh=LRvEwVPSnxOLD13PeU9vl9AW59ffj/fAW5FA2vJuiPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XQeIrPy19nFqH7zaAM7EihRym6nzM+by8O8+YBtuTWNDyF7gcDeVFJhYOXLKl6f5
         4ROvb3PgXmisMz0v0BZ0XUxPoXJjW7u/4xSkkqdzJk0npfMQCmEsXBTOBPHrz9VVLv
         cR9ocOi03U1gSW3X4tR8vTKP4xwLiTppcWMXj0ec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "J . Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 065/190] Revert "nfsd: remove unnecessary assertion in nfsd4_encode_replay"
Date:   Wed, 21 Apr 2021 14:59:00 +0200
Message-Id: <20210421130105.1226686-66-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fc1b20659597015a30e8ea032f168e97848c1d39.

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
Cc: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/nfs4xdr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index eaaa1605b5b5..a3609562671c 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -5385,6 +5385,8 @@ nfsd4_encode_replay(struct xdr_stream *xdr, struct nfsd4_op *op)
 	__be32 *p;
 	struct nfs4_replay *rp = op->replay;
 
+	BUG_ON(!rp);
+
 	p = xdr_reserve_space(xdr, 8 + rp->rp_buflen);
 	if (!p) {
 		WARN_ON_ONCE(1);
-- 
2.31.1

