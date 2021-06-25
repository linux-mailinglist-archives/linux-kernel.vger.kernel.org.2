Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF203B3D54
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFYH3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:29:53 -0400
Received: from m12-11.163.com ([220.181.12.11]:48166 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhFYH3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DxN/L
        Pd+DwEs1NBhUB8MHzk5X1iVPZi8nze07XcdyUs=; b=MnxI2MpZQNNwz3INVUr0K
        9T668ihARLnjmsK1edrxE6vNvz9z4pIRMHJB4Q1URPvVqgKtIBXC2jzjoKaeMm3i
        OEeX3TQR6W13ICyuHh6gO9wnDuDJKfKWRwW3UVSbHpY3Hns+wXpu3SToRn/YZtPw
        fEEngUNFuVjjzZ2E5t5ofo=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAAndp5GhdVgL1oUjw--.24889S2;
        Fri, 25 Jun 2021 15:27:03 +0800 (CST)
From:   13145886936@163.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] tools/testing/nvdimm: NULL check before vfree() is not needed
Date:   Fri, 25 Jun 2021 00:27:00 -0700
Message-Id: <20210625072700.22662-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAndp5GhdVgL1oUjw--.24889S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrW8JF4DAryxJr4xAFWfuFg_yoW3Grg_Jr
        nrtrn2k395GFy2ka12yr15urZ7Ca1UuFs7Wr4UtF1fZrWUtr45Kw1xCrs5JF4Sgr98GFZr
        tFyrCrsxJr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5c2-5UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzh68g1QHNBBrawAAsY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

NULL check before vfree() is not needed.

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

