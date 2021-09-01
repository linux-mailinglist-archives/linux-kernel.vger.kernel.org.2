Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C853FD2B1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbhIAFGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:06:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45759 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241903AbhIAFGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:06:31 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C01AC5C0091;
        Wed,  1 Sep 2021 01:05:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 01 Sep 2021 01:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=1bTOo28Yws7Mc
        dNdX79AXy9UPylytP12nPD51NYQywQ=; b=pmlLt1UCyVAuqtAjsgWEHGcGNId98
        qwYyuQwe86vQ0wJFAN7s9SE3EvNMwcd+SAnU0mxf5sDaH5r+XYeWeNJeTuaY47uk
        2vPnjWg3hU611meAiBFtXUY0QKItbfk7g0donVgKf8tcV+pmiVFn49rF1DWxrzCQ
        IpglQymmJ1DG7iT17AbCJjQlwTg4bpygwikT8abakJyqbbK2J/YQlzLXy/DmAhoj
        V7skZMBmk09yINkmqQB+QVDxZicPSxQPKYOBiVkC3QMRPXdb5qzYwr3V18ATrG0e
        Jv9hstvvmloE0BHBAediI3Ypsen1jaDP6mkSzWBIdHdH3Zsq01tIJdl4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=1bTOo28Yws7McdNdX79AXy9UPylytP12nPD51NYQywQ=; b=s0qunCvg
        756zV/p+xoKEaMwEK9MDruCHKNYz7jDX8JedE957rGITDPRNX5EX8rnyLfv00atM
        pGvO03KSfJAjsZ3hTSG12YzRwZQfkn1kiesERFAg+eU7ecZEgA271r7iSKa06+JY
        YudD7qLOFIxij02k6Rz2T7sXuENQFyidEFSL8F5u4d3RM17rebgNh2+47EAAHgSi
        6uWEQjkCDDITAMkznV1FYTEDs3XF+h15Tph4E98Ly3GO4CEBzMGT4JL/3v1srmRR
        1ZfbtbutObUro9cyXnexTDKojNuO/nKmompnl+X/Nz+arF76ycpkGjbvTWB7jFcD
        3sm71eiJFR/g/g==
X-ME-Sender: <xms:HgovYSwE3U9vzdy1vEIJPvuqZ5XOg8Q9SQzGLjSTvxd8fLcxCFw7BA>
    <xme:HgovYeRqYNspad3t2SfW8EtqTAH6oh0Pk7rZ19CHdv5M8IC1iQhny18QCofMhBDFv
    IjkQQ0Avhdek6JbVw>
X-ME-Received: <xmr:HgovYUWzpkHTgfyGhzxd9sI7uhARpZfvirBTQc5-v0FpllzT5DtwfgzR1ByFXGpz-DyM8dxeHCQDR9LS6mXPCOUblCFwlmBGWp7UtzhK5056W-U6NYBSUS0Z_aIOLeJFeJdwFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HgovYYi-iRdoTi_s4-cBDEEl_bpdfs7V7v6_DjhCxYOzkrVBhOKx0g>
    <xmx:HgovYUAUeJjyh-hLR6XtlbiduEUpS5BkZs1x2cTZk6vu1NXdPZn-kA>
    <xmx:HgovYZK7OHleOZeMOGX_xEI3RYnYC49-MBy4Cx6JYYcOf1NZlKwikw>
    <xmx:HgovYQ33rEtGdFr132WT1C2WEBnQcQyxK-k6KkF0VLuERL5VogGWDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 01:05:34 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/8] clk: sunxi-ng: Rename files to match Kconfig and drivers
