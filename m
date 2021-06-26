Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426513B4BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhFZCIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 22:08:48 -0400
Received: from m12-17.163.com ([220.181.12.17]:38758 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhFZCIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 22:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=5CAK0
        +ktE6BZ4jyQ2xXHcEmvm7SgPXIFo2AsgHUAxzY=; b=GlEkUG9bVD2T2pjRgfmP9
        xUEW8rpnTHI9sBZIXJoVqBN5R/cog3AcScHfBDdWHp1atcChOCvA5EirhHMhWR8A
        Fc9CI2KXI5iKjpK1UtMni726jv83KtPSV2+n5iCxyHRqtUL/aMgV7rorQbTsLDE9
        xwa5tWwDylz8vPQ3kVA+6A=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp13 (Coremail) with SMTP id EcCowABHJW2Xi9Zg9NBd9g--.54253S2;
        Sat, 26 Jun 2021 10:06:16 +0800 (CST)
From:   13145886936@163.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>,
        gushengxian <13145886936@163.com>
Subject: [PATCH] ndtest: Remove NULL test before vfree
Date:   Fri, 25 Jun 2021 19:06:13 -0700
Message-Id: <20210626020613.517758-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowABHJW2Xi9Zg9NBd9g--.54253S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fJw47ur1UGr4fWF15urg_yoWfJrb_AF
        42qr92kFWkJryxCa17Arn8uFWIka15urs7W3ya9FnxA34jy3y5KwnrWrn5GF4xWr95GF9r
        tr9YyrsxGr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0Tv3UUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGhi9g1aD+Pi3YgAAs8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

This NULL test is redundant since vfree() checks for NULL.
Reported by Coccinelle.

Signed-off-by: gushengxian <13145886936@163.com>
Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/testing/nvdimm/test/ndtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 6862915f1fb0..b1025c08ba92 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -487,8 +487,8 @@ static void *ndtest_alloc_resource(struct ndtest_priv *p, size_t size,
 buf_err:
 	if (__dma && size >= DIMM_SIZE)
 		gen_pool_free(ndtest_pool, __dma, size);
-	if (buf)
-		vfree(buf);
+
+	vfree(buf);
 	kfree(res);
 
 	return NULL;
-- 
2.25.1


