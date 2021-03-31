Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18834FBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhCaIpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:45:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:7606 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232310AbhCaIpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:45:23 -0400
IronPort-SDR: Z6FYpesUmLsBcBlFulcixTZX2EzLEfECmUj8CwH7Bt/d3tcDGLikkrEGMuwg5pwQ87vJvV4yU9
 N4aYELJlkhaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="253285794"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="253285794"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 01:45:23 -0700
IronPort-SDR: 0MNtYsv/j/cbz/rskN3dS8GOG5SeWmvh+AVKjyB7ioHIF55QhF30VOZ2nsHnu3G1ms+jBPPDqY
 FsNCEgQ0hEog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="516791164"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 31 Mar 2021 01:45:19 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 31 Mar 2021 11:45:19 +0300
Date:   Wed, 31 Mar 2021 11:45:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     cristian.birsan@microchip.com
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/2] usb: typec: sama7g5_tcpc: add driver for
 Microchip sama7g5 tcpc
Message-ID: <YGQ2n17aAQ0Q6zNx@kuha.fi.intel.com>
References: <20210330205442.981649-1-cristian.birsan@microchip.com>
 <20210330205442.981649-3-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330205442.981649-3-cristian.birsan@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Tue, Mar 30, 2021 at 11:54:42PM +0300, cristian.birsan@microchip.com wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> This patch adds initial driver support for the new Microchip USB
> Type-C Port Controller (TCPC) embedded in sama7g5 SoC.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> ---
>  drivers/usb/typec/tcpm/Kconfig        |   8 +
>  drivers/usb/typec/tcpm/Makefile       |   1 +
>  drivers/usb/typec/tcpm/sama7g5_tcpc.c | 610 ++++++++++++++++++++++++++
>  3 files changed, 619 insertions(+)
>  create mode 100644 drivers/usb/typec/tcpm/sama7g5_tcpc.c
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 557f392fe24d..8ba0fd85741f 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -52,6 +52,14 @@ config TYPEC_FUSB302
>  	  Type-C Port Controller Manager to provide USB PD and USB
>  	  Type-C functionalities.
>  
> +config TYPEC_SAMA7G5
> +	tristate "Microchip SAMA7G5 Type-C Port Controller driver"
> +	select REGMAP_MMIO
> +	help
> +	  Say Y or M here if your system has SAMA7G5 TCPC controller.
> +	  It works with Type-C Port Controller Manager to provide USB
> +	  Type-C functionalities.
> +
>  config TYPEC_WCOVE
>  	tristate "Intel WhiskeyCove PMIC USB Type-C PHY driver"
>  	depends on ACPI
> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/Makefile
> index 7d499f3569fd..9abe8a7ae1cc 100644
> --- a/drivers/usb/typec/tcpm/Makefile
> +++ b/drivers/usb/typec/tcpm/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_TYPEC_TCPM)		+= tcpm.o
>  obj-$(CONFIG_TYPEC_FUSB302)		+= fusb302.o
> +obj-$(CONFIG_TYPEC_SAMA7G5)		+= sama7g5_tcpc.o
>  obj-$(CONFIG_TYPEC_WCOVE)		+= typec_wcove.o
>  typec_wcove-y				:= wcove.o
>  obj-$(CONFIG_TYPEC_TCPCI)		+= tcpci.o
> diff --git a/drivers/usb/typec/tcpm/sama7g5_tcpc.c b/drivers/usb/typec/tcpm/sama7g5_tcpc.c
> new file mode 100644
> index 000000000000..2986c0fcc8a3
> --- /dev/null
> +++ b/drivers/usb/typec/tcpm/sama7g5_tcpc.c
> @@ -0,0 +1,610 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Microchip SAMA7G5 Type-C Port Controller Driver
> + *
> + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/usb/pd.h>
> +#include <linux/usb/tcpm.h>
> +#include <linux/usb/typec.h>
> +
> +#define SAMA7G5_TCPC_GCLK				32000
> +
> +/* TCPC registers offsets */
> +#define TCPC_CR			0x80		/* TCPC Control Register */
> +#define TCPC_UPC		0xA0		/* TCPC PHY Control Register */
> +#define TCPC_UPS		0xA4		/* TCPC PHY Status Register */
> +
> +#define TCPC_CR_RESET		0x54434301	/* Magic value */
> +
> +/* TCPC PHY Control Register */
> +#define TCPC_UPC_BCDETE		BIT(29)
> +#define TCPC_UPC_BCVSRCE	BIT(28)
> +#define	TCPC_UPC_BCDETSEL	BIT(27)