Date:   Wed,  1 Sep 2021 00:05:22 -0500
Message-Id: <20210901050526.45673-5-samuel@sholland.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901050526.45673-1-samuel@sholland.org>
References: <20210901050526.45673-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the drivers are built as modules, the file name will become the
module name. Rename the files so everything matches: the Kconfig symbol,
the platform driver name (as seen in sysfs), and the module name.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/Makefile                 | 42 +++++++++----------
 .../{ccu-sun4i-a10.c => sun4i-a10-ccu.c}      |  2 +-
 .../{ccu-sun4i-a10.h => sun4i-a10-ccu.h}      |  0
 .../{ccu-sun50i-a100.c => sun50i-a100-ccu.c}  |  2 +-
 .../{ccu-sun50i-a100.h => sun50i-a100-ccu.h}  |  0
 ...cu-sun50i-a100-r.c => sun50i-a100-r-ccu.c} |  2 +-
 ...cu-sun50i-a100-r.h => sun50i-a100-r-ccu.h} |  0
 .../{ccu-sun50i-a64.c => sun50i-a64-ccu.c}    |  2 +-
 .../{ccu-sun50i-a64.h => sun50i-a64-ccu.h}    |  0
 .../{ccu-sun50i-h6.c => sun50i-h6-ccu.c}      |  2 +-
 .../{ccu-sun50i-h6.h => sun50i-h6-ccu.h}      |  0
 .../{ccu-sun50i-h6-r.c => sun50i-h6-r-ccu.c}  |  2 +-
 .../{ccu-sun50i-h6-r.h => sun50i-h6-r-ccu.h}  |  0
 .../{ccu-sun50i-h616.c => sun50i-h616-ccu.c}  |  2 +-
 .../{ccu-sun50i-h616.h => sun50i-h616-ccu.h}  |  0
 .../clk/sunxi-ng/{ccu-sun5i.c => sun5i-ccu.c} |  2 +-
 .../clk/sunxi-ng/{ccu-sun5i.h => sun5i-ccu.h} |  0
 .../{ccu-sun6i-a31.c => sun6i-a31-ccu.c}      |  2 +-
 .../{ccu-sun6i-a31.h => sun6i-a31-ccu.h}      |  0
 ...cu-sun8i-a23-a33.h => sun8i-a23-a33-ccu.h} |  0
 .../{ccu-sun8i-a23.c => sun8i-a23-ccu.c}      |  2 +-
 .../{ccu-sun8i-a33.c => sun8i-a33-ccu.c}      |  2 +-
 .../{ccu-sun8i-a83t.c => sun8i-a83t-ccu.c}    |  2 +-
 .../{ccu-sun8i-a83t.h => sun8i-a83t-ccu.h}    |  0
 .../{ccu-sun8i-de2.c => sun8i-de2-ccu.c}      |  2 +-
 .../{ccu-sun8i-de2.h => sun8i-de2-ccu.h}      |  0
 .../{ccu-sun8i-h3.c => sun8i-h3-ccu.c}        |  2 +-
 .../{ccu-sun8i-h3.h => sun8i-h3-ccu.h}        |  0
 .../sunxi-ng/{ccu-sun8i-r.c => sun8i-r-ccu.c} |  2 +-
 .../sunxi-ng/{ccu-sun8i-r.h => sun8i-r-ccu.h} |  0
 .../{ccu-sun8i-r40.c => sun8i-r40-ccu.c}      |  2 +-
 .../{ccu-sun8i-r40.h => sun8i-r40-ccu.h}      |  0
 .../{ccu-sun8i-v3s.c => sun8i-v3s-ccu.c}      |  2 +-
 .../{ccu-sun8i-v3s.h => sun8i-v3s-ccu.h}      |  0
 .../{ccu-sun9i-a80.c => sun9i-a80-ccu.c}      |  2 +-
 .../{ccu-sun9i-a80.h => sun9i-a80-ccu.h}      |  0
 ...{ccu-sun9i-a80-de.c => sun9i-a80-de-ccu.c} |  2 +-
 ...{ccu-sun9i-a80-de.h => sun9i-a80-de-ccu.h} |  0
 ...cu-sun9i-a80-usb.c => sun9i-a80-usb-ccu.c} |  2 +-
 ...cu-sun9i-a80-usb.h => sun9i-a80-usb-ccu.h} |  0
 ...cu-suniv-f1c100s.c => suniv-f1c100s-ccu.c} |  2 +-
 ...cu-suniv-f1c100s.h => suniv-f1c100s-ccu.h} |  0
 42 files changed, 42 insertions(+), 42 deletions(-)
 rename drivers/clk/sunxi-ng/{ccu-sun4i-a10.c => sun4i-a10-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun4i-a10.h => sun4i-a10-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100.c => sun50i-a100-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100.h => sun50i-a100-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100-r.c => sun50i-a100-r-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a100-r.h => sun50i-a100-r-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a64.c => sun50i-a64-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-a64.h => sun50i-a64-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6.c => sun50i-h6-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6.h => sun50i-h6-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6-r.c => sun50i-h6-r-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h6-r.h => sun50i-h6-r-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h616.c => sun50i-h616-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun50i-h616.h => sun50i-h616-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun5i.c => sun5i-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun5i.h => sun5i-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun6i-a31.c => sun6i-a31-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun6i-a31.h => sun6i-a31-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a23-a33.h => sun8i-a23-a33-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a23.c => sun8i-a23-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a33.c => sun8i-a33-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a83t.c => sun8i-a83t-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-a83t.h => sun8i-a83t-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-de2.c => sun8i-de2-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-de2.h => sun8i-de2-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => sun8i-h3-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => sun8i-h3-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r.c => sun8i-r-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r.h => sun8i-r-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r40.c => sun8i-r40-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-r40.h => sun8i-r40-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-v3s.c => sun8i-v3s-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-v3s.h => sun8i-v3s-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80.c => sun9i-a80-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80.h => sun9i-a80-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-de.c => sun9i-a80-de-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-de.h => sun9i-a80-de-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-usb.c => sun9i-a80-usb-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-sun9i-a80-usb.h => sun9i-a80-usb-ccu.h} (100%)
 rename drivers/clk/sunxi-ng/{ccu-suniv-f1c100s.c => suniv-f1c100s-ccu.c} (99%)
 rename drivers/clk/sunxi-ng/{ccu-suniv-f1c100s.h => suniv-f1c100s-ccu.h} (100%)

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 96c324306d97..9ebf5920c93b 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -21,24 +21,24 @@ obj-y				+= ccu_nm.o
 obj-y				+= ccu_mp.o
 
 # SoC support
