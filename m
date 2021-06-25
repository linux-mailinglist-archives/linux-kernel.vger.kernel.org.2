Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088EB3B3D28
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhFYHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:19:51 -0400
Received: from m12-16.163.com ([220.181.12.16]:44047 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhFYHTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=kYVlP
        09aoBeceP0zBI+4CfnkJXpyY9lE6UqEum6eaCg=; b=BSXd2FrvHmomZi5iq7MS5
        zqynNNebY26bo7AfxBYl3nSt0mOS/834RgvWqh3ZWgOp04NgrfRPrXvfJAjOrXQt
        xPf80adVQ2WHmSAk588c0+lyl0KzyVrREGskgNgsFSFCi3ZIeGq8BL6AqczdIzHk
        uKIpf+VniGZRzjf6UYtDkI=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAB3fb34gtVgrwaHzA--.35975S2;
        Fri, 25 Jun 2021 15:17:13 +0800 (CST)
From:   13145886936@163.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ndtest: NULL check before some freeing functions is not needed
Date:   Fri, 25 Jun 2021 00:17:09 -0700
Message-Id: <20210625071709.22440-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAB3fb34gtVgrwaHzA--.35975S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW7CFy5uFyftr43CrykKrg_yoW3Wrc_AF
        42qr92kFW8JryxCa12yrn09FW8Ca15urs7W3yY9Fn3A34jy3y5Kw17Crn5GF1xWr98Ga9r
        tr95ArnxGr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5umh7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiGhm8g1aD+PAGOgAAsd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

NULL check before some freeing functions is not needed.

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


