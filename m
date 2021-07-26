Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1F83D5AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhGZNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:21:13 -0400
Received: from forward105o.mail.yandex.net ([37.140.190.183]:55252 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234377AbhGZNVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:21:07 -0400
Received: from myt5-4fa6d87d1832.qloud-c.yandex.net (myt5-4fa6d87d1832.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2507:0:640:4fa6:d87d])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 4C8B34202D39;
        Mon, 26 Jul 2021 17:01:34 +0300 (MSK)
Received: from myt3-07a4bd8655f2.qloud-c.yandex.net (myt3-07a4bd8655f2.qloud-c.yandex.net [2a02:6b8:c12:693:0:640:7a4:bd86])
        by myt5-4fa6d87d1832.qloud-c.yandex.net (mxback/Yandex) with ESMTP id AFoVSd3XUq-1XIKe2J5;
        Mon, 26 Jul 2021 17:01:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1627308094;
        bh=ZPKi+3h7cIDELuNsLDPqEKqnDZsKpHAqUSlHzS8tXwY=;
        h=In-Reply-To:References:Date:Subject:To:From:Message-Id:Cc;
        b=kM+WFyGzfiTE3w72hDytuU//bKQLJxnk/l6Zc42449Vts4O/v62Yl7M1eeFDYszBa
         YHPgTPgD1jWcsh2OUzidL1PAbDwOQ3d5d9q1zhnRbFEXYKSuEFYtKjj6lWHeTzaETv
         uiY4JKfbEAJQN4AWzytHL/TyGfent5sp6P7Q+YUs=
Authentication-Results: myt5-4fa6d87d1832.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt3-07a4bd8655f2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id olJ9yWy468-1W2ijSWL;
        Mon, 26 Jul 2021 17:01:32 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
Date:   Mon, 26 Jul 2021 16:59:56 +0300
Message-Id: <20210726140001.24820-9-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210726140001.24820-1-nikita.shubin@maquefel.me>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converted in-place without moving file to drivers/clk.

tested on ts7250 (EP9302).

Only setting rate and change parent tested for, as they
are missing on ts7250:
- video
- I2S
- ADC/KEYPAD
- PWM

Only video and I2S clock are interesting, as they are
GATE + double DIV + MUX, all other are pretty much
common but require ep93xx_syscon_swlocked_write to set
registers.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/Kconfig             |   2 +-
 arch/arm/mach-ep93xx/clock.c | 975 ++++++++++++++++++++---------------
 arch/arm/mach-ep93xx/core.c  |   2 +-
 arch/arm/mach-ep93xx/soc.h   |  42 +-
 4 files changed, 581 insertions(+), 440 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302d..8f4a74a37406 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -357,7 +357,7 @@ config ARCH_EP93XX
 	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GPIOLIB
-	select HAVE_LEGACY_CLK
+	select COMMON_CLK
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 2810eb5b2aca..cc75087134d3 100644
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/clkdev.h>
+#include <linux/clk-provider.h>
 #include <linux/soc/cirrus/ep93xx.h>
 
 #include "hardware.h"
@@ -24,348 +25,194 @@
 
 #include "soc.h"
 
-struct clk {
-	struct clk	*parent;
-	unsigned long	rate;
-	int		users;
-	int		sw_locked;
-	void __iomem	*enable_reg;
-	u32		enable_mask;
-
-	unsigned long	(*get_rate)(struct clk *clk);
-	int		(*set_rate)(struct clk *clk, unsigned long rate);
-};
-
-
-static unsigned long get_uart_rate(struct clk *clk);
-
-static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
-static int set_div_rate(struct clk *clk, unsigned long rate);
-static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate);
-static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate);
+static DEFINE_SPINLOCK(clk_lock);
 
-static struct clk clk_xtali = {
-	.rate		= EP93XX_EXT_CLK_RATE,
-};
-static struct clk clk_uart1 = {
-	.parent		= &clk_xtali,
-	.sw_locked	= 1,
-	.enable_reg	= EP93XX_SYSCON_DEVCFG,
-	.enable_mask	= EP93XX_SYSCON_DEVCFG_U1EN,
-	.get_rate	= get_uart_rate,
-};
-static struct clk clk_uart2 = {
-	.parent		= &clk_xtali,
-	.sw_locked	= 1,
-	.enable_reg	= EP93XX_SYSCON_DEVCFG,
-	.enable_mask	= EP93XX_SYSCON_DEVCFG_U2EN,
-	.get_rate	= get_uart_rate,
-};
-static struct clk clk_uart3 = {
-	.parent		= &clk_xtali,
-	.sw_locked	= 1,
-	.enable_reg	= EP93XX_SYSCON_DEVCFG,
-	.enable_mask	= EP93XX_SYSCON_DEVCFG_U3EN,
-	.get_rate	= get_uart_rate,
-};
-static struct clk clk_pll1 = {
-	.parent		= &clk_xtali,
-};
-static struct clk clk_f = {
-	.parent		= &clk_pll1,
-};
-static struct clk clk_h = {
-	.parent		= &clk_pll1,
-};
-static struct clk clk_p = {
-	.parent		= &clk_pll1,
-};
-static struct clk clk_pll2 = {
-	.parent		= &clk_xtali,
-};
-static struct clk clk_usb_host = {
-	.parent		= &clk_pll2,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_USH_EN,
-};
-static struct clk clk_keypad = {
-	.parent		= &clk_xtali,
-	.sw_locked	= 1,
-	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
-	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
-	.set_rate	= set_keytchclk_rate,
-};
-static struct clk clk_adc = {
-	.parent		= &clk_xtali,
-	.sw_locked	= 1,
-	.enable_reg	= EP93XX_SYSCON_KEYTCHCLKDIV,
-	.enable_mask	= EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
-	.set_rate	= set_keytchclk_rate,
-};
-static struct clk clk_spi = {
-	.parent		= &clk_xtali,
-	.rate		= EP93XX_EXT_CLK_RATE,
-};
-static struct clk clk_pwm = {
-	.parent		= &clk_xtali,
-	.rate		= EP93XX_EXT_CLK_RATE,
-};
+static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
+static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
+static char pclk_divisors[] = { 1, 2, 4, 8 };
 
