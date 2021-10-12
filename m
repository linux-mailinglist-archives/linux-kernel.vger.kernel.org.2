Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB33429B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 04:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhJLCVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhJLCVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 22:21:49 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577ACC061570;
        Mon, 11 Oct 2021 19:19:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 75so12438393pga.3;
        Mon, 11 Oct 2021 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsTEZDiGXlkIDUL0VIL7ycKtQ7nRIFM02SA/nCqOki4=;
        b=hOz3gRrfZQKg3ihnvPYwjZIs65xysfvluVM3fZB6pY5x1PWIVdxmLGXOqMiBbWsRnQ
         J1pp8gpTr7Cx2fTjXH7AQq3kXIbwlIAI9gnhe8gyEP40pq2zb5PhvM6JXHWyiveukH05
         ltCbJJLYvokyBr9s/eaB7DXc4rHPz8gDdf5Vpbo+4xMVL+qWWbL7EYG2U7+Xm6LkTIgB
         JF96gWfzVPSt0ioP26MJoeFDchyn2CnNGgy4wcQeCG8pBGxgXOBEcxP1mZgVOqWh2xkX
         6hDaBnhb2LJmu6fxrC4BbKkG5tTTsQFkHvxoFXRf2Po8G7MQWuAzr0UGXFRAAw7DmJ5d
         A4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsTEZDiGXlkIDUL0VIL7ycKtQ7nRIFM02SA/nCqOki4=;
        b=0BtK7CBKD7bOjvxJPFdH2K3RPY9Ihy/s8N//oLA/AAn6rT+HcGi4akobFv+9pVuRL7
         UjH3GxXGkljDpuRDGtXWu8j/9qEcUdvt+6EpNYzJz5Pt29HYUTJ2z6rD/kqywxska5e8
         fsRoiPnmWQyb/IHV3vAqbNsd7tjTVdYApXZ4ualRfRk168GSx9JsroaQCwgw7WC0IE5A
         7E872Q7x5ds2SykRcGkozdQo1N9HpPhcgsn+i7qEdjSZxHaIQSVSxx/WZJYscDVQBMCE
         RGZiceQFfzn0NCbh1869wHY0/DplRch6FSug7MoIcBbfd/0iMzzmL9a/rsdfhEDnmm2b
         liGg==
X-Gm-Message-State: AOAM532+anmzoOKfyZ3tx4JLFIQWZUAgVLKk9j7X0oNxEpXyVIcdczk2
        BId77OT4yz0OgrFyTxAjk9s=
X-Google-Smtp-Source: ABdhPJxfHTmL7N+QR5zJ12HR7ob99/RXp8zKZHNKZv7Rs+uxMtESTC9K7l25KUfdU7rDUm3gNQ5lbg==
X-Received: by 2002:a63:8bc4:: with SMTP id j187mr20937440pge.402.1634005187871;
        Mon, 11 Oct 2021 19:19:47 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id y9sm8846845pfm.129.2021.10.11.19.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 19:19:47 -0700 (PDT)
From:   davidcomponentone@gmail.com
To:     nm@ti.com
Cc:     kristo@kernel.org, ssantosh@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        David Yang <davidcomponentone@gmail.com>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH sci-clk] Fix application of sizeof to pointer
Date:   Tue, 12 Oct 2021 10:19:31 +0800
Message-Id: <20211012021931.176727-1-davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Yang <davidcomponentone@gmail.com>

The coccinelle check report:
"./drivers/clk/keystone/sci-clk.c:398:8-14:
ERROR: application of sizeof to pointer"
Using the "sizeof(*clk)" to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 drivers/clk/keystone/sci-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 7e1b136e71ae..010a61a2549c 100644
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
2.30.2

