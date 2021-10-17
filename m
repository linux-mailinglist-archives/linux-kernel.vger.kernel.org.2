Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8643085B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbhJQL2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:28:09 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:60707 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbhJQL2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:28:08 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id bca8902c;
        Sun, 17 Oct 2021 13:25:55 +0200 (CEST)
Date:   Sun, 17 Oct 2021 13:25:55 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     jassisinghbrar@gmail.com, sven@svenpeter.dev, robh+dt@kernel.org,
        marcan@marcan.st, alyssa@rosenzweig.io,
        mohamed.mediouni@caramail.com, stan@corellium.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210916154911.3168-3-sven@svenpeter.dev> (message from Sven
        Peter on Thu, 16 Sep 2021 17:49:11 +0200)
Subject: Re: [PATCH v2 2/2] mailbox: apple: Add driver for Apple mailboxes
References: <20210916154911.3168-1-sven@svenpeter.dev> <20210916154911.3168-3-sven@svenpeter.dev>
Message-ID: <d3ca67dc326fb052@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sven Peter <sven@svenpeter.dev>
> Date: Thu, 16 Sep 2021 17:49:11 +0200

Hi Sven,

> Apple SoCs such as the M1 come with various co-processors. Mailboxes
> are used to communicate with those. This driver adds support for
> two variants of those mailboxes.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  MAINTAINERS                     |   2 +
>  drivers/mailbox/Kconfig         |  12 +
>  drivers/mailbox/Makefile        |   2 +
>  drivers/mailbox/apple-mailbox.c | 431 ++++++++++++++++++++++++++++++++
>  include/linux/apple-mailbox.h   |  18 ++
>  5 files changed, 465 insertions(+)
>  create mode 100644 drivers/mailbox/apple-mailbox.c
>  create mode 100644 include/linux/apple-mailbox.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 47de27282c98..cf0500bbea5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1724,8 +1724,10 @@ F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/irqchip/irq-apple-aic.c
> +F:	drivers/mailbox/apple-mailbox.c
>  F:	include/dt-bindings/interrupt-controller/apple-aic.h
>  F:	include/dt-bindings/pinctrl/apple.h
> +F:	include/linux/apple-mailbox.h
>  
>  ARM/ARTPEC MACHINE SUPPORT
>  M:	Jesper Nilsson <jesper.nilsson@axis.com>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index c9fc06c7e685..d9cd3606040e 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -8,6 +8,18 @@ menuconfig MAILBOX
>  
>  if MAILBOX
>  
> +config APPLE_MAILBOX
> +	tristate "Apple Mailbox driver"
> +	depends on ARCH_APPLE || (ARM64 && COMPILE_TEST)
> +	default ARCH_APPLE
> +	help
> +	  Apple SoCs have various co-processors required for certain
> +	  peripherals to work (NVMe, display controller, etc.). This
> +	  driver adds support for the mailbox controller used to
> +	  communicate with those.
> +
> +	  Say Y here if you have a Apple SoC.
> +
>  config ARM_MHU
>  	tristate "ARM MHU Mailbox"
>  	depends on ARM_AMBA
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index c2089f04887e..338cc05e5431 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -58,3 +58,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>  obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
>  
>  obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
> +
> +obj-$(CONFIG_APPLE_MAILBOX)	+= apple-mailbox.o
> diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
> new file mode 100644
> index 000000000000..2622a6369075
> --- /dev/null
> +++ b/drivers/mailbox/apple-mailbox.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Apple mailbox driver
> + *
> + * Copyright (C) 2021 The Asahi Linux Contributors
> + *
> + * This driver adds support for two mailbox variants (called ASC and M3 by
> + * Apple) found in Apple SoCs such as the M1. It consists of two FIFOs used to
> + * exchange 64+32 bit messages between the main CPU and a co-processor.
> + * Various coprocessors implement different IPC protocols based on these simple
> + * messages and shared memory buffers.
> + *
> + * Both the main CPU and the co-processor see the same set of registers but
> + * the first FIFO (A2I) is always used to transfer messages from the application
> + * processor (us) to the I/O processor and the second one (I2A) for the
> + * other direction.
> + */
> +
> +#include <linux/apple-mailbox.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/gfp.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#define APPLE_ASC_MBOX_CONTROL_FULL  BIT(16)
> +#define APPLE_ASC_MBOX_CONTROL_EMPTY BIT(17)
> +
> +#define APPLE_ASC_MBOX_A2I_CONTROL 0x110
> +#define APPLE_ASC_MBOX_A2I_SEND0   0x800
> +#define APPLE_ASC_MBOX_A2I_SEND1   0x808
> +#define APPLE_ASC_MBOX_A2I_RECV0   0x810
> +#define APPLE_ASC_MBOX_A2I_RECV1   0x818
> +
> +#define APPLE_ASC_MBOX_I2A_CONTROL 0x114
> +#define APPLE_ASC_MBOX_I2A_SEND0   0x820
> +#define APPLE_ASC_MBOX_I2A_SEND1   0x828
> +#define APPLE_ASC_MBOX_I2A_RECV0   0x830
> +#define APPLE_ASC_MBOX_I2A_RECV1   0x838
> +
> +#define APPLE_M3_MBOX_CONTROL_FULL  BIT(16)
> +#define APPLE_M3_MBOX_CONTROL_EMPTY BIT(17)
> +
> +#define APPLE_M3_MBOX_A2I_CONTROL 0x50
> +#define APPLE_M3_MBOX_A2I_SEND0	  0x60
> +#define APPLE_M3_MBOX_A2I_SEND1	  0x68
> +#define APPLE_M3_MBOX_A2I_RECV0	  0x70
> +#define APPLE_M3_MBOX_A2I_RECV1	  0x78
> +
> +#define APPLE_M3_MBOX_I2A_CONTROL 0x80
> +#define APPLE_M3_MBOX_I2A_SEND0	  0x90
> +#define APPLE_M3_MBOX_I2A_SEND1	  0x98
> +#define APPLE_M3_MBOX_I2A_RECV0	  0xa0
> +#define APPLE_M3_MBOX_I2A_RECV1	  0xa8
> +
> +#define APPLE_M3_MBOX_IRQ_ENABLE	0x48
> +#define APPLE_M3_MBOX_IRQ_ACK		0x4c
> +#define APPLE_M3_MBOX_IRQ_A2I_EMPTY	BIT(0)
> +#define APPLE_M3_MBOX_IRQ_A2I_NOT_EMPTY BIT(1)
> +#define APPLE_M3_MBOX_IRQ_I2A_EMPTY	BIT(2)
> +#define APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY BIT(3)
> +
> +#define APPLE_MBOX_MSG1_OUTCNT GENMASK(56, 52)
> +#define APPLE_MBOX_MSG1_INCNT  GENMASK(51, 48)
> +#define APPLE_MBOX_MSG1_OUTPTR GENMASK(47, 44)
> +#define APPLE_MBOX_MSG1_INPTR  GENMASK(43, 40)
> +#define APPLE_MBOX_MSG1_MSG    GENMASK(31, 0)
> +
> +struct apple_mbox_hw {
> +	unsigned int control_full;
> +	unsigned int control_empty;
> +
> +	unsigned int a2i_control;
> +	unsigned int a2i_send0;
> +	unsigned int a2i_send1;
> +
> +	unsigned int i2a_control;
> +	unsigned int i2a_recv0;
> +	unsigned int i2a_recv1;
> +
> +	bool has_irq_controls;
> +	unsigned int irq_enable;
> +	unsigned int irq_ack;
> +	unsigned int irq_bit_recv_not_empty;
> +	unsigned int irq_bit_send_empty;
> +};
> +
> +static const struct apple_mbox_hw apple_mbox_asc_hw = {
> +	.control_full = APPLE_ASC_MBOX_CONTROL_FULL,
> +	.control_empty = APPLE_ASC_MBOX_CONTROL_EMPTY,
> +
> +	.a2i_control = APPLE_ASC_MBOX_A2I_CONTROL,
> +	.a2i_send0 = APPLE_ASC_MBOX_A2I_SEND0,
> +	.a2i_send1 = APPLE_ASC_MBOX_A2I_SEND1,
> +
> +	.i2a_control = APPLE_ASC_MBOX_I2A_CONTROL,
> +	.i2a_recv0 = APPLE_ASC_MBOX_I2A_RECV0,
> +	.i2a_recv1 = APPLE_ASC_MBOX_I2A_RECV1,
> +
> +	.has_irq_controls = false,
> +};
> +
> +static const struct apple_mbox_hw apple_mbox_m3_hw = {
> +	.control_full = APPLE_M3_MBOX_CONTROL_FULL,
> +	.control_empty = APPLE_M3_MBOX_CONTROL_EMPTY,
> +
> +	.a2i_control = APPLE_M3_MBOX_A2I_CONTROL,
> +	.a2i_send0 = APPLE_M3_MBOX_A2I_SEND0,
> +	.a2i_send1 = APPLE_M3_MBOX_A2I_SEND1,
> +
> +	.i2a_control = APPLE_M3_MBOX_I2A_CONTROL,
> +	.i2a_recv0 = APPLE_M3_MBOX_I2A_RECV0,
> +	.i2a_recv1 = APPLE_M3_MBOX_I2A_RECV1,
> +
> +	.has_irq_controls = true,
> +	.irq_enable = APPLE_M3_MBOX_IRQ_ENABLE,
> +	.irq_ack = APPLE_M3_MBOX_IRQ_ACK,
> +	.irq_bit_recv_not_empty = APPLE_M3_MBOX_IRQ_I2A_NOT_EMPTY,
> +	.irq_bit_send_empty = APPLE_M3_MBOX_IRQ_A2I_EMPTY,
> +};
> +
> +static const struct of_device_id apple_mbox_of_match[] = {
> +	{ .compatible = "apple,t8103-asc-mailbox", .data = &apple_mbox_asc_hw },
> +	{ .compatible = "apple,t8103-m3-mailbox", .data = &apple_mbox_m3_hw },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, apple_mbox_of_match);
> +
> +struct apple_mbox {
> +	void __iomem *regs;
> +	const struct apple_mbox_hw *hw;
> +
> +	int irq_recv_not_empty;
> +	int irq_send_empty;
> +
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +
> +	struct mbox_chan chan;
> +
> +	struct device *dev;
> +	struct mbox_controller controller;
> +};
> +
> +static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
> +{
> +	u32 mbox_ctrl =
> +		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
> +
> +	return !(mbox_ctrl & apple_mbox->hw->control_full);
> +}
> +
> +static int apple_mbox_hw_send(struct apple_mbox *apple_mbox,
> +			      struct apple_mbox_msg *msg)
> +{
> +	if (!apple_mbox_hw_can_send(apple_mbox))
> +		return -EBUSY;
> +
> +	dev_dbg(apple_mbox->dev, "> TX %016llx %08x\n", msg->msg0, msg->msg1);
> +
> +	/*
> +	 * This message may be related to a shared memory buffer and we must
> +	 * ensure all previous writes to normal memory are visible before
> +	 * submitting it.
> +	 */
> +	dma_wmb();
> +
> +	writeq_relaxed(msg->msg0, apple_mbox->regs + apple_mbox->hw->a2i_send0);
> +	writeq_relaxed(FIELD_PREP(APPLE_MBOX_MSG1_MSG, msg->msg1),
> +		       apple_mbox->regs + apple_mbox->hw->a2i_send1);
> +
> +	return 0;
> +}
> +
> +static bool apple_mbox_hw_can_recv(struct apple_mbox *apple_mbox)
> +{
> +	u32 mbox_ctrl =
> +		readl_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_control);
> +
> +	return !(mbox_ctrl & apple_mbox->hw->control_empty);
> +}
> +
> +static int apple_mbox_hw_recv(struct apple_mbox *apple_mbox,
> +			      struct apple_mbox_msg *msg)
> +{
> +	if (!apple_mbox_hw_can_recv(apple_mbox))
> +		return -ENOMSG;
> +
> +	msg->msg0 = readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv0);
> +	msg->msg1 = FIELD_GET(
> +		APPLE_MBOX_MSG1_MSG,
> +		readq_relaxed(apple_mbox->regs + apple_mbox->hw->i2a_recv1));
> +
> +	dev_dbg(apple_mbox->dev, "< RX %016llx %08x\n", msg->msg0, msg->msg1);
> +
> +	/*
> +	 * This message may be related to a shared memory buffer and we must
> +	 * ensure any following reads from normal memory only happen after
> +	 * having read this message.
> +	 */
> +	dma_rmb();
> +
> +	return 0;
> +}
> +
> +static int apple_mbox_chan_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct apple_mbox *apple_mbox = chan->con_priv;
> +	struct apple_mbox_msg *msg = data;
> +	int ret;
> +
> +	ret = apple_mbox_hw_send(apple_mbox, msg);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The interrupt is level triggered and will keep firing as long as the
> +	 * FIFO is empty. It will also keep firing if the FIFO was empty
> +	 * at any point in the past until it has been acknowledged at the
> +	 * mailbox level. By acknowledging it here we can ensure that we will
> +	 * only get the interrupt once the FIFO has been cleared again.
> +	 * If the FIFO is already empty before the ack it will fire again
> +	 * immediately after the ack.
> +	 */
> +	if (apple_mbox->hw->has_irq_controls) {
> +		writel_relaxed(apple_mbox->hw->irq_bit_send_empty,
> +			       apple_mbox->regs + apple_mbox->hw->irq_ack);
> +	}
> +	enable_irq(apple_mbox->irq_send_empty);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
> +{
> +	struct apple_mbox *apple_mbox = data;
> +
> +	/*
> +	 * We don't need to acknowledge the interrupt at the mailbox level
> +	 * here even if supported by the hardware. It will keep firing but that
> +	 * doesn't matter since it's disabled at the main interrupt controller.
> +	 * apple_mbox_chan_send_data will acknowledge it before enabling
> +	 * it at the main controller again.
> +	 */
> +	disable_irq_nosync(apple_mbox->irq_send_empty);
> +	mbox_chan_txdone(&apple_mbox->chan, 0);
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
> +{
> +	struct apple_mbox *apple_mbox = data;
> +	struct apple_mbox_msg msg;
> +
> +	while (apple_mbox_hw_recv(apple_mbox, &msg) == 0)
> +		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
> +
> +	/*
> +	 * The interrupt will keep firing even if there are no more messages
> +	 * unless we also acknowledge it at the mailbox level here.
> +	 * There's no race if a message comes in between the check in the while
> +	 * loop above and the ack below: If a new messages arrives inbetween
> +	 * those two the interrupt will just fire again immediately after the
> +	 * ack since it's level triggered.
> +	 */
> +	if (apple_mbox->hw->has_irq_controls) {
> +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty,
> +			       apple_mbox->regs + apple_mbox->hw->irq_ack);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static struct mbox_chan *apple_mbox_of_xlate(struct mbox_controller *mbox,
> +					     const struct of_phandle_args *spec)
> +{
> +	struct apple_mbox *apple_mbox = dev_get_drvdata(mbox->dev);
> +
> +	if (spec->args_count != 0)
> +		return ERR_PTR(-EINVAL);
> +	if (apple_mbox->chan.con_priv)
> +		return ERR_PTR(-EBUSY);
> +
> +	apple_mbox->chan.con_priv = apple_mbox;
> +	return &apple_mbox->chan;
> +}
> +
> +static int apple_mbox_chan_startup(struct mbox_chan *chan)
> +{
> +	struct apple_mbox *apple_mbox = chan->con_priv;
> +
> +	/*
> +	 * Only some variants of this mailbox HW provide interrupt control
> +	 * at the mailbox level. We therefore need to handle enabling/disabling
> +	 * interrupts at the main interrupt controller anyway for hardware that
> +	 * doesn't. Just always keep the interrupts we care about enabled at
> +	 * the mailbox level so that both hardware revisions behave almost
> +	 * the same.
> +	 */
> +	if (apple_mbox->hw->has_irq_controls) {
> +		writel_relaxed(apple_mbox->hw->irq_bit_recv_not_empty |
> +				       apple_mbox->hw->irq_bit_send_empty,
> +			       apple_mbox->regs + apple_mbox->hw->irq_enable);
> +	}
> +
> +	enable_irq(apple_mbox->irq_recv_not_empty);
> +	return 0;
> +}
> +
> +static void apple_mbox_chan_shutdown(struct mbox_chan *chan)
> +{
> +	struct apple_mbox *apple_mbox = chan->con_priv;
> +
> +	disable_irq(apple_mbox->irq_recv_not_empty);
> +}
> +
> +static const struct mbox_chan_ops apple_mbox_ops = {
> +	.send_data = apple_mbox_chan_send_data,
> +	.startup = apple_mbox_chan_startup,
> +	.shutdown = apple_mbox_chan_shutdown,
> +};
> +
> +static int apple_mbox_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	const struct of_device_id *match;
> +	char *irqname;
> +	struct apple_mbox *mbox;
> +	struct device *dev = &pdev->dev;
> +
> +	match = of_match_node(apple_mbox_of_match, pdev->dev.of_node);
> +	if (!match)
> +		return -EINVAL;
> +	if (!match->data)
> +		return -EINVAL;
> +
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, mbox);
> +
> +	mbox->dev = dev;
> +	mbox->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mbox->regs))
> +		return PTR_ERR(mbox->regs);
> +
> +	mbox->hw = match->data;
> +	mbox->irq_recv_not_empty =
> +		platform_get_irq_byname(pdev, "recv-not-empty");
> +	if (mbox->irq_recv_not_empty < 0)
> +		return -ENODEV;
> +
> +	mbox->irq_send_empty = platform_get_irq_byname(pdev, "send-empty");
> +	if (mbox->irq_send_empty < 0)
> +		return -ENODEV;
> +
> +	ret = devm_clk_bulk_get_all(dev, &mbox->clks);
> +	if (ret < 0)
> +		return ret;
> +	mbox->num_clks = ret;
> +
> +	ret = clk_bulk_prepare_enable(mbox->num_clks, mbox->clks);
> +	if (ret)
> +		return ret;

