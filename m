Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23F3F08B1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 18:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhHRQFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHRQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 12:05:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA02C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 09:05:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mGO3s-0008WN-Ib; Wed, 18 Aug 2021 18:05:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mGO3p-00088y-QS; Wed, 18 Aug 2021 18:05:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mGO3p-0003yw-Pb; Wed, 18 Aug 2021 18:05:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] clk: expand clk_ignore_unused mechanism to keep only a few clks on
Date:   Wed, 18 Aug 2021 18:04:57 +0200
Message-Id: <20210818160457.320598-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=6fYG3N27aP3RxGkdjJx+eQpQfw+B/9UsoCC6yr5DVh4=; m=Wdwflwi90I4cCBeib1j1UNX47P0rpqfdzRni5sSiBLg=; p=kc1PwVF5dTn2HiF8Yhbu+eW52ORveCw6bmJWvdZ5dzA=; g=f4a36396aa3bbd06149d2f39257e07a5c4e8afbb
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmEdL6YACgkQwfwUeK3K7An02wf+Jhw xQRBiTEgWzp681eUqbGP+vZXXAD8TX4H3XgFOVOi4VX07YO8G0bnSK5a3FTEQA6p1+kTViaJRJNjn 3QR0ep4V81Yt8ArYGbYsrgyBKytqSfe4ozfXefTv5dp0muwF5YoHVyOe+O4rN6ZvlVdKnt4oG0qfQ SScpQ8hG2ogWyQ5kpGw6xhIDuZ4tKI7g5fE0+FpchjN3Mx5j+1mTV1Pyhxxh0oZN2WDYojmFf0x4C wIdurkHHhsJ6C5lg1s4/gASxGKtqctjjNwJzSL74JHNn8WYSdwTnRT+Snb/Xb8QtomhErDDTenh1G Oj/DkFOcXQRA7B/YEsPUyIUt7eahpZw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to pass an integer n that results in only keeping n unused clocks
enabled.

This helps to debug the problem if you only know that clk_ignore_unused
helps but you have no clue yet which clock is the culprit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 Documentation/driver-api/clk.rst |  4 +++-
 drivers/clk/clk.c                | 33 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 3cad45d14187..65ae7c3e2b33 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -259,7 +259,9 @@ the disabling means that the driver will remain functional while the issues
 are sorted out.
 
 To bypass this disabling, include "clk_ignore_unused" in the bootargs to the
-kernel.
+kernel. If you pass "clk_ignore_unused=n" (where n is an integer) the first n
+found clocks are not disabled which can be useful for bisecting over the unused
+clks if you don't know yet which of them is reponsible for your problem.
 
 Locking
 =======
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..7189a56bb29f 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1236,6 +1236,8 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 	clk_pm_runtime_put(core);
 }
 
+static unsigned clk_unused_keep_on __initdata;
+
 static void __init clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
@@ -1266,12 +1268,17 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 	 * back to .disable
 	 */
 	if (clk_core_is_enabled(core)) {
-		trace_clk_disable(core);
-		if (core->ops->disable_unused)
-			core->ops->disable_unused(core->hw);
-		else if (core->ops->disable)
-			core->ops->disable(core->hw);
-		trace_clk_disable_complete(core);
+		if (clk_unused_keep_on) {
+			pr_warn("Keep unused clk \"%s\" on\n", core->name);
+			clk_unused_keep_on -= 1;
+		} else {
+			trace_clk_disable(core);
+			if (core->ops->disable_unused)
+				core->ops->disable_unused(core->hw);
+			else if (core->ops->disable)
+				core->ops->disable(core->hw);
+			trace_clk_disable_complete(core);
+		}
 	}
 
 unlock_out:
@@ -1283,9 +1290,17 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 }
 
 static bool clk_ignore_unused __initdata;
-static int __init clk_ignore_unused_setup(char *__unused)
+static int __init clk_ignore_unused_setup(char *keep)
 {
-	clk_ignore_unused = true;
+	if (*keep == '=') {
+		int ret;
+
+		ret = kstrtouint(keep + 1, 0, &clk_unused_keep_on);
+		if (ret < 0)
+			pr_err("Warning: failed to parse clk_ignore_unused parameter, ignoring");
+	} else {
+		clk_ignore_unused = true;
+	}
 	return 1;
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
@@ -1297,6 +1312,8 @@ static int __init clk_disable_unused(void)
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
+	} else if (clk_ignore_unused) {
+		pr_warn("clk: Not disabling %u unused clocks\n", clk_ignore_unused);
 	}
 
 	clk_prepare_lock();
-- 
2.30.2