-static struct clk clk_video = {
-	.sw_locked	= 1,
-	.enable_reg     = EP93XX_SYSCON_VIDCLKDIV,
-	.enable_mask    = EP93XX_SYSCON_CLKDIV_ENABLE,
-	.set_rate	= set_div_rate,
-};
+static char adc_divisors[] = { 16, 4 };
+static char sclk_divisors[] = { 2, 4 };
+static char lrclk_divisors[] = { 32, 64, 128 };
 
-static struct clk clk_i2s_mclk = {
-	.sw_locked	= 1,
-	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
-	.enable_mask	= EP93XX_SYSCON_CLKDIV_ENABLE,
-	.set_rate	= set_div_rate,
+static const char * const mux_parents[] = {
+	"xtali",
+	"pll1",
+	"pll2"
 };
 
-static struct clk clk_i2s_sclk = {
-	.sw_locked	= 1,
-	.parent		= &clk_i2s_mclk,
-	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
-	.enable_mask	= EP93XX_SYSCON_I2SCLKDIV_SENA,
-	.set_rate	= set_i2s_sclk_rate,
-};
+/*
+ * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
+ */
+static unsigned long calc_pll_rate(unsigned long long rate, u32 config_word)
+{
+	int i;
 
-static struct clk clk_i2s_lrclk = {
-	.sw_locked	= 1,
-	.parent		= &clk_i2s_sclk,
-	.enable_reg	= EP93XX_SYSCON_I2SCLKDIV,
-	.enable_mask	= EP93XX_SYSCON_I2SCLKDIV_SENA,
-	.set_rate	= set_i2s_lrclk_rate,
-};
+	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
+	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
+	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */
+	for (i = 0; i < ((config_word >> 16) & 3); i++)		/* PS */
+		rate >>= 1;
 
-/* DMA Clocks */
-static struct clk clk_m2p0 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P0,
-};
-static struct clk clk_m2p1 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P1,
-};
-static struct clk clk_m2p2 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P2,
-};
-static struct clk clk_m2p3 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P3,
-};
-static struct clk clk_m2p4 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P4,
-};
-static struct clk clk_m2p5 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P5,
-};
-static struct clk clk_m2p6 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P6,
-};
-static struct clk clk_m2p7 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P7,
-};
-static struct clk clk_m2p8 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P8,
-};
-static struct clk clk_m2p9 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2P9,
-};
-static struct clk clk_m2m0 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M0,
-};
-static struct clk clk_m2m1 = {
-	.parent		= &clk_h,
-	.enable_reg	= EP93XX_SYSCON_PWRCNT,
-	.enable_mask	= EP93XX_SYSCON_PWRCNT_DMA_M2M1,
-};
+	return (unsigned long)rate;
+}
 
-#define INIT_CK(dev,con,ck)					\
-	{ .dev_id = dev, .con_id = con, .clk = ck }
-
-static struct clk_lookup clocks[] = {
-	INIT_CK(NULL,			"xtali",	&clk_xtali),
-	INIT_CK("apb:uart1",		NULL,		&clk_uart1),
-	INIT_CK("apb:uart2",		NULL,		&clk_uart2),
-	INIT_CK("apb:uart3",		NULL,		&clk_uart3),
-	INIT_CK(NULL,			"pll1",		&clk_pll1),
-	INIT_CK(NULL,			"fclk",		&clk_f),
-	INIT_CK(NULL,			"hclk",		&clk_h),
-	INIT_CK(NULL,			"apb_pclk",	&clk_p),
-	INIT_CK(NULL,			"pll2",		&clk_pll2),
-	INIT_CK("ohci-platform",	NULL,		&clk_usb_host),
-	INIT_CK("ep93xx-keypad",	NULL,		&clk_keypad),
-	INIT_CK("ep93xx-adc",		NULL,		&clk_adc),
-	INIT_CK("ep93xx-fb",		NULL,		&clk_video),
-	INIT_CK("ep93xx-spi.0",		NULL,		&clk_spi),
-	INIT_CK("ep93xx-i2s",		"mclk",		&clk_i2s_mclk),
-	INIT_CK("ep93xx-i2s",		"sclk",		&clk_i2s_sclk),
-	INIT_CK("ep93xx-i2s",		"lrclk",	&clk_i2s_lrclk),
-	INIT_CK(NULL,			"pwm_clk",	&clk_pwm),
-	INIT_CK(NULL,			"m2p0",		&clk_m2p0),
-	INIT_CK(NULL,			"m2p1",		&clk_m2p1),
-	INIT_CK(NULL,			"m2p2",		&clk_m2p2),
-	INIT_CK(NULL,			"m2p3",		&clk_m2p3),
-	INIT_CK(NULL,			"m2p4",		&clk_m2p4),
-	INIT_CK(NULL,			"m2p5",		&clk_m2p5),
-	INIT_CK(NULL,			"m2p6",		&clk_m2p6),
-	INIT_CK(NULL,			"m2p7",		&clk_m2p7),
-	INIT_CK(NULL,			"m2p8",		&clk_m2p8),
-	INIT_CK(NULL,			"m2p9",		&clk_m2p9),
-	INIT_CK(NULL,			"m2m0",		&clk_m2m0),
-	INIT_CK(NULL,			"m2m1",		&clk_m2m1),
+struct clk_psc {
+	struct clk_hw hw;
+	void __iomem *reg;
+	u8 bit_idx;
+	u32 mask;
+	u8 shift;
+	u8 width;
+	char *div;
+	u8 num_div;
+	spinlock_t *lock;
 };
 
-static DEFINE_SPINLOCK(clk_lock);
+#define to_clk_psc(_hw) container_of(_hw, struct clk_psc, hw)
 
-static void __clk_enable(struct clk *clk)
+static int ep93xx_clk_is_enabled(struct clk_hw *hw)
 {
-	if (!clk->users++) {
-		if (clk->parent)
-			__clk_enable(clk->parent);
-
-		if (clk->enable_reg) {
-			u32 v;
-
-			v = __raw_readl(clk->enable_reg);
-			v |= clk->enable_mask;
-			if (clk->sw_locked)
-				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
-			else
-				__raw_writel(v, clk->enable_reg);
-		}
-	}
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val = readl(psc->reg);
+
+	return (val & BIT(psc->bit_idx)) ? 1 : 0;
 }
 
-int clk_enable(struct clk *clk)
+static int ep93xx_clk_enable(struct clk_hw *hw)
 {
-	unsigned long flags;
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long flags = 0;
+	u32 val;
 
-	if (!clk)
-		return -EINVAL;
+	if (psc->lock)
+		spin_lock_irqsave(psc->lock, flags);
+
+	val = __raw_readl(psc->reg);
+	val |= BIT(psc->bit_idx);
+
+	ep93xx_syscon_swlocked_write(val, psc->reg);
 
-	spin_lock_irqsave(&clk_lock, flags);
-	__clk_enable(clk);
-	spin_unlock_irqrestore(&clk_lock, flags);
+	if (psc->lock)
+		spin_unlock_irqrestore(psc->lock, flags);
 
 	return 0;
 }
-EXPORT_SYMBOL(clk_enable);
 
-static void __clk_disable(struct clk *clk)
+static void ep93xx_clk_disable(struct clk_hw *hw)
 {
-	if (!--clk->users) {
-		if (clk->enable_reg) {
-			u32 v;
-
-			v = __raw_readl(clk->enable_reg);
-			v &= ~clk->enable_mask;
-			if (clk->sw_locked)
-				ep93xx_syscon_swlocked_write(v, clk->enable_reg);
-			else
-				__raw_writel(v, clk->enable_reg);
-		}
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long flags = 0;
+	u32 val;
 
-		if (clk->parent)
-			__clk_disable(clk->parent);
-	}
-}
+	if (psc->lock)
+		spin_lock_irqsave(psc->lock, flags);
 
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
+	val = __raw_readl(psc->reg);
+	val &= ~BIT(psc->bit_idx);
 
-	if (!clk)
-		return;
+	ep93xx_syscon_swlocked_write(val, psc->reg);
 
-	spin_lock_irqsave(&clk_lock, flags);
-	__clk_disable(clk);
-	spin_unlock_irqrestore(&clk_lock, flags);
+	if (psc->lock)
+		spin_unlock_irqrestore(psc->lock, flags);
 }
