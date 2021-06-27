Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170353B5377
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 15:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhF0NfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 09:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhF0NfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 09:35:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB0761C2E;
        Sun, 27 Jun 2021 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624800758;
        bh=/MLqqw3r2VUawzFcJJCJ279yx9HsZsFtE3O6P8hbUaI=;
        h=From:To:Cc:Subject:Date:From;
        b=pN8SmqYaXDw0b1/C/nvC2cfC0RCLIH/WI1QC/7a7FmZmFwA+akkydTdOw81+M4z6Z
         afcpLBjU14RTkpvL0CEfMMbRWqmfc6GJA8YwBVZIE1TT4BIVqsdtDO9YPSfGd7Ei7S
         U+j7swcLMsxc7Bj/VRNvL3y4fYD+/Q/oyJairfo2+MflxRXNfpYFzXdjeiVuWVPa8C
         NXV/BYjarH5yciy8n8wk2YyAhaDtmqm0djryVO959rBhcmcl52VCAq7IoEVLliH+PB
         jfxqk8gm40gIf9cAQQD9qn42ZNninpAE8LMZTKLVqrZdQhCae+YAHbryFSL+qdgrqw
         gZ+XKLJfFTcXQ==
From:   Chao Yu <chao@kernel.org>
To:     linux-erofs@lists.ozlabs.org
Cc:     xiang@kernel.org, linux-kernel@vger.kernel.org, chao@kernel.org
Subject: [PATCH] MAINTAINERS: erofs: update my email address
Date:   Sun, 27 Jun 2021 21:32:29 +0800
Message-Id: <20210627133229.8025-1-chao@kernel.org>
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
index 93ce2b8c1b44..7fa367400f7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6763,7 +6763,7 @@ F:	include/video/s1d13xxxfb.h
 
 EROFS FILE SYSTEM
 M:	Gao Xiang <xiang@kernel.org>
-M:	Chao Yu <yuchao0@huawei.com>
+M:	Chao Yu <chao@kernel.org>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
-- 
2.22.1

