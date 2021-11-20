Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA47458004
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 19:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbhKTSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 13:25:49 -0500
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:53568 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhKTSZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 13:25:47 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id oV0dmDpwsozlioV0dmJ4wJ; Sat, 20 Nov 2021 19:22:43 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 20 Nov 2021 19:22:43 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] CacheFiles: Slightly optimize 'cachefiles_has_space()'
Date:   Sat, 20 Nov 2021 19:22:42 +0100
Message-Id: <92718c86a836f0d730a96b11cfc94b85edf32c19.1637432444.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <495d769a2b90ebad5f21bdfb4df3800cb5d9a627.1637432444.git.christophe.jaillet@wanadoo.fr>
References: <495d769a2b90ebad5f21bdfb4df3800cb5d9a627.1637432444.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to clear the 'struct kstatfs' buffer when calling
'vfs_statfs()', it is already be done in 'statfs_by_dentry()'. So a few
cycles can be saved here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/cachefiles/daemon.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index be8f2ec453b6..45bfc5643615 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -688,8 +688,6 @@ int cachefiles_has_space(struct cachefiles_cache *cache,
 	//       fnr, bnr);
 
 	/* find out how many pages of blockdev are available */
-	memset(&stats, 0, sizeof(stats));
-
 	ret = vfs_statfs(&path, &stats);
 	if (ret < 0) {
 		if (ret == -EIO)
-- 
2.30.2