-EXPORT_SYMBOL(clk_disable);
 
-static unsigned long get_uart_rate(struct clk *clk)
-{
-	unsigned long rate = clk_get_rate(clk->parent);
-	u32 value;
+static const struct clk_ops clk_ep93xx_gate_ops = {
+	.enable = ep93xx_clk_enable,
+	.disable = ep93xx_clk_disable,
+	.is_enabled = ep93xx_clk_is_enabled,
+};
 
-	value = __raw_readl(EP93XX_SYSCON_PWRCNT);
-	if (value & EP93XX_SYSCON_PWRCNT_UARTBAUD)
-		return rate;
-	else
-		return rate / 2;
+static struct clk_hw *ep93xx_clk_register_gate(const char *name,
+				    const char *parent_name,
+				    void __iomem *reg,
+				    u8 bit_idx)
+{
+	struct clk_init_data init;
+	struct clk_psc *psc;
+	struct clk *clk;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_ep93xx_gate_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	psc->reg = reg;
+	psc->bit_idx = bit_idx;
+	psc->hw.init = &init;
+	psc->lock = &clk_lock;
+
+	clk = clk_register(NULL, &psc->hw);
+	if (IS_ERR(clk))
+		kfree(psc);
+
+	return &psc->hw;
 }
 
-unsigned long clk_get_rate(struct clk *clk)
+static u8 ep93xx_mux_get_parent(struct clk_hw *hw)
 {
-	if (clk->get_rate)
-		return clk->get_rate(clk);
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val = __raw_readl(psc->reg);
 
-	return clk->rate;
+	if (!(val & EP93XX_SYSCON_CLKDIV_ESEL))
+		return 0;
+
+	if (!(val & EP93XX_SYSCON_CLKDIV_PSEL))
+		return 1;
+
+	return 2;
 }
-EXPORT_SYMBOL(clk_get_rate);
 
-static int set_keytchclk_rate(struct clk *clk, unsigned long rate)
+static int ep93xx_mux_set_parent_lock(struct clk_hw *hw, u8 index)
 {
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long flags = 0;
 	u32 val;
-	u32 div_bit;
 
-	val = __raw_readl(clk->enable_reg);
+	if (index >= ARRAY_SIZE(mux_parents))
+		return -EINVAL;
 
-	/*
-	 * The Key Matrix and ADC clocks are configured using the same
-	 * System Controller register.  The clock used will be either
-	 * 1/4 or 1/16 the external clock rate depending on the
-	 * EP93XX_SYSCON_KEYTCHCLKDIV_KDIV/EP93XX_SYSCON_KEYTCHCLKDIV_ADIV
-	 * bit being set or cleared.
-	 */
-	div_bit = clk->enable_mask >> 15;
+	if (psc->lock)
+		spin_lock_irqsave(psc->lock, flags);
 
-	if (rate == EP93XX_KEYTCHCLK_DIV4)
-		val |= div_bit;
-	else if (rate == EP93XX_KEYTCHCLK_DIV16)
-		val &= ~div_bit;
-	else
-		return -EINVAL;
+	val = __raw_readl(psc->reg);
+	val &= ~(EP93XX_SYSCON_CLKDIV_ESEL | EP93XX_SYSCON_CLKDIV_PSEL);
+
+
+	if (index != 0) {
+		val |= EP93XX_SYSCON_CLKDIV_ESEL;
+		val |= (index - 1) ? EP93XX_SYSCON_CLKDIV_PSEL : 0;
+	}
+
+	ep93xx_syscon_swlocked_write(val, psc->reg);
+
+	if (psc->lock)
+		spin_unlock_irqrestore(psc->lock, flags);
 
-	ep93xx_syscon_swlocked_write(val, clk->enable_reg);
-	clk->rate = rate;
 	return 0;
 }
 
-static int calc_clk_div(struct clk *clk, unsigned long rate,
-			int *psel, int *esel, int *pdiv, int *div)
+static bool is_best(unsigned long rate, unsigned long now,
+		     unsigned long best)
 {
-	struct clk *mclk;
-	unsigned long max_rate, actual_rate, mclk_rate, rate_err = -1;
-	int i, found = 0, __div = 0, __pdiv = 0;
+	return abs(rate - now) < abs(rate - best);
+}
 
-	/* Don't exceed the maximum rate */
-	max_rate = max3(clk_pll1.rate / 4, clk_pll2.rate / 4, clk_xtali.rate / 4);
-	rate = min(rate, max_rate);
+static int ep93xx_mux_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	unsigned long rate = req->rate;
+	struct clk *best_parent = 0;
+	unsigned long __parent_rate;
+	unsigned long best_rate = 0, actual_rate, mclk_rate;
+	unsigned long best_parent_rate;
+	int __div = 0, __pdiv = 0;
+	int i;
 
 	/*
 	 * Try the two pll's and the external clock
@@ -376,14 +223,11 @@ static int calc_clk_div(struct clk *clk, unsigned long rate,
 	 * http://be-a-maverick.com/en/pubs/appNote/AN269REV1.pdf
 	 *
 	 */
-	for (i = 0; i < 3; i++) {
-		if (i == 0)
-			mclk = &clk_xtali;
-		else if (i == 1)
-			mclk = &clk_pll1;
-		else
-			mclk = &clk_pll2;
-		mclk_rate = mclk->rate * 2;
+	for (i = 0; i < ARRAY_SIZE(mux_parents); i++) {
+		struct clk *parent = clk_get_sys(mux_parents[i], NULL);
+
+		__parent_rate = clk_get_rate(parent);
+		mclk_rate = __parent_rate * 2;
 
 		/* Try each predivider value */
 		for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
@@ -392,197 +236,494 @@ static int calc_clk_div(struct clk *clk, unsigned long rate,
 				continue;
 
 			actual_rate = mclk_rate / (__pdiv * __div);
-
-			if (!found || abs(actual_rate - rate) < rate_err) {
-				*pdiv = __pdiv - 3;
-				*div = __div;
-				*psel = (i == 2);
-				*esel = (i != 0);
-				clk->parent = mclk;
-				clk->rate = actual_rate;
-				rate_err = abs(actual_rate - rate);
-				found = 1;
+			if (is_best(rate, actual_rate, best_rate)) {
+				best_rate = actual_rate;
+				best_parent_rate = __parent_rate;
+				best_parent = parent;
 			}
 		}
 	}
 
-	if (!found)
+	if (!best_parent)
 		return -EINVAL;
 
+	req->best_parent_rate = best_parent_rate;
+	req->best_parent_hw = __clk_get_hw(best_parent);
+	req->rate = best_rate;
+
 	return 0;
 }
 
-static int set_div_rate(struct clk *clk, unsigned long rate)
+static unsigned long ep93xx_ddiv_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
-	int err, psel = 0, esel = 0, pdiv = 0, div = 0;
-	u32 val;
-
-	err = calc_clk_div(clk, rate, &psel, &esel, &pdiv, &div);
-	if (err)
-		return err;
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long rate = 0;
+	u32 val = __raw_readl(psc->reg);
+	int __pdiv = ((val >> EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) & 0x03);
+	int __div = val & 0x7f;
 
-	/* Clear the esel, psel, pdiv and div bits */
-	val = __raw_readl(clk->enable_reg);
-	val &= ~0x7fff;
+	if (__div > 0)
+		rate = (parent_rate * 2) / ((__pdiv + 3) * __div);
 
-	/* Set the new esel, psel, pdiv and div bits for the new clock rate */
-	val |= (esel ? EP93XX_SYSCON_CLKDIV_ESEL : 0) |
-		(psel ? EP93XX_SYSCON_CLKDIV_PSEL : 0) |
-		(pdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | div;
-	ep93xx_syscon_swlocked_write(val, clk->enable_reg);
-	return 0;
+	return rate;
 }
 
-static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate)
+static int ep93xx_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
 {
-	unsigned val = __raw_readl(clk->enable_reg);
-
-	if (rate == clk_i2s_mclk.rate / 2)
-		ep93xx_syscon_swlocked_write(val & ~EP93XX_I2SCLKDIV_SDIV, 
-					     clk->enable_reg);
-	else if (rate == clk_i2s_mclk.rate / 4)
-		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_SDIV, 
-					     clk->enable_reg);
-	else
+	struct clk_psc *psc = to_clk_psc(hw);
+	int pdiv = 0, div = 0;
+	unsigned long best_rate = 0, actual_rate, mclk_rate;
+	int __div = 0, __pdiv = 0;
+	u32 val;
+
+	mclk_rate = parent_rate * 2;
+
+	for (__pdiv = 4; __pdiv <= 6; __pdiv++) {
+		__div = mclk_rate / (rate * __pdiv);
+		if (__div < 2 || __div > 127)
+			continue;
+
+		actual_rate = mclk_rate / (__pdiv * __div);
+		if (is_best(rate, actual_rate, best_rate)) {
+			pdiv = __pdiv - 3;
+			div = __div;
+			best_rate = actual_rate;
+		}
+	}
+
+	if (!best_rate)
 		return -EINVAL;
 
-	clk_i2s_sclk.rate = rate;
+	val = __raw_readl(psc->reg);
+
+	/* Clear old dividers */
+	val &= ~0x37f;
+
+	/* Set the new pdiv and div bits for the new clock rate */
+	val |= (pdiv << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | div;
+	ep93xx_syscon_swlocked_write(val, psc->reg);
+
 	return 0;
 }
 
-static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned val = __raw_readl(clk->enable_reg) & 
-		~EP93XX_I2SCLKDIV_LRDIV_MASK;
-	
-	if (rate == clk_i2s_sclk.rate / 32)
-		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV32,
-					     clk->enable_reg);
-	else if (rate == clk_i2s_sclk.rate / 64)
-		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV64,
-					     clk->enable_reg);
-	else if (rate == clk_i2s_sclk.rate / 128)
-		ep93xx_syscon_swlocked_write(val | EP93XX_I2SCLKDIV_LRDIV128,
-					     clk->enable_reg);
-	else
-		return -EINVAL;
+static const struct clk_ops clk_ddiv_ops = {
+	.enable = ep93xx_clk_enable,
+	.disable = ep93xx_clk_disable,
+	.is_enabled = ep93xx_clk_is_enabled,
+	.get_parent = ep93xx_mux_get_parent,
+	.set_parent = ep93xx_mux_set_parent_lock,
+	.determine_rate = ep93xx_mux_determine_rate,
+	.recalc_rate = ep93xx_ddiv_recalc_rate,
+	.set_rate = ep93xx_ddiv_set_rate,
+};
 
