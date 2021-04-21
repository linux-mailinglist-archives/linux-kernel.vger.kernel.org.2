Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11285366B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbhDUNEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240488AbhDUNDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:03:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C506144C;
        Wed, 21 Apr 2021 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010194;
        bh=89kxREtPf2htSEjjuf1n+Ag6s1bNqHtO2rnpCeyFvqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLgM1wuDzHbpPVmIN8X0cRFvGHY0TsHTtgaTJNwov6G3W+5Kr3vTE1wTd6YvcJDWd
         DdCKyiPnJHIcz3V1BAkDUu72mnAO80dZemqhNrA6FY+Ugqz4a8UYM6ma1gnR5NaRAg
         3T7fJ1y0tn3k++vgPlKH2VO5nScpkuRFjROgfivA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qiushi Wu <wu000273@umn.edu>,
        David Howells <dhowells@redhat.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 047/190] Revert "rxrpc: Fix a memory leak in rxkad_verify_response()"
Date:   Wed, 21 Apr 2021 14:58:42 +0200
Message-Id: <20210421130105.1226686-48-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f45d01f4f30b53c3a0a1c6c1c154acb7ff74ab9f.

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

Cc: Qiushi Wu <wu000273@umn.edu>
Cc: David Howells <dhowells@redhat.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rxrpc/rxkad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index e2e9e9b0a6d7..6cdbfb4f8cda 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1241,7 +1241,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxkad_decrypt_ticket(conn, server_key, skb, ticket, ticket_len,
 				   &session_key, &expiry, _abort_code);
 	if (ret < 0)
-		goto temporary_error_free_ticket;
+		goto temporary_error_free_resp;
 
 	/* use the session key from inside the ticket to decrypt the
 	 * response */
-- 
2.31.1

