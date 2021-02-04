Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8177C30E9E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhBDCCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:02:55 -0500
Received: from mail.v3.sk ([167.172.186.51]:53782 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234515AbhBDCCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:02:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B29C3E0BB1;
        Thu,  4 Feb 2021 01:57:51 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i1GTECU_Kxz7; Thu,  4 Feb 2021 01:57:51 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1D2C7E0BB3;
        Thu,  4 Feb 2021 01:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fZ-ZKh38JzfT; Thu,  4 Feb 2021 01:57:50 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id ADD4FE0BB1;
        Thu,  4 Feb 2021 01:57:50 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Ivan Najdanovic <najdanovicivan@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/1] clk: mmp2: Enable the 3D GPU clock alongside the 2D clock
Date:   Thu,  4 Feb 2021 03:01:55 +0100
Message-Id: <20210204020155.527556-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210204020155.527556-1-lkundrak@v3.sk>
References: <20210204020155.527556-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bits intended to control the 3D GPU clock need to be enabled for the
2D GPU to work. It is not clear why this needs to be done.

Forcing the 3D clock on when the etnaviv driver requests a 2D clock
works around the problem.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-gate.c    |  9 ++++++++-
 drivers/clk/mmp/clk-of-mmp2.c |  2 +-
 drivers/clk/mmp/clk.c         |  3 ++-
 drivers/clk/mmp/clk.h         | 10 +++++++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mmp/clk-gate.c b/drivers/clk/mmp/clk-gate.c
index 1755916ddef2d..bf93ffb258667 100644
--- a/drivers/clk/mmp/clk-gate.c
+++ b/drivers/clk/mmp/clk-gate.c
@@ -9,6 +9,7 @@
  * warranty of any kind, whether express or implied.
  */
=20
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -31,6 +32,8 @@ static int mmp_clk_gate_enable(struct clk_hw *hw)
 	unsigned long rate;
 	u32 tmp;
=20
+	clk_prepare_enable(gate->companion);
+
 	if (gate->lock)
 		spin_lock_irqsave(gate->lock, flags);
=20
@@ -67,6 +70,8 @@ static void mmp_clk_gate_disable(struct clk_hw *hw)
=20
 	if (gate->lock)
 		spin_unlock_irqrestore(gate->lock, flags);
+
+	clk_disable_unprepare(gate->companion);
 }
=20
 static int mmp_clk_gate_is_enabled(struct clk_hw *hw)
@@ -95,7 +100,8 @@ const struct clk_ops mmp_clk_gate_ops =3D {
 struct clk *mmp_clk_register_gate(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u32 mask, u32 val_enable, u32 val_disable,
-		unsigned int gate_flags, spinlock_t *lock)
+		unsigned int gate_flags, spinlock_t *lock,
+		struct clk *companion)
 {
 	struct mmp_clk_gate *gate;
 	struct clk *clk;
@@ -119,6 +125,7 @@ struct clk *mmp_clk_register_gate(struct device *dev,=
 const char *name,
 	gate->val_disable =3D val_disable;
 	gate->flags =3D gate_flags;
 	gate->lock =3D lock;
+	gate->companion =3D companion;
 	gate->hw.init =3D &init;
=20
 	clk =3D clk_register(dev, &gate->hw);
diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index 8b2eb989980bf..7ac96a1dcd60c 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -394,7 +394,7 @@ static struct mmp_param_gate_clk mmp2_apmu_gate_clks[=
] =3D {
 static struct mmp_param_gate_clk mmp3_apmu_gate_clks[] =3D {
 	{MMP3_CLK_SDH4, "sdh4_clk", "sdh_mix_clk", CLK_SET_RATE_PARENT, APMU_SD=
H4, 0x1b, 0x1b, 0x0, 0, &sdh_lock},
 	{MMP3_CLK_GPU_3D, "gpu_3d_clk", "gpu_3d_div", CLK_SET_RATE_PARENT, APMU=
_GPU, 0x5, 0x5, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
-	{MMP3_CLK_GPU_2D, "gpu_2d_clk", "gpu_2d_div", CLK_SET_RATE_PARENT, APMU=
_GPU, 0x1c0000, 0x1c0000, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock},
+	{MMP3_CLK_GPU_2D, "gpu_2d_clk", "gpu_2d_div", CLK_SET_RATE_PARENT, APMU=
_GPU, 0x1c0000, 0x1c0000, 0x0, MMP_CLK_GATE_NEED_DELAY, &gpu_lock, MMP3_C=
LK_GPU_3D},
 };
=20
 static void mmp2_axi_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
diff --git a/drivers/clk/mmp/clk.c b/drivers/clk/mmp/clk.c
index ca7d37e2c7be6..05d2b901cae5f 100644
--- a/drivers/clk/mmp/clk.c
+++ b/drivers/clk/mmp/clk.c
@@ -109,7 +109,8 @@ void mmp_register_gate_clks(struct mmp_clk_unit *unit=
,
 					clks[i].val_enable,
 					clks[i].val_disable,
 					clks[i].gate_flags,
-					clks[i].lock);
+					clks[i].lock,
+					unit->clk_table[clks[i].companion_id]);
=20
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 55ac053797819..385b74e671c31 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -117,6 +117,13 @@ struct mmp_clk_gate {
 	u32 val_disable;
 	unsigned int flags;
 	spinlock_t *lock;
+
+	/*
+	 * The sole purpose of this is to make sure the 3D GPU clock gets
+	 * enabled alongside 2D GPU clock, otherwise the 2D unit wouldn't
+	 * work. It is not know why this needs to be done.
+	 */
+	struct clk *companion;
 };
=20
 extern const struct clk_ops mmp_clk_gate_ops;
@@ -124,7 +131,7 @@ extern struct clk *mmp_clk_register_gate(struct devic=
e *dev, const char *name,
 			const char *parent_name, unsigned long flags,
 			void __iomem *reg, u32 mask, u32 val_enable,
 			u32 val_disable, unsigned int gate_flags,
-			spinlock_t *lock);
+			spinlock_t *lock, struct clk *companion);
=20
 extern struct clk *mmp_clk_register_apbc(const char *name,
 		const char *parent_name, void __iomem *base,
@@ -187,6 +194,7 @@ struct mmp_param_gate_clk {
 	u32 val_disable;
 	unsigned int gate_flags;
 	spinlock_t *lock;
+	unsigned int companion_id;
 };
 void mmp_register_gate_clks(struct mmp_clk_unit *unit,
 			struct mmp_param_gate_clk *clks,
--=20
2.29.2