-	clk_i2s_lrclk.rate = rate;
-	return 0;
+static struct clk_hw *clk_hw_register_ddiv(const char *name,
+					  void __iomem *reg,
+					  u8 bit_idx)
+{
+	struct clk_init_data init;
+	struct clk_psc *psc;
+	struct clk *clk;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &clk_ddiv_ops;
+	init.flags = 0;
+	init.parent_names = mux_parents;
+	init.num_parents = ARRAY_SIZE(mux_parents);
+
+	psc->reg = reg;
+	psc->bit_idx = bit_idx;
+	psc->lock = &clk_lock;
+	psc->hw.init = &init;
+
+	clk = clk_register(NULL, &psc->hw);
+	if (IS_ERR(clk))
+		kfree(psc);
+
+	return &psc->hw;
 }
 
-int clk_set_rate(struct clk *clk, unsigned long rate)
+static unsigned long ep93xx_div_recalc_rate(struct clk_hw *hw,
+					    unsigned long parent_rate)
 {
-	if (clk->set_rate)
-		return clk->set_rate(clk, rate);
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val = __raw_readl(psc->reg);
+	u8 index = (val & psc->mask) >> psc->shift;
 
-	return -EINVAL;
+	if (index > psc->num_div)
+		return 0;
+
+	return DIV_ROUND_UP_ULL(parent_rate, psc->div[index]);
 }
