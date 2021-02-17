Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7382B31D5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhBQHeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhBQHeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:34:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6D7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:33:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v6so7751748ybk.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=jXWGHt9jRwVqp50Y7QYDvOSA4wdR1J9h5f49GquQC6Q=;
        b=icHc+0qqXNEUprO/LB7t+8OmRF1LT0qCGgyKI5LqNzKu9rgMrZtXFit3T6ngeoO7aP
         /8ZSqgmpANeTZp2VqYOjCTN8a85d7Dy0D99R1SQhqLeCbT/A9GALQocHW/ehkt/PQSOS
         nN3WO9ver1Aq3EE/4v0lo7V+oHa0Lv6HSeKT5AzwC7uW6wfv5mAdgB1l08dtejo5H6+U
         dZKtMaJ21EWz8WELcjTbGDopr2cKcfcUeUQYMjAa8YyEoF6bpPuC1VKIcU8LeuaPoB3F
         QUlao6Pj/3np2mIDn5OoV3qbnhuUpOXUbCy66pTAwNmH7JbGh5te0FDgch6Anx+iWAwX
         KwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jXWGHt9jRwVqp50Y7QYDvOSA4wdR1J9h5f49GquQC6Q=;
        b=Dxwz+9i0+d+snhvJ0HGx7k0wty00wOSvgFEFGnvoNgPdkHtRfz/Ksh9eVQLFYhgfec
         vvtUxG1kAS1E8rPLuoXQM7mlZTzq3qiypQyGLFb03H4aJ81kZwDghVWlAcUmfT0WNbH8
         p6+rz6IT1YXPck20tSyKY6VgpPNQpNxVnGn/v2IXEkGo/pQaBnaeNmoYyBUHw0SnF2L/
         n2O1JAA8/WSjNQ5zrC5UbYKlbUAonMBU+1SCWTPHZFu63k1eCSk7486olSXvDPGFeRUo
         Eo8Gbv4PLGG15Pd0u4Tit9eNiF76YzX367KDdtA1anXFj5WB9FvS0ydHxbnYHoV2cQlL
         2AAg==
X-Gm-Message-State: AOAM531h3NpMJCNHHiE8zfkOUQSNfghVXo7AAWApi3c50Y1c8Sgh+Sr0
        ZlQXT5GsdqB4vAQwvJcfBGhgops=
X-Google-Smtp-Source: ABdhPJyYTPhKUxVvdRer1weKgSDCNhHFFAYHgcJ2oMhr8mX7eVNgDsnYPbb269S/vlUxoeFl5ZWP6W4=
Sender: "wak via sendgmr" <wak@wak-linux.svl.corp.google.com>
X-Received: from wak-linux.svl.corp.google.com ([2620:15c:2c5:3:e984:b7fc:110a:274a])
 (user=wak job=sendgmr) by 2002:a25:e54:: with SMTP id 81mr35003501ybo.404.1613547223024;
 Tue, 16 Feb 2021 23:33:43 -0800 (PST)