Why do you have a tab right after "#define" above?

> +#define	TCPC_UPC_BCIDPSRCE	BIT(26)

And here?

> +#define TCPC_UPC_DMPDFE		BIT(25)
> +#define TCPC_UPC_DMPDFD		BIT(24)
> +#define TCPC_UPC_IP_OFF		(0 << 12)
> +#define TCPC_UPC_IP_0P5		(1 << 12)
> +#define TCPC_UPC_IP_1P5		(2 << 12)
> +#define TCPC_UPC_IP_3P0		(3 << 12)
> +#define TCPC_UPC_THRESHOLD0	(0 << 8)
> +#define TCPC_UPC_THRESHOLD2	(2 << 8)
> +#define TCPC_UPC_THRESHOLD4	(4 << 8)
> +#define TCPC_UPC_THRESHOLD6	(6 << 8)
> +
> +/* TCPC PHY  Status Register */
> +#define TCPC_UPS_CC2RDT		BIT(4)
> +#define TCPC_UPS_CC1ID		BIT(3)
> +#define TCPC_UPS_CC_MASK	GENMASK(4, 3)
> +#define TCPC_UPS_CHGDCP		BIT(2)
> +#define TCPC_UPS_DM		BIT(1)
> +#define TCPC_UPS_DP		BIT(0)
> +
> +#define TCPC_VERSION		0xFC
> +
> +/* USB Type-C measurement timings */
> +#define T_CC_MEASURE		100 /* 100 ms */
> +
> +#define SAMA7G5_TCPC_VBUS_IRQFLAGS (IRQF_ONESHOT \
> +			   | IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)
> +
> +struct sama7g5_tcpc {
> +	struct device *dev;
> +
> +	struct workqueue_struct *wq;
> +	struct delayed_work measure_work;
> +
> +	struct regmap *regmap;
> +	void __iomem *base;
> +
> +	struct clk *pclk;
> +	struct clk *gclk;
> +
> +	struct gpio_desc *vbus_pin;
> +	struct regulator *vbus;
> +
> +	/* lock for sharing states */
> +	struct mutex lock;
> +
> +	/* port status */
> +	enum typec_cc_polarity cc_polarity;
> +	enum typec_cc_status cc1_status;
> +	enum typec_cc_status cc2_status;
> +	enum typec_cc_status cc1_status_prev;
> +	enum typec_cc_status cc2_status_prev;
> +
> +	/* mutex used for VBUS detection */
> +	struct mutex vbus_mutex;
> +	int vbus_present;
> +	int vbus_present_prev;
> +
> +	unsigned int phy_status;
> +	unsigned int phy_status_old;
> +
> +	struct tcpc_dev tcpc;
> +	struct tcpm_port *tcpm;
> +};
> +
> +#define tcpc_to_sama7g5_tcpc(_tcpc_) \
> +		container_of(_tcpc_, struct sama7g5_tcpc, tcpc)
> +
> +static bool sama7g5_tcpc_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TCPC_CR:
> +	case TCPC_UPC:
> +	case TCPC_UPS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool sama7g5_tcpc_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case TCPC_CR:
> +	case TCPC_UPC:
> +	case TCPC_UPS:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config sama7g5_tcpc_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.max_register = TCPC_VERSION,
> +	.readable_reg = sama7g5_tcpc_readable_reg,
> +	.writeable_reg = sama7g5_tcpc_writeable_reg,
> +};
> +
> +static int sama7g5_tcpc_get_vbus(struct tcpc_dev *tcpc)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc = tcpc_to_sama7g5_tcpc(tcpc);
> +	int ret;
> +
> +	mutex_lock(&sama7g5_tcpc->vbus_mutex);
> +	ret = sama7g5_tcpc->vbus_present ? 1 : 0;
> +	mutex_unlock(&sama7g5_tcpc->vbus_mutex);
> +
> +	return ret;
> +}
> +
> +static int sama7g5_tcpc_set_vbus(struct tcpc_dev *tcpc, bool on, bool sink)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc = tcpc_to_sama7g5_tcpc(tcpc);
> +	int ret;
> +
> +	mutex_lock(&sama7g5_tcpc->vbus_mutex);
> +	if (on)
> +		ret = regulator_enable(sama7g5_tcpc->vbus);
> +	else
> +		ret = regulator_disable(sama7g5_tcpc->vbus);
> +	mutex_unlock(&sama7g5_tcpc->vbus_mutex);
> +
> +	return ret;
> +}
> +
> +static int sama7g5_tcpc_set_vconn(struct tcpc_dev *tcpc, bool on)
> +{
> +	/* VCONN is not supported */
> +	return -EPERM;
> +}
> +
> +static int sama7g5_tcpc_get_cc(struct tcpc_dev *tcpc, enum typec_cc_status *cc1,
> +			       enum typec_cc_status *cc2)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc = tcpc_to_sama7g5_tcpc(tcpc);
> +
> +	mutex_lock(&sama7g5_tcpc->lock);
> +	*cc1 = sama7g5_tcpc->cc1_status;
> +	*cc2 = sama7g5_tcpc->cc2_status;
> +	mutex_unlock(&sama7g5_tcpc->lock);
> +
> +	return 0;
> +}
> +
> +static int sama7g5_tcpc_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc = tcpc_to_sama7g5_tcpc(tcpc);
> +	unsigned int ctrl;
> +	int ret = 0;
> +
> +	mutex_lock(&sama7g5_tcpc->lock);
> +	switch (cc) {
> +	case TYPEC_CC_RD:
> +		ctrl = TCPC_UPC_IP_OFF;
> +		break;
> +	case TYPEC_CC_RP_DEF:
> +		ctrl = TCPC_UPC_IP_0P5;
> +		break;
> +	default:
> +		ret =  -EINVAL;
> +		goto done;
> +	}
> +	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_UPC, ctrl);
> +done:
> +	mutex_unlock(&sama7g5_tcpc->lock);
> +	return ret;
> +}
> +
> +static int sama7g5_tcpc_set_polarity(struct tcpc_dev *tcpc,
> +				     enum typec_cc_polarity pol)
> +{
> +	return 0;
> +}
> +
> +static int sama7g5_tcpc_set_roles(struct tcpc_dev *tcpc, bool attached,
> +			   enum typec_role role, enum typec_data_role data)
> +{
> +	return 0;
> +}
> +
> +static int sama7g5_tcpc_set_pd_rx(struct tcpc_dev *tcpc, bool on)
> +{
> +	return -EPERM;
> +}
> +
> +static int sama7g5_tcpc_pd_transmit(struct tcpc_dev *tcpc,
> +				    enum tcpm_transmit_type type,
> +				    const struct pd_message *msg,
> +				    unsigned int negotiated_rev)
> +{
> +	return -EPERM;
> +}
> +
> +static int sama7g5_tcpc_start_toggling(struct tcpc_dev *tcpc,
> +				       enum typec_port_type port_type,
> +				       enum typec_cc_status cc)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static void _sama7g5_tcpc_measure_snk(struct sama7g5_tcpc *sama7g5_tcpc)
> +{
> +	struct device *dev = sama7g5_tcpc->dev;
> +	int ret;
> +
> +	/* Save previous CC1/CC2 state */
> +	sama7g5_tcpc->cc1_status_prev = sama7g5_tcpc->cc1_status;
> +	sama7g5_tcpc->cc2_status_prev = sama7g5_tcpc->cc2_status;
> +
> +	/* Comparator Threshold 2 */
> +	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_UPC, TCPC_UPC_IP_OFF |
> +			   TCPC_UPC_THRESHOLD2);

