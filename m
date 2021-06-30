Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C803B7EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbhF3IMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 04:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbhF3IMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:12:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1BC061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 01:10:08 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u14so1462123pga.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XSmPgSj0fdFBLsZJ/VblJqLDOdAGVIaBxvJNyRn2g4=;
        b=MJpMzqzlsJxICRx0u858aWlaqmetVD04LAxP+sMK1wBPvxziSKZFGEx4+BL8MIbjc3
         Hr5Ngd1NCyC06X5i6lH5VMc8hk7UphVLMfikFCWHZ276pk6hw9JPfSAh3bQE9CNIgMIf
         sp05lYhXKa3zFQejjsU9GEM9l7HvLDNqDcKttVhJ2hjEj/jmb5xDnlgn3qBP6oKnmFG6
         4+vfv4u0PNozX4Z4rl+VF38KXDQU8vvNkv1lb6sRDrTyiODuTTHNlZBE4OPDo74e1Tcc
         XppAX8ORyCeza9bfWfGlcF1JReo4GUP4k1BmjMxthENQZ5vBMyPbs1ffJrurmLQUjC+N
         dIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0XSmPgSj0fdFBLsZJ/VblJqLDOdAGVIaBxvJNyRn2g4=;
        b=O0uJyQPwMGDzA5zZKzW5bzi0n4lHl2jFAWdIz+8k9Kzg+lla5SRs7T7qN7pbPZBD5S
         t+e62t4ggWgphNcLDSShR/qmH6PFMvEAAWaI3DkCdpzGUvEg8CIGpGFx/A4hri81D/Pv
         mENydFwmD2+g0AnJNJ/JhyARv6zcEwT39uPC1sUq0+4CSFz6vAS+FR8COeoMIg3hSPjb
         rGn/17ZxuxFmLNkVKu79EPv2Ov5pXUTBbY9mKheqY5Cgb4mcM8ciDWQDMxOkbL/S5RDQ
         W7T6MduZZqorIk8DpMbQz9lBMuYr5nD1Q+PpkcKhfTGHGDCjKDvULkIAqbgbICQ2Bokn
         WsZA==
X-Gm-Message-State: AOAM5323w7QdznqgDy3plbkXL0xX7ALnGt40vk3APl8Qxmo0o5FCTAUV
        RwDmSoUwRtEBuKno/AFqlIg=
X-Google-Smtp-Source: ABdhPJxDXXSWiAxwVnsiIDiKm42GRoCNRJwceCMDQiOVS8U3kqdibHcpWBKF5VlTsGXyRItSTOMaig==
X-Received: by 2002:a65:5346:: with SMTP id w6mr19774241pgr.392.1625040607600;
        Wed, 30 Jun 2021 01:10:07 -0700 (PDT)
Received: from ubuntu.localdomain ([218.17.89.92])
        by smtp.gmail.com with ESMTPSA id 10sm20723080pgl.42.2021.06.30.01.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 01:10:07 -0700 (PDT)
From:   gushengxian <gushengxian507419@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com
Cc:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ndtest: Remove NULL test before vfree
Date:   Wed, 30 Jun 2021 01:10:01 -0700
Message-Id: <20210630081001.1052396-1-gushengxian507419@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

This NULL test is redundant since vfree() checks for NULL.
Reported by Coccinelle.

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

