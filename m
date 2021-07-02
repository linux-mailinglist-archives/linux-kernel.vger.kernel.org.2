Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBFF3BA61B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhGBWyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhGBWyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:54:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8BC061762;
        Fri,  2 Jul 2021 15:52:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb6so1999285ejc.5;
        Fri, 02 Jul 2021 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=faNXvR3tx7KD+s7khCjZtAZqhs7ILrjagiLN5169MA8=;
        b=uDJCglXnuDw53LtC8KWzaQ83KG071Y8VkDrMy1Qy8tMYbffgHLiXZlmUUZiHIjtVp5
         lhn3l6NJ5byXjBsyDlDbAuI6kJ99htHY2t7BF1zuYFY49bB7Ih0QlmnW733yBf1iI7rN
         6WLwaQpzQSCpzu2H6wvomIFX3H0tXGoVtg+uZTBp/eLZzoptXVHvNoCTBnVEkhwmNt5n
         C/U3MkgYhBAPlaRHQKREloxHzwBfesjDtFU6BWg8K+y1VelqryEDpazd0vv6JFtySK7X
         IstacKz3/ejDkdTBalE5rANV3daRc5ASPPqmzonGubj8CLKcMVSu2p5H9iZ6W7tp8nOJ
         lkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=faNXvR3tx7KD+s7khCjZtAZqhs7ILrjagiLN5169MA8=;
        b=Ex+NENxMMKwPut7Shh8O8xHcYHdy3dvV+dD3uJPbiUhUyJ1M5FnqaEbQZQCGBTDvVc
         pF/MMRwVdd2+23ehRRYFDGZCsqVEYMNBalXNIePINIoYavWe5VBaS+XfoHxeyMfqadPz
         KCFWStEaGLvza6Qy++ZKNi1fZrIejwZQh4U9kVOgQ7thU9M3+xGRLdrCeM6NEGlCQ/uK
         3/BpylYIEOAC/zkjg5Shf6i1h8rA5xSvgnTaHZD1dHBPMgpYcvv3ylVWmVhjmNDfq4SE
         i2cWTArGEH6XdHUKNphiJe4YbaKDEAAYrjTV+WJFviYGHYp606fOoTljnBFdXKl3Mm5e
         /0Yg==
X-Gm-Message-State: AOAM5331PPKTtslYJajcJUTSbFmgnGnAxmrYNfJbeQAcgMQrpuNp54Cq
        YZ4osIR0u4j9NzsRaUUetvYdEx4Zly8=
X-Google-Smtp-Source: ABdhPJwtzWyis2mfuY/taJOWeS/vOPZB1y7JjZJkpRVbpg/Yfy0fom9pRY11N/LQRFPXjnDFZK9t2Q==
X-Received: by 2002:a17:907:60d6:: with SMTP id hv22mr2030745ejc.78.1625266319554;
        Fri, 02 Jul 2021 15:51:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-063-046.95.117.pool.telefonica.de. [95.117.63.46])
        by smtp.googlemail.com with ESMTPSA id r17sm1866964edt.33.2021.07.02.15.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:51:59 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/6] clk: divider: Implement and wire up .determine_rate by default
Date:   Sat,  3 Jul 2021 00:51:40 +0200
Message-Id: <20210702225145.2643303-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.determine_rate is meant to replace .round_rate. The former comes with a
benefit which is especially relevant on 32-bit systems: since
.determine_rate uses an "unsigned long" (compared to a "signed long"
which is used by .round_rate) the maximum value on 32-bit systems
increases from 2^31 (or approx. 2.14GHz) to 2^32 (or approx. 4.29GHz).

Implement .determine_rate in addition to .round_rate so drivers that are
using clk_divider_{ro_,}ops can benefit from this by default. Keep the
.round_rate callback for now since some drivers rely on
clk_divider_ops.round_rate being implemented.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-divider.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 87ba4966b0e8..f6b2bf558486 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -446,6 +446,27 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 				  divider->width, divider->flags);
 }
 
+static int clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+
+	/* if read only, just return current value */
+	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
+		u32 val;
+
+		val = clk_div_readl(divider) >> divider->shift;
+		val &= clk_div_mask(divider->width);
+
+		return divider_ro_determine_rate(hw, req, divider->table,
+						 divider->width,
+						 divider->flags, val);
+	}
+
+	return divider_determine_rate(hw, req, divider->table, divider->width,
+				      divider->flags);
+}
+
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		    const struct clk_div_table *table, u8 width,
 		    unsigned long flags)
@@ -501,6 +522,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 const struct clk_ops clk_divider_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 	.set_rate = clk_divider_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ops);
@@ -508,6 +530,7 @@ EXPORT_SYMBOL_GPL(clk_divider_ops);
 const struct clk_ops clk_divider_ro_ops = {
 	.recalc_rate = clk_divider_recalc_rate,
 	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
 
-- 
2.32.0

