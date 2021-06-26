Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC23B4BE9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhFZB7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 21:59:11 -0400
Received: from m12-13.163.com ([220.181.12.13]:52950 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhFZB7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 21:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SrcBE
        3S+lwaK5PLxStWIzdToklAs/6wqSigmuvAzPg4=; b=YPE8MUD4bAEuQEu/9Af64
        CO16FbBdkm52bwsxXlju07a4vKBwKifouNXJUfbHKzEZWAPkHc2bz/4Fa4nWauoL
        SM0ZfaCz+XnuJhDqV7f1Lah1HJqA7HCadtmkhDXtADBQzFkp+G686lJszDeA3NKd
        KJBG46raS02a5BVWuHOCPo=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowADHyXlBidZgdPTJIA--.60612S2;
        Sat, 26 Jun 2021 09:56:17 +0800 (CST)
From:   13145886936@163.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>,
        gushengxian <13145886936@163.com>
Subject: [PATCH v3] tools/testing/nvdimm: Remove NULL test before vfree
Date:   Fri, 25 Jun 2021 18:56:14 -0700
Message-Id: <20210626015614.517103-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowADHyXlBidZgdPTJIA--.60612S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fJw47Zw1DJr1rXr4UXFb_yoW3KFb_AF
        47trn7KFZ5JFyIka17Arn8urZ2ka15uFs7Ww4UtFn3ZrWUtr45Kwn7Grs5XF4Sgr98CFZF
        yF95CrsxJr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0StC7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGgK9g1aD+PiYxQAAsu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

This NULL test is redundant since vfree() checks for NULL.
Reported by Coccinelle.

Signed-off-by: gushengxian <13145886936@163.com>
Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/testing/nvdimm/test/nfit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 54f367cbadae..cb86f0cbb11c 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1641,8 +1641,8 @@ static void *__test_alloc(struct nfit_test *t, size_t size, dma_addr_t *dma,
  err:
 	if (*dma && size >= DIMM_SIZE)
 		gen_pool_free(nfit_pool, *dma, size);
-	if (buf)
-		vfree(buf);
+
+	vfree(buf);
 	kfree(nfit_res);
 	return NULL;
 }
-- 
2.25.1


