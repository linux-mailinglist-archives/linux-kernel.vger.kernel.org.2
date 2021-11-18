Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125994556FD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244599AbhKRId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244553AbhKRIdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:33:22 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F947C061570;
        Thu, 18 Nov 2021 00:30:22 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g28so4727525pgg.3;
        Thu, 18 Nov 2021 00:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c6Lxx4TXfjBkvm4wGudSZgIaFPEI/+SKic/apfT6R10=;
        b=cKxB1LeYrLZ4qFfo+ekjpTch+jOOBh3aE6wPkgLog+oCnjj3QpeonlaqaUWQw5gG3w
         7xCxT2UHhso+SIOM19zT1OlWeP1z8prlJ9NSyFP97sqLRgpe0w64WGTTkapFr1xe9gIa
         KQ7G1Lfr2E+W8c2FSGZ93a6lFzx9uiRJC84SjnDt03D6P4lB+15WfiYy/HjGC5F5Q31p
         p0yojJ6FCmSF/zf0I0hPmh44O5xLrDSs1yHRODTORhf7af9RUTN+SJk6neemavVtT0hi
         XeNuwzBY8M4aQRZnK4TIHQpIwjPeWvNakJhY/k/5mfhuNbCNHm26DsAK+PMWAevGAQmb
         /gUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c6Lxx4TXfjBkvm4wGudSZgIaFPEI/+SKic/apfT6R10=;
        b=QB3u/F1Fqvvpq17BaOAgP6O9UDkTxJPLTk8Os0wHJI02cbAh5z19sOttK035HLf6nd
         CwrPdibSmdgJ24g0fWVwDYWs7AsySHDqwGS8iuNB5uxj3T0r65pcO8bMehfBXDb7EpkR
         fnwPZEOTK7aXwvqW/xTg+BUDGUDWE9C1keqROzcLbjUPbHPhUii+H/f/InCOKGvXnR6+
         HfyJCycmUUb4FG3CrVrQm9rvAdVfD1TmdHlbhZSMerFdOFdCXnvYNTlsnrBsGB1PO1Gd
         1V4+8a3CEoURChA1MfMtXWyWHs9LwuzbzKIW2aCTXTWWs0/luk1AL1mnmMZXsGzF6aCk
         0HGw==
X-Gm-Message-State: AOAM5318N7jft5dRzuJJ8dx3CBgexTvXuj02BRPvA8+Wum0YTOoh5+dF
        Tk5ujxcIU6ki86OHyb/mGnY=
X-Google-Smtp-Source: ABdhPJxQ9wL1q09H9aed/A6vCOvB0QmdwbHXmPIA1QbrvEK9NoCXyXVcrc2RgWtgMF1sfra+lALpTw==
X-Received: by 2002:a05:6a00:2313:b0:49f:d9ec:7492 with SMTP id h19-20020a056a00231300b0049fd9ec7492mr55481875pfh.25.1637224217085;
        Thu, 18 Nov 2021 00:30:17 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e13sm1770391pgb.8.2021.11.18.00.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 00:30:16 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     avifishman70@gmail.com
Cc:     benjaminfair@google.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        openbmc@lists.ozlabs.org, sboyd@kernel.org, tali.perry1@gmail.com,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        zealci@zte.com.cn, cgel.zte@gmail.com, deng.changcheng@zte.com.cn
Subject: [PATCH v2] clk: Use div64_ul instead of do_div
Date:   Thu, 18 Nov 2021 08:28:58 +0000
Message-Id: <20211118082858.165538-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211117011244.158541-1-deng.changcheng@zte.com.cn>
References: <20211117011244.158541-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

do_div() does a 64-by-32 division. Here the divisor is an unsigned long
which on some platforms is 64 bit wide. So use div64_ul instead of do_div
to avoid a possible truncation.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/clk/clk-npcm7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index e677bb5a784b..c75880af2b74 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -56,7 +56,7 @@ static unsigned long npcm7xx_clk_pll_recalc_rate(struct clk_hw *hw,
 	otdv2 = FIELD_GET(PLLCON_OTDV2, val);
 
 	ret = (u64)parent_rate * fbdv;
-	do_div(ret, indv * otdv1 * otdv2);
+	ret = div64_ul(ret, indv * otdv1 * otdv2);
 
 	return ret;
 }
-- 
2.25.1

