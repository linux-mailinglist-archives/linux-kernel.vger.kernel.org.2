Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830C4338B15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhCLLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhCLLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE44C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so4544437wrc.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THhKmywjPm3PSEVsHRgJ9yFTX2Li2LH1I2Fys+RHMbE=;
        b=aI9TlIjXysV5NO5te1tQfH8c+2PYDCD+Wy2lUjD3kFpYtm+upwffmJQd8DgW07vrbr
         +BTTPocgGko+6YTXpPeBwfl5snKyLMHh2nzaNfAlNa3w0J5zzBlsnUc+14WDH/5t7ALA
         P7LS2kOqbTapoK/3V9vkIt2tU5dosgbbtl5iiI2atOR4Cw2JE+6VHEYNY+hmFtR7bQ16
         TKX/zrYPKiybQfjV8jE223NJVJSd6+D8NlCbnEVlRClDQ5p/zOwgasZSbzIsoUAsg53X
         v9MPwpz1ECsSifRsUrWfUtml5EHjeYiW+cd1L6S0E//fscpnPXtkxVikp9CeAyZeIWau
         N1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THhKmywjPm3PSEVsHRgJ9yFTX2Li2LH1I2Fys+RHMbE=;
        b=aSCwP76wVBiP8SUVC3g840T/XClO35P0yEgLdVtS3gaDFP/ONxiP+EYZurvTUMKwLP
         Aret6C8hWGILv8gzPO931DDXCG7078WdAHw6ng2pRW7jLiG4UcRccX981IT9XTjqh9mI
         Zm46zQfrgIjucGPu8SKz2qYXbftLD+ZWMx2t25Re1cyKiFmJL7SJ9V2uTXKSuKy/gns4
         aBYSK6s4VeBKQAYd3TWawZzXVErGTHYPNfo5S7Qi4GlAr7nZuqFYRaLC915abdU8B03/
         xE0NNXpfipIdZljbzyxScQnVlr7XrhELZBFqwF9sha2/Yd+LMjVslMG95gA/HD5hnleZ
         xDNw==
X-Gm-Message-State: AOAM533qSSulPd078RT1SBdOMvoz0lp1jFzRi6kg7W1Kqp9THcA0Hfj5
        PBe6xnDqt8y1yRjikwN6esrz/A==
X-Google-Smtp-Source: ABdhPJyu1LjK73d1lFpmrW/zYHV2RGU5mXu/RAKxrvrHgLjCcrx2q7lgAhts5b1L28Y1X7XoNMRcdQ==
X-Received: by 2002:adf:a18a:: with SMTP id u10mr13500935wru.197.1615547288130;
        Fri, 12 Mar 2021 03:08:08 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f126sm1813003wmf.17.2021.03.12.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:08:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        benh@kernel.crashing.org, devicetree@vger.kernel.org
Subject: [PATCH 07/10] of: fdt: Demote kernel-doc abuses
Date:   Fri, 12 Mar 2021 11:07:55 +0000
Message-Id: <20210312110758.2220959-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110758.2220959-1-lee.jones@linaro.org>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
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
 drivers/of/fdt.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index dcc1dd96911a9..1fb3348eb9516 100644
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
@@ -539,7 +539,7 @@ static int __init __reserved_mem_check_root(unsigned long node)
 	return 0;
 }
 
-/**
+/*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
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
@@ -771,7 +772,7 @@ static int __init of_flat_dt_match(unsigned long node, const char *const *compat
 	return score;
 }
 
-/**
+/*
  * of_get_flat_dt_prop - Given a node in the flat blob, return the phandle
  */
 uint32_t __init of_get_flat_dt_phandle(unsigned long node)
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

