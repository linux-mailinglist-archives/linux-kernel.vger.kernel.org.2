Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3105D360D54
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbhDOPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234321AbhDOOzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:55:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 645A8613A9;
        Thu, 15 Apr 2021 14:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618498422;
        bh=hjnrXiOy1eh8Nvt+i7eLpbDfpBf5i3P8ESgLZO6JydI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zrXaKYf0W/ZqEjYh5sOZHqasFKlI3Letb7pDdYbK11C9xVS4ONhlWqPsr0sIGCdP2
         LuF1pCIGyMKeX5t+alcYDKtspVj8tESI2Yo6fvvU8L5Weg/yvEHaQ8ygpiVYYqK6LB
         KcWkTVU75q2AWcUVE1dtFSIcbvcpgeGtUb9lLDxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Muhammad Usama Anjum <musamaanjum@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 08/68] net: ipv6: check for validity before dereferencing cfg->fc_nlinfo.nlh
Date:   Thu, 15 Apr 2021 16:46:49 +0200
Message-Id: <20210415144414.743874547@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415144414.464797272@linuxfoundation.org>
References: <20210415144414.464797272@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muhammad Usama Anjum <musamaanjum@gmail.com>

commit 864db232dc7036aa2de19749c3d5be0143b24f8f upstream.

nlh is being checked for validtity two times when it is dereferenced in
this function. Check for validity again when updating the flags through
nlh pointer to make the dereferencing safe.

CC: <stable@vger.kernel.org>
Addresses-Coverity: ("NULL pointer dereference")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3283,9 +3283,11 @@ static int ip6_route_multipath_add(struc
 		 * nexthops have been replaced by first new, the rest should
 		 * be added to it.
 		 */
-		cfg->fc_nlinfo.nlh->nlmsg_flags &= ~(NLM_F_EXCL |
-						     NLM_F_REPLACE);
-		cfg->fc_nlinfo.nlh->nlmsg_flags |= NLM_F_CREATE;
+		if (cfg->fc_nlinfo.nlh) {
+			cfg->fc_nlinfo.nlh->nlmsg_flags &= ~(NLM_F_EXCL |
+							     NLM_F_REPLACE);
+			cfg->fc_nlinfo.nlh->nlmsg_flags |= NLM_F_CREATE;
+		}
 		nhn++;
 	}
 


