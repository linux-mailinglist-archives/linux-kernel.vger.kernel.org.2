Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54E40F818
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244491AbhIQMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:42:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhIQMmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:42:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67AE861056;
        Fri, 17 Sep 2021 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631882441;
        bh=GpbIfTwiOxJQ58oOMSj9bCULmIYxFlhQkyVYakO9X7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y74HdFLgB9h3PGYjJYP6KC7Ne4oDYVeOZiLLjTj8J684BLLxYrjZFT86f/wFUENv7
         AYCDhsXMv4hA1Ac5bmBuzxnk5nIzYn7nGiZEq6O5Zw0/m7vImOlfUwL4I9I8QcIvUc
         4KzY4u+nPFwnc/EV0W98mSxEVegQWQg92CfZa2NugzSz3Gk0R3cztMbZbklPhbFJ7l
         fhVGpbx2No+v547iRKi9gIiGGsQexuW2IikdlMxC6MmB5pUyayXa31WhDgwZcJMao+
         mhDOffbeZvRhJY6KzlAFHu4+caU+NieIFOXR9nF+kruGy26PQN2TLzH3UmkTVjI74p
         rp0RS435dCHUw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, sj@kernel.org, linux-damon@amazon.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] MAINTAINERS: Update SeongJae's email address
Date:   Fri, 17 Sep 2021 12:39:55 +0000
Message-Id: <20210917123958.3819-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210917123958.3819-1-sj@kernel.org>
References: <20210917123958.3819-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates SeongJae's email address in MAINTAINERS file to his
preferred one.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d05b4e35e63f..774b6aac16ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5163,7 +5163,7 @@ F:	net/ax25/ax25_timer.c
 F:	net/ax25/sysctl_net_ax25.c
 
 DATA ACCESS MONITOR
-M:	SeongJae Park <sjpark@amazon.de>
+M:	SeongJae Park <sj@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/admin-guide/mm/damon/
-- 
2.17.1