-obj-$(CONFIG_SUNIV_F1C100S_CCU)	+= ccu-suniv-f1c100s.o
-obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
-obj-$(CONFIG_SUN50I_A100_CCU)	+= ccu-sun50i-a100.o
-obj-$(CONFIG_SUN50I_A100_R_CCU)	+= ccu-sun50i-a100-r.o
-obj-$(CONFIG_SUN50I_H6_CCU)	+= ccu-sun50i-h6.o
-obj-$(CONFIG_SUN50I_H616_CCU)	+= ccu-sun50i-h616.o
-obj-$(CONFIG_SUN50I_H6_R_CCU)	+= ccu-sun50i-h6-r.o
-obj-$(CONFIG_SUN4I_A10_CCU)	+= ccu-sun4i-a10.o
-obj-$(CONFIG_SUN5I_CCU)		+= ccu-sun5i.o
-obj-$(CONFIG_SUN6I_A31_CCU)	+= ccu-sun6i-a31.o
-obj-$(CONFIG_SUN8I_A23_CCU)	+= ccu-sun8i-a23.o
-obj-$(CONFIG_SUN8I_A33_CCU)	+= ccu-sun8i-a33.o
-obj-$(CONFIG_SUN8I_A83T_CCU)	+= ccu-sun8i-a83t.o
-obj-$(CONFIG_SUN8I_H3_CCU)	+= ccu-sun8i-h3.o
-obj-$(CONFIG_SUN8I_V3S_CCU)	+= ccu-sun8i-v3s.o
-obj-$(CONFIG_SUN8I_DE2_CCU)	+= ccu-sun8i-de2.o
-obj-$(CONFIG_SUN8I_R_CCU)	+= ccu-sun8i-r.o
-obj-$(CONFIG_SUN8I_R40_CCU)	+= ccu-sun8i-r40.o
-obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
-obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
-obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
+obj-$(CONFIG_SUNIV_F1C100S_CCU)	+= suniv-f1c100s-ccu.o
+obj-$(CONFIG_SUN50I_A64_CCU)	+= sun50i-a64-ccu.o
+obj-$(CONFIG_SUN50I_A100_CCU)	+= sun50i-a100-ccu.o
+obj-$(CONFIG_SUN50I_A100_R_CCU)	+= sun50i-a100-r-ccu.o
+obj-$(CONFIG_SUN50I_H6_CCU)	+= sun50i-h6-ccu.o
+obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
+obj-$(CONFIG_SUN50I_H6_R_CCU)	+= sun50i-h6-r-ccu.o
+obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
+obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
+obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
+obj-$(CONFIG_SUN8I_A23_CCU)	+= sun8i-a23-ccu.o
+obj-$(CONFIG_SUN8I_A33_CCU)	+= sun8i-a33-ccu.o
+obj-$(CONFIG_SUN8I_A83T_CCU)	+= sun8i-a83t-ccu.o
+obj-$(CONFIG_SUN8I_H3_CCU)	+= sun8i-h3-ccu.o
+obj-$(CONFIG_SUN8I_V3S_CCU)	+= sun8i-v3s-ccu.o
+obj-$(CONFIG_SUN8I_DE2_CCU)	+= sun8i-de2-ccu.o
+obj-$(CONFIG_SUN8I_R_CCU)	+= sun8i-r-ccu.o
+obj-$(CONFIG_SUN8I_R40_CCU)	+= sun8i-r40-ccu.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= sun9i-a80-ccu.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= sun9i-a80-de-ccu.o
+obj-$(CONFIG_SUN9I_A80_CCU)	+= sun9i-a80-usb-ccu.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/sun4i-a10-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun4i-a10.c
rename to drivers/clk/sunxi-ng/sun4i-a10-ccu.c
index bd9a8782fec3..5d67f5666943 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/sun4i-a10-ccu.c
@@ -23,7 +23,7 @@
 #include "ccu_phase.h"
 #include "ccu_sdm.h"
 