-EXPORT_SYMBOL(clk_set_rate);
 
-long clk_round_rate(struct clk *clk, unsigned long rate)
+static long ep93xx_div_round_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long *parent_rate)
 {
-	WARN_ON(clk);
-	return 0;
+	struct clk_psc *psc = to_clk_psc(hw);
+	unsigned long best = 0, now, maxdiv;
+	int i;
+
+	maxdiv = psc->div[psc->num_div - 1];
+
+	for (i = 0; i < psc->num_div; i++) {
+		if ((rate * psc->div[i]) == *parent_rate)
+			return DIV_ROUND_UP_ULL((u64)*parent_rate, psc->div[i]);
+
+		now = DIV_ROUND_UP_ULL((u64)*parent_rate, psc->div[i]);
+
+		if (is_best(rate, now, best))
+			best = now;
+	}
+
+	if (!best)
+		best = DIV_ROUND_UP_ULL(*parent_rate, maxdiv);
+
+	return best;
 }
-EXPORT_SYMBOL(clk_round_rate);
 
-int clk_set_parent(struct clk *clk, struct clk *parent)
+static int ep93xx_div_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
 {
-	WARN_ON(clk);
+	struct clk_psc *psc = to_clk_psc(hw);
+	u32 val = __raw_readl(psc->reg) & ~psc->mask;
+	int i;
+
+	for (i = 0; i < psc->num_div; i++)
+		if (rate == parent_rate / psc->div[i]) {
+			val |= i << psc->shift;
+			break;
+		}
+
+	if (i == psc->num_div)
+		return -EINVAL;
+
+	ep93xx_syscon_swlocked_write(val, psc->reg);
+
 	return 0;
 }
-EXPORT_SYMBOL(clk_set_parent);
 
-struct clk *clk_get_parent(struct clk *clk)
+static const struct clk_ops ep93xx_div_ops = {
+	.enable = ep93xx_clk_enable,
+	.disable = ep93xx_clk_disable,
+	.is_enabled = ep93xx_clk_is_enabled,
+	.recalc_rate = ep93xx_div_recalc_rate,
+	.round_rate = ep93xx_div_round_rate,
+	.set_rate = ep93xx_div_set_rate,
+};
+
+static struct clk_hw *clk_hw_register_div(const char *name,
+					  const char *parent_name,
+					  void __iomem *reg,
+					  u8 enable_bit,
+					  u8 shift,
+					  u8 width,
+					  char *clk_divisors,
+					  u8 num_div)
 {
-	return clk->parent;
+	struct clk_init_data init;
+	struct clk_psc *psc;
+	struct clk *clk;
+
+	psc = kzalloc(sizeof(*psc), GFP_KERNEL);
+	if (!psc)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = name;
+	init.ops = &ep93xx_div_ops;
+	init.flags = 0;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = 1;
+
+	psc->reg = reg;
+	psc->bit_idx = enable_bit;
+	psc->mask = GENMASK(shift + width - 1, shift);
+	psc->shift = shift;
+	psc->div = clk_divisors;
+	psc->num_div = num_div;
+	psc->lock = &clk_lock;
+	psc->hw.init = &init;
+
+	clk = clk_register(NULL, &psc->hw);
+	if (IS_ERR(clk))
+		kfree(psc);
+
+	return &psc->hw;
 }
-EXPORT_SYMBOL(clk_get_parent);
 
+struct ep93xx_gate {
+	unsigned int bit;
+	const char *dev_id;
+	const char *con_id;
+};
 
-static char fclk_divisors[] = { 1, 2, 4, 8, 16, 1, 1, 1 };
-static char hclk_divisors[] = { 1, 2, 4, 5, 6, 8, 16, 32 };
-static char pclk_divisors[] = { 1, 2, 4, 8 };
+static struct ep93xx_gate ep93xx_uarts[] = {
+	{EP93XX_SYSCON_DEVCFG_U1EN, "apb:uart1", NULL},
+	{EP93XX_SYSCON_DEVCFG_U2EN, "apb:uart2", NULL},
+	{EP93XX_SYSCON_DEVCFG_U3EN, "apb:uart3", NULL},
+};
 
-/*
- * PLL rate = 14.7456 MHz * (X1FBD + 1) * (X2FBD + 1) / (X2IPD + 1) / 2^PS
- */
-static unsigned long calc_pll_rate(u32 config_word)
+static void __init ep93xx_uart_clock_init(void)
 {
-	unsigned long long rate;
-	int i;
+	unsigned int i;
+	struct clk_hw *hw;
+	u32 value;
+	unsigned int clk_uart_div;
 
-	rate = clk_xtali.rate;
-	rate *= ((config_word >> 11) & 0x1f) + 1;		/* X1FBD */
-	rate *= ((config_word >> 5) & 0x3f) + 1;		/* X2FBD */
-	do_div(rate, (config_word & 0x1f) + 1);			/* X2IPD */
-	for (i = 0; i < ((config_word >> 16) & 3); i++)		/* PS */
-		rate >>= 1;
+	value = __raw_readl(EP93XX_SYSCON_PWRCNT);
+	if (value & EP93XX_SYSCON_PWRCNT_UARTBAUD)
+		clk_uart_div = 1;
+	else
+		clk_uart_div = 2;
 
-	return (unsigned long)rate;
+	hw = clk_hw_register_fixed_factor(NULL, "uart", "xtali", 0, 1, clk_uart_div);
+
+	/* parenting uart gate clocks to uart clock */
+	for (i = 0; i < ARRAY_SIZE(ep93xx_uarts); i++) {
+		hw = ep93xx_clk_register_gate(ep93xx_uarts[i].dev_id,
+					"uart",
+					EP93XX_SYSCON_DEVCFG,
+					ep93xx_uarts[i].bit);
+
+		clk_hw_register_clkdev(hw, NULL, ep93xx_uarts[i].dev_id);
+	}
 }
 
