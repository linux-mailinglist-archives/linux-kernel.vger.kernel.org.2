Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEEAE3BA621
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhGBWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhGBWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:54:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E14C0613DD;
        Fri,  2 Jul 2021 15:52:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m1so15215596edq.8;
        Fri, 02 Jul 2021 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tDqwwsMfqU+YTlX7nUA9tYQ0qz5qpRvsVLjs65oq6sA=;
        b=sbTABOINWnDkV7vqSAeBZOUUoZpNOwfwP79uIslNUGhI91o+/Q4W6MsptPiwDzodlK
         sINPa2ZHyLT1HwzTODHAum01LuqZbaInErlXG7CevVLWVmZu4MUwaLJAPPj4sbeYw3bD
         86Plh23LYm51clZTBeLad+71Brt6Da7XcmLBgSV+XH8jxy/BH/ZwMQdyQlEeAUIo81Jo
         Q9OgDvoy7hw8ro12l9CZeS+ikGB9JNyGMQgoiBLOOd3kHA/S+tsYDPQV9jC7Mxe1Bysr
         8beHTmLQWhxetmSaU6lzv5WvDxVIzCZsZgZvqrp1lHE0L9IxmJB4hjwnayAtEG/tAIkJ
         FL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDqwwsMfqU+YTlX7nUA9tYQ0qz5qpRvsVLjs65oq6sA=;
        b=r+JEQDV2IydSU+piCAvLkh7JBOiCD/eqVj/OwVDSijvOjT3y4zX44b+zGy8FuWZZa9
         olFZ8dZEixy5Oefsn38qhubaZhy0gVU88QqZDAjDlPPAIdw3Q3A+7z1Gv4UeeLfghKLa
         gq19rsKF0dPkv6lrAGn7Zjz4AwU+w6m0pkddPXJFsInEeO8p/KuFqWijp9RClvc/U7am
         5zNTZbT84eA8zEb/jEFLtGZ+EilONzZ5jmoei+v5Enu5HiC9a7VQ437mL7FvOQiUgoJz
         4GJkpJeLs25Eup+oz2kShtDyREKQS2PCGRvDVcq6Nmxtnc2Wi/DRxR+IXsCYUiAmiZxB
         Sztg==
X-Gm-Message-State: AOAM531xJfQMPE9x5INI1Zm6je34xAcjlDW8tCPnE+0//gW2RZn4ny7i
        QkrhnY1u7RZmg5fxMmJjnAsnan7mFdQ=
X-Google-Smtp-Source: ABdhPJzbCHHCDX0VLPouL6nXL312RmrkyTgGK9KxV9CLAe8LLwMi9WKTcs1bnCOfwl8adqw1x5NUJQ==
X-Received: by 2002:aa7:d34f:: with SMTP id m15mr2067164edr.155.1625266322654;
        Fri, 02 Jul 2021 15:52:02 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-063-046.95.117.pool.telefonica.de. [95.117.63.46])
        by smtp.googlemail.com with ESMTPSA id r17sm1866964edt.33.2021.07.02.15.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:52:02 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 5/6] clk: stm32h7: Switch to clk_divider.determine_rate
Date:   Sat,  3 Jul 2021 00:51:44 +0200
Message-Id: <20210702225145.2643303-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.determine_rate is meant to replace .round_rate in CCF in the future.
Switch over to .determine_rate now that clk_divider_ops has gained
support for that.

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-stm32h7.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-stm32h7.c b/drivers/clk/clk-stm32h7.c
index 0ea7261d15e0..1a701eada0c1 100644
--- a/drivers/clk/clk-stm32h7.c
+++ b/drivers/clk/clk-stm32h7.c
@@ -845,10 +845,10 @@ static unsigned long odf_divider_recalc_rate(struct clk_hw *hw,
 	return clk_divider_ops.recalc_rate(hw, parent_rate);
 }
 
-static long odf_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-		unsigned long *prate)
+static int odf_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
-	return clk_divider_ops.round_rate(hw, rate, prate);
+	return clk_divider_ops.determine_rate(hw, req);
 }
 
 static int odf_divider_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -875,7 +875,7 @@ static int odf_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops odf_divider_ops = {
 	.recalc_rate	= odf_divider_recalc_rate,
-	.round_rate	= odf_divider_round_rate,
+	.determine_rate	= odf_divider_determine_rate,
 	.set_rate	= odf_divider_set_rate,
 };
 
-- 
2.32.0