Given that we now realized that the clocks are really power domains,
the clock code should probably be dropped.  Makes the driver smaller
since power domains are handle automatically by the core device code.

> +
> +	mbox->controller.dev = mbox->dev;
> +	mbox->controller.num_chans = 1;
> +	mbox->controller.chans = &mbox->chan;
> +	mbox->controller.ops = &apple_mbox_ops;
> +	mbox->controller.of_xlate = &apple_mbox_of_xlate;
> +	mbox->controller.txdone_irq = true;
> +
> +	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
> +	if (!irqname) {
> +		ret = -ENOMEM;
> +		goto err_clk_disable;
> +	}
> +	ret = devm_request_threaded_irq(dev, mbox->irq_recv_not_empty, NULL,
> +					apple_mbox_recv_irq,
> +					IRQF_NO_AUTOEN | IRQF_ONESHOT, irqname,
> +					mbox);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-send", dev_name(dev));
> +	if (!irqname) {
> +		ret = -ENOMEM;
> +		goto err_clk_disable;
> +	}
> +	ret = devm_request_irq(dev, mbox->irq_send_empty,
> +			       apple_mbox_send_empty_irq, IRQF_NO_AUTOEN,
> +			       irqname, mbox);
> +	if (ret)
> +		goto err_clk_disable;
> +
> +	ret = devm_mbox_controller_register(dev, &mbox->controller);
> +	if (ret)
> +		goto err_clk_disable;
> +	return ret;
> +
> +err_clk_disable:
> +	clk_bulk_disable_unprepare(mbox->num_clks, mbox->clks);
> +	return ret;
> +}
> +
> +static int apple_mbox_remove(struct platform_device *pdev)
> +{
> +	struct apple_mbox *apple_mbox = dev_get_drvdata(&pdev->dev);
> +
> +	clk_bulk_disable_unprepare(apple_mbox->num_clks, apple_mbox->clks);
> +	return 0;
> +}
> +
> +static struct platform_driver apple_mbox_driver = {
> +	.driver = {
> +		.name = "apple-mailbox",
> +		.of_match_table = apple_mbox_of_match,
> +	},
> +	.probe = apple_mbox_probe,
> +	.remove = apple_mbox_remove,
> +};
> +module_platform_driver(apple_mbox_driver);
> +
> +MODULE_LICENSE("Dual MIT/GPL");
> +MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
> +MODULE_DESCRIPTION("Apple Mailbox driver");
> diff --git a/include/linux/apple-mailbox.h b/include/linux/apple-mailbox.h
> new file mode 100644
> index 000000000000..c455e0f9c73b
> --- /dev/null
> +++ b/include/linux/apple-mailbox.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Apple mailbox message format
> + *
> + * Copyright (C) 2021 The Asahi Linux Contributors
> + */
> +
> +#ifndef _LINUX_APPLE_MAILBOX_H_
> +#define _LINUX_APPLE_MAILBOX_H_
> +
> +#include <linux/types.h>
> +
> +struct apple_mbox_msg {
> +	u64 msg0;
> +	u32 msg1;
> +};
> +
> +#endif
> -- 
> 2.25.1
> 
> 