-#include "ccu-sun4i-a10.h"
+#include "sun4i-a10-ccu.h"
 
 static struct ccu_nkmp pll_core_clk = {
 	.enable		= BIT(31),
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.h b/drivers/clk/sunxi-ng/sun4i-a10-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun4i-a10.h
rename to drivers/clk/sunxi-ng/sun4i-a10-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c b/drivers/clk/sunxi-ng/sun50i-a100-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun50i-a100.c
rename to drivers/clk/sunxi-ng/sun50i-a100-ccu.c
index 1d475d5a3d91..5a813af9941c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100.c
+++ b/drivers/clk/sunxi-ng/sun50i-a100-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun50i-a100.h"
+#include "sun50i-a100-ccu.h"
 
 #define SUN50I_A100_PLL_SDM_ENABLE		BIT(24)
 #define SUN50I_A100_PLL_OUTPUT_ENABLE		BIT(27)
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100.h b/drivers/clk/sunxi-ng/sun50i-a100-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun50i-a100.h
rename to drivers/clk/sunxi-ng/sun50i-a100-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c b/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
rename to drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c
index 804729e0a208..078ebdf8b093 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
+++ b/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.c
@@ -16,7 +16,7 @@
 #include "ccu_mp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun50i-a100-r.h"
+#include "sun50i-a100-r-ccu.h"
 
 static const char * const cpus_r_apb2_parents[] = { "dcxo24M", "osc32k",
 						     "iosc", "pll-periph0" };
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h b/drivers/clk/sunxi-ng/sun50i-a100-r-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h
rename to drivers/clk/sunxi-ng/sun50i-a100-r-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/sun50i-a64-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun50i-a64.c
rename to drivers/clk/sunxi-ng/sun50i-a64-ccu.c
index fcbd914e84e0..ffc5ef5fab3c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/sun50i-a64-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun50i-a64.h"
+#include "sun50i-a64-ccu.h"
 
 static struct ccu_nkmp pll_cpux_clk = {
 	.enable		= BIT(31),
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.h b/drivers/clk/sunxi-ng/sun50i-a64-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun50i-a64.h
rename to drivers/clk/sunxi-ng/sun50i-a64-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/sun50i-h6-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun50i-h6.c
rename to drivers/clk/sunxi-ng/sun50i-h6-ccu.c
index 9a8902f702c5..8876358710c5 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/sun50i-h6-ccu.c
@@ -20,7 +20,7 @@
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun50i-h6.h"
+#include "sun50i-h6-ccu.h"
 
 /*
  * The CPU PLL is actually NP clock, with P being /1, /2 or /4. However
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.h b/drivers/clk/sunxi-ng/sun50i-h6-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun50i-h6.h
rename to drivers/clk/sunxi-ng/sun50i-h6-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
rename to drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c
index f30d7eb5424d..bb7f9ed78c4c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.c
@@ -15,7 +15,7 @@
 #include "ccu_mp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun50i-h6-r.h"
+#include "sun50i-h6-r-ccu.h"
 
 /*
  * Information about AR100 and AHB/APB clocks in R_CCU are gathered from
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/sun50i-h6-r-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
rename to drivers/clk/sunxi-ng/sun50i-h6-r-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/sun50i-h616-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun50i-h616.c
rename to drivers/clk/sunxi-ng/sun50i-h616-ccu.c
index 22eb18079a15..71d75833253f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/sun50i-h616-ccu.c
@@ -22,7 +22,7 @@
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun50i-h616.h"
+#include "sun50i-h616-ccu.h"
 
 /*
  * The CPU PLL is actually NP clock, with P being /1, /2 or /4. However
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-ng/sun50i-h616-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun50i-h616.h
rename to drivers/clk/sunxi-ng/sun50i-h616-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c b/drivers/clk/sunxi-ng/sun5i-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun5i.c
rename to drivers/clk/sunxi-ng/sun5i-ccu.c
index 1f4bc0e773a7..4763ef93319f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.c
+++ b/drivers/clk/sunxi-ng/sun5i-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_phase.h"
 #include "ccu_sdm.h"
 
-#include "ccu-sun5i.h"
+#include "sun5i-ccu.h"
 
 static struct ccu_nkmp pll_core_clk = {
 	.enable		= BIT(31),
diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.h b/drivers/clk/sunxi-ng/sun5i-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun5i.h
rename to drivers/clk/sunxi-ng/sun5i-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/sun6i-a31-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun6i-a31.c
rename to drivers/clk/sunxi-ng/sun6i-a31-ccu.c
index 3df5c0b41580..b05c06a428ad 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/sun6i-a31-ccu.c
@@ -26,7 +26,7 @@
 #include "ccu_phase.h"
 #include "ccu_sdm.h"
 
-#include "ccu-sun6i-a31.h"
+#include "sun6i-a31-ccu.h"
 
 static SUNXI_CCU_NKM_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
 				     "osc24M", 0x000,
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.h b/drivers/clk/sunxi-ng/sun6i-a31-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun6i-a31.h
rename to drivers/clk/sunxi-ng/sun6i-a31-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h b/drivers/clk/sunxi-ng/sun8i-a23-a33-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-a23-a33.h
rename to drivers/clk/sunxi-ng/sun8i-a23-a33-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/sun8i-a23-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-a23.c
rename to drivers/clk/sunxi-ng/sun8i-a23-ccu.c
index 577bb235d658..5bbc66a762db 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/sun8i-a23-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_phase.h"
 #include "ccu_sdm.h"
 
-#include "ccu-sun8i-a23-a33.h"
+#include "sun8i-a23-a33-ccu.h"
 
 
 static struct ccu_nkmp pll_cpux_clk = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/sun8i-a33-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-a33.c
rename to drivers/clk/sunxi-ng/sun8i-a33-ccu.c
index 8f65cd03f5ac..6cd214b444d1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/sun8i-a33-ccu.c
@@ -20,7 +20,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun8i-a23-a33.h"
+#include "sun8i-a23-a33-ccu.h"
 
 static struct ccu_nkmp pll_cpux_clk = {
 	.enable = BIT(31),
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/sun8i-a83t-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
rename to drivers/clk/sunxi-ng/sun8i-a83t-ccu.c
index e663ab0c9935..067eb9bb4b53 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/sun8i-a83t-ccu.c
@@ -19,7 +19,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun8i-a83t.h"
+#include "sun8i-a83t-ccu.h"
 
 #define CCU_SUN8I_A83T_LOCK_REG	0x20c
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.h b/drivers/clk/sunxi-ng/sun8i-a83t-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-a83t.h
rename to drivers/clk/sunxi-ng/sun8i-a83t-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/sun8i-de2-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-de2.c
rename to drivers/clk/sunxi-ng/sun8i-de2-ccu.c
index 4b94b6041b27..15d15448ac21 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/sun8i-de2-ccu.c
@@ -15,7 +15,7 @@
 #include "ccu_gate.h"
 #include "ccu_reset.h"
 
-#include "ccu-sun8i-de2.h"
+#include "sun8i-de2-ccu.h"
 
 static SUNXI_CCU_GATE(bus_mixer0_clk,	"bus-mixer0",	"bus-de",
 		      0x04, BIT(0), 0);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.h b/drivers/clk/sunxi-ng/sun8i-de2-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-de2.h
rename to drivers/clk/sunxi-ng/sun8i-de2-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/sun8i-h3-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-h3.c
rename to drivers/clk/sunxi-ng/sun8i-h3-ccu.c
index d2fc2903787d..c566cc1aa168 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/sun8i-h3-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_phase.h"
 #include "ccu_sdm.h"
 
-#include "ccu-sun8i-h3.h"
+#include "sun8i-h3-ccu.h"
 
 static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpux_clk, "pll-cpux",
 				     "osc24M", 0x000,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.h b/drivers/clk/sunxi-ng/sun8i-h3-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-h3.h
rename to drivers/clk/sunxi-ng/sun8i-h3-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/sun8i-r-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-r.c
rename to drivers/clk/sunxi-ng/sun8i-r-ccu.c
index 9e754d1f754a..eb623b01df58 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/sun8i-r-ccu.c
@@ -15,7 +15,7 @@
 #include "ccu_mp.h"
 #include "ccu_nm.h"
 
-#include "ccu-sun8i-r.h"
+#include "sun8i-r-ccu.h"
 
 static const struct clk_parent_data ar100_parents[] = {
 	{ .fw_name = "losc" },
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.h b/drivers/clk/sunxi-ng/sun8i-r-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-r.h
rename to drivers/clk/sunxi-ng/sun8i-r-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/sun8i-r40-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-r40.c
rename to drivers/clk/sunxi-ng/sun8i-r40-ccu.c
index a2144ee728a0..7347b65a5051 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/sun8i-r40-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun8i-r40.h"
+#include "sun8i-r40-ccu.h"
 
 /* TODO: The result of N*K is required to be in [10, 88] range. */
 static struct ccu_nkmp pll_cpu_clk = {
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/sun8i-r40-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-r40.h
rename to drivers/clk/sunxi-ng/sun8i-r40-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/sun8i-v3s-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
rename to drivers/clk/sunxi-ng/sun8i-v3s-ccu.c
index ce150f83ab54..58b123ad1212 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/sun8i-v3s-ccu.c
@@ -23,7 +23,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun8i-v3s.h"
+#include "sun8i-v3s-ccu.h"
 
 static SUNXI_CCU_NKMP_WITH_GATE_LOCK(pll_cpu_clk, "pll-cpu",
 				     "osc24M", 0x000,
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.h b/drivers/clk/sunxi-ng/sun8i-v3s-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun8i-v3s.h
rename to drivers/clk/sunxi-ng/sun8i-v3s-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/sun9i-a80-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun9i-a80.c
rename to drivers/clk/sunxi-ng/sun9i-a80-ccu.c
index 68b30fdc60fd..bc0b89e18652 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/sun9i-a80-ccu.c
@@ -18,7 +18,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-sun9i-a80.h"
+#include "sun9i-a80-ccu.h"
 
 #define CCU_SUN9I_LOCK_REG	0x09c
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.h b/drivers/clk/sunxi-ng/sun9i-a80-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun9i-a80.h
rename to drivers/clk/sunxi-ng/sun9i-a80-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c b/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
rename to drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c
index d2072972b614..5be451411cb4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.c
+++ b/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.c
@@ -14,7 +14,7 @@
 #include "ccu_gate.h"
 #include "ccu_reset.h"
 
-#include "ccu-sun9i-a80-de.h"
+#include "sun9i-a80-de-ccu.h"
 
 static SUNXI_CCU_GATE(fe0_clk,		"fe0",		"fe0-div",
 		      0x00, BIT(0), 0);
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h b/drivers/clk/sunxi-ng/sun9i-a80-de-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun9i-a80-de.h
rename to drivers/clk/sunxi-ng/sun9i-a80-de-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
rename to drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c
index 596243b3e0fa..62417b6e4f74 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
+++ b/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.c
@@ -12,7 +12,7 @@
 #include "ccu_gate.h"
 #include "ccu_reset.h"
 
-#include "ccu-sun9i-a80-usb.h"
+#include "sun9i-a80-usb-ccu.h"
 
 static const struct clk_parent_data clk_parent_hosc[] = {
 	{ .fw_name = "hosc" },
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h b/drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h
rename to drivers/clk/sunxi-ng/sun9i-a80-usb-ccu.h
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c
similarity index 99%
rename from drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
rename to drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c
index 61ad7ee91c11..850ab8af2471 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.c
@@ -21,7 +21,7 @@
 #include "ccu_nm.h"
 #include "ccu_phase.h"
 
-#include "ccu-suniv-f1c100s.h"
+#include "suniv-f1c100s-ccu.h"
 
 static struct ccu_nkmp pll_cpu_clk = {
 	.enable = BIT(31),
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h b/drivers/clk/sunxi-ng/suniv-f1c100s-ccu.h
similarity index 100%
rename from drivers/clk/sunxi-ng/ccu-suniv-f1c100s.h
rename to drivers/clk/sunxi-ng/suniv-f1c100s-ccu.h
-- 
2.31.1

