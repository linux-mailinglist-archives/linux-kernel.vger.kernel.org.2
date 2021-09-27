Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443A54195CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhI0OCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:48 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:64360 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhI0OCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:02:14 -0400
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 18RE07Fw028280;
        Mon, 27 Sep 2021 23:00:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 18RE07Fw028280
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1632751208;
        bh=sbbtG/svmz0yZkoEwS+QEl6uI6SK2Ial4jl+8NYu1LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vos8ho8ZBYtl4tDKRjKVnFLlrG4eMcLWMlsRfyevV5CUeJGM4sc+REIi4jOtphLAy
         ZcXhWzgOeax02PeC1EECnKCnLOz61DrKiV6luPpEShHZ/r2zGBzN9kn9SsGPLA2HJ1
         YJMkAGLscMy0dl1VAO4Xj2n47sWCtEH4M3nD9LlFMGs5zW0S8MORr18v4rWltNauKh
         K5WcwaRSs8RUL6imNoZ95bRYaWIeFZDFw7KJNciRs6AsZRtyqUV/ONDmLk+GTGySaV
         tSktkQ7I1hZHf6fGrpFDITqJD6wuQMxEHSq5UzJeRcX2U/lDSjclMTDnimXwk4rjoS
         87d+8U0hErX2g==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RESEND PATCH 1/4] block: remove redundant =y from BLK_CGROUP dependency
Date:   Mon, 27 Sep 2021 22:59:57 +0900
Message-Id: <20210927140000.866249-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927140000.866249-1-masahiroy@kernel.org>
References: <20210927140000.866249-1-masahiroy@kernel.org>
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
index 8e28ae7718bd..1d83504749e7 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -73,7 +73,7 @@ config BLK_DEV_ZONED
 
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
-	depends on BLK_CGROUP=y
+	depends on BLK_CGROUP
 	select BLK_CGROUP_RWSTAT
 	help
 	Block layer bio throttling support. It can be used to limit
@@ -112,7 +112,7 @@ config BLK_WBT_MQ
 
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
-	depends on BLK_CGROUP=y
+	depends on BLK_CGROUP
 	help
 	Enabling this option enables the .latency interface for IO throttling.
 	The IO controller will attempt to maintain average IO latencies below
@@ -132,7 +132,7 @@ config BLK_CGROUP_FC_APPID
 
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
-	depends on BLK_CGROUP=y
+	depends on BLK_CGROUP
 	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
-- 
2.30.2

