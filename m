Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003BD3F231F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhHSWdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHSWdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:33:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ADAC061575;
        Thu, 19 Aug 2021 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fgrMqdI59QDQirrUi1yV5QqI7hDGiY78fzkpEzX1ANk=; b=rwgecTFDRCR2CJJaEbr3hvgjhS
        5Mm16be69xiTWuhlHJMH5sLCWWi/dL4Fg8G5NxBvEokbqZgtTCYYQmoeH/THojKksSHpnTIlJ9x8O
        aMivYE6r9qMD8jptdsQbJ/8ZLrcD6ZrajM2bnjSuNDxpXgIwgBLBD2T4cMTv+gcmczDtf580ZRMvZ
        3OZbmbSH9NTvrO9cbcXjZuYJP4sQU05DUzjNSRzCSjufZXMZakJR+Y+gihCdIr1k3H381meziEKNX
        rEyYmAGJwgipcDIpTx4tdOo7FDsiEZTOW8TiLvQY2bTwbVhhR/bNOmoumAucrseZp9DT81dkl+sAD
        7HYr8Nfw==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGqaU-009eWu-Ew; Thu, 19 Aug 2021 22:32:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] clk: at91: sama7g5: remove all kernel-doc & kernel-doc warnings
Date:   Thu, 19 Aug 2021 15:32:37 -0700
Message-Id: <20210819223237.20115-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all "/**" kernel-doc markers from sama7g5.c since they are
all internal to this driver source file only.
This eliminates 14 warnings that were reported by the kernel test robot.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
v2: use /* instead of /** comments for internal documentation (as
    suggested by Claudiu)

 drivers/clk/at91/sama7g5.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- linux-next-20210819.orig/drivers/clk/at91/sama7g5.c
+++ linux-next-20210819/drivers/clk/at91/sama7g5.c
@@ -35,7 +35,7 @@ static DEFINE_SPINLOCK(pmc_pll_lock);
 static DEFINE_SPINLOCK(pmc_mck0_lock);
 static DEFINE_SPINLOCK(pmc_mckX_lock);
 
-/**
+/*
  * PLL clocks identifiers
  * @PLL_ID_CPU:		CPU PLL identifier
  * @PLL_ID_SYS:		System PLL identifier
@@ -56,7 +56,7 @@ enum pll_ids {
 	PLL_ID_MAX,
 };
 
-/**
+/*
  * PLL type identifiers
  * @PLL_TYPE_FRAC:	fractional PLL identifier
  * @PLL_TYPE_DIV:	divider PLL identifier
@@ -118,7 +118,7 @@ static const struct clk_pll_characterist
 	.output = pll_outputs,
 };
 
-/**
+/*
  * PLL clocks description
  * @n:		clock name
  * @p:		clock parent
@@ -285,7 +285,7 @@ static const struct {
 	},
 };
 
-/**
+/*
  * Master clock (MCK[1..4]) description
  * @n:			clock name
  * @ep:			extra parents names array
@@ -337,7 +337,7 @@ static const struct {
 	  .c = 1, },
 };
 
-/**
+/*
  * System clock description
  * @n:	clock name
  * @p:	clock parent name
@@ -361,7 +361,7 @@ static const struct {
 /* Mux table for programmable clocks. */
 static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 5, 6, 7, 8, 9, 10, };
 
-/**
+/*
  * Peripheral clock description
  * @n:		clock name
  * @p:		clock parent name
@@ -449,7 +449,7 @@ static const struct {
 	{ .n = "uhphs_clk",	.p = "mck1", .id = 106, },
 };
 
-/**
+/*
  * Generic clock description
  * @n:			clock name
  * @pp:			PLL parents
