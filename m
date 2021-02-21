Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44616320D3F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhBUTpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhBUTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:45:25 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675BC061574;
        Sun, 21 Feb 2021 11:44:45 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 81so10724999qkf.4;
        Sun, 21 Feb 2021 11:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0oZ/Aoqc+jhlq+IXWCixtgMhYMlhbXJmBxkwhESdw0=;
        b=Z9oshFxD1wk/HYPxq5f0TgFL9bzB2CsGIUaK3ZzkRrrl1TFWjbZ7mYHyRlTTOnfjKV
         gt0hjtqPHLbTconTClu2d34PUg7KoTM0WNnaJlG0/cm4WEcSu6+xA0Eu6t8E3qIp1NMg
         TBD3QX4DXemSBhTfxio/SitCIj9WgwLPDCPipJOZYvlDmCN6qK7RBINoqlzwmoHqYzce
         yAM6KCV9qwdaLbpWQDfoiQEJrgXfPm9Jy4c+ZftCM+lyJUluG8y6JKU5S1Wup6cKnyFk
         KRWnunTLrGP+f/IvLTZVl9CwqFU/sFvm/X1UxCWEp4w5M5fUPMQw/mLjBxiUXiZiFZph
         YV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i0oZ/Aoqc+jhlq+IXWCixtgMhYMlhbXJmBxkwhESdw0=;
        b=EMyb3UUop7rwmRZKT/327l8RZCgfRKWSWsn/+NbmP8gFj1L8UJGpo4bBKsfOTsMzxZ
         QYUyrifmm0HVXVYqRrVwkI093U5BW0YUXd+VcydQe8nR2Mv7xAbHPjkv7c7FMKg+ZK05
         1uhaWE7nEVb0EGUhV4AfeA98PV4HD4YWhreIP1QcW0TlFGFOSGyM0b0D+jdgNHbEhhVV
         DkmApyLwhLOLuazAke2uI9/oyp0Pv6II8M8Jlb6zTc89kSf1qyxWiN1xr+JJs3TNOvq0
         w4CF6ARmK77+aCoHsN4I9xHI7PJ8vtwyrqYUAhbFYbg5SvPfXauO8YxK9NbBaJfNnZ3r
         Is6w==
X-Gm-Message-State: AOAM5308WpIs9y2kAZuSkgNd1zNGCoUJ3cqLq54L/WWNwFYRTlYx9bUb
        CY9OcDAieXNZat0g15R+U8a3VPgim5O3IY7D
X-Google-Smtp-Source: ABdhPJwjGpvKgv5PnkW55djSC+Tfz3OPuaIBvBzSM6W+MZBIuJu6VuQALtpdYLfvdq91rKhp/2EyqA==
X-Received: by 2002:a05:620a:41:: with SMTP id t1mr18312248qkt.322.1613936683967;
        Sun, 21 Feb 2021 11:44:43 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id l6sm10772792qki.25.2021.02.21.11.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 11:44:43 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v2 0/2] add support for the lmk04832
Date:   Sun, 21 Feb 2021 14:44:25 -0500
Message-Id: <20210221194427.1184208-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Hi,

The LMK04832 is an ultra-high performance clock conditioner with JEDEC
JESD204B support and is also pin compatible with the LMK0482x family of
devices.

This driver adds initial support to configure the LMK04832 clocks using
the clock framework.

This has been tested on a system using JESD204B subclass 1.

At the moment, the VCO rate has to be set manually from the devicetree
and a dclk (or sclk) rate change isn't propagated to the VCO
automatically.

Changes since v1:
- add yaml devicetree documentation,
- add links to datasheet,
- use {u8,u16,u32} instead of Uint_ variants,
- drop redundant debugfs code,
- use a pointer to device_info instead of struct copy,
- add of_device_id table,
- add support for SYSREF digital delay and JESD204B subclass 1

Thanks for your time,
Liam

Liam Beguin (2):
  clk: add support for the lmk04832
  clk: lmk04832: add support for digital delay

 .../bindings/clock/ti,lmk04832.yaml           |  201 +++
 drivers/clk/Kconfig                           |    7 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-lmk04832.c                    | 1595 +++++++++++++++++
 4 files changed, 1804 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,lmk04832.yaml
 create mode 100644 drivers/clk/clk-lmk04832.c