+static struct ep93xx_gate ep93xx_dmas[] = {
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P0, NULL, "m2p0"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P1, NULL, "m2p1"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P2, NULL, "m2p2"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P3, NULL, "m2p3"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P4, NULL, "m2p4"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P5, NULL, "m2p5"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P6, NULL, "m2p6"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P7, NULL, "m2p7"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P8, NULL, "m2p8"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2P9, NULL, "m2p9"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2M0, NULL, "m2m0"},
+	{EP93XX_SYSCON_PWRCNT_DMA_M2M1, NULL, "m2m1"},
+};
+
 static void __init ep93xx_dma_clock_init(void)
 {
-	clk_m2p0.rate = clk_h.rate;
-	clk_m2p1.rate = clk_h.rate;
-	clk_m2p2.rate = clk_h.rate;
-	clk_m2p3.rate = clk_h.rate;
-	clk_m2p4.rate = clk_h.rate;
-	clk_m2p5.rate = clk_h.rate;
-	clk_m2p6.rate = clk_h.rate;
-	clk_m2p7.rate = clk_h.rate;
-	clk_m2p8.rate = clk_h.rate;
-	clk_m2p9.rate = clk_h.rate;
-	clk_m2m0.rate = clk_h.rate;
-	clk_m2m1.rate = clk_h.rate;
+	unsigned int i;
+	struct clk_hw *hw;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(ep93xx_dmas); i++) {
+		hw = clk_hw_register_gate(NULL, ep93xx_dmas[i].con_id,
+					"hclk", 0,
+					EP93XX_SYSCON_PWRCNT,
+					ep93xx_dmas[i].bit,
+					0,
+					&clk_lock);
+
+		ret = clk_hw_register_clkdev(hw, ep93xx_dmas[i].con_id, NULL);
+		if (ret)
+			pr_err("%s: failed to register lookup %s\n",
+			       __func__, ep93xx_dmas[i].con_id);
+	}
 }
 
 static int __init ep93xx_clock_init(void)
 {
 	u32 value;
+	struct clk_hw *hw;
+	unsigned long clk_pll1_rate;
+	unsigned long clk_f_rate;
+	unsigned long clk_h_rate;
+	unsigned long clk_p_rate;
+	unsigned long clk_pll2_rate;
+	unsigned int clk_f_div;
+	unsigned int clk_h_div;
+	unsigned int clk_p_div;
+	unsigned int clk_usb_div;
+	unsigned long clk_spi_div;
+
+	hw = clk_hw_register_fixed_rate(NULL, "xtali", NULL, 0, EP93XX_EXT_CLK_RATE);
+	clk_hw_register_clkdev(hw, NULL, "xtali");
 
 	/* Determine the bootloader configured pll1 rate */
 	value = __raw_readl(EP93XX_SYSCON_CLKSET1);
 	if (!(value & EP93XX_SYSCON_CLKSET1_NBYP1))
-		clk_pll1.rate = clk_xtali.rate;
+		clk_pll1_rate = EP93XX_EXT_CLK_RATE;
 	else
-		clk_pll1.rate = calc_pll_rate(value);
+		clk_pll1_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
+
+	hw = clk_hw_register_fixed_rate(NULL, "pll1", "xtali", 0, clk_pll1_rate);
+	clk_hw_register_clkdev(hw, NULL, "pll1");
 
 	/* Initialize the pll1 derived clocks */
-	clk_f.rate = clk_pll1.rate / fclk_divisors[(value >> 25) & 0x7];
-	clk_h.rate = clk_pll1.rate / hclk_divisors[(value >> 20) & 0x7];
-	clk_p.rate = clk_h.rate / pclk_divisors[(value >> 18) & 0x3];
+	clk_f_div = fclk_divisors[(value >> 25) & 0x7];
+	clk_h_div = hclk_divisors[(value >> 20) & 0x7];
+	clk_p_div = pclk_divisors[(value >> 18) & 0x3];
+
+	hw = clk_hw_register_fixed_factor(NULL, "fclk", "pll1", 0, 1, clk_f_div);
+	clk_f_rate = clk_get_rate(hw->clk);
+	hw = clk_hw_register_fixed_factor(NULL, "hclk", "pll1", 0, 1, clk_h_div);
+	clk_h_rate = clk_get_rate(hw->clk);
+	hw = clk_hw_register_fixed_factor(NULL, "pclk", "hclk", 0, 1, clk_p_div);
+	clk_p_rate = clk_get_rate(hw->clk);
+
+	clk_hw_register_clkdev(hw, "apb_pclk", NULL);
+
 	ep93xx_dma_clock_init();
 
 	/* Determine the bootloader configured pll2 rate */
 	value = __raw_readl(EP93XX_SYSCON_CLKSET2);
 	if (!(value & EP93XX_SYSCON_CLKSET2_NBYP2))
-		clk_pll2.rate = clk_xtali.rate;
+		clk_pll2_rate = EP93XX_EXT_CLK_RATE;
 	else if (value & EP93XX_SYSCON_CLKSET2_PLL2_EN)
-		clk_pll2.rate = calc_pll_rate(value);
+		clk_pll2_rate = calc_pll_rate(EP93XX_EXT_CLK_RATE, value);
 	else
-		clk_pll2.rate = 0;
+		clk_pll2_rate = 0;
+
+	hw = clk_hw_register_fixed_rate(NULL, "pll2", "xtali", 0, clk_pll2_rate);
+	clk_hw_register_clkdev(hw, NULL, "pll2");
 
 	/* Initialize the pll2 derived clocks */
-	clk_usb_host.rate = clk_pll2.rate / (((value >> 28) & 0xf) + 1);
+	/*
+	 * These four bits set the divide ratio between the PLL2
+	 * output and the USB clock.
+	 * 0000 - Divide by 1
+	 * 0001 - Divide by 2
+	 * 0010 - Divide by 3
+	 * 0011 - Divide by 4
+	 * 0100 - Divide by 5
+	 * 0101 - Divide by 6
+	 * 0110 - Divide by 7
+	 * 0111 - Divide by 8
+	 * 1000 - Divide by 9
+	 * 1001 - Divide by 10
+	 * 1010 - Divide by 11
+	 * 1011 - Divide by 12
+	 * 1100 - Divide by 13
+	 * 1101 - Divide by 14
+	 * 1110 - Divide by 15
+	 * 1111 - Divide by 1
+	 * On power-on-reset these bits are reset to 0000b.
+	 */
+	clk_usb_div = (((value >> 28) & 0xf) + 1);
+	hw = clk_hw_register_fixed_factor(NULL, "usb_clk", "pll2", 0, 1, clk_usb_div);
+	hw = clk_hw_register_gate(NULL, "ohci-platform",
+				"usb_clk", 0,
+				EP93XX_SYSCON_PWRCNT,
+				EP93XX_SYSCON_PWRCNT_USH_EN,
+				0,
+				&clk_lock);
+	clk_hw_register_clkdev(hw, NULL, "ohci-platform");
 
 	/*
 	 * EP93xx SSP clock rate was doubled in version E2. For more information
 	 * see:
 	 *     http://www.cirrus.com/en/pubs/appNote/AN273REV4.pdf
 	 */
+	clk_spi_div = 1;
 	if (ep93xx_chip_revision() < EP93XX_CHIP_REV_E2)
-		clk_spi.rate /= 2;
+		clk_spi_div = 2;
+	hw = clk_hw_register_fixed_factor(NULL, "ep93xx-spi.0", "xtali", 0, 1, clk_spi_div);
+	clk_hw_register_clkdev(hw, NULL, "ep93xx-spi.0");
+
+	/* pwm clock */
+	hw = clk_hw_register_fixed_factor(NULL, "pwm_clk", "xtali", 0, 1, 1);
+	clk_hw_register_clkdev(hw, "pwm_clk", NULL);
 
 	pr_info("PLL1 running at %ld MHz, PLL2 at %ld MHz\n",
-		clk_pll1.rate / 1000000, clk_pll2.rate / 1000000);
+		clk_pll1_rate / 1000000, clk_pll2_rate / 1000000);
 	pr_info("FCLK %ld MHz, HCLK %ld MHz, PCLK %ld MHz\n",
-		clk_f.rate / 1000000, clk_h.rate / 1000000,
-		clk_p.rate / 1000000);
+		clk_f_rate / 1000000, clk_h_rate / 1000000,
+		clk_p_rate / 1000000);
+
+	ep93xx_uart_clock_init();
+
+	/* touchscreen/adc clock */
+	hw = clk_hw_register_div("ep93xx-adc",
+				"xtali",
+				EP93XX_SYSCON_KEYTCHCLKDIV,
+				EP93XX_SYSCON_KEYTCHCLKDIV_TSEN,
+				EP93XX_SYSCON_KEYTCHCLKDIV_ADIV,
+				1,
+				adc_divisors,
+				ARRAY_SIZE(adc_divisors));
+
+	clk_hw_register_clkdev(hw, NULL, "ep93xx-adc");
+
+	/* keypad clock */
+	hw = clk_hw_register_div("ep93xx-keypad",
+				"xtali",
+				EP93XX_SYSCON_KEYTCHCLKDIV,
+				EP93XX_SYSCON_KEYTCHCLKDIV_KEN,
+				EP93XX_SYSCON_KEYTCHCLKDIV_KDIV,
+				1,
+				adc_divisors,
+				ARRAY_SIZE(adc_divisors));
+
+	clk_hw_register_clkdev(hw, NULL, "ep93xx-keypad");
+
+	/* On reset PDIV and VDIV is set to zero, while PDIV zero
+	 * means clock disable, VDIV shouldn't be zero.
+	 * So i set both dividers to minimum.
+	 */
+	/* ENA - Enable CLK divider. */
+	/* PDIV - 00 - Disable clock */
+	/* VDIV - at least 2 */
+	/* Check and enable video clk registers */
+	value = __raw_readl(EP93XX_SYSCON_VIDCLKDIV);
+	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
+	ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_VIDCLKDIV);
+
+	/* check and enable i2s clk registers */
+	value = __raw_readl(EP93XX_SYSCON_I2SCLKDIV);
+	value |= (1 << EP93XX_SYSCON_CLKDIV_PDIV_SHIFT) | 2;
+	ep93xx_syscon_swlocked_write(value, EP93XX_SYSCON_I2SCLKDIV);
+
+	/* video clk */
+	hw = clk_hw_register_ddiv("ep93xx-fb",
+				EP93XX_SYSCON_VIDCLKDIV,
+				EP93XX_SYSCON_CLKDIV_ENABLE);
+
+	clk_hw_register_clkdev(hw, NULL, "ep93xx-fb");
+
+	/* i2s clk */
+	hw = clk_hw_register_ddiv("mclk",
+				EP93XX_SYSCON_I2SCLKDIV,
+				EP93XX_SYSCON_CLKDIV_ENABLE);
+
+	clk_hw_register_clkdev(hw, "mclk", "ep93xx-i2s");
+
+	/* i2s sclk */
+#define EP93XX_I2SCLKDIV_SDIV_SHIFT	16
+#define EP93XX_I2SCLKDIV_SDIV_WIDTH	1
+	hw = clk_hw_register_div("sclk",
+				"mclk",
+				EP93XX_SYSCON_I2SCLKDIV,
+				EP93XX_SYSCON_I2SCLKDIV_SENA,
+				EP93XX_I2SCLKDIV_SDIV_SHIFT,
+				EP93XX_I2SCLKDIV_SDIV_WIDTH,
+				sclk_divisors,
+				ARRAY_SIZE(sclk_divisors));
+
+	clk_hw_register_clkdev(hw, "sclk", "ep93xx-i2s");
+
+	/* i2s lrclk */
+#define EP93XX_I2SCLKDIV_LRDIV32_SHIFT	17
+#define EP93XX_I2SCLKDIV_LRDIV32_WIDTH	3
+	hw = clk_hw_register_div("lrclk",
+				"sclk",
+				EP93XX_SYSCON_I2SCLKDIV,
+				EP93XX_SYSCON_I2SCLKDIV_SENA,
+				EP93XX_I2SCLKDIV_LRDIV32_SHIFT,
+				EP93XX_I2SCLKDIV_LRDIV32_WIDTH,
+				lrclk_divisors,
+				ARRAY_SIZE(lrclk_divisors));
+
+	clk_hw_register_clkdev(hw, "lrclk", "ep93xx-i2s");
 
