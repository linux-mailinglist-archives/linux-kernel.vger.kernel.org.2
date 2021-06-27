Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401FA3B5371
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhF0NcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230225AbhF0NcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEC176144E;
        Sun, 27 Jun 2021 13:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624800599;
        bh=2uC2toy+ka1uze6VAxg44Fq+lJlePnzUG0woD9XSRg4=;
        h=From:To:Cc:Subject:Date:From;
        b=PNVPMXMoUnW+DEZBbSb3wju7VDxdr6yVpRaDihJbGu4jR4+ab3QfoNTWd2eJ9V2ZZ
         rwa7H2UJeA9oB47TRQ6tWW/KonDVlD/vZtz8+fD0vLz3ep+R6KOts7J6XeUPMk5jOR
         gVVZxzjJq58ih5J9NZ0lIWVRC9UXAGBEgZAS+W3niPxTgb8KcAma7eWwpNYsSLp2h+
         4pLXCrGtlRbFNMgqvRFcZaQLYvtjGQ4UgfplcMCPdZquKgOXAbOTbA/MaF4zN9s2eo
         2iNrqumiFIoF0OAU5Gzxu9LStVl6/I/daaNBueNl8yG88mTzDJzB+MumrZsfRzBubA
         hpVw7KUdr0j8A==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: [PATCH] MAINTAINERS: f2fs: update my email address
Date:   Sun, 27 Jun 2021 21:29:18 +0800
Message-Id: <20210627132918.7956-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old email address will be invalid after a few days, update it
to kernel.org one.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fa367400f7d..d19d825be1de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6903,7 +6903,7 @@ F:	drivers/iommu/exynos-iommu.c
 
 F2FS FILE SYSTEM
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
-M:	Chao Yu <yuchao0@huawei.com>
+M:	Chao Yu <chao@kernel.org>
 L:	linux-f2fs-devel@lists.sourceforge.net
 S:	Maintained
 W:	https://f2fs.wiki.kernel.org/
-- 
2.22.1

