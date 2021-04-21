Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AB0366C04
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235456AbhDUNKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241059AbhDUNHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:07:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4F1161476;
        Wed, 21 Apr 2021 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010427;
        bh=sJSw6qt9LXj+9OtwxYG1zowOAe5ygGGsGComf4kfhs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iyipivLPM4ox1E48pvzDtUFHOy8/0g2PxN2XIQ4dLhM88Au0e5Jukv5bnAGc8xTcU
         JYaO3PZQrK0JCmrrOhLI8s9iXcXRqhWH9Q8jCUzyxRG5ALmyTeocpCvsKuRHDSWE7M
         Fkk2NrFBAziuICqLBsdQtb4JD4jXJ6LXz1yuyTfY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 132/190] Revert "net: fujitsu: fix a potential NULL pointer dereference"
Date:   Wed, 21 Apr 2021 15:00:07 +0200
Message-Id: <20210421130105.1226686-133-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9f4d6358e11bbc7b839f9419636188e4151fb6e4.

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

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
index a7b7a4aace79..dc90c61fc827 100644
--- a/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
+++ b/drivers/net/ethernet/fujitsu/fmvj18x_cs.c
@@ -547,11 +547,6 @@ static int fmvj18x_get_hwinfo(struct pcmcia_device *link, u_char *node_id)
 	return -1;
 
     base = ioremap(link->resource[2]->start, resource_size(link->resource[2]));
-    if (!base) {
-	    pcmcia_release_window(link, link->resource[2]);
-	    return -ENOMEM;
-    }
-
     pcmcia_map_mem_page(link, link->resource[2], 0);
 
     /*
-- 
2.31.1