How about:

	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_UPC,
                           TCPC_UPC_IP_OFF | TCPC_UPC_THRESHOLD2);

just to make it a bit easier to read?

> +	if (ret) {
> +		dev_err(dev, "failed to wite register: %d\n", ret);
> +		return;
> +	}
> +
> +	usleep_range(560, 1000);
> +
> +	ret = regmap_read(sama7g5_tcpc->regmap, TCPC_UPS,
> +			  &sama7g5_tcpc->phy_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read register: %d\n", ret);
> +		return;
> +	}
> +
> +	if (!(sama7g5_tcpc->phy_status & TCPC_UPS_CC_MASK)) {
> +		/* VRa*/
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_OPEN;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_OPEN;
> +		return;
> +	}
> +
> +	/* CC1 or CC2 is connected wait for PD messages to end ~ 30ms */
> +	usleep_range(30000, 35000);
> +
> +	/* Comparator Threshold 4 */
> +	sama7g5_tcpc->phy_status_old = sama7g5_tcpc->phy_status;
> +
> +	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_UPC, TCPC_UPC_IP_OFF |
> +			   TCPC_UPC_THRESHOLD4);

And here:

	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_UPC,
                           TCPC_UPC_IP_OFF | TCPC_UPC_THRESHOLD4);

> +	if (ret) {
> +		dev_err(dev, "failed to wite register: %d\n", ret);
> +		return;
> +	}
> +
> +	usleep_range(560, 1000);
> +	ret = regmap_read(sama7g5_tcpc->regmap, TCPC_UPS,
> +			  &sama7g5_tcpc->phy_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read register: %d\n", ret);
> +		return;
> +	}
> +
> +	if ((sama7g5_tcpc->phy_status_old & TCPC_UPS_CC1ID) &&
> +	    (!(sama7g5_tcpc->phy_status & TCPC_UPS_CC1ID))) {
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_RP_DEF;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_OPEN;
> +		return;
> +	}
> +
> +	if ((sama7g5_tcpc->phy_status_old & TCPC_UPS_CC2RDT) &&
> +	    (!(sama7g5_tcpc->phy_status & TCPC_UPS_CC2RDT))) {
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_OPEN;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_RP_DEF;
> +		return;
> +	}
> +
> +	/* Comparator Threshold 6 */
> +	sama7g5_tcpc->phy_status_old = sama7g5_tcpc->phy_status;
> +
> +	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_UPC, TCPC_UPC_IP_OFF |
> +			   TCPC_UPC_THRESHOLD6);