Range-diff against v1:
1:  84575b516f7c ! 1:  ab3c2162e4f2 clk: add initial support for the lmk04832
    @@ Metadata
     Author: Liam Beguin <lvb@xiphos.com>
     
      ## Commit message ##
    -    clk: add initial support for the lmk04832
    +    clk: add support for the lmk04832
     
         The LMK04832 is an ultra-high performance clock conditioner with JEDEC
         JESD204B support and is also pin compatible with the LMK0482x family of
    @@ Commit message
     
         Signed-off-by: Liam Beguin <lvb@xiphos.com>
     
    - ## Documentation/devicetree/bindings/clock/ti,lmk04832.txt (new) ##
    + ## Documentation/devicetree/bindings/clock/ti,lmk04832.yaml (new) ##
     @@
    -+* Texas Instruments LMK04832 JESD204B Compliant Clock Jitter Cleaner
    -+
    -+Required properties:
    -+	- compatible: Must be "ti,lmk04832"
    -+	- reg: SPI chip select for the device
    -+	- spi-max-frequency: should be lower that 5MHz
    -+	- #clock-cells: should be 1
    -+	- clock-names: list of input clock names: "oscin"
    -+	- clocks: clock phandles and specifiers (see clock bindings for details on
    -+            clock-names and clocks)
    -+Optional properties:
    -+	- lmk,spi-4wire-rdbk: Set readback pin when the SPI bus is in 4-wire mode
    -+			can be one of:
    -+			- 0: CLKin_SEL0
    -+			- 1: CLKin_SEL1
    -+			- 2: Reset
    -+	- clock-output-names: From common clock bindings
    -+	- assigned-clock-rates: From common clock bindings
    -+	- reset-gpios: Phandle and specifier for the GPIO used to reset the
    -+	               device.
    -+
    -+
    -+Optionally, child nodes can be added to configure output channels:
    -+Required child properties:
    -+	- reg: clock output id
    -+
    -+Optional properties:
    -+	- lmk,clkout-fmt: desired clock format for CLKoutX
    -+		- see https://www.ti.com/lit/ds/symlink/lmk04832.pdf p.57 for
    -+		  values
    -+	- lmk,clkout-sysref: use the output as a SYSREF
    -+
    -+
    -+Example:
    -+&clocks {
    -+	lmk04832_oscin: oscin {
    -+		compatible = "fixed-clock";
    -+
    -+		#clock-cells = <0>;
    -+		clock-frequency = <122880000>;
    -+		clock-output-names = "lmk04832-oscin";
    -+	};
    -+};
    ++# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
    ++%YAML 1.2
    ++---
    ++$id: http://devicetree.org/schemas/clock/ti,lmk04832.yaml#
    ++$schema: http://devicetree.org/meta-schemas/core.yaml#
    ++
    ++title: Clock bindings for the Texas Instruments LMK04832
    ++
    ++maintainers:
    ++  - Liam Beguin <liambeguin@gmail.com>
    ++
    ++description: |
    ++  Devicetree binding for the LMK04832, a clock conditioner with JEDEC JESD204B
    ++  support. The LMK04832 is pin compatible with the LMK0482x family.
    ++
    ++  Link to datasheet, https://www.ti.com/lit/ds/symlink/lmk04832.pdf
    ++
    ++properties:
    ++  compatible:
    ++    enum:
    ++      - ti,lmk04832
    ++
    ++  reg:
    ++    maxItems: 1
    ++
    ++  '#clock-cells':
    ++    const: 1
    ++
    ++  clocks:
    ++    maxItems: 1
    ++    items:
    ++      - description: PLL2 reference clock.
    ++
    ++  clock-names:
    ++    maxItems: 1
    ++    items:
    ++      - const: oscin
    ++
    ++  reset-gpios:
    ++    description: A connection of the 'reset' gpio line.
    ++    maxItems: 1
    ++
    ++  lmk,spi-4wire-rdbk:
    ++    description: |
    ++      Select SPI 4wire readback pin configuration.
    ++      Available readback pins are,
    ++        CLKin_SEL0 0
    ++        CLKin_SEL1 1
    ++        RESET 2
    ++    allOf:
    ++      - $ref: /schemas/types.yaml#/definitions/uint32
    ++      - enum: [0, 1, 2]
    ++      - default: 1
    ++
    ++  lmk,vco-rate:
    ++    description: VCO rate to use (in Hz).
    ++    $ref: /schemas/types.yaml#/definitions/uint32
    ++
    ++  lmk,sysref-ddly:
    ++    description: SYSREF digital delay value.
    ++    allOf:
    ++      - $ref: /schemas/types.yaml#/definitions/uint32
    ++      - minimum: 8
    ++      - maximum: 8191
    ++      - default: 8
    ++
    ++  lmk,sysref-mux:
    ++    description: |
    ++      SYSREF Mux configuration.
    ++      Available options are,
    ++        Normal SYNC 0
    ++        Re-clocked 1
    ++        SYSREF Pulser 2
    ++        SYSREF Continuous 3
    ++    allOf:
    ++      - $ref: /schemas/types.yaml#/definitions/uint32
    ++      - enum: [0, 1, 2, 3]
    ++      - default: 3
    ++
    ++  lmk,sync-mode:
    ++    description: SYNC pin configuration.
    ++    allOf:
    ++      - $ref: /schemas/types.yaml#/definitions/uint32
    ++      - enum: [0, 1, 2]
    ++      - default: 1
    ++
    ++  lmk,sysref-pulse-count:
    ++    description:
    ++      Number of SYSREF pulses to send when SYSREF is not in continuous mode.
    ++    allOf:
    ++      - $ref: /schemas/types.yaml#/definitions/uint32
    ++      - enum: [1, 2, 4, 8]
    ++      - default: 4
    ++
    ++patternProperties:
    ++  "^.*@[0-9a-f]+$":
    ++    type: object
    ++    description:
    ++      Child nodes used to configure output clocks.
    ++
    ++    properties:
    ++      reg:
    ++        description:
    ++          clock output identifier.
    ++        minimum: 0
    ++        maximum: 13
    ++
    ++      lmk,clkout-fmt:
    ++        description:
    ++          Clock output format.
    ++          Available options are,
    ++            Powerdown 0x00
    ++            LVDS 0x01
    ++            HSDS 6 mA 0x02
    ++            HSDS 8 mA 0x03
    ++            LVPECL 1600 mV 0x04
    ++            LVPECL 2000 mV 0x05
    ++            LCPECL 0x06
    ++            CML 16 mA 0x07
    ++            CML 24 mA 0x08
    ++            CML 32 mA 0x09
    ++            CMOS (Off/Inverted) 0x0a
    ++            CMOS (Normal/Off) 0x0b
    ++            CMOS (Inverted/Inverted) 0x0c
    ++            CMOS (Inverted/Normal) 0x0d
    ++            CMOS (Normal/Inverted) 0x0e
    ++            CMOS (Normal/Normal) 0x0f
    ++        allOf:
    ++          - $ref: /schemas/types.yaml#/definitions/uint32
    ++          - minimum: 0
    ++          - maximum: 15
    ++
    ++      lmk,clkout-sysref:
    ++        description:
    ++          Select SYSREF clock path for output clock.
    ++        type: boolean
    ++
    ++    required:
    ++      - reg
    ++
    ++required:
    ++  - compatible
    ++  - reg
    ++  - '#clock-cells'
    ++
    ++additionalProperties: false
    ++
    ++examples:
    ++  - |
    ++    clocks {
    ++        lmk04832_oscin: oscin {
    ++            compatible = "fixed-clock";
    ++
    ++            #clock-cells = <0>;
    ++            clock-frequency = <122880000>;
    ++            clock-output-names = "lmk04832-oscin";
    ++        };
    ++    };
    ++
    ++    lmk04832: lmk04832@0 {
    ++        reg = <0>;
    ++        #address-cells = <1>;
    ++        #size-cells = <0>;
    ++
    ++        compatible = "ti,lmk04832";
    ++        spi-max-frequency = <781250>;
    ++
    ++        reset-gpios = <&gpio_lmk 0 0 0>;
    ++
    ++        #clock-cells = <1>;
    ++        clocks = <&lmk04832_oscin>;
    ++        clock-names = "oscin";
    ++
    ++        lmk,spi-4wire-rdbk = <0>;
    ++        lmk,vco-rate = <2457600000>;
    ++
    ++        assigned-clocks =
    ++            <&lmk04832 0>, <&lmk04832 1>,
    ++            <&lmk04832 2>, <&lmk04832 3>,
    ++            <&lmk04832 4>,
    ++            <&lmk04832 6>, <&lmk04832 7>,
    ++            <&lmk04832 10>, <&lmk04832 11>;
    ++      assigned-clock-rates =
    ++            <122880000>, <384000>,
    ++            <122880000>, <384000>,
    ++            <122880000>,
    ++            <153600000>, <384000>,
    ++            <614400000>, <384000>;
    ++
    ++      clkout0@0 {
    ++          reg = <0>;
    ++          lmk,clkout-fmt = <0x01>; // LVDS
    ++      };
    ++
    ++      clkout1@1 {
    ++          reg = <1>;
    ++          lmk,clkout-fmt = <0x01>; // LVDS
    ++          lmk,clkout-sysref;
    ++      };
    ++  };
     +
    -+&spi0 {
    -+	status = "okay";
    -+	lmk04832@0 {
    -+		reg = <0>;
    -+		#address-cells = <1>;
    -+		#size-cells = <0>;
    -+
    -+		compatible = "ti,lmk04832";
    -+		spi-max-frequency = <781250>;
    -+
    -+		#clock-cells = <1>;
    -+		clocks = <&lmk04832_oscin>;
    -+		clock-names = "oscin";
    -+
    -+		lmk,spi-4wire-rdbk = <0>;
    -+
    -+		assigned-clocks =
    -+			<&lmk04832 0>, <&lmk04832 1>,
    -+			<&lmk04832 2>, <&lmk04832 3>;
    -+
    -+		assigned-clock-rates =
    -+			<122880000>, <3840000>,
    -+			<122880000>, <3840000>;
    -+
    -+		clkout0@0 {
    -+			reg = <0>;
    -+			lmk,clkout-fmt = <0x01>; // LVDS
    -+		};
    -+
    -+		clkout1@1 {
    -+			reg = <1>;
    -+			lmk,clkout-fmt = <0x01>; // LVDS
    -+			lmk,clkout-sysref;
    -+		};
    -+
    -+		clkout2@2 {
    -+			reg = <2>;
    -+			lmk,clkout-fmt = <0x01>; // LVDS
    -+		};
    -+
    -+		clkout3@3 {
    -+			reg = <3>;
    -+			lmk,clkout-fmt = <0x01>; // LVDS
    -+			lmk,clkout-sysref;
    -+		};
    -+};
     
      ## drivers/clk/Kconfig ##
     @@ drivers/clk/Kconfig: config CLK_HSDK
    @@ drivers/clk/clk-lmk04832.c (new)
     + * LMK04832 Ultra Low-Noise JESD204B Compliant Clock Jitter Cleaner
     + * Pin compatible with the LMK0482x family
     + *
    ++ * Datasheet: https://www.ti.com/lit/ds/symlink/lmk04832.pdf
    ++ *
     + * Copyright (c) 2020, Xiphos Systems Corp.
     + *
     + */
    ++
     +#include <linux/bitfield.h>
     +#include <linux/clk.h>
     +#include <linux/clk-provider.h>
    @@ drivers/clk/clk-lmk04832.c (new)
     +#define LMK04832_REG_ID_VNDR_LSB	0x00d
     +
     +/* 0x100 - 0x137 Device Clock and SYSREF Clock Output Control */
    -+#define LMK04832_REG_DCLK_DIV_LSB(ch)	(0x100 + (ch >> 1) * 8)
    -+#define LMK04832_REG_CLKOUT_CTRL0(ch)	(0x102 + (ch >> 1) * 8)
    ++#define LMK04832_REG_CLKOUT_CTRL0(ch)	(0x100 + (ch >> 1) * 8)
    ++#define LMK04832_BIT_DCLK_DIV_LSB		GENMASK(7, 0)
    ++#define LMK04832_REG_CLKOUT_CTRL1(ch)	(0x101 + (ch >> 1) * 8)
    ++#define LMK04832_REG_CLKOUT_CTRL2(ch)	(0x102 + (ch >> 1) * 8)
     +#define LMK04832_BIT_CLKOUTX_Y_PD		BIT(7)
     +#define LMK04832_BIT_DCLK_DIV_MSB		GENMASK(1, 0)
     +#define LMK04832_REG_CLKOUT_SRC_MUX(ch)	(0x103 + (ch % 2) + (ch >> 1) * 8)
     +#define LMK04832_BIT_CLKOUT_SRC_MUX		BIT(5)
    -+#define LMK04832_REG_CLKOUT_CTRL1(ch)	(0x103 + (ch >> 1) * 8)
    -+#define LMK04832_BIT_DCLK_PD			BIT(4)
    -+#define LMK04832_REG_CLKOUT_CTRL2(ch)	(0x104 + (ch >> 1) * 8)
    ++#define LMK04832_REG_CLKOUT_CTRL3(ch)	(0x103 + (ch >> 1) * 8)
    ++#define LMK04832_BIT_DCLKX_Y_PD			BIT(4)
    ++#define LMK04832_BIT_DCLKX_Y_DCC		BIT(2)
    ++#define LMK04832_REG_CLKOUT_CTRL4(ch)	(0x104 + (ch >> 1) * 8)
     +#define LMK04832_BIT_SCLK_PD			BIT(4)
     +#define LMK04832_REG_CLKOUT_FMT(ch)	(0x107 + (ch >> 1) * 8)
     +#define LMK04832_BIT_CLKOUT_FMT(ch)		(ch % 2 ? 0xf0 : 0x0f)
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +/**
     + * lmk04832_device_info - Holds static device information that is specific to
    -+ * the chip revision
    ++ *                        the chip revision
     + *
     + * pid:          Product Identifier
     + * maskrev:      IC version identifier
    @@ drivers/clk/clk-lmk04832.c (new)
     + * vco1_range:   {min, max} of the VCO1 operating range (in MHz)
     + */
     +struct lmk04832_device_info {
    -+	uint16_t pid;
    -+	uint8_t maskrev;
    -+	unsigned int num_channels;
    ++	u16 pid;
    ++	u8 maskrev;
    ++	size_t num_channels;
     +	unsigned int vco0_range[2];
     +	unsigned int vco1_range[2];
     +};
     +
    -+struct lmk04832_device_info lmk04832_device_info[] = {
    ++const struct lmk04832_device_info lmk04832_device_info[] = {
     +	[LMK04832] = {
     +		.pid = 0x63d1, /* WARNING PROD_ID is inverted in the datasheet */
     +		.maskrev = 0x70,
    @@ drivers/clk/clk-lmk04832.c (new)
     +struct lmk_dclk {
     +	struct lmk04832 *lmk;
     +	struct clk_hw hw;
    -+	uint8_t id;
    ++	u8 id;
     +};
     +
     +struct lmk_clkout {
     +	struct lmk04832 *lmk;
     +	struct clk_hw hw;
    -+	uint32_t format;
     +	bool sysref;
    -+	uint8_t id;
    ++	u32 format;
    ++	u8 id;
     +};
     +
     +/**
     + * struct lmk04832 - The LMK04832 device structure
     + *
    -+ * @dev:    reference to a struct device, linked to the spi_device
    ++ * @dev: reference to a struct device, linked to the spi_device
     + * @regmap: struct regmap instance use to access the chip
    -+ *
    -+ * @oscin:  PLL2 input clock
    -+ * @vco:    reference to the internal VCO clock
    -+ * @sclk:   reference to the internal sysref clock (SCLK)
    -+ *
    -+ * @reset_gpio: Device reset GPIO
    -+ *
    -+ * @dclk:   List of device clocks (DCLKX_Y), There's one device clock for each
    -+ *          pair of clkout clocks.
    -+ * @clkout: List of output clocks.
    ++ * @oscin: PLL2 input clock
    ++ * @vco: reference to the internal VCO clock
    ++ * @sclk: reference to the internal sysref clock (SCLK)
    ++ * @vco_rate: user provided VCO rate
    ++ * @reset_gpio: reference to the reset GPIO
    ++ * @dclk: list of internal device clock references.
    ++ *        Each pair of clkout clocks share a single device clock (DCLKX_Y)
    ++ * @clkout: list of output clock references
    ++ * @clk_data: holds clkout related data like clk_hw* and number of clocks
     + */
     +struct lmk04832 {
     +	struct device *dev;
    @@ drivers/clk/clk-lmk04832.c (new)
     +	struct clk *oscin;
     +	struct clk_hw vco;
     +	struct clk_hw sclk;
    ++	unsigned int vco_rate;
     +
     +	struct gpio_desc *reset_gpio;
     +
     +	struct lmk_dclk *dclk;
     +	struct lmk_clkout *clkout;
     +	struct clk_hw_onecell_data *clk_data;
    -+
    -+#ifdef CONFIG_DEBUG_FS
    -+	struct dentry *debugfs_dentry;
    -+	uint16_t cached_reg_addr;
    -+#endif
    -+};
    -+
    -+#ifdef CONFIG_DEBUG_FS
    -+static ssize_t debugfs_read_reg(struct file *file, char __user *userbuf,
    -+				size_t count, loff_t *ppos)
    -+{
    -+	struct lmk04832 *lmk = file->private_data;
    -+	unsigned int val = 0;
    -+	char buf[20];
    -+	ssize_t len;
    -+	int ret;
    -+
    -+	ret = regmap_read(lmk->regmap, lmk->cached_reg_addr, &val);
    -+	if (ret) {
    -+		dev_err(lmk->dev, "%s: read reg 0x%04x failed (%d)\n", __func__,
    -+			lmk->cached_reg_addr, ret);
    -+		return ret;
    -+	}
    -+
    -+	len = snprintf(buf, sizeof(buf), "0x%02x\n", val);
    -+
    -+	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
    -+}
    -+
    -+static ssize_t debugfs_write_reg(struct file *file, const char __user *userbuf,
    -+				 size_t count, loff_t *ppos)
    -+{
    -+	struct lmk04832 *lmk = file->private_data;
    -+	unsigned int reg, val;
    -+	char buf[32];
    -+	int ret;
    -+
    -+	count = min_t(size_t, count, (sizeof(buf) - 1));
    -+	if (copy_from_user(buf, userbuf, count))
    -+		return -EFAULT;
    -+
    -+	buf[count] = 0;
    -+
    -+	ret = sscanf(buf, "%i %i", &reg, &val);
    -+
    -+	switch (ret) {
    -+	case 1:
    -+		lmk->cached_reg_addr = reg;
    -+		break;
    -+	case 2:
    -+		lmk->cached_reg_addr = reg;
    -+		ret = regmap_write(lmk->regmap, reg, val);
    -+		if (ret) {
    -+			dev_err(lmk->dev, "%s: write reg 0x%04x failed\n",
    -+				__func__, lmk->cached_reg_addr);
    -+			return ret;
    -+		}
    -+		break;
    -+	default:
    -+		return -EINVAL;
    -+	}
    -+
    -+	return count;
    -+}
    -+
    -+static const struct file_operations debugfs_reg_fops = {
    -+	.open = simple_open,
    -+	.read = debugfs_read_reg,
    -+	.write = debugfs_write_reg,
     +};
     +
    -+static int lmk04832_register_debugfs(struct lmk04832 *lmk)
    -+{
    -+	struct dentry *d;
    -+	struct device_node *np = lmk->dev->of_node;
    -+
    -+	lmk->debugfs_dentry = debugfs_create_dir(np->name, NULL);
    -+	if (IS_ERR(lmk->debugfs_dentry))
    -+		return PTR_ERR(lmk->debugfs_dentry);
    -+
    -+	if (lmk->debugfs_dentry == NULL) {
    -+		dev_warn(lmk->dev, "Failed to create debugfs directory\n");
    -+		return -EFAULT;
    -+	}
    -+
    -+	d = debugfs_create_file("direct_reg_access", 0644,
    -+				lmk->debugfs_dentry,
    -+				lmk, &debugfs_reg_fops);
    -+	if (!d) {
    -+		debugfs_remove_recursive(lmk->debugfs_dentry);
    -+		return -ENOMEM;
    -+	}
    -+
    -+	return 0;
    -+}
    -+#endif
    -+
     +static bool lmk04832_regmap_rd_regs(struct device *dev, unsigned int reg)
     +{
     +	switch (reg) {
     +	case LMK04832_REG_RST3W ... LMK04832_REG_ID_MASKREV:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_ID_VNDR_MSB:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_ID_VNDR_LSB:
    -+		/* fallthrough */
    -+	case LMK04832_REG_DCLK_DIV_LSB(0) ... LMK04832_REG_PLL2_DLD_CNT_LSB:
    -+		/* fallthrough */
    ++		fallthrough;
    ++	case LMK04832_REG_CLKOUT_CTRL0(0) ... LMK04832_REG_PLL2_DLD_CNT_LSB:
    ++		fallthrough;
     +	case LMK04832_REG_PLL2_LD:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_PLL2_PD:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_PLL1R_RST:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_CLR_PLL_LOST ... LMK04832_REG_RB_DAC_VAL_LSB:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_RB_HOLDOVER:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_SPI_LOCK:
     +		return true;
     +	default:
    @@ drivers/clk/clk-lmk04832.c (new)
     +{
     +	switch (reg) {
     +	case LMK04832_REG_RST3W:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_POWERDOWN:
     +		return true;
     +	case LMK04832_REG_ID_DEV_TYPE ... LMK04832_REG_ID_MASKREV:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_ID_VNDR_MSB:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_ID_VNDR_LSB:
     +		return false;
    -+	case LMK04832_REG_DCLK_DIV_LSB(0) ... LMK04832_REG_PLL2_DLD_CNT_LSB:
    -+		/* fallthrough */
    ++	case LMK04832_REG_CLKOUT_CTRL0(0) ... LMK04832_REG_PLL2_DLD_CNT_LSB:
    ++		fallthrough;
     +	case LMK04832_REG_PLL2_LD:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_PLL2_PD:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_PLL1R_RST:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_CLR_PLL_LOST ... LMK04832_REG_RB_DAC_VAL_LSB:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_RB_HOLDOVER:
    -+		/* fallthrough */
    ++		fallthrough;
     +	case LMK04832_REG_SPI_LOCK:
     +		return true;
     +	default:
    @@ drivers/clk/clk-lmk04832.c (new)
     +	unsigned int pll2_n, p, pll2_r;
     +	unsigned int pll2_misc;
     +	unsigned long vco_rate;
    -+	uint8_t tmp[3];
    ++	u8 tmp[3];
     +	int ret;
     +
     +	ret = regmap_read(lmk->regmap, LMK04832_REG_PLL2_MISC, &pll2_misc);
    @@ drivers/clk/clk-lmk04832.c (new)
     +	if (ret)
     +		return ret;
     +
    -+	pll2_n = (FIELD_GET(LMK04832_BIT_PLL2_N_0, tmp[0]) << 16) |
    -+		 tmp[1] << 8 | tmp[2];
    ++	pll2_n = FIELD_PREP(0x030000, tmp[0]) |
    ++		 FIELD_PREP(0x00ff00, tmp[1]) |
    ++		 FIELD_PREP(0x0000ff, tmp[2]);
     +
     +	ret = regmap_bulk_read(lmk->regmap, LMK04832_REG_PLL2_R_MSB, &tmp, 2);
     +	if (ret)
     +		return ret;
     +
    -+	pll2_r = (FIELD_GET(LMK04832_BIT_PLL2_R_MSB, tmp[0]) << 8) | tmp[1];
    -+
    ++	pll2_r = FIELD_PREP(0x0f00, tmp[0]) |
    ++		 FIELD_PREP(0x00ff, tmp[1]);
     +
     +	vco_rate = (prate << FIELD_GET(LMK04832_BIT_PLL2_MISC_REF_2X_EN,
     +				       pll2_misc)) * pll2_n * pll2_p[p] / pll2_r;
    @@ drivers/clk/clk-lmk04832.c (new)
     + * @lmk:   Reference to the lmk device
     + * @rate:  Desired output rate for the VCO
     + *
    -+ * The LMK04832 has 2 internal VCO, each with independant operating ranges. Use
    -+ * the device_info structure to determine which VCO to use based on rate.
    ++ * The LMK04832 has 2 internal VCO, each with independant operating ranges.
    ++ * Use the device_info structure to determine which VCO to use based on rate.
     + *
     + * Returns VCO_MUX value or negative errno.
     + */
     +static int lmk04832_check_vco_ranges(struct lmk04832 *lmk, unsigned long rate)
     +{
     +	struct spi_device *spi = to_spi_device(lmk->dev);
    -+	struct lmk04832_device_info info;
    ++	const struct lmk04832_device_info *info;
     +	unsigned long mhz = rate / 1000000;
     +
    -+	info = lmk04832_device_info[spi_get_device_id(spi)->driver_data];
    ++	info = &lmk04832_device_info[spi_get_device_id(spi)->driver_data];
     +
    -+	if (mhz >= info.vco0_range[0] && mhz <= info.vco0_range[1]) {
    ++	if (mhz >= info->vco0_range[0] && mhz <= info->vco0_range[1]) {
     +		return LMK04832_VAL_VCO_MUX_VCO0;
    -+	} else if (mhz >= info.vco1_range[0] && mhz <= info.vco1_range[1]) {
    ++	} else if (mhz >= info->vco1_range[0] && mhz <= info->vco1_range[1]) {
     +		return LMK04832_VAL_VCO_MUX_VCO1;
     +	} else {
    -+		dev_err(lmk->dev, "%lu Hz is out of VCO ranges", rate);
    ++		dev_err(lmk->dev, "%lu Hz is out of VCO ranges\n", rate);
     +		return -ERANGE;
     +	}
     +}
    @@ drivers/clk/clk-lmk04832.c (new)
     + * @prate: parent rate to the PLL2, usually OSCin
     + * @rate:  Desired output rate for the VCO
     + * @n:     reference to PLL2_N
    ++ * @p:     reference to PLL2_P
     + * @r:     reference to PLL2_R
     + *
     + * This functions assumes LMK04832_BIT_PLL2_MISC_REF_2X_EN is set since it is
    @@ drivers/clk/clk-lmk04832.c (new)
     +				      unsigned int *n, unsigned int *p,
     +				      unsigned int *r)
     +{
    ++	unsigned int pll2_n, pll2_p, pll2_r;
     +	unsigned long num, div;
     +
     +	/* Set PLL2_P to a fixed value to simplify optimizations */
    -+	*p = 2;
    ++	pll2_p = 2;
     +
     +	div = gcd(rate, prate);
     +
    -+	/* num = 2 * PLL_N * PLL_P */
     +	num = DIV_ROUND_CLOSEST(rate, div);
    -+	*r = DIV_ROUND_CLOSEST(prate, div);
    ++	pll2_r = DIV_ROUND_CLOSEST(prate, div);
     +
     +	if (num > 4) {
    -+		*n = num >> 2;
    ++		pll2_n = num >> 2;
     +	} else {
    -+		*r = *r << 2;
    -+		*n = num;
    ++		pll2_r = pll2_r << 2;
    ++		pll2_n = num;
     +	}
     +
    -+	if (*n < 1 || *n > 0x03ffff)
    ++	if (pll2_n < 1 || pll2_n > 0x03ffff)
     +		return -EINVAL;
    -+	if (*r < 1 || *r > 0xfff)
    ++	if (pll2_r < 1 || pll2_r > 0xfff)
     +		return -EINVAL;
     +
    -+	return DIV_ROUND_CLOSEST(prate * 2 * *p * *n, *r);
    ++	*n = pll2_n;
    ++	*p = pll2_p;
    ++	*r = pll2_r;
    ++
    ++	return DIV_ROUND_CLOSEST(prate * 2 * pll2_p * pll2_n, pll2_r);
     +}
     +
     +static long lmk04832_vco_round_rate(struct clk_hw *hw, unsigned long rate,
     +				    unsigned long *prate)
     +{
     +	struct lmk04832 *lmk = container_of(hw, struct lmk04832, vco);
    -+	unsigned long vco_rate;
     +	unsigned int n, p, r;
    ++	long vco_rate;
     +	int ret;
     +
     +	ret = lmk04832_check_vco_ranges(lmk, rate);
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +	vco_rate = lmk04832_calc_pll2_params(*prate, rate, &n, &p, &r);
     +	if (vco_rate < 0) {
    -+		dev_err(lmk->dev, "PLL2 parmeters out of range (N=%d, P=%d, R=%d)\n",
    -+			n, p, r);
    ++		dev_err(lmk->dev, "PLL2 parmeters out of range\n");
     +		return vco_rate;
     +	}
     +
    -+	dev_dbg(lmk->dev, "%s: prate %ld Hz, got %ld Hz (delta=%lu Hz)\n",
    -+		clk_hw_get_name(hw), *prate, vco_rate, abs(rate - vco_rate));
    ++	if (rate != vco_rate)
    ++		return -EINVAL;
     +
     +	return vco_rate;
     +};
    @@ drivers/clk/clk-lmk04832.c (new)
     +				 unsigned long prate)
     +{
     +	struct lmk04832 *lmk = container_of(hw, struct lmk04832, vco);
    -+	unsigned long vco_rate;
     +	unsigned int n, p, r;
    ++	long vco_rate;
     +	int vco_mux;
     +	int ret;
     +
    @@ drivers/clk/clk-lmk04832.c (new)
     +			   FIELD_GET(0x00ff00, n));
     +	if (ret)
     +		return ret;
    -+	ret = regmap_write(lmk->regmap, LMK04832_REG_PLL2_N_2,
    -+			   FIELD_GET(0x0000ff, n));
    -+	if (ret)
    -+		return ret;
     +
    -+	return 0;
    ++	return regmap_write(lmk->regmap, LMK04832_REG_PLL2_N_2,
    ++			    FIELD_GET(0x0000ff, n));
     +};
     +
    -+const struct clk_ops lmk04832_vco_ops = {
    ++static const struct clk_ops lmk04832_vco_ops = {
     +	.is_enabled = lmk04832_vco_is_enabled,
     +	.prepare = lmk04832_vco_prepare,
     +	.unprepare = lmk04832_vco_unprepare,
    @@ drivers/clk/clk-lmk04832.c (new)
     +	.set_rate = lmk04832_vco_set_rate,
     +};
     +
    ++/*
    ++ * lmk04832_register_vco - Initialize the internal VCO and clock distribution
    ++ *                         path in PLL2 single loop mode.
    ++ */
     +static int lmk04832_register_vco(struct lmk04832 *lmk)
     +{
     +	const char *parent_names[1];
    @@ drivers/clk/clk-lmk04832.c (new)
     +	init.parent_names = parent_names;
     +
     +	init.ops = &lmk04832_vco_ops;
    -+	init.flags = CLK_SET_RATE_GATE;
     +	init.num_parents = 1;
     +
     +	ret = regmap_update_bits(lmk->regmap, LMK04832_REG_VCO_OSCOUT,
    @@ drivers/clk/clk-lmk04832.c (new)
     +{
     +	struct lmk04832 *lmk = container_of(hw, struct lmk04832, sclk);
     +	unsigned int sysref_div;
    -+	uint8_t tmp[2];
    ++	u8 tmp[2];
     +	int ret;
     +
     +	ret = regmap_bulk_read(lmk->regmap, LMK04832_REG_SYSREF_DIV_MSB, &tmp, 2);
    @@ drivers/clk/clk-lmk04832.c (new)
     +		return -EINVAL;
     +	}
     +
    -+	dev_dbg(lmk->dev, "%s: prate %ld Hz, got %ld Hz (delta=%lu Hz)\n",
    -+		clk_hw_get_name(hw), *prate, sclk_rate, abs(rate - sclk_rate));
    ++	if (rate != sclk_rate)
    ++		return -EINVAL;
     +
     +	return sclk_rate;
     +}
    @@ drivers/clk/clk-lmk04832.c (new)
     +			    FIELD_GET(0x00ff, sysref_div));
     +}
     +
    -+const struct clk_ops lmk04832_sclk_ops = {
    ++static const struct clk_ops lmk04832_sclk_ops = {
     +	.is_enabled = lmk04832_sclk_is_enabled,
     +	.prepare = lmk04832_sclk_prepare,
     +	.unprepare = lmk04832_sclk_unprepare,
    @@ drivers/clk/clk-lmk04832.c (new)
     +{
     +	const char *parent_names[1];
     +	struct clk_init_data init;
    -+	int ret = 0;
    ++	int ret;
     +
     +	init.name = "lmk-sclk";
     +	parent_names[0] = clk_hw_get_name(&lmk->vco);
    @@ drivers/clk/clk-lmk04832.c (new)
     +	unsigned int tmp;
     +	int ret;
     +
    -+	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL1(dclk->id),
    ++	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL3(dclk->id),
     +			  &tmp);
     +	if (ret)
     +		return ret;
     +
    -+	return !FIELD_GET(LMK04832_BIT_DCLK_PD, tmp);
    ++	return !FIELD_GET(LMK04832_BIT_DCLKX_Y_PD, tmp);
     +}
     +
     +static int lmk04832_dclk_prepare(struct clk_hw *hw)
    @@ drivers/clk/clk-lmk04832.c (new)
     +	struct lmk04832 *lmk = dclk->lmk;
     +
     +	return regmap_update_bits(lmk->regmap,
    -+				  LMK04832_REG_CLKOUT_CTRL1(dclk->id),
    -+				  LMK04832_BIT_DCLK_PD, 0x00);
    ++				  LMK04832_REG_CLKOUT_CTRL3(dclk->id),
    ++				  LMK04832_BIT_DCLKX_Y_PD, 0x00);
     +}
     +
     +static void lmk04832_dclk_unprepare(struct clk_hw *hw)
    @@ drivers/clk/clk-lmk04832.c (new)
     +	struct lmk04832 *lmk = dclk->lmk;
     +
     +	regmap_update_bits(lmk->regmap,
    -+			   LMK04832_REG_CLKOUT_CTRL1(dclk->id),
    -+			   LMK04832_BIT_DCLK_PD, 0xff);
    ++			   LMK04832_REG_CLKOUT_CTRL3(dclk->id),
    ++			   LMK04832_BIT_DCLKX_Y_PD, 0xff);
     +}
     +
     +static unsigned long lmk04832_dclk_recalc_rate(struct clk_hw *hw,
    @@ drivers/clk/clk-lmk04832.c (new)
     +	unsigned long rate;
     +	int ret;
     +
    -+	ret = regmap_read(lmk->regmap, LMK04832_REG_DCLK_DIV_LSB(dclk->id),
    ++	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(dclk->id),
     +			  &lsb);
     +	if (ret)
     +		return ret;
     +
    -+	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(dclk->id),
    ++	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL2(dclk->id),
     +			  &msb);
     +	if (ret)
     +		return ret;
    @@ drivers/clk/clk-lmk04832.c (new)
     +	dclk_rate = DIV_ROUND_CLOSEST(*prate, dclk_div);
     +
     +	if (dclk_div < 1 || dclk_div > 0x3ff) {
    -+		dev_err(lmk->dev, "%s_div out of range", clk_hw_get_name(hw));
    ++		dev_err(lmk->dev, "%s_div out of range\n", clk_hw_get_name(hw));
     +		return -EINVAL;
     +	}
     +
    -+	dev_dbg(lmk->dev, "%s: prate %ld Hz, got %ld Hz (delta=%lu Hz)\n",
    -+		clk_hw_get_name(hw), *prate, dclk_rate, abs(rate - dclk_rate));
    ++	if (rate != dclk_rate)
    ++		return -EINVAL;
     +
     +	return dclk_rate;
     +};
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +	dclk_div = DIV_ROUND_CLOSEST(prate, rate);
     +
    -+	if (dclk_div < 1 || dclk_div > 0x3ff) {
    -+		dev_err(lmk->dev, "%s_div out of range", clk_hw_get_name(hw));
    ++	if (dclk_div > 0x3ff) {
    ++		dev_err(lmk->dev, "%s_div out of range\n", clk_hw_get_name(hw));
     +		return -EINVAL;
     +	}
     +
    -+	ret = regmap_write(lmk->regmap, LMK04832_REG_DCLK_DIV_LSB(dclk->id),
    ++	/* Enable Duty Cycle Corretion */
    ++	if (dclk_div == 1) {
    ++		ret = regmap_update_bits(lmk->regmap,
    ++					 LMK04832_REG_CLKOUT_CTRL3(dclk->id),
    ++					 LMK04832_BIT_DCLKX_Y_DCC,
    ++					 FIELD_PREP(LMK04832_BIT_DCLKX_Y_DCC, 1));
    ++		if (ret)
    ++			return ret;
    ++	}
    ++
    ++	ret = regmap_write(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(dclk->id),
     +			   FIELD_GET(0x0ff, dclk_div));
     +	if (ret)
     +		return ret;
     +
     +	return regmap_update_bits(lmk->regmap,
    -+				  LMK04832_REG_CLKOUT_CTRL0(dclk->id),
    ++				  LMK04832_REG_CLKOUT_CTRL2(dclk->id),
     +				  LMK04832_BIT_DCLK_DIV_MSB,
     +				  FIELD_GET(0x300, dclk_div));
     +};
     +
    -+const struct clk_ops lmk04832_dclk_ops = {
    ++static const struct clk_ops lmk04832_dclk_ops = {
     +	.is_enabled = lmk04832_dclk_is_enabled,
     +	.prepare = lmk04832_dclk_prepare,
     +	.unprepare = lmk04832_dclk_unprepare,
    @@ drivers/clk/clk-lmk04832.c (new)
     +	unsigned int clkoutx_y_pd;
     +	unsigned int sclkx_y_pd;
     +	unsigned int tmp;
    -+	uint8_t fmt;
    -+	int enabled;
    ++	u32 enabled;
     +	int ret;
    ++	u8 fmt;
     +
    -+	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL0(clkout->id),
    ++	ret = regmap_read(lmk->regmap, LMK04832_REG_CLKOUT_CTRL2(clkout->id),
     +			  &clkoutx_y_pd);
     +	if (ret)
     +		return ret;
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +	if (FIELD_GET(LMK04832_BIT_CLKOUT_SRC_MUX, tmp)) {
     +		ret = regmap_read(lmk->regmap,
    -+				  LMK04832_REG_CLKOUT_CTRL2(clkout->id),
    ++				  LMK04832_REG_CLKOUT_CTRL4(clkout->id),
     +				  &sclkx_y_pd);
     +		if (ret)
     +			return ret;
    @@ drivers/clk/clk-lmk04832.c (new)
     +	if (ret)
     +		return ret;
     +
    -+	fmt = (tmp & (0xf << 4 * (clkout->id % 2))) >> 4 * (clkout->id % 2);
    ++	if (clkout->id % 2)
    ++		fmt = FIELD_GET(0xf0, tmp);
    ++	else
    ++		fmt = FIELD_GET(0x0f, tmp);
    ++
     +	return enabled && !fmt;
     +}
     +
    @@ drivers/clk/clk-lmk04832.c (new)
     +			clk_hw_get_name(hw));
     +
     +	ret = regmap_update_bits(lmk->regmap,
    -+				 LMK04832_REG_CLKOUT_CTRL0(clkout->id),
    ++				 LMK04832_REG_CLKOUT_CTRL2(clkout->id),
     +				 LMK04832_BIT_CLKOUTX_Y_PD, 0x00);
     +	if (ret)
     +		return ret;
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +	if (FIELD_GET(LMK04832_BIT_CLKOUT_SRC_MUX, tmp)) {
     +		ret = regmap_update_bits(lmk->regmap,
    -+					 LMK04832_REG_CLKOUT_CTRL2(clkout->id),
    ++					 LMK04832_REG_CLKOUT_CTRL4(clkout->id),
     +					 LMK04832_BIT_SCLK_PD, 0x00);
     +		if (ret)
     +			return ret;
    @@ drivers/clk/clk-lmk04832.c (new)
     +	return FIELD_GET(LMK04832_BIT_CLKOUT_SRC_MUX, tmp);
     +}
     +
    -+const struct clk_ops lmk04832_clkout_ops = {
    ++static const struct clk_ops lmk04832_clkout_ops = {
     +	.is_enabled = lmk04832_clkout_is_enabled,
     +	.prepare = lmk04832_clkout_prepare,
     +	.unprepare = lmk04832_clkout_unprepare,
    @@ drivers/clk/clk-lmk04832.c (new)
     +		lmk->dclk[dclk_num].id = num;
     +		lmk->dclk[dclk_num].lmk = lmk;
     +		lmk->dclk[dclk_num].hw.init = &init;
    ++
     +		ret = devm_clk_hw_register(lmk->dev, &lmk->dclk[dclk_num].hw);
     +		if (ret)
     +			return ret;
    @@ drivers/clk/clk-lmk04832.c (new)
     +	int reg;
     +	int ret;
     +
    -+	dev_info(lmk->dev, "Setting up 4-wire mode");
    ++	dev_info(lmk->dev, "setting up 4-wire mode\n");
     +	ret = regmap_write(lmk->regmap, LMK04832_REG_RST3W,
     +			   LMK04832_BIT_SPI_3WIRE_DIS);
     +	if (ret)
    @@ drivers/clk/clk-lmk04832.c (new)
     +
     +static int lmk04832_probe(struct spi_device *spi)
     +{
    -+	struct lmk04832_device_info lmk_devinfo;
    ++	const struct lmk04832_device_info *info;
     +	int rdbk_pin = RDBK_CLKIN_SEL1;
     +	struct device_node *child;
     +	struct lmk04832 *lmk;
    -+	uint8_t tmp[3];
    -+	int ret = 0;
    ++	u8 tmp[3];
    ++	int ret;
     +	int i;
     +
    -+	lmk_devinfo = lmk04832_device_info[spi_get_device_id(spi)->driver_data];
    ++	info = &lmk04832_device_info[spi_get_device_id(spi)->driver_data];
     +
     +	lmk = devm_kzalloc(&spi->dev, sizeof(struct lmk04832), GFP_KERNEL);
     +	if (!lmk)
    @@ drivers/clk/clk-lmk04832.c (new)
     +	if (ret)
     +		return ret;
     +
    -+	lmk->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
    -+	if (!IS_ERR(lmk->reset_gpio)) {
    -+		ret = gpiod_direction_output(lmk->reset_gpio, 0);
    -+	}
    ++	lmk->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
    ++						  GPIOD_OUT_LOW);
     +
    -+	lmk->dclk = devm_kcalloc(lmk->dev, lmk_devinfo.num_channels >> 1,
    ++	lmk->dclk = devm_kcalloc(lmk->dev, info->num_channels >> 1,
     +				 sizeof(struct lmk_dclk), GFP_KERNEL);
     +	if (IS_ERR(lmk->dclk)) {
     +		ret = PTR_ERR(lmk->dclk);
     +		goto err_disable_oscin;
     +	}
     +
    -+	lmk->clkout = devm_kcalloc(lmk->dev, lmk_devinfo.num_channels,
    -+				    sizeof(struct lmk_clkout), GFP_KERNEL);
    ++	lmk->clkout = devm_kcalloc(lmk->dev, info->num_channels,
    ++				   sizeof(*lmk->clkout), GFP_KERNEL);
     +	if (IS_ERR(lmk->clkout)) {
     +		ret = PTR_ERR(lmk->clkout);
     +		goto err_disable_oscin;
     +	}
     +
    -+	lmk->clk_data = devm_kzalloc(lmk->dev, sizeof(*lmk->clk_data) +
    -+				     sizeof(*lmk->clk_data->hws) *
    -+				     lmk_devinfo.num_channels,
    ++	lmk->clk_data = devm_kzalloc(lmk->dev, struct_size(lmk->clk_data, hws,
    ++							   info->num_channels),
     +				     GFP_KERNEL);
     +	if (IS_ERR(lmk->clk_data)) {
     +		ret = PTR_ERR(lmk->clk_data);
     +		goto err_disable_oscin;
     +	}
     +
    ++	device_property_read_u32(lmk->dev, "lmk,vco-rate", &lmk->vco_rate);
    ++
     +	for_each_child_of_node(lmk->dev->of_node, child) {
     +		int reg;
     +
    @@ drivers/clk/clk-lmk04832.c (new)
     +	}
     +
     +	regmap_bulk_read(lmk->regmap, LMK04832_REG_ID_PROD_MSB, &tmp, 3);
    -+	if ((tmp[0] << 8 | tmp[1]) != lmk_devinfo.pid || tmp[2] != lmk_devinfo.maskrev) {
    ++	if ((tmp[0] << 8 | tmp[1]) != info->pid || tmp[2] != info->maskrev) {
     +		dev_err(lmk->dev, "unsupported device type: pid 0x%04x, maskrev 0x%02x\n",
     +			tmp[0] << 8 | tmp[1], tmp[2]);
     +		ret = -EINVAL;
     +		goto err_disable_oscin;
     +	}
     +
    -+	/* Setup device clock path in PLL2 single loop mode */
     +	ret = lmk04832_register_vco(lmk);
     +	if (ret) {
     +		dev_err(lmk->dev, "failed to init device clock path\n");
     +		goto err_disable_oscin;
     +	}
     +
    -+	/* Setup SYNC/SYSREF in continuous mode */
    ++	if (lmk->vco_rate) {
    ++		dev_info(lmk->dev, "setting VCO rate to %u Hz\n", lmk->vco_rate);
    ++		ret = clk_set_rate(lmk->vco.clk, lmk->vco_rate);
    ++		if (ret) {
    ++			dev_err(lmk->dev, "failed to set VCO rate\n");
    ++			goto err_disable_vco;
    ++		}
    ++	}
    ++
     +	ret = lmk04832_register_sclk(lmk);
     +	if (ret) {
     +		dev_err(lmk->dev, "failed to init SYNC/SYSREF clock path\n");
    -+		goto err_disable_oscin;
    ++		goto err_disable_vco;
     +	}
     +
    -+	for (i = 0; i < lmk_devinfo.num_channels; i++) {
    ++	for (i = 0; i < info->num_channels; i++) {
     +		ret = lmk04832_register_clkout(lmk, i);
     +		if (ret) {
     +			dev_err(lmk->dev, "failed to register clk %d\n", i);
    -+			goto err_disable_oscin;
    ++			goto err_disable_vco;
     +		}
     +	}
     +
    -+	lmk->clk_data->num = lmk_devinfo.num_channels;
    ++	lmk->clk_data->num = info->num_channels;
     +	ret = of_clk_add_hw_provider(lmk->dev->of_node, of_clk_hw_onecell_get,
     +				     lmk->clk_data);
     +	if (ret) {
     +		dev_err(lmk->dev, "failed to add provider (%d)\n", ret);
    -+		goto err_disable_oscin;
    ++		goto err_disable_vco;
     +	}
     +
    -+#ifdef CONFIG_DEBUG_FS
    -+	ret = lmk04832_register_debugfs(lmk);
    -+	if (ret)
    -+		goto err_del_provider;
    -+#endif
    -+
     +	spi_set_drvdata(spi, lmk);
    -+	dev_info(lmk->dev, "successfully initialized, product ID is 0x%04x\n",
    -+		 lmk_devinfo.pid);
     +
     +	return 0;
     +
    -+err_del_provider:
    -+	of_clk_del_provider(spi->dev.of_node);
    ++err_disable_vco:
    ++	clk_disable_unprepare(lmk->vco.clk);
     +
     +err_disable_oscin:
     +	clk_disable_unprepare(lmk->oscin);
    @@ drivers/clk/clk-lmk04832.c (new)
     +{
     +	struct lmk04832 *lmk = spi_get_drvdata(spi);
     +
    -+#ifdef CONFIG_DEBUG_FS
    -+	debugfs_remove_recursive(lmk->debugfs_dentry);
    -+#endif
     +	clk_disable_unprepare(lmk->oscin);
    -+
     +	of_clk_del_provider(spi->dev.of_node);
     +
     +	return 0;
     +}
     +static const struct spi_device_id lmk04832_id[] = {
     +	{ "lmk04832", LMK04832 },
    -+	{}
    ++	{},
     +};
     +MODULE_DEVICE_TABLE(spi, lmk04832_id);
     +
    ++static const struct of_device_id lmk04832_of_id[] = {
    ++	{ .compatible = "ti,lmk04832" },
    ++	{},
    ++};
    ++
     +static struct spi_driver lmk04832_driver = {
     +	.driver = {
     +		.name	= "lmk04832",
    -+		.owner	= THIS_MODULE,
     +	},
     +	.probe		= lmk04832_probe,
     +	.remove		= lmk04832_remove,
-:  ------------ > 2:  0cb26fc6f2ff clk: lmk04832: add support for digital delay

base-commit: f40ddce88593482919761f74910f42f4b84c004b
-- 
2.30.1.489.g328c10930387

