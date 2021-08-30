Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA133FBD32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbhH3T5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:57:12 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:45848 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhH3T5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:57:11 -0400
Received: by mail-qt1-f181.google.com with SMTP id s32so12705852qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZDIiVhJpw7U6/4829fQy1iT9qkd/BhVJCgsXByFln68=;
        b=DgAHYKcNxjqqR0lphU9MJah9oi3Q1EaZzbMiaXM2Q2A4QAnhA0dqR6ucQAIgkpx1u+
         H8c060MG/wv8zlKsQbDuLLGo6jTitZZh2RycBGtQnlQ9+pFn2fVypp4NcDGvYda/H07g
         Jq7o9qvqHm72s4oD0jFuKK8Uz7osds/mDL/q1K/JJNQ06R/dB2gfQrO7LtbN2SVVCfO6
         mRkc7C56l6Zn38JbPYiH/a97vRhgg8U0POfRQHjS5y2osK7bEIEDShBb+SzyS6G7jyJE
         COvVGc5DUK0SOkx75UMCWpywoP84RQ4Amdwxzj7Xb//PGLV8fLkRYMdmX2eCiF/K4rr5
         F7Pg==
X-Gm-Message-State: AOAM532REXP/2c1Ads5V4Jr/Yxqkj144I2tZF3jB9MNe0lIVRQ8F4jNU
        hYMlVmTkjy2/yjCUpW131OU=
X-Google-Smtp-Source: ABdhPJyhvdcVIOR/S68NWhNlu+UIay0Ma0FvPdWp2xeOZq97aaU6bW97RZl4T0J1Mh57CMJCshS+eA==
X-Received: by 2002:ac8:4156:: with SMTP id e22mr129439qtm.308.1630353377034;
        Mon, 30 Aug 2021 12:56:17 -0700 (PDT)
Received: from MacBook-Pro.internal.carlosedp.com (201-68-134-150.dsl.telesp.net.br. [201.68.134.150])
        by smtp.googlemail.com with ESMTPSA id m68sm12399944qkb.105.2021.08.30.12.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Aug 2021 12:56:16 -0700 (PDT)
From:   Carlos de Paula <me@carlosedp.com>
Cc:     me@carlosedp.com,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: da9063: Add support for latest EA silicon revision
Date:   Mon, 30 Aug 2021 16:53:45 -0300
Message-Id: <20210830195345.71853-1-me@carlosedp.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update adds new regmap to support the latest EA silicon
which will be selected based on the chip and variant
information read from the device.

Signed-off-by: Carlos de Paula <me@carlosedp.com>
---
 drivers/mfd/da9063-i2c.c        | 2 ++
 include/linux/mfd/da9063/core.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 4b7f707b7952..343ed6e96d87 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -391,6 +391,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 				&da9063_bb_da_volatile_table;
 			break;
 		case PMIC_DA9063_DA:
+		case PMIC_DA9063_EA:
 			da9063_regmap_config.rd_table =
 				&da9063_da_readable_table;
 			da9063_regmap_config.wr_table =
@@ -416,6 +417,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 				&da9063l_bb_da_volatile_table;
 			break;
 		case PMIC_DA9063_DA:
+		case PMIC_DA9063_EA:
 			da9063_regmap_config.rd_table =
 				&da9063l_da_readable_table;
 			da9063_regmap_config.wr_table =
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index fa7a43f02f27..8db52324f416 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -36,6 +36,7 @@ enum da9063_variant_codes {
 	PMIC_DA9063_BB = 0x5,
 	PMIC_DA9063_CA = 0x6,
 	PMIC_DA9063_DA = 0x7,
+	PMIC_DA9063_EA = 0x8,
 };
 
 /* Interrupts */
-- 
2.30.2

