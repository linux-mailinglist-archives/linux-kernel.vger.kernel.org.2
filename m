Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4716445F6C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 23:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbhKZWR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 17:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243454AbhKZWPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 17:15:55 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DBC061746;
        Fri, 26 Nov 2021 14:12:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l16so21413316wrp.11;
        Fri, 26 Nov 2021 14:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYiadRhNNssRL10U2exdYiy/ZtbsaPvzaUpEf1LyXzQ=;
        b=QlIRHwAHcq4D8jHGbjoR4a/M513JCgzzk+uQcp+D0ltqpbZueJswOxZvhyNmOCN1ay
         5lNOzPRDpEgWgJOSEW7bMhcIU+5LppYAnn8pIPR1orU9bl/2C0sxtFXFv0cXRJmKiy83
         rqK/LWcLGllh95tThLzK39fXcXWInZ2UVc9J1O/RhdMaD3+kAyfq2D3k39aa9k/bYVvc
         mC2HvsashzzkW0cSgiqLYS7Srzzoo9cBM/kkn38Dj71davkk2aJHIB/HyQZyokBjV9UA
         aZg8fBy1cH9ytEaOguJmcekzw1hTLFqu+9pqOGZy5VtXZt5JYQrVP9heznR84Fu89Nwd
         kNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zYiadRhNNssRL10U2exdYiy/ZtbsaPvzaUpEf1LyXzQ=;
        b=wrHZrCJrrottb40dQTkv2mSk1th+o7IAKMi4JySYaPytmt7kvwGtEey+dOeMMWmC7f
         HBfRTI7+/O7IP7gHRZDj7IkUrnGsC2Ow5pQONlThhm/hhWuTJoE9fqP+3iUDfV+Gl2zo
         sZxHrNwixeUPDb4aVl+OsmZ6S8xjHohQi0sjc7YKP3JiRvBUQiyjdmehqvut0+iPZGAb
         kRzEszyBbCiS+Vf3MrA+uGjyf4tlwlZ76L2cvG6OmWR548mJVcshzF4Dg2QvppuI4DfO
         xVEZsV0Vzau64zA6tn6gqnUfufMZjn+x6fAMPgBBKAPLjUuovxqPG58rBLFVzDLbFsqr
         40uA==
X-Gm-Message-State: AOAM533MPlNKZh66MkZzvRW+KwTgyeosBTBD/Z76UbhRvZS72Kx5f5bk
        2hhjRPgNZlTfam7kXqoJVN1H
X-Google-Smtp-Source: ABdhPJyjwm80wgN80iNVkpbxs8y7KzhCYWHeboUV6F2q0r9e59FfKMxVK3MdSV+B8Ah5wWRcio37UA==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr16766262wrn.82.1637964760617;
        Fri, 26 Nov 2021 14:12:40 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r15sm11884970wmh.13.2021.11.26.14.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 14:12:40 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: stm32mp1: remove redundant assignment to pointer data
Date:   Fri, 26 Nov 2021 22:12:39 +0000
Message-Id: <20211126221239.1100960-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer data is being initialized with a value and a few lines
later on being re-assigned the same value, so this re-assignment is
redundant. Clean up the code and remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/clk/clk-stm32mp1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 4bd1fe7d8af4..863274aa50e3 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -2253,8 +2253,6 @@ static int stm32_rcc_reset_init(struct device *dev, void __iomem *base,
 	const struct stm32_rcc_match_data *data = match->data;
 	struct stm32_reset_data *reset_data = NULL;
 
-	data = match->data;
-
 	reset_data = kzalloc(sizeof(*reset_data), GFP_KERNEL);
 	if (!reset_data)
 		return -ENOMEM;
-- 
2.33.1

