Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB68A3DD0B0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbhHBGiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:38:17 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:33753 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232240AbhHBGiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:38:15 -0400
X-QQ-mid: bizesmtp42t1627886272t1ba813m
Received: from localhost.localdomain (unknown [113.89.245.207])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 02 Aug 2021 14:37:51 +0800 (CST)
X-QQ-SSF: 01100000002000208000D00A0000000
X-QQ-FEAT: XGV+RRZ8vFzS9N5nc1Ll/UPHCSh7Odr8Q/src8aDVWIveDQXJ6EX/1Pa3B1wt
        HPloZlkdoRp7Xa+yGhow5FMn17rpRraMmQNq3GsBSSLAh3/hkWNymO9mG+CpJE8JurPTXCJ
        diw4+T8r28CYcPHk1eCSMDO13KfKTMLJhHohvgY0XTnI54GDFqQ2mPp2VSJo4Dgi3AImMQN
        ovkYfp1xKSqcfTr5XS3htmtfGu2NGKfnNRoks5EQWBOLqo+HI1BnAbM4k+zZQbxsG2vyOJX
        IthlmPP96GZCoSwC9oBe3anPrpRDHDfHFKgScyLBsAfT2jsxmkyzEorkJP5WE0uUxTmXJPg
        76GZWKgT5Fo7w+Qw3ny8t9FHVmypQ==
X-QQ-GoodBg: 0
From:   Icenowy Zheng <icenowy@sipeed.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH] regmap: allow const array for {devm_,}regmap_field_bulk_alloc reg_fields
Date:   Mon,  2 Aug 2021 14:37:41 +0800
Message-Id: <20210802063741.76301-1-icenowy@sipeed.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:sipeed.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reg_fields array fed to {devm_}regmap_field_bulk_alloc is currently
not const, which is not correct on semantics (the functions shouldn't
change reg_field contents) and prevents pre-defined const reg_field
array to be used.

As the implementation of this function doesn't change the content of it,
just add const to its prototype.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/base/regmap/regmap.c | 4 ++--
 include/linux/regmap.h       | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index dcfa99ea7f31..6ad41d0720ba 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1298,7 +1298,7 @@ EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
  */
 int regmap_field_bulk_alloc(struct regmap *regmap,
 			    struct regmap_field **rm_field,
-			    struct reg_field *reg_field,
+			    const struct reg_field *reg_field,
 			    int num_fields)
 {
 	struct regmap_field *rf;
@@ -1334,7 +1334,7 @@ EXPORT_SYMBOL_GPL(regmap_field_bulk_alloc);
 int devm_regmap_field_bulk_alloc(struct device *dev,
 				 struct regmap *regmap,
 				 struct regmap_field **rm_field,
-				 struct reg_field *reg_field,
+				 const struct reg_field *reg_field,
 				 int num_fields)
 {
 	struct regmap_field *rf;
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f5f08dd0a116..77755196277c 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1269,12 +1269,13 @@ void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
 
 int regmap_field_bulk_alloc(struct regmap *regmap,
 			     struct regmap_field **rm_field,
-			     struct reg_field *reg_field,
+			     const struct reg_field *reg_field,
 			     int num_fields);
 void regmap_field_bulk_free(struct regmap_field *field);
 int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
 				 struct regmap_field **field,
-				 struct reg_field *reg_field, int num_fields);
+				 const struct reg_field *reg_field,
+				 int num_fields);
 void devm_regmap_field_bulk_free(struct device *dev,
 				 struct regmap_field *field);
 
-- 
2.30.2

