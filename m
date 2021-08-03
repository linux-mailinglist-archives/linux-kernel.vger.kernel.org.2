Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165573DE8B3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhHCIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:46:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39851 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234732AbhHCIqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:46:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9017E5C00C4;
        Tue,  3 Aug 2021 04:46:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 03 Aug 2021 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jcXn7Uzs7Rb29
        QcnVO48/qoLIHG3J7H1wv2fWRrP/oQ=; b=FOK7PGIH3NvfKCiiejlsPpP1jx4tm
        U/6g1UAlASfrs1P1vHvgPmKCCYlRDmmYijsYLOFPQxlg3asgHbVvAwuxKVzzNBa3
        VUAzLZIb/48jSrRn2qFahFGUygLgpAXXPV0NxZ1CypIW3leczx/KTSssNQXlcCCf
        zsOGkIxG9K3EYmkIWgrbRhTYP/NWZ8oFAXxITL8UYZiFNoCfjlWs1sCjl26LUFdO
        aRVziXgQOCS1hGZSXfhCu4fhuRUdZLXYXRA4/BCUvJMJgFMzz9cdcYx4w7at5WOk
        ZUD97CTQBFBwlepYk5ujSvgkw0tXN0/z3CADj+XC2EhiOkNbH1rNA28vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jcXn7Uzs7Rb29QcnVO48/qoLIHG3J7H1wv2fWRrP/oQ=; b=wYoNUEqe
        P7vQBeHdrwoM1jxEEtazBWhhG7kXHBEwup6adNBxel3Fq6S8EqtYwo/F25Kawbrx
        1aGH08v+21TZnJ3YhBcorsAO+JxQmkjLvhu9uGqA+IOxpGBWzGoqTdh5U8Or31WX
        cpr1ulMFbOjnr6gBbwykhSWGBRZlMv7Ll99uqUPx+d9fAyIPXKBwMXxSFpjhDDjF
        DBhaCocb/TPxZDBvnNvs4kP28kxqIywnEOji2IPZHJVqdsmbfSCaMxYhmZm5cX6M
        tUYwLcUmLnFzF9OLEf7gIUoMMnAjf+3/iXbQzrIXORzjmSMoHC4b+w66qMk9qF8W
        GHCs7KU7oCJOdg==
X-ME-Sender: <xms:UAIJYa99gQviEd3ur-wLOt4MrL6pyRV_t3QbAVaqhsikr6U_PnzcHg>
    <xme:UAIJYavZVyRWYnn_XzoLaXUNWTumeKrlswExH2lSNguSTU8D0fKTYwQHbkoNAGcY-
    KK1nZ-BGM2OtOjjZi0>
X-ME-Received: <xmr:UAIJYQCo-1HBJ4SQBlYASZly7gaqoI2dPwmCn-KoOGHMP0_qlYxcrvuIJQjYM8Ol5gqXqJl7TErY4v-sM8V2KjSisqcx5xhZwYoQmzE1lEllWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:UAIJYSf0-SXAUPa0bPy-s4QDX9BWPRmFaBW9PtyQxpm5egHAOWFBBg>
    <xmx:UAIJYfPC_97_reYyegvyj5OHq0SMiPPRjtgDcgR5eDBla2vRXURx7Q>
    <xmx:UAIJYcnv9q7-YRo1kuLYmBf_Vy9xf4M2TYMf9SSraugwCz4L8wUdXw>
    <xmx:UAIJYack5528GUmX6KFVgajImqdcSksv5bbc6VKZ3jiJACox0nayEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 04:46:04 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v8 05/11] regulator: sy7636a: Remove the poll_enable_time
Date:   Tue,  3 Aug 2021 18:44:52 +1000
Message-Id: <20210803084456.198-5-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803084456.198-1-alistair@alistair23.me>
References: <20210803084456.198-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From testing on hardware the poll_enable_time isn't required and
sometimes causes the driver probe to fail so let's remove it.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/regulator/sy7636a-regulator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index e021ae08cbaa..c3b34cac8c7f 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -13,8 +13,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/sy7636a.h>
 
-#define SY7636A_POLL_ENABLED_TIME 500
-
 static int sy7636a_get_vcom_voltage_op(struct regulator_dev *rdev)
 {
 	int ret;
@@ -61,7 +59,6 @@ static const struct regulator_desc desc = {
 	.owner = THIS_MODULE,
 	.enable_reg = SY7636A_REG_OPERATION_MODE_CRL,
 	.enable_mask = SY7636A_OPERATION_MODE_CRL_ONOFF,
-	.poll_enabled_time = SY7636A_POLL_ENABLED_TIME,
 	.regulators_node = of_match_ptr("regulators"),
 	.of_match = of_match_ptr("vcom"),
 };
-- 
2.31.1

