Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771D33403AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCRKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhCRKky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9C4C061763
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id 61so4941080wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqsJEFNZDm1zRQWkx9oBbTS7v3YGOj5LKMbHcTRx7PQ=;
        b=c4aKYDLxmr57pQXCsjKqPoy8XCYciLJ9N+tpcorGz9F1LHX8NQi74FoEND8uug/RN9
         ez8yaDpAtg1IBvk6MF+7xPlErckecdqr+nzp5lbuxNtkNfT6LZoqPLuFqTx5AItUiLs4
         cpR47f/qAHTx5O7CFGZYiaWFrRcnQrAy8cfiM4wd4m0I0MLFvXOVTfybuZi1YvkIX83V
         PWq1hO/o0XKYiVRZus1sUq7jtZ+9NLsPUAMM3Ii/seGT3LznUtLbPGUWtt6mz2+8iMmx
         rXzTbVfv37DGISLqNJT9UFXZNdoZBH+R5EUarBa1KulLq+8o1XilACquFpnkIho/LwvO
         HPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqsJEFNZDm1zRQWkx9oBbTS7v3YGOj5LKMbHcTRx7PQ=;
        b=OEMt+PCaG5ts6P+Czb1gH262dQqqbuBQ4iQXjSavwKFPW2YV0RXyVBdnitpt55cU98
         PrHKGXUi5Dvfq3qLAGQsPDnYE9idglvFYVSIwFDDBLp00l9O3obd2ByPX3082TTkwkID
         dbLh2GoB9c6zNWZlD+FUGPGYqTxsQr7DQu4PKu0kSuVMvaIrHHqpwJki51owi1NSan3W
         i5sdnkJO1MrsXj7WaEmyCqa1mCZf5SXKz5X+ZbbV7WNQ31x6F8EIL3xzaQW2Hw3YsVg+
         wy3AEIOgHpn24iiEWv3ZDvfM1/VOdWxPe570Ez4OAWTWyHRxXQU74tGds+LoBzuSq5sJ
         An3A==
X-Gm-Message-State: AOAM531+jk6yJsqwvplDHbovyWQRR8cOUT5/U4XsEcuzdiOZdtNx1v0s
        3YuA45bC74jwIhq0OHA5dFHt0w==
X-Google-Smtp-Source: ABdhPJywv7telrZhgTo8CVB0g7RRIFhem/IKumPSW4fk8cikOR2kTnVdQri7On5rsLI1iJA9gcO6RQ==
X-Received: by 2002:adf:f4ce:: with SMTP id h14mr8895057wrp.257.1616064053290;
        Thu, 18 Mar 2021 03:40:53 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Josh Cartwright <joshc@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 10/10] of: of_reserved_mem: Demote kernel-doc abuses
Date:   Thu, 18 Mar 2021 10:40:36 +0000
Message-Id: <20210318104036.3175910-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/of_reserved_mem.c:53: warning: Function parameter or member 'node' not described in 'fdt_reserved_mem_save_node'
 drivers/of/of_reserved_mem.c:53: warning: Function parameter or member 'uname' not described in 'fdt_reserved_mem_save_node'
 drivers/of/of_reserved_mem.c:53: warning: Function parameter or member 'base' not described in 'fdt_reserved_mem_save_node'
 drivers/of/of_reserved_mem.c:53: warning: Function parameter or member 'size' not described in 'fdt_reserved_mem_save_node'
 drivers/of/of_reserved_mem.c:76: warning: Function parameter or member 'node' not described in '__reserved_mem_alloc_size'
 drivers/of/of_reserved_mem.c:76: warning: Function parameter or member 'uname' not described in '__reserved_mem_alloc_size'
 drivers/of/of_reserved_mem.c:76: warning: Function parameter or member 'res_base' not described in '__reserved_mem_alloc_size'
 drivers/of/of_reserved_mem.c:76: warning: Function parameter or member 'res_size' not described in '__reserved_mem_alloc_size'
 drivers/of/of_reserved_mem.c:171: warning: Function parameter or member 'rmem' not described in '__reserved_mem_init_node'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Josh Cartwright <joshc@codeaurora.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/of_reserved_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index a7fbc5e37e19e..15e2417974d67 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -45,7 +45,7 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return memblock_reserve(base, size);
 }
 
-/**
+/*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
 void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
@@ -67,7 +67,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 	return;
 }
 
-/**
+/*
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
@@ -164,7 +164,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 static const struct of_device_id __rmem_of_table_sentinel
 	__used __section("__reservedmem_of_table_end");
 
-/**
+/*
  * __reserved_mem_init_node() - call region specific reserved memory init code
  */
 static int __init __reserved_mem_init_node(struct reserved_mem *rmem)
-- 
2.27.0

