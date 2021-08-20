Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20843F24BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbhHTCVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhHTCVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:21:47 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CB6C061575;
        Thu, 19 Aug 2021 19:21:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id p22so9388100qki.10;
        Thu, 19 Aug 2021 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CiQkEiqhrAGOxxC4zUbfLasMJ5pR76RadgCPPnlco4=;
        b=Q3Hg0+Js+xVezU0UQeaoEV37fFUpiU+3dPKlwTn+UQyWkmeklObm9uFQXZa3iUsaD0
         eiBDHLKTSEgtKiSA14VMOi8javbKyhRDxNYi/mnyG89nAaFYBHj7QYka1RS+4JLWcicr
         3oawdUNBMA4WD3ptbPL6BUW3Kq/UWBEiwY9aOcIQsTANwcTS3ieX3N5x0XCd7eoWDBbS
         6qgtG+UMhR1/jZOE0SRtosJxScYKsYyA8Bkdj4EB3fzVV6MfES3VkTNjdI/aFoSlfVi5
         23fmQzD8Vx9ADmc3g66GZl3lDWy2lZtOVW0pBxgXpRCrppOlyMSj7t4lpuixMqbwkSLt
         oNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1CiQkEiqhrAGOxxC4zUbfLasMJ5pR76RadgCPPnlco4=;
        b=H1VjQW/J+D2DRwCyE8A8+5Iq1mJrYoY0LFaEp9w5o77fFf+UtQ/GOJpbyJdGqy/1yy
         OqGWfw7k42SBuBhU+pyWA7Uf0c14cwTcX7U60o20AvNMEFbf2l47QlouvgGEtJ2F5YrZ
         +JwB5GFy5ngrwX5Ckcc1r7tQzzqJ0koIzJc4tzoR5TukXRZfGbH3sd3niLj3FPJNCE1q
         5MXuQe8oOnEVyqUQPFpPO1zuiLZSpBrXZJS+HFOXVatUXmmSEjCbLtXp223fTPpZFrAs
         EKYHgvhiBJKE63Gqd3LQzsEkr8VZ5aQigzr3exUqvTq9adzLa0Uub2dj2ulm/LmRWD8f
         gRyQ==
X-Gm-Message-State: AOAM533iVrzFyeqnPvstd2BaPEAJhLmomG4ndS2FQpQ1IAQU4t+QSymQ
        bqkYIEEXykz7XmjCsxaWZIo=
X-Google-Smtp-Source: ABdhPJzkQPEBH7SrqGJSpTLlqOXclQXK4GlV7E2ZJzFipdQgsFY1+xk+Uemnad+x/BAw+VwqX6xRmw==
X-Received: by 2002:a05:620a:81c:: with SMTP id s28mr6555355qks.45.1629426069357;
        Thu, 19 Aug 2021 19:21:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n124sm2601834qkf.119.2021.08.19.19.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:21:08 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] clk/keystone: fix application of sizeof to pointer
Date:   Thu, 19 Aug 2021 19:20:54 -0700
Message-Id: <84a6ba16686347099a3dab2e5161a930e792eb6e.1629198281.git.jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof when applied to a pointer typed expression gives the size of
the pointer.

./drivers/clk/keystone/sci-clk.c:398:8-14: ERROR application of sizeof to pointer

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 drivers/clk/keystone/sci-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 7e1b136..010a61a 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -395,7 +395,7 @@ static struct clk_hw *sci_clk_get(struct of_phandle_args *clkspec, void *data)
 	key.clk_id = clkspec->args[1];
 
 	clk = bsearch(&key, provider->clocks, provider->num_clocks,
-		      sizeof(clk), _cmp_sci_clk);
+		      sizeof(*clk), _cmp_sci_clk);
 
 	if (!clk)
 		return ERR_PTR(-ENODEV);
-- 
1.8.3.1


