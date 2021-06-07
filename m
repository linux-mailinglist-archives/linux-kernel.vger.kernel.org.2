Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD539EA25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 01:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFGXdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 19:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhFGXdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 19:33:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB0F561182;
        Mon,  7 Jun 2021 23:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623108689;
        bh=VU3/5+i8dI+KU7+2oF0H2q925ejEATiZRYicF58gOpE=;
        h=From:To:Cc:Subject:Date:From;
        b=CtIRBqEImKtUzJ/zPHBRCesDTVKkw/YSOGgo9FGmByItv3spNtH/s4dFadFxkz6nk
         KNJYJIARzw0FFrkwhKHo9ilsBH1ZvuBaL8f4WnjD2QxsQat0Q60dbI2NOmTK+x7Y3n
         fOuOavNmcBhnTxDLemDi6YhaD0nhcbATnLJ1qzSwQrHdWVKCZaFuu/1utDDCDN++5k
         xd/6K3mmhuwlYWlmJ0c6VEBGbFAzYFHIsTwt++TOmkds7haEHDmyq2DYFp6/DH+AR1
         aj/kI0vO35q3pgtyrhPLr1XMsIVh8Mb2e42NezDJZC8txUQtYad4AosOoC2H0K2j77
         MDSZQnejmPSgg==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] f2fs: fix to avoid adding tab before doc section
Date:   Tue,  8 Jun 2021 07:31:22 +0800
Message-Id: <20210607233122.3946-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Otherwise whole section after tab will be invisible in compiled
html format document.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Fixes: 89272ca1102e ("docs: filesystems: convert f2fs.txt to ReST")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 Documentation/filesystems/f2fs.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 809c4d0a696f..b91e5a8444d5 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -720,10 +720,10 @@ users.
 ===================== ======================== ===================
 User                  F2FS                     Block
 ===================== ======================== ===================
-                      META                     WRITE_LIFE_NOT_SET
-                      HOT_NODE                 "
-                      WARM_NODE                "
-                      COLD_NODE                "
+N/A                   META                     WRITE_LIFE_NOT_SET
+N/A                   HOT_NODE                 "
+N/A                   WARM_NODE                "
+N/A                   COLD_NODE                "
 ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
 extension list        "                        "
 
@@ -749,10 +749,10 @@ WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
 ===================== ======================== ===================
 User                  F2FS                     Block
 ===================== ======================== ===================
-                      META                     WRITE_LIFE_MEDIUM;
-                      HOT_NODE                 WRITE_LIFE_NOT_SET
-                      WARM_NODE                "
-                      COLD_NODE                WRITE_LIFE_NONE
+N/A                   META                     WRITE_LIFE_MEDIUM;
+N/A                   HOT_NODE                 WRITE_LIFE_NOT_SET
+N/A                   WARM_NODE                "
+N/A                   COLD_NODE                WRITE_LIFE_NONE
 ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
 extension list        "                        "
 
-- 
2.22.1

