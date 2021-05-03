Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B968E3714AD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhECMAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:00:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233529AbhECL7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 07:59:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B54161185;
        Mon,  3 May 2021 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043142;
        bh=oaNbVguWIhiPgAhjzz4YEESwHcEG+fgbkMy3I2ofsuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JujJ2DLlJVgsDCduEE0DXarsozqmOhtp7VTQz+BdZzhWscDOXtIjixhvUBIOwrDVB
         BFHxE7M4TwAMVgDUXtC3dzWZ/7lIPpqwNog2k33tH9yTqZKfVrf98+gZadB2DPTzCy
         VxC38gdTx5/FBmTFG78HxIJ9icZv+VlEjo9+u0sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 14/69] Revert "net: fujitsu: fix a potential NULL pointer dereference"
Date:   Mon,  3 May 2021 13:56:41 +0200
Message-Id: <20210503115736.2104747-15-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9f4d6358e11bbc7b839f9419636188e4151fb6e4.

Because of recent interactions with developers from @umn.edu, all
commits from them have been recently re-reviewed to ensure if they were
correct or not.

Upon review, this commit was found to be incorrect for the reasons
below, so it must be reverted.  It will be fixed up "correctly" in a
later kernel change.

The original change does not change any behavior as the caller of this
function onlyu checks for "== -1" as an error condition so this error is
not handled properly.  Remove this change and it will be fixed up
properly in a later commit.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: David S. Miller <davem@davemloft.net>
Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
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