Date:   Tue, 16 Feb 2021 23:33:15 -0800
In-Reply-To: <20210217073318.540369-1-wak@google.com>
Message-Id: <20210217073318.540369-2-wak@google.com>
Mime-Version: 1.0
References: <20210217073318.540369-1-wak@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 2/4] ipmi: kcs_bmc: Remove register abstraction
From:   "William A. Kennington III" <wak@google.com>
To:     Corey Minyard <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "William A. Kennington III" <wak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic kcs_bmc code doesn't care about how byte reads / writes are
implemented. This pushes that logic to the device specific handlers, so
that kcs_bmc doesn't need to understand registers and how to read
or write them.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 drivers/char/ipmi/kcs_bmc.c         |  60 +++++----------
 drivers/char/ipmi/kcs_bmc.h         |  13 +---
 drivers/char/ipmi/kcs_bmc_aspeed.c  | 110 +++++++++++++++++-----------
 drivers/char/ipmi/kcs_bmc_npcm7xx.c |  60 +++++++++------
 4 files changed, 130 insertions(+), 113 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index ccb35f1645cf..aa2093323622 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -45,34 +45,12 @@ enum kcs_states {
 #define KCS_CMD_WRITE_END         0x62
 #define KCS_CMD_READ_BYTE         0x68
 
-static inline u8 read_data(struct kcs_bmc *kcs_bmc)
-{
-	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.idr);
-}
-
-static inline void write_data(struct kcs_bmc *kcs_bmc, u8 data)
-{
-	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.odr, data);
-}
-
-static inline u8 read_status(struct kcs_bmc *kcs_bmc)
-{
-	return kcs_bmc->io_inputb(kcs_bmc, kcs_bmc->ioreg.str);
-}
-
-static inline void write_status(struct kcs_bmc *kcs_bmc, u8 data)
-{
-	kcs_bmc->io_outputb(kcs_bmc, kcs_bmc->ioreg.str, data);
-}
-
 static void update_status_bits(struct kcs_bmc *kcs_bmc, u8 mask, u8 val)
 {
-	u8 tmp = read_status(kcs_bmc);
-
+	u8 tmp = kcs_bmc->read_status(kcs_bmc);
 	tmp &= ~mask;
 	tmp |= val & mask;
-
-	write_status(kcs_bmc, tmp);
+	kcs_bmc->write_status(kcs_bmc, tmp);
 }
 
 static inline void set_state(struct kcs_bmc *kcs_bmc, u8 state)