Ditto?

> +	if (ret) {
> +		dev_err(dev, "failed to wite register: %d\n", ret);
> +		return;
> +	}
> +
> +	usleep_range(560, 1000);
> +	ret = regmap_read(sama7g5_tcpc->regmap, TCPC_UPS,
> +			  &sama7g5_tcpc->phy_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read register: %d\n", ret);
> +		return;
> +	}
> +
> +	if ((sama7g5_tcpc->phy_status_old & TCPC_UPS_CC1ID) &&
> +	    (!(sama7g5_tcpc->phy_status & TCPC_UPS_CC1ID))) {
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_RP_1_5;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_OPEN;
> +		return;
> +	}
> +
> +	if ((sama7g5_tcpc->phy_status_old & TCPC_UPS_CC1ID) &&
> +	    ((sama7g5_tcpc->phy_status & TCPC_UPS_CC1ID))) {
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_RP_3_0;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_OPEN;
> +		return;
> +	}
> +
> +	if ((sama7g5_tcpc->phy_status_old & TCPC_UPS_CC2RDT) &&
> +	    (!(sama7g5_tcpc->phy_status & TCPC_UPS_CC2RDT))) {
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_OPEN;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_RP_1_5;
> +		return;
> +	}
> +
> +	if ((sama7g5_tcpc->phy_status_old & TCPC_UPS_CC2RDT) &&
> +	    ((sama7g5_tcpc->phy_status & TCPC_UPS_CC2RDT))) {
> +		sama7g5_tcpc->cc1_status = TYPEC_CC_OPEN;
> +		sama7g5_tcpc->cc2_status = TYPEC_CC_RP_3_0;
> +		return;
> +	}

