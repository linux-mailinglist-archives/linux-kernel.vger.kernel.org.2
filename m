Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837353B4BD2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 03:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhFZBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 21:30:20 -0400
Received: from m12-15.163.com ([220.181.12.15]:32891 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhFZBaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 21:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=f2CyK
        mMlq7uRwuz/k0ZEXMT/kyFKnpFPhfQx5RLJFFE=; b=X0JL8oYZnEJoN0jWp2jwv
        9vLopB3eObQ0Qr/SvfvcObndRIzSCHBbJ4eyJcmJw+OEa+sEn6u0YTyGhu8GxQ5e
        p5t+WzYSijB3MdrvxKaZAlc87XKMwvtuhtOmQRdfsNy8d6JHKwy7cIMXMGDJPFaT
        RUENN8pj4hMsvOlTeR5pgM=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp11 (Coremail) with SMTP id D8CowABnh99kgtZg40LOAQ--.4S2;
        Sat, 26 Jun 2021 09:27:38 +0800 (CST)
From:   13145886936@163.com
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] tools/testing/nvdimm: Remove NULL test before vfree
Date:   Fri, 25 Jun 2021 18:26:55 -0700
Message-Id: <20210626012655.515279-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowABnh99kgtZg40LOAQ--.4S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fJw1xuF1fGryUGF4Durg_yoW3Awb_Cr
        47trn7KFZ5JFy2ka12yrn8urZ7Ca1UuFs7Ww4UtF13ZrWUtr45Kwn7Grs5XF4Sgr98KFZF
        yF95CrnxJr12kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU54T5JUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzhq9g1QHNBgHrAABs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

This NULL test is redundant since vfree() checks for NULL.
Reported by Coccinelle.

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