-	clkdev_add_table(clocks, ARRAY_SIZE(clocks));
 	return 0;
 }
 postcore_initcall(ep93xx_clock_init);
diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
index 6fb19a393fd2..bbb79f263331 100644
--- a/arch/arm/mach-ep93xx/core.c
+++ b/arch/arm/mach-ep93xx/core.c
@@ -214,7 +214,7 @@ static int ep93xx_ohci_power_on(struct platform_device *pdev)
 			return PTR_ERR(ep93xx_ohci_host_clock);
 	}
 
-	return clk_enable(ep93xx_ohci_host_clock);
+	return clk_prepare_enable(ep93xx_ohci_host_clock);
 }
 
 static void ep93xx_ohci_power_off(struct platform_device *pdev)
diff --git a/arch/arm/mach-ep93xx/soc.h b/arch/arm/mach-ep93xx/soc.h
index f2dace1c9154..94ef7f275f94 100644
--- a/arch/arm/mach-ep93xx/soc.h
+++ b/arch/arm/mach-ep93xx/soc.h
@@ -111,19 +111,19 @@
 #define EP93XX_SYSCON_PWRCNT		EP93XX_SYSCON_REG(0x04)
 #define EP93XX_SYSCON_PWRCNT_FIR_EN	(1<<31)
 #define EP93XX_SYSCON_PWRCNT_UARTBAUD	(1<<29)
