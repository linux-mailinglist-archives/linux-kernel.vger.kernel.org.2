Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177443403A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhCRKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCRKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BB4C061763
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so6677469wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p93RSQraOmdRnXpBn6AdELj34NhQouUv0hXIunYHDbU=;
        b=rO8Z4QIM1BizCvyGUPP8TY5VqNFZM8Vtqw56fkZnF7B95OJSVNgMK+BKygDffOJkpn
         YAjoTpAYUFF9DlpyryfL20qh+5X7p3YnkjPp8e+UU9kGv8TcG8bg/ABwhqiEJZHzkaxW
         qqTSmn+zBqQ8BOUSmmiGmrYP5gnHGTr+B1yJ3qBNS81fIPocdKG6j957kbdkZp3CkY+f
         JVtoQ3KkVkofgujrLhV/1pRxdowN9V6MQc5g3+0nrnw0yFiuBOSy9oUbCpJIveYLIxv0
         5NUA7qq3IgPYSNaUgRVH6914CYTeGScMvvnRyhkkFal7QIh8LqVGvzac8th/NRdjet/V
         uuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p93RSQraOmdRnXpBn6AdELj34NhQouUv0hXIunYHDbU=;
        b=UZxhr7y5H4DAJxKRm2SrjGPbZEbTCJ3u2yGz0zwZWkbTleEXir5TRnzARxorqIW3tk
         UkNYQUClnORg02ROt92F9TBpFlAbKaomuVLWH4sbobEOIE4LbhHiw+ZarCysY3WRTcEm
         7jWcjR2dCt3GBvYzSVGpgRNFevsZ1FpGrsJqZCTmqq5wKcDPSTzgZMRPWQ6WhPtJhVm3
         pDl6z17rxiggFxHR8u1wLhAe0TKHWM6khvbR36O6rfM1KfBGwIYcJSsK0jLMpH6S47J+
         zw+6X0HKKkN4vwbv0H+sQX9cVme+63+c0p6gidDg8CkLo1hXoJi4KkmOqw9qQLrvA7iR
         copw==
X-Gm-Message-State: AOAM531lgF0KPRcgVJvwWc6HijcQlay2tY5nsiN2L3be8y8zF9bSZyHo
        ASdqHeGdqi1sjTPAfXjoUeJdWw==
X-Google-Smtp-Source: ABdhPJygumVBjWwtTQSPa436+pkbEEukKwr3djzv0rDa0LOMEz/aF9CSC12YFnqy2NLbD5RK7tjI7w==
X-Received: by 2002:a05:600c:608:: with SMTP id o8mr3096483wmm.42.1616064050494;
        Thu, 18 Mar 2021 03:40:50 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:50 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        benh@kernel.crashing.org, devicetree@vger.kernel.org
