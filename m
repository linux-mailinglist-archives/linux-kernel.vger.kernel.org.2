Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90983E21C8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 04:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhHFCpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 22:45:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhHFCpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 22:45:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5872E6115C;
        Fri,  6 Aug 2021 02:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628217925;
        bh=4WG3Xy5a28hpnUiSoPP15oFF0Y1VPccNAl4XAoX006E=;
        h=From:To:Cc:Subject:Date:From;
        b=aH8LQa0SU+wbfB0EqM6lmUcBBLxn2Wv7+KOFcOpU/65iUzD2W0XBz4hZTj9yccKTg
         7Ee+VR/OQ1Shuiq1w5g9e+PM7ozHa30uNWUGlodS04pVCnxBtzmrERhPkH3X7sWHfe
         yskb9TNx4bcTfKItonEQXUAoPHJMWa1CQxtsHXAaiDvi0IsWkk8Uhr9OohRt1rjCYi
         CUFlZxeaWo6Ht+3OGPisGkYP/AMew39/JJhLwWsTByJRgUUea9oOcui63r6FAB4daq
         K1RRWw2Nql5lXAHeP1B+6FmggtpvW5To0WvZ4e1S/l8T7+RjzxkN5zofbDciYlTkid
         CGul8gsVgTJtw==
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: fix to keep compatibility of fault injection interface
Date:   Fri,  6 Aug 2021 10:45:20 +0800
Message-Id: <20210806024521.52089-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of FAULT_* macros and its description in f2fs.rst became
inconsistent, fix this to keep compatibility of fault injection
interface.

Fixes: 67883ade7a98 ("f2fs: remove FAULT_ALLOC_BIO")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 1 +
 fs/f2fs/f2fs.h                     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 8f251a662542..8fe1450670bb 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -185,6 +185,7 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 FAULT_KVMALLOC		  0x000000002
 			 FAULT_PAGE_ALLOC	  0x000000004
 			 FAULT_PAGE_GET		  0x000000008
+			 FAULT_ALLOC_BIO	  0x000000010 (obsolete)
 			 FAULT_ALLOC_NID	  0x000000020
 			 FAULT_ORPHAN		  0x000000040
 			 FAULT_BLOCK		  0x000000080
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8e1c2766eee2..0f4349e6979a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -43,6 +43,7 @@ enum {
 	FAULT_KVMALLOC,
 	FAULT_PAGE_ALLOC,
 	FAULT_PAGE_GET,
+	FAULT_ALLOC_BIO,	/* it's obsolete due to bio_alloc() will never fail */
 	FAULT_ALLOC_NID,
 	FAULT_ORPHAN,
 	FAULT_BLOCK,
-- 
2.22.1