-#define EP93XX_SYSCON_PWRCNT_USH_EN	(1<<28)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2M1	(1<<27)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2M0	(1<<26)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P8	(1<<25)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P9	(1<<24)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P6	(1<<23)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P7	(1<<22)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P4	(1<<21)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P5	(1<<20)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P2	(1<<19)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P3	(1<<18)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P0	(1<<17)
-#define EP93XX_SYSCON_PWRCNT_DMA_M2P1	(1<<16)
+#define EP93XX_SYSCON_PWRCNT_USH_EN	28
+#define EP93XX_SYSCON_PWRCNT_DMA_M2M1	27
+#define EP93XX_SYSCON_PWRCNT_DMA_M2M0	26
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P8	25
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P9	24
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P6	23
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P7	22
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P4	21
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P5	20
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P2	19
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P3	18
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P0	17
+#define EP93XX_SYSCON_PWRCNT_DMA_M2P1	16
 #define EP93XX_SYSCON_HALT		EP93XX_SYSCON_REG(0x08)
 #define EP93XX_SYSCON_STANDBY		EP93XX_SYSCON_REG(0x0c)
 #define EP93XX_SYSCON_CLKSET1		EP93XX_SYSCON_REG(0x20)
@@ -139,13 +139,13 @@
 #define EP93XX_SYSCON_DEVCFG_GONK	(1<<27)
 #define EP93XX_SYSCON_DEVCFG_TONG	(1<<26)
 #define EP93XX_SYSCON_DEVCFG_MONG	(1<<25)
-#define EP93XX_SYSCON_DEVCFG_U3EN	(1<<24)
+#define EP93XX_SYSCON_DEVCFG_U3EN	24
 #define EP93XX_SYSCON_DEVCFG_CPENA	(1<<23)
 #define EP93XX_SYSCON_DEVCFG_A2ONG	(1<<22)
 #define EP93XX_SYSCON_DEVCFG_A1ONG	(1<<21)
-#define EP93XX_SYSCON_DEVCFG_U2EN	(1<<20)
+#define EP93XX_SYSCON_DEVCFG_U2EN	20
 #define EP93XX_SYSCON_DEVCFG_EXVC	(1<<19)
-#define EP93XX_SYSCON_DEVCFG_U1EN	(1<<18)
+#define EP93XX_SYSCON_DEVCFG_U1EN	18
 #define EP93XX_SYSCON_DEVCFG_TIN	(1<<17)
 #define EP93XX_SYSCON_DEVCFG_HC3IN	(1<<15)
 #define EP93XX_SYSCON_DEVCFG_HC3EN	(1<<14)
@@ -163,12 +163,12 @@
 #define EP93XX_SYSCON_DEVCFG_KEYS	(1<<1)
 #define EP93XX_SYSCON_DEVCFG_SHENA	(1<<0)
 #define EP93XX_SYSCON_VIDCLKDIV		EP93XX_SYSCON_REG(0x84)
-#define EP93XX_SYSCON_CLKDIV_ENABLE	(1<<15)
+#define EP93XX_SYSCON_CLKDIV_ENABLE	15
 #define EP93XX_SYSCON_CLKDIV_ESEL	(1<<14)
 #define EP93XX_SYSCON_CLKDIV_PSEL	(1<<13)
 #define EP93XX_SYSCON_CLKDIV_PDIV_SHIFT	8
 #define EP93XX_SYSCON_I2SCLKDIV		EP93XX_SYSCON_REG(0x8c)
-#define EP93XX_SYSCON_I2SCLKDIV_SENA	(1<<31)
+#define EP93XX_SYSCON_I2SCLKDIV_SENA	31
 #define EP93XX_SYSCON_I2SCLKDIV_ORIDE   (1<<29)
 #define EP93XX_SYSCON_I2SCLKDIV_SPOL	(1<<19)
 #define EP93XX_I2SCLKDIV_SDIV		(1 << 16)
@@ -177,9 +177,9 @@
 #define EP93XX_I2SCLKDIV_LRDIV128	(2 << 17)
 #define EP93XX_I2SCLKDIV_LRDIV_MASK	(3 << 17)
 #define EP93XX_SYSCON_KEYTCHCLKDIV	EP93XX_SYSCON_REG(0x90)
-#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	(1<<31)
-#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	(1<<16)
-#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	(1<<15)
+#define EP93XX_SYSCON_KEYTCHCLKDIV_TSEN	31
+#define EP93XX_SYSCON_KEYTCHCLKDIV_ADIV	16
+#define EP93XX_SYSCON_KEYTCHCLKDIV_KEN	15
 #define EP93XX_SYSCON_KEYTCHCLKDIV_KDIV	(1<<0)
 #define EP93XX_SYSCON_SYSCFG		EP93XX_SYSCON_REG(0x9c)
 #define EP93XX_SYSCON_SYSCFG_REV_MASK	(0xf0000000)
-- 
2.26.2

