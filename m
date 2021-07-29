Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7578D3DA0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhG2KM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:12:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhG2KMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:12:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4ADC60F23;
        Thu, 29 Jul 2021 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627553542;
        bh=wZgGcmpyMN7Nk+w3+TI7Qk6lXitpUc49m9RqsVKzl7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dSMZu+mYsM3F2ctk0DNw9xZ1VCzqXOJ4JH035THwmdpj8nHNZPxpQp37iE1IgbNgY
         FvXxrAnkccBJ+O6qFfbJ/QEcJzMS/adHZ0/4TJxQnYN5btJd5a24igyHbNtntahCJi
         2hb8DojqAkAAqfJ0p8uXw7E48LsR+sedaDVgPQCF1ZTMfwEuU5FKb0CnsnUQh7pK8S
         PzXdBz0phGshHYkoGgARceDidjO/Bw9Nr0JNAv2TC00OSvb/qQtljYF7AbPciwgYiX
         GI0mo9NPft98EVSXZuLlEtbSG41kUivPb5v0W/t9lsgjEwmtbs5Yzr+A6hUsjVcppJ
         xXxUeEw6PoNcg==
Date:   Thu, 29 Jul 2021 12:12:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v7 06/10] dt-bindings: phy: Add bindings for HiKey 970
 PCIe PHY
Message-ID: <20210729121216.6131d2dc@coco.lan>
In-Reply-To: <CAL_JsqLQX-zkWigA3P4PG2LikCQMq6Lrh8Ok95P4KbcbNS6+_w@mail.gmail.com>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <946f2426bc542638240980931eae924c57f2ba27.1626855713.git.mchehab+huawei@kernel.org>
        <20210723225059.GA2727093@robh.at.kernel.org>
        <20210724021244.780297ee@coco.lan>
        <CAL_JsqLA7Z908SQKkZpyEcCvpkWsW3pa42eajpxCSkbUy4rv9g@mail.gmail.com>
        <20210727015020.403bbf73@coco.lan>
        <20210727085205.5aafb5c9@coco.lan>
        <CAL_Jsq+5raGQAK5T4SoC=Jfzsbov-y4u-rdJ3DJt+ryYOK8q2w@mail.gmail.com>
        <20210728093838.4c7114bf@coco.lan>
        <CAL_JsqLQX-zkWigA3P4PG2LikCQMq6Lrh8Ok95P4KbcbNS6+_w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Em Wed, 28 Jul 2021 08:28:26 -0600
Rob Herring <robh@kernel.org> escreveu:

> > > pcie@f4000000 { // RP: Bus 0, Device 0
> > >     compatible = "hisilicon,kirin970-pcie";
> > >     ...
> > >     reset-gpios = <&gpio7 0 0>;  // PERST to switch
> > >
> > >     pcie@0 { // PCIe switch: Bus 1, Device 0
> > >         reg = <0 0 0 0 0>;
> > >         compatible = "pciclass,0604";
> > >         device_type = "pci";
> > >
> > >         pcie@1 { // NC (Can omit this node)
> > >             reg = <0x80 0 0 0 0>;
> > >             compatible = "pciclass,0604";
> > >             device_type = "pci";
> > >         };
> > >
> > >         pcie@4 { // M.2
> > >             reg = <0x200 0 0 0 0>;  
> >
> > Not sure what to put at reg. I suspect that the best would be to follow
> > the PEX port number, as, if one day someone decides to implement an
> > I2C driver, this might be useful.  
> 
> It's defined in the PCI bus binding. Basically, it's the BDF of the
> device. However, as the bus number is dynamic, I think we want to
> leave that as 0 for FDT. The function is optional and always 0 in this
> case.

Ok. I'll use 0 there.

> > >             compatible = "pciclass,0604";
> > >             device_type = "pci";
> > >             reset-gpios = <&gpio7 1 0>; // PERST to M.2 slot  
> >
> > We also need the clock-req phandle for the three devices.  
> 
> Hopefully, you can figure out where those belong now...

I added it here too.

> > With regards to the clock-req phandles, those should be enabled before
> > the PHY clocks, in order to avoid the SError issue.  
> 
> Huh? What exactly causes an SError. Has to be some bus access.

I'm not sure, but I got lots of those when playing with drivers
for this SoC. It is not easy to check the root case when such
errors happen, as the backtrace is useless.

> 
> > It should be easy to implement this at the the PCIe driver, but, this
> > should happen in early stages at the power-on sequence (before enabling
> > the DWC PHY clocks). So, the PCIe driver (or the PHY) will need to
> > walk the child nodes and get all the 'reset-gpios' properties.
> >
> > For the sake of avoiding to duplicate the walk-though and parsing
> > logic, I would do it only at the PHY driver.  
> 
> Everyone else handles this stuff in their PCIe driver. You are not special...
> 
> I have a plan to make the PERST handling common across all PCIe host
> drivers and also make the PHY handling common across DWC drivers.
> Don't make that harder.

It turns that changing this to work the way you're expecting was
a lot simpler than I was expecting ;-)

The enclosed patch, applied on the top of my past series, does that.

I'll rebase my patch series to take this change into account.

Could you please check if the DTS there is OK from your side?
I'll then change the dt-schema to match such change.

Thanks,
Mauro

[PATCH] PCI: kirin: change DT schema to use child nodes

Instead of having multiple PERST# pins as part of pcie,
add PCIe child slots, and place there the information related
to clock request and PERST# signals.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index cae90cd0b06a..a17562bb4dff 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -687,9 +687,6 @@ pcie_phy: pcie-phy@fc000000 {
 				      "apb_phy", "apb_sys",
 				      "aclk";
 
-			clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
-				       <&gpio17 0 0 >;
-
 			/* vboost iboost pre post main */
 			hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
 						       0xFFFFFFFF 0xFFFFFFFF
@@ -726,8 +723,40 @@ &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
 					 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
 					<0x0 0 0 4
 					 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
-			reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
-				      <&gpio3 1 0 >, <&gpio27 4 0 >;
+			reset-gpios = <&gpio7 0 0 >;
+
+			pcie@4 { // Lane 4: M.2
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reset-gpios = <&gpio7 1 0>;
+				clkreq-gpios = <&gpio27 3 0 >;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+
+			pcie@5 { // Lane 5: Mini PCIe
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reset-gpios = <&gpio7 2 0>;
+				clkreq-gpios = <&gpio17 0 0 >;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
+
+			pcie@7 { // Lane 7: Ethernet
+				reg = <0 0 0 0 0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reset-gpios = <&gpio7 3 0>;
+				clkreq-gpios = <&gpio20 0 0 >;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		/* UFS */
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 9dad14929538..5f515c4c6076 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -52,6 +52,19 @@
 #define PCIE_DEBOUNCE_PARAM	0xF0F400
 #define PCIE_OE_BYPASS		(0x3 << 28)
 
+/*
+ * Max number of connected PCI slots at an external PCI bridge
+ *
+ * This is used on HiKey 970, which has a PEX 8606 bridge with has
+ * 4 connected lanes (lane 0 upstream, and the other tree lanes,
+ * one connected to an in-board Ethernet adapter and the other two
+ * connected to M.2 and mini PCI slots.
+ *
+ * Each slot has a different clock source and uses a separate PERST#
+ * pin.
+ */
+#define MAX_PCI_SLOTS		3
+
 enum pcie_kirin_phy_type {
 	PCIE_KIRIN_INTERNAL_PHY,
 	PCIE_KIRIN_EXTERNAL_PHY
@@ -64,6 +77,18 @@ struct kirin_pcie {
 	struct regmap   *apb;
 	struct phy	*phy;
 	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
+
+	/* DWC PERST# */
+	int		gpio_id_dwc_perst;
+
+	int		num_slots;
+	/* Per-slot PERST# */
+	int		gpio_id_reset[MAX_PCI_SLOTS];
+	const char	*reset_names[MAX_PCI_SLOTS];
+
+	/* Per-slot clkreq */
+	int		gpio_id_clkreq[MAX_PCI_SLOTS];
+	const char	*clkreq_names[MAX_PCI_SLOTS];
 };
 
 /*
@@ -108,7 +133,6 @@ struct hi3660_pcie_phy {
 	struct clk	*phy_ref_clk;
 	struct clk	*aclk;
 	struct clk	*aux_clk;
-	int		gpio_id_reset;
 };
 
 /* Registers in PCIePHY */
@@ -171,16 +195,6 @@ static int hi3660_pcie_phy_get_resource(struct hi3660_pcie_phy *phy)
 	if (IS_ERR(phy->sysctrl))
 		return PTR_ERR(phy->sysctrl);
 
-	/* gpios */
-	phy->gpio_id_reset = of_get_named_gpio(dev->of_node,
-					       "reset-gpios", 0);
-	if (phy->gpio_id_reset == -EPROBE_DEFER) {
-		return -EPROBE_DEFER;
-	} else if (!gpio_is_valid(phy->gpio_id_reset)) {
-		dev_err(phy->dev, "unable to get a valid gpio pin\n");
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
@@ -297,16 +311,6 @@ static int hi3660_pcie_phy_power_on(struct kirin_pcie *pcie)
 	if (ret)
 		goto disable_clks;
 
-	/* perst assert Endpoint */
-	if (!gpio_request(phy->gpio_id_reset, "pcie_perst")) {
-		usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
-		ret = gpio_direction_output(phy->gpio_id_reset, 1);
-		if (ret)
-			goto disable_clks;
-		usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
-		return 0;
-	}
-
 disable_clks:
 	hi3660_pcie_phy_clk_ctrl(phy, false);
 	return ret;
@@ -347,11 +351,54 @@ static const struct regmap_config pcie_kirin_regmap_conf = {
 	.reg_stride = 4,
 };
 
+static int kirin_pcie_parse_port(struct kirin_pcie *kirin_pcie,
+				 struct platform_device *pdev,
+				 struct device_node *node)
+{
+	struct device *dev = &pdev->dev;
+	int i = kirin_pcie->num_slots;
+	char name[32];
+
+	if (i + 1 > MAX_PCI_SLOTS) {
+		dev_err(dev, "Too many PCI slots!\n");
+		return -EINVAL;
+	}
+
+	kirin_pcie->num_slots++;
+
+	/* perst reset gpio */
+	kirin_pcie->gpio_id_reset[i] = of_get_named_gpio(node,
+							 "reset-gpios", 0);
+
+	if (kirin_pcie->gpio_id_reset[i] < 0) {
+		dev_err(dev, "%d: Missing PERST# for %pOF\n", i, node);
+		return kirin_pcie->gpio_id_reset[i];
+	}
+
+	/* clkreq gpio */
+	kirin_pcie->gpio_id_clkreq[i] = of_get_named_gpio(node,
+							  "clkreq-gpios", 0);
+	if (kirin_pcie->gpio_id_clkreq[i] < 0) {
+		dev_err(dev, "%d: Missing clqreq for %pOF\n", i, node);
+		return kirin_pcie->gpio_id_clkreq[i];
+	}
+
+	sprintf(name, "pcie_clkreq_%d", i);
+	kirin_pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
+							 GFP_KERNEL);
+	if (!kirin_pcie->clkreq_names[i])
+		return -ENOMEM;
+
+	return 0;
+}
+
 static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 				    struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node, *child;
 	void __iomem *apb_base;
+	int ret;
 
 	apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
 	if (IS_ERR(apb_base))
@@ -362,6 +409,29 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 	if (IS_ERR(kirin_pcie->apb))
 		return PTR_ERR(kirin_pcie->apb);
 
+	/* pcie internal PERST# gpio */
+	kirin_pcie->gpio_id_dwc_perst = of_get_named_gpio(dev->of_node,
+							  "reset-gpios", 0);
+	if (kirin_pcie->gpio_id_dwc_perst == -EPROBE_DEFER) {
+		return -EPROBE_DEFER;
+	} else if (!gpio_is_valid(kirin_pcie->gpio_id_dwc_perst)) {
+		dev_err(dev, "unable to get a valid gpio pin\n");
+		return -ENODEV;
+	}
+
+	/* Parse OF children */
+	for_each_available_child_of_node(node, child) {
+		ret = of_pci_get_devfn(child);
+		if (ret < 0) {
+			dev_info(dev, "failed to parse devfn: %d\n", ret);
+			return ret;
+		}
+
+		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -419,9 +489,31 @@ static int kirin_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int kirin_pcie_add_bus(struct pci_bus *bus)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct kirin_pcie *kirin_pcie = to_kirin_pcie(pci);
+	int i, ret;
+
+	/* perst assert Endpoint */
+	usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
+
+	/* Send PERST# to each slot */
+	for (i = 0; i < kirin_pcie->num_slots; i++) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
+		if (ret)
+			return ret;
+	}
+	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
+
+	return 0;
+}
+
+
 static struct pci_ops kirin_pci_ops = {
 	.read = kirin_pcie_rd_own_conf,
 	.write = kirin_pcie_wr_own_conf,
+	.add_bus = kirin_pcie_add_bus,
 };
 
 static u32 kirin_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
@@ -477,6 +569,46 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static int kirin_pcie_gpio_request(struct kirin_pcie *kirin_pcie,
+				   struct device *dev)
+{
+	int ret, i;
+
+	for (i = 0; i < kirin_pcie->num_slots; i++) {
+		if (!gpio_is_valid(kirin_pcie->gpio_id_reset[i])) {
+			dev_err(dev, "unable to get a valid %s gpio\n",
+				kirin_pcie->reset_names[i]);
+			return -ENODEV;
+		}
+
+		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[i],
+					kirin_pcie->reset_names[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < kirin_pcie->num_slots; i++) {
+		if (!gpio_is_valid(kirin_pcie->gpio_id_clkreq[i])) {
+			dev_err(dev, "unable to get a valid %s gpio\n",
+				kirin_pcie->clkreq_names[i]);
+			return -ENODEV;
+		}
+
+		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[i],
+					kirin_pcie->clkreq_names[i]);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < kirin_pcie->num_slots; i++) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 0);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static const struct dw_pcie_ops kirin_dw_pcie_ops = {
 	.read_dbi = kirin_pcie_read_dbi,
 	.write_dbi = kirin_pcie_write_dbi,
@@ -499,24 +631,43 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
 		if (ret)
 			return ret;
 
-		return hi3660_pcie_phy_power_on(kirin_pcie);
+		ret = kirin_pcie_gpio_request(kirin_pcie, dev);
+		if (ret)
+			return ret;
+
+		ret = hi3660_pcie_phy_power_on(kirin_pcie);
+		if (ret)
+			return ret;
+	} else {
+		kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
+		if (IS_ERR(kirin_pcie->phy))
+			return PTR_ERR(kirin_pcie->phy);
+
+		ret = phy_init(kirin_pcie->phy);
+		if (ret)
+			goto err;
+
+		ret = phy_power_on(kirin_pcie->phy);
+		if (ret)
+			goto err;
 	}
 
-	kirin_pcie->phy = devm_of_phy_get(dev, dev->of_node, NULL);
-	if (IS_ERR(kirin_pcie->phy))
-		return PTR_ERR(kirin_pcie->phy);
+	/* perst assert Endpoint */
+	usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
 
-	ret = phy_init(kirin_pcie->phy);
-	if (ret)
-		goto err;
+	if (!gpio_request(kirin_pcie->gpio_id_dwc_perst, "pcie_perst")) {
+		ret = gpio_direction_output(kirin_pcie->gpio_id_dwc_perst, 1);
+		if (ret)
+			goto err;
+	}
 
-	ret = phy_power_on(kirin_pcie->phy);
-	if (ret)
-		goto err;
+	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
 
 	return 0;
 err:
-	phy_exit(kirin_pcie->phy);
+	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
+		phy_exit(kirin_pcie->phy);
+
 	return ret;
 }
 
diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index 82cc5fc4eac2..ac6052a05788 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -87,9 +87,6 @@
 #define NOC_PW_MASK         0x10000
 #define NOC_PW_SET_BIT      0x1
 
-/* Number of GPIOs required by PHY */
-#define MAX_GPIO_RESETS		4
-#define MAX_GPIO_CLKREQ		3
 #define NUM_EYEPARAM		5
 
 /* info located in sysctrl */
@@ -108,10 +105,6 @@
 #define CRGCTRL_PCIE_ASSERT_BIT		0x8c000000
 
 /* Time for delay */
-#define REF_2_PERST_MIN		20000
-#define REF_2_PERST_MAX		25000
-#define PERST_2_ACCESS_MIN	10000
-#define PERST_2_ACCESS_MAX	12000
 #define PIPE_CLK_WAIT_MIN	550
 #define PIPE_CLK_WAIT_MAX	600
 #define TIME_CMOS_MIN		100
@@ -131,12 +124,6 @@ struct hi3670_pcie_phy {
 	struct clk	*phy_ref_clk;
 	struct clk	*aclk;
 	struct clk	*aux_clk;
-	int		n_gpio_resets;
-	int		n_gpio_clkreq;
-	int		gpio_id_reset[MAX_GPIO_RESETS];
-	const char	*reset_names[MAX_GPIO_RESETS];
-	int		gpio_id_clkreq[MAX_GPIO_CLKREQ];
-	const char	*clkreq_names[MAX_GPIO_CLKREQ];
 	u32		eye_param[NUM_EYEPARAM];
 };
 
@@ -230,40 +217,6 @@ static void hi3670_pcie_set_eyeparam(struct hi3670_pcie_phy *phy)
 	kirin_apb_natural_phy_writel(phy, val, LANEN_DIG_ASIC_TX_OVRD_IN_1);
 }
 
-static int hi3670_pcie_gpio_request(struct hi3670_pcie_phy *phy,
-				    struct device *dev)
-{
-	int ret, i;
-
-	for (i = 0; i < phy->n_gpio_resets; i++) {
-		if (!gpio_is_valid(phy->gpio_id_reset[i])) {
-			dev_err(dev, "unable to get a valid %s gpio\n",
-				phy->reset_names[i]);
-			return -ENODEV;
-		}
-
-		ret = devm_gpio_request(dev, phy->gpio_id_reset[i],
-					phy->reset_names[i]);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < phy->n_gpio_clkreq; i++) {
-		if (!gpio_is_valid(phy->gpio_id_clkreq[i])) {
-			dev_err(dev, "unable to get a valid %s gpio\n",
-				phy->clkreq_names[i]);
-			return -ENODEV;
-		}
-
-		ret = devm_gpio_request(dev, phy->gpio_id_clkreq[i],
-					phy->clkreq_names[i]);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
 static void hi3670_pcie_natural_cfg(struct hi3670_pcie_phy *phy)
 {
 	u32 val;
@@ -558,8 +511,6 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	struct device_node *pcie_port;
 	struct device *dev = phy->dev;
 	struct device *pcie_dev;
-	char name[32];
-	int i;
 
 	pcie_port = of_get_child_by_name(dev->parent->of_node, "pcie");
 	if (!pcie_port) {
@@ -588,27 +539,6 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 		return -ENODEV;
 	}
 
-	/* perst reset gpios */
-	phy->n_gpio_resets = of_gpio_named_count(pcie_dev->of_node,
-						 "reset-gpios");
-	if (phy->n_gpio_resets > MAX_GPIO_RESETS) {
-		dev_err(dev, "Too many GPIO resets!\n");
-		return -EINVAL;
-	}
-	for (i = 0; i < phy->n_gpio_resets; i++) {
-		phy->gpio_id_reset[i] = of_get_named_gpio(pcie_dev->of_node,
-							  "reset-gpios", i);
-		if (phy->gpio_id_reset[i] < 0)
-			return phy->gpio_id_reset[i];
-
-		sprintf(name, "pcie_perst_%d", i);
-
-		phy->reset_names[i] = devm_kstrdup_const(dev, name,
-							 GFP_KERNEL);
-		if (!phy->reset_names[i])
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 
@@ -663,7 +593,6 @@ static int kirin_pcie_clk_ctrl(struct hi3670_pcie_phy *phy, bool enable)
 static int hi3670_pcie_phy_init(struct phy *generic_phy)
 {
 	struct hi3670_pcie_phy *phy = phy_get_drvdata(generic_phy);
-	struct device *dev = phy->dev;
 	int ret;
 
 	/*
@@ -681,15 +610,6 @@ static int hi3670_pcie_phy_init(struct phy *generic_phy)
 	if (ret)
 		return ret;
 
-	/* phy regulator needs to be powered on before calling it */
-	return hi3670_pcie_gpio_request(phy, dev);
-}
-
-static int hi3670_pcie_phy_power_on(struct phy *generic_phy)
-{
-	struct hi3670_pcie_phy *phy = phy_get_drvdata(generic_phy);
-	int val, ret, i;
-
 	/* Power supply for Host */
 	regmap_write(phy->sysctrl,
 		     SCTRL_PCIE_CMOS_OFFSET, SCTRL_PCIE_CMOS_BIT);
@@ -697,11 +617,13 @@ static int hi3670_pcie_phy_power_on(struct phy *generic_phy)
 
 	hi3670_pcie_phy_oe_enable(phy);
 
-	for (i = 0; i < phy->n_gpio_clkreq; i++) {
-		ret = gpio_direction_output(phy->gpio_id_clkreq[i], 0);
-		if (ret)
-			return ret;
-	}
+	return 0;
+}
+
+static int hi3670_pcie_phy_power_on(struct phy *generic_phy)
+{
+	struct hi3670_pcie_phy *phy = phy_get_drvdata(generic_phy);
+	int val, ret;
 
 	ret = kirin_pcie_clk_ctrl(phy, true);
 	if (ret)
@@ -732,15 +654,6 @@ static int hi3670_pcie_phy_power_on(struct phy *generic_phy)
 	regmap_write(phy->apb, SOC_PCIECTRL_CTRL12_ADDR, val);
 	udelay(10);
 
-	/* perst assert Endpoints */
-	usleep_range(21000, 23000);
-	for (i = 0; i < phy->n_gpio_resets; i++) {
-		ret = gpio_direction_output(phy->gpio_id_reset[i], 1);
-		if (ret)
-			return ret;
-	}
-	usleep_range(10000, 11000);
-
 	ret = is_pipe_clk_stable(phy);
 	if (!ret)
 		goto disable_clks;
@@ -781,9 +694,6 @@ static int hi3670_pcie_phy_get_resources(struct hi3670_pcie_phy *phy,
 					 struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	char name[32];
-	int i;
 
 	/* syscon */
 	phy->crgctrl = syscon_regmap_lookup_by_compatible("hisilicon,hi3670-crgctrl");
@@ -824,25 +734,6 @@ static int hi3670_pcie_phy_get_resources(struct hi3670_pcie_phy *phy,
 	if (IS_ERR(phy->base))
 		return PTR_ERR(phy->base);
 
-	/* clock request gpios */
-	phy->n_gpio_clkreq = of_gpio_named_count(np, "clkreq-gpios");
-	if (phy->n_gpio_clkreq > MAX_GPIO_CLKREQ) {
-		dev_err(dev, "Too many GPIO clock requests!\n");
-		return -EINVAL;
-	}
-	for (i = 0; i < phy->n_gpio_clkreq; i++) {
-		phy->gpio_id_clkreq[i] = of_get_named_gpio(dev->of_node,
-							   "clkreq-gpios", i);
-		if (phy->gpio_id_clkreq[i] < 0)
-			return phy->gpio_id_clkreq[i];
-
-		sprintf(name, "pcie_clkreq_%d", i);
-		phy->clkreq_names[i] = devm_kstrdup_const(dev, name,
-							  GFP_KERNEL);
-		if (!phy->clkreq_names[i])
-			return -ENOMEM;
-	}
-
 	hi3670_pcie_get_eyeparam(phy);
 
 	return 0;