It looks like you only use that phy_status_old member in this
function, so you could make it a local variable, no?

> +}
> +
> +static void sama7g5_tcpc_measure_work(struct work_struct *work)
> +{
> +	struct sama7g5_tcpc *port = container_of(work, struct sama7g5_tcpc,
> +						 measure_work.work);
> +
> +	mutex_lock(&port->lock);
> +
> +	_sama7g5_tcpc_measure_snk(port);
> +
> +	/* Check if the state has changed and notify TCPM */
> +	if (port->cc1_status != port->cc1_status_prev ||
> +	    port->cc2_status != port->cc2_status_prev)
> +		tcpm_cc_change(port->tcpm);

And those ccx_status_prev you are only using here, so you probable
don't need those members either.

> +	mod_delayed_work(port->wq, &port->measure_work,
> +			 msecs_to_jiffies(T_CC_MEASURE));
> +
> +	mutex_unlock(&port->lock);
> +}
> +
> +static int sama7g5_tcpc_init(struct tcpc_dev *tcpc)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc = tcpc_to_sama7g5_tcpc(tcpc);
> +	int ret;
> +
> +	ret = regmap_write(sama7g5_tcpc->regmap, TCPC_CR, TCPC_CR_RESET);
> +	if (ret)
> +		return ret;
> +
> +	sama7g5_tcpc->wq =
> +		create_singlethread_workqueue(dev_name(sama7g5_tcpc->dev));

One line is enough for the above.

> +	if (!sama7g5_tcpc->wq)
> +		return -ENOMEM;
> +
> +	INIT_DELAYED_WORK(&sama7g5_tcpc->measure_work,
> +			  sama7g5_tcpc_measure_work);
> +
> +	sama7g5_tcpc->cc1_status = TYPEC_CC_OPEN;
> +	sama7g5_tcpc->cc2_status = TYPEC_CC_OPEN;
> +	sama7g5_tcpc->cc1_status_prev = TYPEC_CC_OPEN;
> +	sama7g5_tcpc->cc2_status_prev = TYPEC_CC_OPEN;
> +	sama7g5_tcpc->cc_polarity = TYPEC_POLARITY_CC1;
> +
> +	/* We do not have an interrupt so polling only */
> +	mod_delayed_work(sama7g5_tcpc->wq, &sama7g5_tcpc->measure_work,
> +			 msecs_to_jiffies(T_CC_MEASURE));
> +
> +	/* Enable VBUS detection */
> +	if (sama7g5_tcpc->vbus_pin)
> +		enable_irq(gpiod_to_irq(sama7g5_tcpc->vbus_pin));
> +
> +	return 0;
> +}
> +
> +static int vbus_is_present(struct sama7g5_tcpc *sama7g5_tcpc)
> +{
> +	if (sama7g5_tcpc->vbus_pin)
> +		return gpiod_get_value(sama7g5_tcpc->vbus_pin);
> +
> +	/* No Vbus detection: Assume always present */
> +	return 1;
> +}
> +
> +static irqreturn_t sama7g5_vbus_irq_thread(int irq, void *devid)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc = devid;
> +
> +	/* debounce */
> +	udelay(10);
> +
> +	mutex_lock(&sama7g5_tcpc->vbus_mutex);
> +
> +	sama7g5_tcpc->vbus_present = vbus_is_present(sama7g5_tcpc);
> +	if (sama7g5_tcpc->vbus_present != sama7g5_tcpc->vbus_present_prev) {
> +		/* VBUS changed, notify TCPM */
> +		tcpm_vbus_change(sama7g5_tcpc->tcpm);
> +		sama7g5_tcpc->vbus_present_prev = sama7g5_tcpc->vbus_present;
> +	}

