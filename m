Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74105338B18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhCLLIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhCLLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:12 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220B8C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so4544514wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqsJEFNZDm1zRQWkx9oBbTS7v3YGOj5LKMbHcTRx7PQ=;
        b=IS2cn8bYyoEKgx9TQnyV83erYgi3O4sqNhgKMBQ1a3mi78NghSnMF8OXAEd82RjNVZ
         uQZMokDl1yxFnIsc/BTxNSbqabLeW6L3YizE5d7XRQH6cS/CJWbcV+PhxsstpW6sbz74
         WVf6pv4DutsDKl32B0nJElPnlq1YpBJKACB6+8CchMaf/QJmHei7TJjBhUZsYcHLDwQu
         ASp4bozMnmDtgXdV+ChlKymXZYqiCJBkmR4w3Hkc9keFWZEAjkkkhpiKTnVTo536M9NE
         uLU9M9x5pdlw9abS0dn8vEG9MqjkBuUNxUVx0F1rbTxwwd2AKM33P9rHBbIZ9hUDZ0e5
         IzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqsJEFNZDm1zRQWkx9oBbTS7v3YGOj5LKMbHcTRx7PQ=;
        b=tR2bQ0941CxcTZaDC65WqWr9zZRUtQy1GEPm2woEBvQhYhDqsruSOTdHglqSAGmQUF
         cWBzq+AfJDmsy8TDQ7mmbSYVM93RDe78ZKGrJZkxpRPkldANnIrCsggJANR7zBYm+XmT
         8l6Kce81iDnBKmiWP/JA/MQi2yfpHbxpnTvLdYjsmax9NEu3urCVoR8tsESiv8ZPul55
         7wKYo4aVr1VtBYGhRzN1FJUOsKbDNwQBS3YtlhD6e3vSA6Ge23pLZS3INgvX9JmbKzJM
         KygjKSf6etQm97Xfdh1RFUVcy3ifukex6MQ+VBwZdXE0Vribf/qVvihqU/E5KGl2009I
         La8w==
X-Gm-Message-State: AOAM530dbzJNvT2wV3VuR4aD+Aja39eN6DHQUd8PmzqBzo82tgcSiL48
        UKQdLfvumsK/wdXlFyXZa4sraEwtwftx8g==
X-Google-Smtp-Source: ABdhPJwq0bKRk3NyrLwLCSO98CpWoM2REB81uqXmAHbCGtNRVLTD6iYOdMG0Zg6HVQe1IRf4jDzzww==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr14067319wrm.308.1615547290812;
        Fri, 12 Mar 2021 03:08:10 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f126sm1813003wmf.17.2021.03.12.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:08:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Josh Cartwright <joshc@codeaurora.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 10/10] of: of_reserved_mem: Demote kernel-doc abuses
Date:   Fri, 12 Mar 2021 11:07:58 +0000
Message-Id: <20210312110758.2220959-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110758.2220959-1-lee.jones@linaro.org>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
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

