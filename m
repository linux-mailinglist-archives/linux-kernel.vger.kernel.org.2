Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F383562A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 06:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbhDGEkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 00:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243353AbhDGEkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 00:40:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60A86613C2;
        Wed,  7 Apr 2021 04:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617770398;
        bh=L0+TDR9iNfjQDeT5DyA+eksw7ZyuVzgfBc5jhJv/al0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7oReCkwfWoFco32a4jQ4iDzAhVCVoTMc3QQs4QcYvg4Ohq4yQE5SFaKK2wUYWdMd
         u8meKqGP9sCKe4R/hD+1/7NJhx/Z21lLlD76x3rqYnXsRbYlqKlT6QDHRmnYaFiI/f
         viplH1RIdZk7pZSSWe0jLIvTaoNUZh0cKPIE9l8VNz3N39b4aamFDoT8O8BM8oZTCU
         zGBGhEHzgJ7IbemSnsOWjjO7L9UEBd+s6o09rGi25SspnZ+bc+ZhihlZ3vkkwltIqV
         bsHmxgYVQsFvaRBGxgbPsYSD3iJ21eSZ262Dloap8xeOBorSdjUqcwgP3OeLEzqRbl
         WTA37MW0BzgWA==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v3 10/10] erofs: enable big pcluster feature
Date:   Wed,  7 Apr 2021 12:39:27 +0800
Message-Id: <20210407043927.10623-11-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407043927.10623-1-xiang@kernel.org>
References: <20210407043927.10623-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Enable COMPR_CFGS and BIG_PCLUSTER since the implementations are
all settled properly.

Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index ecc3a0ea0bc4..8739d3adf51f 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -20,7 +20,10 @@
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
-#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_ALL_FEATURE_INCOMPAT		\
+	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
-- 
2.20.1