@@ -84,8 +62,8 @@ static inline void set_state(struct kcs_bmc *kcs_bmc, u8 state)
 static void kcs_force_abort(struct kcs_bmc *kcs_bmc)
 {
 	set_state(kcs_bmc, ERROR_STATE);
-	read_data(kcs_bmc);
-	write_data(kcs_bmc, KCS_ZERO_DATA);
+	kcs_bmc->read_data_in(kcs_bmc);
+	kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
 
 	kcs_bmc->phase = KCS_PHASE_ERROR;
 	kcs_bmc->data_in_avail = false;
@@ -104,9 +82,9 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 	case KCS_PHASE_WRITE_DATA:
 		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
 			set_state(kcs_bmc, WRITE_STATE);
-			write_data(kcs_bmc, KCS_ZERO_DATA);
+			kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
 			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
-						read_data(kcs_bmc);
+						kcs_bmc->read_data_in(kcs_bmc);
 		} else {
 			kcs_force_abort(kcs_bmc);
 			kcs_bmc->error = KCS_LENGTH_ERROR;
@@ -117,7 +95,7 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 		if (kcs_bmc->data_in_idx < KCS_MSG_BUFSIZ) {
 			set_state(kcs_bmc, READ_STATE);
 			kcs_bmc->data_in[kcs_bmc->data_in_idx++] =
-						read_data(kcs_bmc);
+						kcs_bmc->read_data_in(kcs_bmc);
 			kcs_bmc->phase = KCS_PHASE_WRITE_DONE;
 			kcs_bmc->data_in_avail = true;
 			wake_up_interruptible(&kcs_bmc->queue);
@@ -131,34 +109,34 @@ static void kcs_bmc_handle_data(struct kcs_bmc *kcs_bmc)
 		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len)
 			set_state(kcs_bmc, IDLE_STATE);
 
-		data = read_data(kcs_bmc);
+		data = kcs_bmc->read_data_in(kcs_bmc);
 		if (data != KCS_CMD_READ_BYTE) {
 			set_state(kcs_bmc, ERROR_STATE);
-			write_data(kcs_bmc, KCS_ZERO_DATA);
+			kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
 			break;
 		}
 
 		if (kcs_bmc->data_out_idx == kcs_bmc->data_out_len) {
-			write_data(kcs_bmc, KCS_ZERO_DATA);
+			kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
 			kcs_bmc->phase = KCS_PHASE_IDLE;
 			break;
 		}
 
-		write_data(kcs_bmc,
+		kcs_bmc->write_data_out(kcs_bmc,
 			kcs_bmc->data_out[kcs_bmc->data_out_idx++]);
 		break;
 
 	case KCS_PHASE_ABORT_ERROR1:
 		set_state(kcs_bmc, READ_STATE);
-		read_data(kcs_bmc);
-		write_data(kcs_bmc, kcs_bmc->error);
+		kcs_bmc->read_data_in(kcs_bmc);
+		kcs_bmc->write_data_out(kcs_bmc, kcs_bmc->error);
 		kcs_bmc->phase = KCS_PHASE_ABORT_ERROR2;
 		break;
 
 	case KCS_PHASE_ABORT_ERROR2:
 		set_state(kcs_bmc, IDLE_STATE);
-		read_data(kcs_bmc);
-		write_data(kcs_bmc, KCS_ZERO_DATA);
+		kcs_bmc->read_data_in(kcs_bmc);
+		kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
 		kcs_bmc->phase = KCS_PHASE_IDLE;
 		break;
 
@@ -173,9 +151,9 @@ static void kcs_bmc_handle_cmd(struct kcs_bmc *kcs_bmc)
 	u8 cmd;
 
 	set_state(kcs_bmc, WRITE_STATE);
-	write_data(kcs_bmc, KCS_ZERO_DATA);
+	kcs_bmc->write_data_out(kcs_bmc, KCS_ZERO_DATA);
 
-	cmd = read_data(kcs_bmc);
+	cmd = kcs_bmc->read_data_in(kcs_bmc);
 	switch (cmd) {
 	case KCS_CMD_WRITE_START:
 		kcs_bmc->phase = KCS_PHASE_WRITE_START;
@@ -218,7 +196,7 @@ irqreturn_t kcs_bmc_irq(int irq, void *arg)
 
 	spin_lock_irqsave(&kcs_bmc->lock, flags);
 
-	status = read_status(kcs_bmc);
+	status = kcs_bmc->read_status(kcs_bmc);
 	if (status & KCS_STATUS_IBF) {
 		if (!kcs_bmc->running)
 			kcs_force_abort(kcs_bmc);
@@ -355,7 +333,7 @@ static ssize_t kcs_bmc_write(struct file *filp, const char __user *buf,
 		kcs_bmc->data_out_idx = 1;
 		kcs_bmc->data_out_len = count;
 		memcpy(kcs_bmc->data_out, kcs_bmc->kbuffer, count);
-		write_data(kcs_bmc, kcs_bmc->data_out[0]);
+		kcs_bmc->write_data_out(kcs_bmc, kcs_bmc->data_out[0]);
 		ret = count;
 	} else {
 		ret = -EINVAL;
diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index 959d7042e6d2..8c541251fe97 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -61,12 +61,6 @@ enum kcs_errors {
  * @odr: Output Data Register
  * @str: Status Register
  */
-struct kcs_ioreg {
-	u32 idr;
-	u32 odr;
-	u32 str;
-};
-
 struct kcs_bmc {
 	spinlock_t lock;
 
@@ -74,9 +68,10 @@ struct kcs_bmc {
 	int running;
 
 	/* Setup by BMC KCS controller driver */
-	struct kcs_ioreg ioreg;
-	u8 (*io_inputb)(struct kcs_bmc *kcs_bmc, u32 reg);
-	void (*io_outputb)(struct kcs_bmc *kcs_bmc, u32 reg, u8 b);
+	u8 (*read_status)(struct kcs_bmc *kcs_bmc);
+	void (*write_status)(struct kcs_bmc *kcs_bmc, u8 b);
+	u8 (*read_data_in)(struct kcs_bmc *kcs_bmc);
+	void (*write_data_out)(struct kcs_bmc *kcs_bmc, u8 b);
 
 	enum kcs_phases phase;
 	enum kcs_errors error;
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 6451a8af2664..d3b771e4d039 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -62,30 +62,55 @@
 #define LPC_ODR4             0x098
 #define LPC_STR4             0x09C
 
-struct aspeed_kcs_bmc {
+struct aspeed_kcs_reg {
+	u32 idr;
+	u32 odr;
+	u32 str;
+};
+
+struct aspeed_kcs {
 	struct regmap *map;
+
+	const struct aspeed_kcs_reg *reg;
 };
 
 
-static u8 aspeed_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
+static u8 aspeed_kcs_inb(struct aspeed_kcs *aspeed_kcs, u32 reg)
 {
-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
 	u32 val = 0;
-	int rc;
-
-	rc = regmap_read(priv->map, reg, &val);
+	int rc = regmap_read(aspeed_kcs->map, reg, &val);
 	WARN(rc != 0, "regmap_read() failed: %d\n", rc);
+	return val;
+}
 
-	return rc == 0 ? (u8) val : 0;
+static void aspeed_kcs_outb(struct aspeed_kcs *aspeed_kcs, u32 reg, u8 data)
+{
+	int rc = regmap_write(aspeed_kcs->map, reg, data);
+	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
 }
 
-static void aspeed_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
+static u8 aspeed_kcs_read_status(struct kcs_bmc *kcs_bmc)
 {
-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
-	int rc;
+	struct aspeed_kcs *aspeed_kcs = kcs_bmc_priv(kcs_bmc);
+	return aspeed_kcs_inb(aspeed_kcs, aspeed_kcs->reg->str);
+}
 
-	rc = regmap_write(priv->map, reg, data);
-	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
+static void aspeed_kcs_write_status(struct kcs_bmc *kcs_bmc, u8 data)
+{
+	struct aspeed_kcs *aspeed_kcs = kcs_bmc_priv(kcs_bmc);
+	aspeed_kcs_outb(aspeed_kcs, aspeed_kcs->reg->str, data);
+}
+
+static u8 aspeed_kcs_read_data_in(struct kcs_bmc *kcs_bmc)
+{
+	struct aspeed_kcs *aspeed_kcs = kcs_bmc_priv(kcs_bmc);
+	return aspeed_kcs_inb(aspeed_kcs, aspeed_kcs->reg->idr);
+}
+
+static void aspeed_kcs_write_data_out(struct kcs_bmc *kcs_bmc, u8 data)
+{
+	struct aspeed_kcs *aspeed_kcs = kcs_bmc_priv(kcs_bmc);
+	aspeed_kcs_outb(aspeed_kcs, aspeed_kcs->reg->odr, data);
 }
 
 
@@ -104,7 +129,7 @@ static void aspeed_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
  */
 static void aspeed_kcs_set_address(struct kcs_bmc *kcs_bmc, u16 addr)
 {
-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
+	struct aspeed_kcs *priv = kcs_bmc_priv(kcs_bmc);
 
 	switch (kcs_bmc->channel) {
 	case 1:
@@ -138,7 +163,7 @@ static void aspeed_kcs_set_address(struct kcs_bmc *kcs_bmc, u16 addr)
 
 static void aspeed_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
 {
-	struct aspeed_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
+	struct aspeed_kcs *priv = kcs_bmc_priv(kcs_bmc);
 
 	switch (kcs_bmc->channel) {
 	case 1:
@@ -217,7 +242,7 @@ static int aspeed_kcs_config_irq(struct kcs_bmc *kcs_bmc,
 				dev_name(dev), kcs_bmc);
 }
 
-static const struct kcs_ioreg ast_kcs_bmc_ioregs[KCS_CHANNEL_MAX] = {
+static const struct aspeed_kcs_reg aspeed_kcs_regs[KCS_CHANNEL_MAX] = {
 	{ .idr = LPC_IDR1, .odr = LPC_ODR1, .str = LPC_STR1 },
 	{ .idr = LPC_IDR2, .odr = LPC_ODR2, .str = LPC_STR2 },
 	{ .idr = LPC_IDR3, .odr = LPC_ODR3, .str = LPC_STR3 },
@@ -226,7 +251,7 @@ static const struct kcs_ioreg ast_kcs_bmc_ioregs[KCS_CHANNEL_MAX] = {
 
 static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
 {
-	struct aspeed_kcs_bmc *priv;
+	struct aspeed_kcs *priv;
 	struct device_node *np;
 	struct kcs_bmc *kcs;
 	u32 channel;
@@ -241,7 +266,7 @@ static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
+	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs), channel);
 	if (!kcs)
 		return ERR_PTR(-ENOMEM);
 
@@ -258,18 +283,18 @@ static struct kcs_bmc *aspeed_kcs_probe_of_v1(struct platform_device *pdev)
 		return ERR_PTR(-EINVAL);
 	}
 
-	kcs->ioreg = ast_kcs_bmc_ioregs[channel - 1];
+	priv->reg = &aspeed_kcs_regs[channel - 1];
 	aspeed_kcs_set_address(kcs, slave);
 
 	return kcs;
 }
 
-static int aspeed_kcs_calculate_channel(const struct kcs_ioreg *regs)
+static int aspeed_kcs_calculate_channel(const struct aspeed_kcs_reg *reg)
 {
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(ast_kcs_bmc_ioregs); i++) {
-		if (!memcmp(&ast_kcs_bmc_ioregs[i], regs, sizeof(*regs)))
+	for (i = 0; i < ARRAY_SIZE(aspeed_kcs_regs); i++) {
+		if (!memcmp(&aspeed_kcs_regs[i], reg, sizeof(*reg)))
 			return i + 1;
 	}
 
@@ -278,11 +303,11 @@ static int aspeed_kcs_calculate_channel(const struct kcs_ioreg *regs)
 
 static struct kcs_bmc *aspeed_kcs_probe_of_v2(struct platform_device *pdev)
 {
-	struct aspeed_kcs_bmc *priv;
+	struct aspeed_kcs *priv;
 	struct device_node *np;
-	struct kcs_ioreg ioreg;
+	struct aspeed_kcs_reg reg;
 	struct kcs_bmc *kcs;
-	const __be32 *reg;
+	const __be32 *of_reg;
 	int channel;
 	u32 slave;
 	int rc;
@@ -290,32 +315,31 @@ static struct kcs_bmc *aspeed_kcs_probe_of_v2(struct platform_device *pdev)
 	np = pdev->dev.of_node;
 
 	/* Don't translate addresses, we want offsets for the regmaps */
-	reg = of_get_address(np, 0, NULL, NULL);
-	if (!reg)
+	of_reg = of_get_address(np, 0, NULL, NULL);
+	if (!of_reg)
 		return ERR_PTR(-EINVAL);
-	ioreg.idr = be32_to_cpup(reg);
+	reg.idr = be32_to_cpup(of_reg);
 
-	reg = of_get_address(np, 1, NULL, NULL);
-	if (!reg)
+	of_reg = of_get_address(np, 1, NULL, NULL);
+	if (!of_reg)
 		return ERR_PTR(-EINVAL);
-	ioreg.odr = be32_to_cpup(reg);
+	reg.odr = be32_to_cpup(of_reg);
 
-	reg = of_get_address(np, 2, NULL, NULL);
-	if (!reg)
+	of_reg = of_get_address(np, 2, NULL, NULL);
+	if (!of_reg)
 		return ERR_PTR(-EINVAL);
-	ioreg.str = be32_to_cpup(reg);
+	reg.str = be32_to_cpup(of_reg);
 
-	channel = aspeed_kcs_calculate_channel(&ioreg);
+	channel = aspeed_kcs_calculate_channel(&reg);
 	if (channel < 0)
 		return ERR_PTR(channel);
 
-	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs_bmc), channel);
+	kcs = kcs_bmc_alloc(&pdev->dev, sizeof(struct aspeed_kcs), channel);
 	if (!kcs)
 		return ERR_PTR(-ENOMEM);
 
-	kcs->ioreg = ioreg;
-
 	priv = kcs_bmc_priv(kcs);
+	priv->reg = &aspeed_kcs_regs[channel - 1];
 	priv->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
 	if (IS_ERR(priv->map)) {
 		dev_err(&pdev->dev, "Couldn't get regmap\n");
@@ -335,6 +359,7 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct kcs_bmc *kcs_bmc;
+	struct aspeed_kcs *priv;
 	struct device_node *np;
 	int rc;
 
@@ -351,8 +376,10 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 	if (IS_ERR(kcs_bmc))
 		return PTR_ERR(kcs_bmc);
 
-	kcs_bmc->io_inputb = aspeed_kcs_inb;
-	kcs_bmc->io_outputb = aspeed_kcs_outb;
+	kcs_bmc->read_status = aspeed_kcs_read_status;
+	kcs_bmc->write_status = aspeed_kcs_write_status;
+	kcs_bmc->read_data_in = aspeed_kcs_read_data_in;
+	kcs_bmc->write_data_out = aspeed_kcs_write_data_out;
 
 	rc = aspeed_kcs_config_irq(kcs_bmc, pdev);
 	if (rc)
@@ -368,10 +395,11 @@ static int aspeed_kcs_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	priv = kcs_bmc_priv(kcs_bmc);
 	dev_dbg(&pdev->dev,
 		"Probed KCS device %d (IDR=0x%x, ODR=0x%x, STR=0x%x)\n",
-		kcs_bmc->channel, kcs_bmc->ioreg.idr, kcs_bmc->ioreg.odr,
-		kcs_bmc->ioreg.str);
+		kcs_bmc->channel, priv->reg->idr, priv->reg->odr,
+		priv->reg->str);
 
 	return 0;
 }
diff --git a/drivers/char/ipmi/kcs_bmc_npcm7xx.c b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
index f417813cf900..572501f7da71 100644
--- a/drivers/char/ipmi/kcs_bmc_npcm7xx.c
+++ b/drivers/char/ipmi/kcs_bmc_npcm7xx.c
@@ -64,7 +64,7 @@ struct npcm7xx_kcs_reg {
 	u32 ie;
 };
 
-struct npcm7xx_kcs_bmc {
+struct npcm7xx_kcs {
 	struct regmap *map;
 
 	const struct npcm7xx_kcs_reg *reg;
@@ -76,30 +76,47 @@ static const struct npcm7xx_kcs_reg npcm7xx_kcs_reg_tbl[KCS_CHANNEL_MAX] = {
 	{ .sts = KCS3ST, .dob = KCS3DO, .dib = KCS3DI, .ctl = KCS3CTL, .ie = KCS3IE },
 };
 
-static u8 npcm7xx_kcs_inb(struct kcs_bmc *kcs_bmc, u32 reg)
+static u8 npcm7xx_kcs_inb(struct npcm7xx_kcs *npcm7xx_kcs, u32 reg)
 {
-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
 	u32 val = 0;
-	int rc;
-
-	rc = regmap_read(priv->map, reg, &val);
+	int rc = regmap_read(npcm7xx_kcs->map, reg, &val);
 	WARN(rc != 0, "regmap_read() failed: %d\n", rc);
+	return val;
+}
 
-	return rc == 0 ? (u8)val : 0;
+static void npcm7xx_kcs_outb(struct npcm7xx_kcs *npcm7xx_kcs, u32 reg, u8 data)
+{
+	int rc = regmap_write(npcm7xx_kcs->map, reg, data);
+	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
 }
 
-static void npcm7xx_kcs_outb(struct kcs_bmc *kcs_bmc, u32 reg, u8 data)
+static u8 npcm7xx_kcs_read_status(struct kcs_bmc *kcs_bmc)
 {
-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
-	int rc;
+	struct npcm7xx_kcs *npcm7xx_kcs = kcs_bmc_priv(kcs_bmc);
+	return npcm7xx_kcs_inb(npcm7xx_kcs, npcm7xx_kcs->reg->sts);
+}
 
-	rc = regmap_write(priv->map, reg, data);
-	WARN(rc != 0, "regmap_write() failed: %d\n", rc);
+static void npcm7xx_kcs_write_status(struct kcs_bmc *kcs_bmc, u8 data)
+{
+	struct npcm7xx_kcs *npcm7xx_kcs = kcs_bmc_priv(kcs_bmc);
+	npcm7xx_kcs_outb(npcm7xx_kcs, npcm7xx_kcs->reg->sts, data);
+}
+
+static u8 npcm7xx_kcs_read_data_in(struct kcs_bmc *kcs_bmc)
+{
+	struct npcm7xx_kcs *npcm7xx_kcs = kcs_bmc_priv(kcs_bmc);
+	return npcm7xx_kcs_inb(npcm7xx_kcs, npcm7xx_kcs->reg->dib);
+}
+
+static void npcm7xx_kcs_write_data_out(struct kcs_bmc *kcs_bmc, u8 data)
+{
+	struct npcm7xx_kcs *npcm7xx_kcs = kcs_bmc_priv(kcs_bmc);
+	npcm7xx_kcs_outb(npcm7xx_kcs, npcm7xx_kcs->reg->dob, data);
 }
 
 static void npcm7xx_kcs_enable_channel(struct kcs_bmc *kcs_bmc, bool enable)
 {
-	struct npcm7xx_kcs_bmc *priv = kcs_bmc_priv(kcs_bmc);
+	struct npcm7xx_kcs *priv = kcs_bmc_priv(kcs_bmc);
 
 	regmap_update_bits(priv->map, priv->reg->ctl, KCS_CTL_IBFIE,
 			   enable ? KCS_CTL_IBFIE : 0);
@@ -125,7 +142,7 @@ static int npcm7xx_kcs_config_irq(struct kcs_bmc *kcs_bmc,
 static int npcm7xx_kcs_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct npcm7xx_kcs_bmc *priv;
+	struct npcm7xx_kcs *priv;
 	struct kcs_bmc *kcs_bmc;
 	u32 chan;
 	int rc;
@@ -148,11 +165,10 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
 	}
 	priv->reg = &npcm7xx_kcs_reg_tbl[chan - 1];
 
-	kcs_bmc->ioreg.idr = priv->reg->dib;
-	kcs_bmc->ioreg.odr = priv->reg->dob;
-	kcs_bmc->ioreg.str = priv->reg->sts;
-	kcs_bmc->io_inputb = npcm7xx_kcs_inb;
-	kcs_bmc->io_outputb = npcm7xx_kcs_outb;
+	kcs_bmc->read_status = npcm7xx_kcs_read_status;
+	kcs_bmc->write_status = npcm7xx_kcs_write_status;
+	kcs_bmc->read_data_in = npcm7xx_kcs_read_data_in;
+	kcs_bmc->write_data_out = npcm7xx_kcs_write_data_out;
 
 	dev_set_drvdata(dev, kcs_bmc);
 
@@ -167,9 +183,9 @@ static int npcm7xx_kcs_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	pr_info("channel=%u idr=0x%x odr=0x%x str=0x%x\n",
-		chan,
-		kcs_bmc->ioreg.idr, kcs_bmc->ioreg.odr, kcs_bmc->ioreg.str);
+	dev_dbg(&pdev->dev,
+		"Probed KCS device %d (DIB=0x%x, DOB=0x%x, STS=0x%x )\n",
+		chan, priv->reg->dib, priv->reg->dob, priv->reg->sts);
 
 	return 0;
 }
-- 
2.30.0.478.g8a0d178c01-goog

