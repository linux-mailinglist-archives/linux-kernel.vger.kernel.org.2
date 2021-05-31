Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64B93965D8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhEaQuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234084AbhEaO5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 10:57:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0086561939;
        Mon, 31 May 2021 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622469620;
        bh=YuISmcruBEAixGzhoO6eLY8HJJ4fJupbjUIXhe4O5BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wYW0P1rF+JMQtFcrI3IIX1YZhf98LXA2vBArEdjN5ysUhYDcoUPCv1FPocGCIxNOa
         L53UN7qfMZsMuUhz7Dk7zZDDAP2aX+lgwLtyUVY1IFk5VJSxwbpNn00lGKt57IuZY1
         kFZVHhrBnIrYegUbMt33Ek0LF3NOHsyDunP+6UUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 267/296] staging: emxx_udc: fix loop in _nbu2ss_nuke()
Date:   Mon, 31 May 2021 15:15:22 +0200
Message-Id: <20210531130712.717176506@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531130703.762129381@linuxfoundation.org>
References: <20210531130703.762129381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e0112a7c9e847ada15a631b88e279d547e8f26a7 ]

The _nbu2ss_ep_done() function calls:

	list_del_init(&req->queue);

which means that the loop will never exit.

Fixes: ca3d253eb967 ("Staging: emxx_udc: Iterate list using list_for_each_entry")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/YKUd0sDyjm/lkJfJ@mwanda
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/emxx_udc/emxx_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3536c03ff523..0d50c1e190bf 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -2065,7 +2065,7 @@ static int _nbu2ss_nuke(struct nbu2ss_udc *udc,
 			struct nbu2ss_ep *ep,
 			int status)
 {
-	struct nbu2ss_req *req;
+	struct nbu2ss_req *req, *n;
 
 	/* Endpoint Disable */
 	_nbu2ss_epn_exit(udc, ep);
@@ -2077,7 +2077,7 @@ static int _nbu2ss_nuke(struct nbu2ss_udc *udc,
 		return 0;
 
 	/* called with irqs blocked */
-	list_for_each_entry(req, &ep->queue, queue) {
+	list_for_each_entry_safe(req, n, &ep->queue, queue) {
 		_nbu2ss_ep_done(ep, req, status);
 	}
 
-- 
2.30.2



