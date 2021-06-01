Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC99F39473D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhE1Sr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:47:28 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:22721 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbhE1Sq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:46:57 -0400
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 14SIibCn014551;
        Sat, 29 May 2021 03:44:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 14SIibCn014551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622227479;
        bh=jaxdsqU7j4qXYB8W7T2mX99WHAg3Osh1zu5S6gjlbZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8qcGC9CNy/bvxlAYsRJhlT2YZ0iCsi9TmrPkuf4zib+OULyrJA8cL22Be5xc1sI4
         paBTPZjpzqcNAyjaEy5kGZRpwqq0SS3gWWfiV0wrVjShqJXSDLrTA+wVkFz/H1i/TI
         8ZKF9qls0wKW1iVUfbVf5pDv+tZdgZLjwTnD7qVWMbCy4kb3BhEwLPD2QcRfcTyYzn
         3IXIUoU/zoagHz82n8+pEg/oB9JcwW4L0/e2x6gw83UBJUAPWM7G2xvyUFBIhKjiIp
         YQQUOVKboKcoWu+j6j6mnO8uGJmWBORYtz8Rq+Ucz2VqGWnvG1HP61Ej38qqzZrjzw
         4XqNd03lzOdiQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] block: move menu "Partition type" to block/partitions/Kconfig
Date:   Sat, 29 May 2021 03:44:34 +0900
Message-Id: <20210528184435.252924-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210528184435.252924-1-masahiroy@kernel.org>
References: <20210528184435.252924-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the menu to the relevant place.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 block/Kconfig            | 4 ----
 block/partitions/Kconfig | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 932596dbe4b4..412a6e11d0cc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -202,12 +202,8 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
-menu "Partition Types"
-
 source "block/partitions/Kconfig"
 
-endmenu
-
 config BLOCK_COMPAT
 	def_bool COMPAT
 
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 6e2a649669e5..edc2d0779814 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -2,6 +2,8 @@
 #
 # Partition configuration
 #
+menu "Partition Types"
+
 config PARTITION_ADVANCED
 	bool "Advanced partition selection"
 	help
@@ -268,3 +270,5 @@ config CMDLINE_PARTITION
 	help
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
+
+endmenu
-- 
2.27.0

