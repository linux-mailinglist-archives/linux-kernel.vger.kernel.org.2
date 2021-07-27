Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB63D6E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbhG0F4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbhG0Fzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:55:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C11C06179E;
        Mon, 26 Jul 2021 22:55:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso1210558wms.1;
        Mon, 26 Jul 2021 22:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MGb3RQsXr/lmdqFOaplbOiClSD+rHLc5oqFNVcfDRAY=;
        b=ge+oaV5Jo6iostRb0X6/pd1lxiold+keQeRu2e1vb60ahqxx8I5ikAx5wonQBO80WE
         j3qYUjEXa9Zrzls9hhqGFZiXlPxFJlDZxD09/0PJ3aDR9iJkEiBZ87xwY7fJHlkIc6AQ
         jKDKP3sX7UqWILGZuPs25Jplu8fmXLgs5xhFMTDUFOEroaaCnSZb1s4ukzsbYQw2Yaqd
         /+aawQ2KAxOYYQU5lLEAMshXekxU9besYw8X2qWudLxuI+ygAJbFlTJdwsrFeO1419kD
         387C0/rJtcBUEkKljJSQcqLxhSit3gRgYMM9+sVjHN6C4hcjuDd/6bknJ9t1PB7Z7434
         rBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MGb3RQsXr/lmdqFOaplbOiClSD+rHLc5oqFNVcfDRAY=;
        b=hCiUWyC825AwjY4qb8wsMfC5TuhoMP8gSL9TkjnViEx65OHQwypEHaJe2tFErE8zM6
         mYJv3/313yD1m70WwJdLIdbc6OkrC9DjcmQ0BUaBZMPwjoFCVqkWZ7woIhytN2bgnj9S
         dqCfSrXuULlzlHPBRMxCVWW4whzi4DrH1x4sre49MUeeLfKUA1ui2A91VpMh2hmPwRQ+
         IbBPwoRy5Q3jJwX5jqniCfnbD8ZC946wqknGgSt3Wqv1Ickk/cPAen6kwDFp1KK40tsw
         SKnbYZgKD31oez1ClpCzQE/w544tMwKXVhGClJYZ5Efd4n0nlkWCbnTy8t1+1OBDSDro
         OcNA==
X-Gm-Message-State: AOAM532PqXKvAn9gQFIiab5JbWo0XaHfzL8OkafCqt/UlTfZUREPTX9r
        wnnJbYihz4SQxOMUEp4YkHD9R3sDvMFYYg==
X-Google-Smtp-Source: ABdhPJxEGUaLn+ZzXwQqavoQP2FHl1y/AYPO/R5GBENlXjRH095t1+FrpflgENa6Haz8/CVkf5pp8g==
X-Received: by 2002:a05:600c:154d:: with SMTP id f13mr20117142wmg.3.1627365339859;
        Mon, 26 Jul 2021 22:55:39 -0700 (PDT)
Received: from localhost.localdomain (189.red-83-51-242.dynamicip.rima-tde.net. [83.51.242.189])
        by smtp.gmail.com with ESMTPSA id d9sm1897927wrx.76.2021.07.26.22.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 22:55:39 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, dqfext@gmail.com
Subject: [PATCH] clk: ralink: avoid to set 'CLK_IS_CRITICAL' flag for gates
Date:   Tue, 27 Jul 2021 07:55:37 +0200
Message-Id: <20210727055537.11785-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clk_init_data' for gates is setting up 'CLK_IS_CRITICAL'
flag for all of them. This was being doing because some
drivers of this SoC might not be ready to use the clock
and we don't wanted the kernel to disable them since default
behaviour without clock driver was to set all gate bits to
enabled state. After a bit more testing and checking driver
code it is safe to remove this flag and just let the kernel
to disable those gates that are not in use. No regressions
seems to appear.

Fixes: 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/clk/ralink/clk-mt7621.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/clk/ralink/clk-mt7621.c b/drivers/clk/ralink/clk-mt7621.c
index 857da1e274be..a2c045390f00 100644
--- a/drivers/clk/ralink/clk-mt7621.c
+++ b/drivers/clk/ralink/clk-mt7621.c
@@ -131,14 +131,7 @@ static int mt7621_gate_ops_init(struct device *dev,
 				struct mt7621_gate *sclk)
 {
 	struct clk_init_data init = {
-		/*
-		 * Until now no clock driver existed so
-		 * these SoC drivers are not prepared
-		 * yet for the clock. We don't want kernel to
-		 * disable anything so we add CLK_IS_CRITICAL
-		 * flag here.
-		 */
-		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+		.flags = CLK_SET_RATE_PARENT,
 		.num_parents = 1,
 		.parent_names = &sclk->parent_name,
 		.ops = &mt7621_gate_ops,
-- 
2.25.1