The vbus_present_prev looks like it could also be a local variable.

> +	mutex_unlock(&sama7g5_tcpc->vbus_mutex);
> +	return IRQ_HANDLED;
> +}
> +
> +static int sama7g5_tcpc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct sama7g5_tcpc *sama7g5_tcpc;
> +
> +	struct resource *mem;
> +	void __iomem *base;
> +
> +	sama7g5_tcpc = devm_kzalloc(&pdev->dev, sizeof(*sama7g5_tcpc),
> +				    GFP_KERNEL);
> +	if (!sama7g5_tcpc)
> +		return -ENOMEM;
> +
> +	mem =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	base = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +	sama7g5_tcpc->base = base;

        sama7g5_tcpc->base = devm_platform_ioremap_resourse(pdev, 0);
        if (IS_ERR(sama7g5_tcpc->base))
                return PTR_ERR(sama7g5_tcpc->base);

> +	sama7g5_tcpc->regmap =  devm_regmap_init_mmio(&pdev->dev, base,
> +						&sama7g5_tcpc_regmap_config);

You can align that properly too:

	sama7g5_tcpc->regmap =  devm_regmap_init_mmio(&pdev->dev, sama7g5_tcpc->base,
                                                      &sama7g5_tcpc_regmap_config);

> +	if (IS_ERR(sama7g5_tcpc->regmap)) {
> +		dev_err(&pdev->dev, "Regmap init failed\n");
> +		return PTR_ERR(sama7g5_tcpc->regmap);
> +	}
> +
> +	/* Get the peripheral clock */
> +	sama7g5_tcpc->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	if (IS_ERR(sama7g5_tcpc->pclk)) {
> +		ret = PTR_ERR(sama7g5_tcpc->pclk);
> +		dev_err(&pdev->dev,
> +			"failed to get the peripheral clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(sama7g5_tcpc->pclk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to enable the peripheral clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Get the generic clock */
> +	sama7g5_tcpc->gclk = devm_clk_get(&pdev->dev, "gclk");
> +	if (IS_ERR(sama7g5_tcpc->gclk)) {
> +		ret = PTR_ERR(sama7g5_tcpc->gclk);
> +		dev_err(&pdev->dev,
> +			"failed to get the PMC generic clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_set_rate(sama7g5_tcpc->gclk, SAMA7G5_TCPC_GCLK);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"unable to change gclk rate to: %u\n",
> +			SAMA7G5_TCPC_GCLK);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(sama7g5_tcpc->gclk);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to enable the generic clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&sama7g5_tcpc->lock);
> +	mutex_init(&sama7g5_tcpc->vbus_mutex);
> +
> +	sama7g5_tcpc->vbus_pin = devm_gpiod_get_optional(&pdev->dev,
> +				"microchip,vbus", GPIOD_IN);

You can align that properly.

> +	if (IS_ERR(sama7g5_tcpc->vbus_pin)) {
> +		ret = PTR_ERR(sama7g5_tcpc->vbus_pin);
> +		dev_err(&pdev->dev, "unable to claim vbus-gpio: %d\n", ret);
> +	}
> +
> +	sama7g5_tcpc->vbus = devm_regulator_get_optional(&pdev->dev, "vbus");
> +
> +	if (IS_ERR(sama7g5_tcpc->vbus)) {
> +		ret = PTR_ERR(sama7g5_tcpc->vbus);
> +		dev_err(&pdev->dev, "unable to claim vbus-supply: %d\n", ret);
> +	}
> +
> +	if (sama7g5_tcpc->vbus_pin) {
> +		irq_set_status_flags(gpiod_to_irq(sama7g5_tcpc->vbus_pin),
> +				     IRQ_NOAUTOEN);
> +		ret = devm_request_threaded_irq(&pdev->dev,
> +				gpiod_to_irq(sama7g5_tcpc->vbus_pin), NULL,
> +				sama7g5_vbus_irq_thread,
> +				SAMA7G5_TCPC_VBUS_IRQFLAGS,
> +				"sama7g5_tcpc", sama7g5_tcpc);
> +		if (ret) {
> +			sama7g5_tcpc->vbus_pin = NULL;
> +			dev_warn(&pdev->dev,
> +				 "failed to request vbus irq; "
> +				 "assuming always on\n");
> +		}
> +	}
> +
> +	sama7g5_tcpc->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, sama7g5_tcpc);
> +
> +	sama7g5_tcpc->tcpc.init = sama7g5_tcpc_init;
> +	sama7g5_tcpc->tcpc.get_vbus = sama7g5_tcpc_get_vbus;
> +	sama7g5_tcpc->tcpc.set_vbus = sama7g5_tcpc_set_vbus;
> +	sama7g5_tcpc->tcpc.set_cc = sama7g5_tcpc_set_cc;
> +	sama7g5_tcpc->tcpc.get_cc = sama7g5_tcpc_get_cc;
> +	sama7g5_tcpc->tcpc.set_polarity = sama7g5_tcpc_set_polarity;
> +	sama7g5_tcpc->tcpc.set_vconn = sama7g5_tcpc_set_vconn;
> +	sama7g5_tcpc->tcpc.start_toggling = sama7g5_tcpc_start_toggling;
> +	sama7g5_tcpc->tcpc.set_pd_rx = sama7g5_tcpc_set_pd_rx;
> +	sama7g5_tcpc->tcpc.set_roles = sama7g5_tcpc_set_roles;
> +	sama7g5_tcpc->tcpc.pd_transmit = sama7g5_tcpc_pd_transmit;
> +
> +	sama7g5_tcpc->tcpc.fwnode = device_get_named_child_node(&pdev->dev,
> +								"connector");
> +	if (!sama7g5_tcpc->tcpc.fwnode) {
> +		dev_err(&pdev->dev, "Can't find connector node.\n");
> +		return -EINVAL;
> +	}
> +
> +	sama7g5_tcpc->tcpm = tcpm_register_port(sama7g5_tcpc->dev,
> +						&sama7g5_tcpc->tcpc);
> +	if (IS_ERR(sama7g5_tcpc->tcpm)) {
> +		fwnode_remove_software_node(sama7g5_tcpc->tcpc.fwnode);
> +		return PTR_ERR(sama7g5_tcpc->tcpm);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sama7g5_tcpc_remove(struct platform_device *pdev)
> +{
> +	struct sama7g5_tcpc *sama7g5_tcpc;
> +
> +	sama7g5_tcpc = platform_get_drvdata(pdev);
> +
> +	/* Mask everything */
> +	if (sama7g5_tcpc->vbus_pin)
> +		disable_irq(gpiod_to_irq(sama7g5_tcpc->vbus_pin));
> +
> +
> +	if (!IS_ERR_OR_NULL(sama7g5_tcpc->tcpm))
> +		tcpm_unregister_port(sama7g5_tcpc->tcpm);
> +
> +	destroy_workqueue(sama7g5_tcpc->wq);
> +
> +	clk_disable_unprepare(sama7g5_tcpc->gclk);
> +	clk_disable_unprepare(sama7g5_tcpc->pclk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sama7g5_tcpc_dt_ids[] = {
> +	{
> +		.compatible = "microchip,sama7g5-tcpc",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sama7g5_tcpc_dt_ids);
> +
> +static struct platform_driver sama7g5_tcpc_driver = {
> +	.probe	= sama7g5_tcpc_probe,
> +	.remove = sama7g5_tcpc_remove,
> +	.driver = {
> +		.name	= "microchip,sama7g5-tcpc",
> +		.of_match_table	= sama7g5_tcpc_dt_ids,
> +	},
> +};
> +module_platform_driver(sama7g5_tcpc_driver);
> +
> +MODULE_AUTHOR("Cristian Birsan <cristian.birsan@microchip.com>");
> +MODULE_DESCRIPTION("Microchip SAMA7G5 Type-C Port Controller Driver");
> +MODULE_LICENSE("GPL");

thanks,

-- 
heikki
