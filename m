Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3170B3E5073
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhHJAy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 20:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhHJAyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 20:54:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5990C0613D3;
        Mon,  9 Aug 2021 17:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=DKH9L/D5qWxaAYmJH5xbQWOuTOQkBWl8uns/CseNhGI=; b=rWSTU6LyG3Ax19GY5TRFGp3+EI
        cK5Kj49eUFo/5agYJLdXh0kG9PjYd5ZnoFD/w8SBNowK5uYx/kDyizv25fS0eupVxxIBM8O55+ZIr
        OPPe9941zxUFGzF4sXn5vKbKf08LawMRROeZ1vTchFMQQwSKiRGirfastgCKxmNxAciBlFwxHZTY6
        m60cKzysbUNzPDHOo25a41W8hyzSjW2xxRYlYr5FbAHZrtyDaIfdWTdgl1zdBjpP8SXNdGtqsOs29
        NbygccEBtX2L/DQr1HLoj+RMxbLjEwMiexOewXwKUkS2N0KzIVxFCS/7q/6KWDUYsqZye8y6JYdR1
        HLOGQFvg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDG2K-002BdO-5f; Tue, 10 Aug 2021 00:54:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        linux-clk@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] clk/at91: remove kernel-doc warnings in sama7g5.c
Date:   Mon,  9 Aug 2021 17:54:31 -0700
Message-Id: <20210810005431.22007-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple kernel-doc warnings in sama7g5.c. There are several
enums and structs that were not identified as such.
There are also several anonymous structs (that scripts/kernel-doc
has problems with), so add struct names to them.

Fixes the following warnings:

drivers/clk/at91/sama7g5.c:39: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * PLL clocks identifiers
drivers/clk/at91/sama7g5.c:60: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * PLL type identifiers
drivers/clk/at91/sama7g5.c:122: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * PLL clocks description
drivers/clk/at91/sama7g5.c:289: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Master clock (MCK[1..4]) description
drivers/clk/at91/sama7g5.c:341: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * System clock description
drivers/clk/at91/sama7g5.c:365: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Peripheral clock description
drivers/clk/at91/sama7g5.c:453: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Generic clock description
drivers/clk/at91/sama7g5.c:339: warning: Function parameter or member 'ep_chg_id' not described in 'master_clock'

Some kernel-doc warnings are still printed, but they are all due to
problems in the kernel-doc script (if anyone is interested in playing
with some Perl :). These warnings are:

sama7g5.c:287: warning: Function parameter or member '{' not described in 'sama7g5_plls'
sama7g5.c:287: warning: Function parameter or member '' not described in 'sama7g5_plls'
sama7g5.c:287: warning: Function parameter or member '}' not described in 'sama7g5_plls'
sama7g5.c:339: warning: Function parameter or member 'sama7g5_mckx' not described in 'master_clock'
sama7g5.c:339: warning: Function parameter or member '}' not described in 'master_clock'
sama7g5.c:360: warning: Function parameter or member 'sama7g5_systemck' not described in 'system_clock'
sama7g5.c:451: warning: Function parameter or member 'sama7g5_periphck' not described in 'periph_clock'
sama7g5.c:451: warning: Function parameter or member '' not described in 'periph_clock'
sama7g5.c:451: warning: Function parameter or member '}' not described in 'periph_clock'
sama7g5.c:841: warning: Function parameter or member 'sama7g5_gck' not described in 'generic_clock'
sama7g5.c:841: warning: Function parameter or member '}' not described in 'generic_clock'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: linux-clk@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>
---
 drivers/clk/at91/sama7g5.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--- linux-next-20210809.orig/drivers/clk/at91/sama7g5.c
+++ linux-next-20210809/drivers/clk/at91/sama7g5.c
@@ -36,7 +36,7 @@ static DEFINE_SPINLOCK(pmc_mck0_lock);
 static DEFINE_SPINLOCK(pmc_mckX_lock);
 
 /**
- * PLL clocks identifiers
+ * enum pll_ids - PLL clocks identifiers
  * @PLL_ID_CPU:		CPU PLL identifier
  * @PLL_ID_SYS:		System PLL identifier
  * @PLL_ID_DDR:		DDR PLL identifier
@@ -44,6 +44,7 @@ static DEFINE_SPINLOCK(pmc_mckX_lock);
  * @PLL_ID_BAUD:	Baud PLL identifier
  * @PLL_ID_AUDIO:	Audio PLL identifier
  * @PLL_ID_ETH:		Ethernet PLL identifier
+ * @PLL_ID_MAX:		Number of PLL_ID values (1 more than the last valid PLL_ID)
  */
 enum pll_ids {
 	PLL_ID_CPU,
@@ -57,7 +58,7 @@ enum pll_ids {
 };
 
 /**
- * PLL type identifiers
+ * enum pll_type - PLL type identifiers
  * @PLL_TYPE_FRAC:	fractional PLL identifier
  * @PLL_TYPE_DIV:	divider PLL identifier
  */
@@ -119,7 +120,7 @@ static const struct clk_pll_characterist
 };
 
 /**
- * PLL clocks description
+ * struct sama7g5_plls - PLL clocks description
  * @n:		clock name
  * @p:		clock parent
  * @l:		clock layout
@@ -128,7 +129,7 @@ static const struct clk_pll_characterist
  * @f:		clock flags
  * @eid:	export index in sama7g5->chws[] array
  */
-static const struct {
+static const struct sama7g5_plls {
 	const char *n;
 	const char *p;
 	const struct clk_pll_layout *l;
@@ -286,17 +287,17 @@ static const struct {
 };
 
 /**
- * Master clock (MCK[1..4]) description
+ * struct master_clock - Master clock (MCK[1..4]) description
  * @n:			clock name
  * @ep:			extra parents names array
- * @ep_chg_chg_id:	index in parents array that specifies the changeable
+ * @ep_chg_id:		index in parents array that specifies the changeable
  *			parent
  * @ep_count:		extra parents count
  * @ep_mux_table:	mux table for extra parents
  * @id:			clock id
  * @c:			true if clock is critical and cannot be disabled
  */
-static const struct {
+static const struct master_clock {
 	const char *n;
 	const char *ep[4];
 	int ep_chg_id;
@@ -338,12 +339,12 @@ static const struct {
 };
 
 /**
- * System clock description
+ * struct system_clock - System clock description
  * @n:	clock name
  * @p:	clock parent name
  * @id: clock id
  */
-static const struct {
+static const struct system_clock {
 	const char *n;
 	const char *p;
 	u8 id;
@@ -362,14 +363,14 @@ static const struct {
 static u32 sama7g5_prog_mux_table[] = { 0, 1, 2, 5, 6, 7, 8, 9, 10, };
 
 /**
- * Peripheral clock description
+ * struct periph_clock - Peripheral clock description
  * @n:		clock name
  * @p:		clock parent name
  * @r:		clock range values
  * @id:		clock id
  * @chgp:	index in parent array of the changeable parent
  */
-static const struct {
+static const struct periph_clock {
 	const char *n;
 	const char *p;
 	struct clk_range r;
@@ -450,7 +451,7 @@ static const struct {
 };
 
 /**
- * Generic clock description
+ * struct generic_clock - Generic clock description
  * @n:			clock name
  * @pp:			PLL parents
  * @pp_mux_table:	PLL parents mux table
@@ -459,7 +460,7 @@ static const struct {
  * @pp_count:		PLL parents count
  * @id:			clock id
  */
-static const struct {
+static const struct generic_clock {
 	const char *n;
 	const char *pp[8];
 	const char pp_mux_table[8];
