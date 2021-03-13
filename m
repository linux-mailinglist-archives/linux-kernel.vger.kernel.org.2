Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C096339C2D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 06:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhCMFfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 00:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 00:34:53 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310DAC061574;
        Fri, 12 Mar 2021 21:34:53 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 6so5573740qty.3;
        Fri, 12 Mar 2021 21:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyjCmj1CmFNVIOJG5PnrvOeviEQ2s4TZykEyZaAYjTM=;
        b=t+j90VQoTIruQ9n5aPpFQQ1ef3+MD8HERR7V6yVn3CsEUXJV0i8UuaPKUcxFVxczbR
         J9B9ULBWtBrCPsWRVckTKdFn4afc7gagrr1iEousQytSV3oGYUDSRQq2OEYudFqTt0vd
         uex84dypSG4u59WagTFAQtTDSH01CZD4/xERFXtQSNqOc8J0BBnYk4clY0nxIvBVHrQL
         ubgXZOTLKix9PBhq9ZSw5Xje5XToIhqt5DG0Ej3SMQLEYj+2XCHH7Ooo3obZf8KvsDIV
         O7XJ2elK7WKiEnSRgOTdHo1HsFKNcUGB2TDarG0dtbbgtHMPHjINnqhrFwDzEa2qCJKN
         66+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dyjCmj1CmFNVIOJG5PnrvOeviEQ2s4TZykEyZaAYjTM=;
        b=RCM7xfXtQd6VtO/G5FJxlSE2ElNwvt2cOCV8acEPyNebwssdCv8BYeCqA0bmPjCCUG
         gB7ISU7sQQdF1r6PNwgYYWmaUEM8tym3YvJdX4a4tCSGplqYn6IAoqSw5NXScEeNywZ4
         2SMQN0Aw0ViF6LLPpRYytDm90fDCHnmayj2AAyevTZBKBc/EaHwOujqwwp+sjPuUgeJy
         G05YESulrEhN+WnLZPQFK3QidJTUvP2Kx6LVKAwErOJf4IDk5JfJ3VQgeDo1sfJnvBY2
         z/QsdE1tccSrFsVsejHCdllQCUJf/nSLfT5FyhXFU/0EcbnQ5VIC80AfoR7BvmWcaSLT
         TNHw==
X-Gm-Message-State: AOAM5332S8juyGhfUmHIu8K2GbNKrOcma/MXv/DArMWxeydzF3tkAfD0
        J19e9WblYcfKelDKw8809ck=
X-Google-Smtp-Source: ABdhPJykRmtpfr9UhSUl53QlRuna8xH7Tgnj/fzFFpiYBsLAhn/lhsugzMEkyduhLAG877j/Rlcf+g==
X-Received: by 2002:ac8:4d43:: with SMTP id x3mr2693011qtv.326.1615613692291;
        Fri, 12 Mar 2021 21:34:52 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id h6sm5321306qtj.75.2021.03.12.21.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 21:34:51 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, claudiu.beznea@microchip.com,
        eugen.hristev@microchip.com, unixbhaskar@gmail.com,
        tudor.ambarus@microchip.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] clk: at91: Trivial typo fixes in the file sama7g5.c
Date:   Sat, 13 Mar 2021 11:02:22 +0530
Message-Id: <20210313053222.14706-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/critial/critical/  ......two different places
s/parrent/parent/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/clk/at91/sama7g5.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index a6e20b35960e..9e1ec48c4474 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -166,7 +166,7 @@ static const struct {
 		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_FRAC,
 		   /*
-		    * This feeds syspll_divpmcck which may feed critial parts
+		    * This feeds syspll_divpmcck which may feed critical parts
 		    * of the systems like timers. Therefore it should not be
 		    * disabled.
 		    */
@@ -178,7 +178,7 @@ static const struct {
 		  .c = &pll_characteristics,
 		  .t = PLL_TYPE_DIV,
 		   /*
-		    * This may feed critial parts of the systems like timers.
+		    * This may feed critical parts of the systems like timers.
 		    * Therefore it should not be disabled.
 		    */
 		  .f = CLK_IS_CRITICAL | CLK_SET_RATE_GATE,
@@ -455,7 +455,7 @@ static const struct {
  * @pp:			PLL parents
  * @pp_mux_table:	PLL parents mux table
  * @r:			clock output range
- * @pp_chg_id:		id in parrent array of changeable PLL parent
+ * @pp_chg_id:		id in parent array of changeable PLL parent
  * @pp_count:		PLL parents count
  * @id:			clock id
  */
--
2.26.2

