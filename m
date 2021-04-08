Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08A03583E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhDHMys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:54:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16097 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:54:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGLkv2wySz19L8g;
        Thu,  8 Apr 2021 20:52:23 +0800 (CST)
Received: from Ubuntu1804.huawei.com (10.67.174.169) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 20:54:24 +0800
From:   Zhao Xuehui <zhaoxuehui1@huawei.com>
To:     <gustavoars@kernel.org>, <sfr@canb.auug.org.au>,
        <ojeda@kernel.org>, <nathan@kernel.org>, <ndesaulniers@google.com>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>,
        <zhaoxuehui1@huawei.com>
Subject: [PATCH -next] lib: zstd: Make symbol 'HUF_compressWeights_wksp' static
Date:   Thu, 8 Apr 2021 20:54:29 +0800
Message-ID: <20210408125429.199592-1-zhaoxuehui1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.174.169]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol 'HUF_compressWeights_wksp' is not used outside of
huf_compress.c, so this commit marks it static.

Signed-off-by: Zhao Xuehui <zhaoxuehui1@huawei.com>
---
 lib/zstd/huf_compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
index fd32838c185f..1e5e001c3d41 100644
--- a/lib/zstd/huf_compress.c
+++ b/lib/zstd/huf_compress.c
@@ -79,7 +79,8 @@ unsigned HUF_optimalTableLog(unsigned maxTableLog, size_t srcSize, unsigned maxS
  * Note : all elements within weightTable are supposed to be <= HUF_TABLELOG_MAX.
  */
 #define MAX_FSE_TABLELOG_FOR_HUFF_HEADER 6
-size_t HUF_compressWeights_wksp(void *dst, size_t dstSize, const void *weightTable, size_t wtSize, void *workspace, size_t workspaceSize)
+static size_t HUF_compressWeights_wksp(void *dst, size_t dstSize, const void *weightTable,
+				       size_t wtSize, void *workspace, size_t workspaceSize)
 {
 	BYTE *const ostart = (BYTE *)dst;
 	BYTE *op = ostart;