Subject: [PATCH 07/10] of: fdt: Demote kernel-doc abuses and fix function naming
Date:   Thu, 18 Mar 2021 10:40:33 +0000
Message-Id: <20210318104036.3175910-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/fdt.c:478: warning: Function parameter or member 'node' not described in '__reserved_mem_reserve_reg'
 drivers/of/fdt.c:478: warning: Function parameter or member 'uname' not described in '__reserved_mem_reserve_reg'
 drivers/of/fdt.c:525: warning: Function parameter or member 'node' not described in '__reserved_mem_check_root'
 drivers/of/fdt.c:547: warning: Function parameter or member 'node' not described in '__fdt_scan_reserved_mem'
 drivers/of/fdt.c:547: warning: Function parameter or member 'uname' not described in '__fdt_scan_reserved_mem'
 drivers/of/fdt.c:547: warning: Function parameter or member 'depth' not described in '__fdt_scan_reserved_mem'
 drivers/of/fdt.c:547: warning: Function parameter or member 'data' not described in '__fdt_scan_reserved_mem'
 drivers/of/fdt.c:547: warning: expecting prototype for fdt_scan_reserved_mem(). Prototype was for __fdt_scan_reserved_mem() instead
 drivers/of/fdt.c:663: warning: Function parameter or member 'parent' not described in 'of_scan_flat_dt_subnodes'
 drivers/of/fdt.c:708: warning: Function parameter or member 'node' not described in 'of_get_flat_dt_prop'
 drivers/of/fdt.c:708: warning: Function parameter or member 'name' not described in 'of_get_flat_dt_prop'
 drivers/of/fdt.c:708: warning: Function parameter or member 'size' not described in 'of_get_flat_dt_prop'
 drivers/of/fdt.c:758: warning: Function parameter or member 'node' not described in 'of_flat_dt_match'
 drivers/of/fdt.c:758: warning: Function parameter or member 'compat' not described in 'of_flat_dt_match'
 drivers/of/fdt.c:778: warning: Function parameter or member 'node' not described in 'of_get_flat_dt_phandle'
 drivers/of/fdt.c:778: warning: expecting prototype for of_get_flat_dt_prop(). Prototype was for of_get_flat_dt_phandle() instead
 drivers/of/fdt.c:955: warning: Function parameter or member 'node' not described in 'early_init_dt_scan_root'
 drivers/of/fdt.c:955: warning: Function parameter or member 'uname' not described in 'early_init_dt_scan_root'
 drivers/of/fdt.c:955: warning: Function parameter or member 'depth' not described in 'early_init_dt_scan_root'
 drivers/of/fdt.c:955: warning: Function parameter or member 'data' not described in 'early_init_dt_scan_root'
 drivers/of/fdt.c:991: warning: Function parameter or member 'node' not described in 'early_init_dt_scan_memory'
 drivers/of/fdt.c:991: warning: Function parameter or member 'uname' not described in 'early_init_dt_scan_memory'
 drivers/of/fdt.c:991: warning: Function parameter or member 'depth' not described in 'early_init_dt_scan_memory'
 drivers/of/fdt.c:991: warning: Function parameter or member 'data' not described in 'early_init_dt_scan_memory'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: benh@kernel.crashing.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/fdt.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a9..4d6d195e089aa 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -470,7 +470,7 @@ void *initial_boot_params __ro_after_init;
 
 static u32 of_fdt_crc32;
 
-/**
+/*
  * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
  */
 static int __init __reserved_mem_reserve_reg(unsigned long node,
@@ -516,7 +516,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	return 0;
 }
 
-/**
+/*
  * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
  * in /reserved-memory matches the values supported by the current implementation,
  * also check if ranges property has been provided
@@ -539,8 +539,8 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
-/**
- * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
+/*
+ * __fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
 					  int depth, void *data)
@@ -650,6 +650,7 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 
 /**
  * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
+ * @parent: parent node
  * @it: callback function
  * @data: context data pointer
  *
@@ -689,7 +690,7 @@ int __init of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
 	return fdt_subnode_offset(initial_boot_params, node, uname);
 }
 
-/**
+/*
  * of_get_flat_dt_root - find the root node in the flat blob
  */
 unsigned long __init of_get_flat_dt_root(void)
@@ -697,7 +698,7 @@ unsigned long __init of_get_flat_dt_root(void)
 	return 0;
 }
 
-/**
+/*
  * of_get_flat_dt_prop - Given a node in the flat blob, return the property ptr
  *
  * This function can be used within scan_flattened_dt callback to get
@@ -751,7 +752,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 	return of_fdt_is_compatible(initial_boot_params, node, compat);
 }
 
-/**
+/*
  * of_flat_dt_match - Return true if node matches a list of compatible values
  */
 static int __init of_flat_dt_match(unsigned long node, const char *const *compat)
@@ -771,8 +772,8 @@ static int __init of_flat_dt_match(unsigned long node, const char *const *compat
 	return score;
 }
 
-/**
- * of_get_flat_dt_prop - Given a node in the flat blob, return the phandle
+/*
+ * of_get_flat_dt_phandle - Given a node in the flat blob, return the phandle
  */
 uint32_t __init of_get_flat_dt_phandle(unsigned long node)
 {
@@ -947,7 +948,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
 }
 #endif
 
-/**
+/*
  * early_init_dt_scan_root - fetch the top level address and size cells
  */
 int __init early_init_dt_scan_root(unsigned long node, const char *uname,
@@ -983,7 +984,7 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
 	return of_read_number(p, s);
 }
 
-/**
+/*
  * early_init_dt_scan_memory - Look for and parse memory nodes
  */
 int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
-- 
2.27.0

