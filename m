Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5072350D23
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhDADa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233452AbhDADa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:30:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5DE12610EA;
        Thu,  1 Apr 2021 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617247826;
        bh=A0qkS7QWzidI3MgcCwg+Y/FUO3s2/bOI/ufSEbt+T3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gwBoG+20+/GbSNimGtHHYe0Ct0fK+JNo7QHeHVYy+vTXUg2fKhGU9MYz8RaBz9dHE
         AaWNjeisETmLSISsw70jDrX4UbaTr7aT5b07mDYPRv7eIeuOVUVH2/04YDrfyi17za
         NGPgnNZFfzIAXcboj+R8f2f+ki4SvO1uI7z+VFJy+T7MRToVr0qgXi48NWjLdHLyCH
         D9luueAapum1vC/pYxkYHUP4nJR5hNEPWwwt1sIpxM3s7L36yrRoJSBCYSwwSMf7aD
         90lxiLKt1VEbK42CbAuqMu/hz+G68JPjDYCyu3sEmwqaNhi4EK3y9mpShkze6KMOcr
         Rjwvq3VfASKNg==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2 10/10] erofs: enable big pcluster feature
Date:   Thu,  1 Apr 2021 11:29:54 +0800
Message-Id: <20210401032954.20555-11-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210401032954.20555-1-xiang@kernel.org>
References: <20210401032954.20555-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Enable COMPR_CFGS and BIG_PCLUSTER since the implementations are
all settled properly.

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

