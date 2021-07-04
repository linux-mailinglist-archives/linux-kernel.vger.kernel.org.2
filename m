Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F093BAC73
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 11:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhGDJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 05:28:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53117 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDJ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 05:27:58 -0400
Received: from cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net ([80.193.200.194] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lzyNO-0005y5-4F; Sun, 04 Jul 2021 09:25:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs: Fix spelling mistake "adressed" -> "addressed"
Date:   Sun,  4 Jul 2021 10:25:21 +0100
Message-Id: <20210704092521.34660-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the Kconfig text. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cramfs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
index d98cef0dbb6b..a8af8c6ac15d 100644
--- a/fs/cramfs/Kconfig
+++ b/fs/cramfs/Kconfig
@@ -38,7 +38,7 @@ config CRAMFS_MTD
 	default y if !CRAMFS_BLOCKDEV
 	help
 	  This option allows the CramFs driver to load data directly from
-	  a linear adressed memory range (usually non volatile memory
+	  a linear addressed memory range (usually non volatile memory
 	  like flash) instead of going through the block device layer.
 	  This saves some memory since no intermediate buffering is
 	  necessary.
-- 
2.31.1

