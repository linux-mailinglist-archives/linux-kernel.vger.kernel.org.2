Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B49366C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbhDUNI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239792AbhDUNGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:06:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF34B61456;
        Wed, 21 Apr 2021 13:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010356;
        bh=xyKRLiAsNPk0vNJs+zp5ArFimlX5BPhJ5AEEvgzXO4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GWdnFXLb6VDH+FgP40tjOkbk4IAi7rs/B2NOQk9TV5ZXZEeDREc9yN1QfS8RZ33tc
         Cg4AQptZSm6IJxKwCpcgpn+/p15lC1t2Jmg9N5FBl4rAHxNUnwoNMwtb+OXIPnn2/b
         tOKbN5aBCl60bBca83XeiC1nXO1H41WpQScOvgTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 071/190] Revert "pppoe: remove redundant BUG_ON() check in pppoe_pernet"
Date:   Wed, 21 Apr 2021 14:59:06 +0200
Message-Id: <20210421130105.1226686-72-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 02a896ca84874bbfcedc006303f2951dda89b298.

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
 drivers/net/ppp/pppoe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index d7f50b835050..803a4fe1ca18 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -119,6 +119,8 @@ static inline bool stage_session(__be16 sid)
 
 static inline struct pppoe_net *pppoe_pernet(struct net *net)
 {
+	BUG_ON(!net);
+
 	return net_generic(net, pppoe_net_id);
 }
 
-- 
2.31.1

