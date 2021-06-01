Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E849239473B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbhE1SrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:47:25 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:22720 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhE1Sqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:46:54 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 14SIibCl014551;
        Sat, 29 May 2021 03:44:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 14SIibCl014551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622227478;
        bh=+BwCCEELL5xHbm5thPyHyFbhX9hUgqXt5F2QplIm71k=;
        h=From:To:Cc:Subject:Date:From;
        b=F+m+kCph/3n5rG/eNeqyyi6rPNza8RGZt6x6gsnxoRbRGKn3dyLDvgs8fGvxMlg5i
         ngdlK7v6o3xjqT4JTBGwTgNr2LS6DHAlB8bsmoCOrpV8OcMQ51R16f9ef3FUv1+GLg
         smeGPKLRLNqJb36XI1zWVonbec0QGcf+pLpBN2tv7Mm+/vNipTq4uSwUVyoNyZbZqw
         fwgW8WBxh7hQN6A6lKFeUbw6o9y2Xoe8DJNbTa07nBnKwvL5RDU90sC882zNQyKdW4
         1DQIOFwj79Yv18CrzuUBomVoOGbYlpkJZbm7xkuTyOUZAr0ar31zxtv59fxMEIGQbz
         ESk550cJ81gRQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] block: remove redundant =y from BLK_CGROUP dependency
Date:   Sat, 29 May 2021 03:44:32 +0900
Message-Id: <20210528184435.252924-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BLK_CGROUP is a boolean option, that is, its value is 'y' or 'n'.
The comparison to 'y' is redundant.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 block/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..cb56f837a4e5 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -93,7 +93,7 @@ config BLK_DEV_ZONED
 
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
-	depends on BLK_CGROUP=y
+	depends on BLK_CGROUP
 	select BLK_CGROUP_RWSTAT
 	help
 	Block layer bio throttling support. It can be used to limit
@@ -135,7 +135,7 @@ config BLK_WBT
 
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
-	depends on BLK_CGROUP=y
+	depends on BLK_CGROUP
 	help
 	Enabling this option enables the .latency interface for IO throttling.
 	The IO controller will attempt to maintain average IO latencies below
@@ -146,7 +146,7 @@ config BLK_CGROUP_IOLATENCY
 
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
-	depends on BLK_CGROUP=y
+	depends on BLK_CGROUP
 	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
-- 
2.27.0

