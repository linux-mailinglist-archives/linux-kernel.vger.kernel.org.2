Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5D41ABE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhI1Jcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:32:36 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:38705 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbhI1JcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:32:21 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 05:32:21 EDT
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 38C3AB9A;
        Tue, 28 Sep 2021 02:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1632821031;
        bh=MaatuTopxFRwd+v9AqgpfMo/zpN+SQAapzidyO5ZjZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVO3HJL8ABpv2F2GdvQT5gVPwA4SjdeylWnhmWUkwMQ2EQboVAYrPPKSzCw2nn489
         7nCP6YMy39mBJe4EWwNb4Pg61AgrVFfFDJynss+KQWg/rgSKjhulxs0MeISZXd7waU
         A1Yn3tkCIFqcwGQAgrS2oUnmNJbeuuiNVWe8hAH0=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] hwmon: (pmbus/lm25066) Let compiler determine outer dimension of lm25066_coeff
Date:   Tue, 28 Sep 2021 02:22:38 -0700
Message-Id: <20210928092242.30036-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928092242.30036-1-zev@bewilderbeest.net>
References: <20210928092242.30036-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintaining this manually is error prone (there are currently only
five chips supported, not six); gcc can do it for us automatically.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: 666c14906b49 ("hwmon: (pmbus/lm25066) Drop support for LM25063")
---
 drivers/hwmon/pmbus/lm25066.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 4dc003ff859e..1ff5407b6977 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -51,7 +51,7 @@ struct __coeff {
 #define PSC_CURRENT_IN_L	(PSC_NUM_CLASSES)
 #define PSC_POWER_L		(PSC_NUM_CLASSES + 1)
 
-static struct __coeff lm25066_coeff[6][PSC_NUM_CLASSES + 2] = {
+static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
 	[lm25056] = {
 		[PSC_VOLTAGE_IN] = {
 			.m = 16296,
-- 
2.33.0

