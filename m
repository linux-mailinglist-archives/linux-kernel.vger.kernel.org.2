Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34473EC104
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 08:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbhHNG7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 02:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232021AbhHNG7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 02:59:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F371F61028;
        Sat, 14 Aug 2021 06:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628924332;
        bh=EV/0x4V8z3izYCldWFKdO2IbRSuZoxsOxbNxI87i/uU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pZFcRdj+IWprpznhWcqB+8mJH+eehoit43d5g8Au/NUd1kyLmBUrJFW/62PYAXdPg
         ooTTdwz81PDboJ5nm6gP//o/ub+TFwrE1MYVufiXY6iAoN7ZK6q+3f/l3g+Cy7KCQJ
         wvgQfCgmm3fCMzwMgk+vPgmsifNVG/dXoAnUE6RoSwUheKXTH0pbkH1bk4j8PYs88w
         69OJ0sQspvxy0ED9YmWgvSE+o3gTGR5cRNrvroL9zsC/4IFDm5O/AktWgOoA4VIu5K
         9C/7ZiiqVke3EWl0PH5CPZL3i23ffk0PTq1Scpu0D6h64h+Do12WP5HL6AbGoJtQdt
         nTPKMbajbclYQ==
Date:   Sat, 14 Aug 2021 08:58:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: add schema for USB hub on Kirin
 devices
Message-ID: <20210814085846.15119702@coco.lan>
In-Reply-To: <YRa/fURTp8QncIEZ@robh.at.kernel.org>
References: <d428b90bb655c7992e9e13fc50130ed223812d2d.1628159456.git.mchehab+huawei@kernel.org>
        <YRa/fURTp8QncIEZ@robh.at.kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 13 Aug 2021 13:52:45 -0500
Rob Herring <robh@kernel.org> escreveu:

> On Thu, Aug 05, 2021 at 12:31:00PM +0200, Mauro Carvalho Chehab wrote:
> > From: Yu Chen <chenyu56@huawei.com>
> > 
> > This patch adds binding documentation to support USB HUB and
> > USB data role switch of HiSilicon HiKey960 and HiKey970 boards.  
> 
> Like PCIe, there's a standard way to describe USB devices in DT. Though 
> PCI is easy compared to USB. :(
> 
> Also like PCIe on Hikey, I'm less than thrilled to define how this 
> should look for a board that's generally not widely available or well 
> supported.

This board is widely available. Mine was bought at Amazon. 96boards has
a list of other places with also sell it:
	https://www.96boards.org/product/hikey970/

> > [mchehab: updated OF names and added support for HiKey970]
> > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bindings/misc/hisilicon,hikey-usb.yaml    | 95 +++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> > new file mode 100644
> > index 000000000000..857f9bd802fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> > @@ -0,0 +1,95 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HiKey960/970 onboard USB GPIO Hub
> > +
> > +maintainers:
> > +  - John Stultz <john.stultz@linaro.org>
> > +
> > +description: |
> > +  Supports the onboard USB GPIO hub found on HiKey960/970.
> > +  The HUB, which acts as a role-switch intermediary to detect the state of
> > +  the USB-C port, to switch the hub into dual-role USB-C or host mode,
> > +  which enables the onboard USB-A host ports.
> > +
> > +  Schematics about the hub can be found here:
> > +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> > +    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - hisilicon,gpio_hubv1
> > +      - hisilicon,kirin970_hikey_usbhub  
> 
> s/_/-/
> 
> Why is one compatible pretty generic and the other very specific?

Historical reasons. I'll change them to:

	  compatible:
	    enum:
	      - hisilicon,hikey960-usbhub
	      - hisilicon,hikey970-usbhub

> 
> > +
> > +  typec-vbus:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle to the typec-vbus gpio  
> 
> If a GPIO, why is it not using a GPIO DT property?

Not sure what you meant. Do you want append "-gpios" to each of the gpio
property, like:

	typec-vbus-gpios
	otg-switch-gpios

Or do you mean something else?

> 
> > +
> > +  otg-switch:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle to the otg-switch gpio  
> 
> Ditto?
> 
> > +
> > +  hub-vdd33-en:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle to the hub 3.3v power enablement gpio  
> 
> GPIOs controlling a power rail should use a gpio-regulator.

Ok. I'll change and do some tests with Kirin960.

> 
> > +
> > +  hub_reset_en_gpio:  
> 
> s/_/-/
> 
> And still, not a GPIO DT property...
> 
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: phandle to the hub reset gpio
> > +
> > +  usb-role-switch:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: Support role switch.
> > +
> > +  hub-vdd-supply:
> > +    description: regulator for hub power
> > +
> > +  port:
> > +    description: |
> > +      any connector to the data bus of this controller should be modelled
> > +      using the OF graph bindings specified, if the "usb-role-switch"
> > +      property is used. Note for this driver, two ports are supported,
> > +      the first being the endpoint that will be notified by this driver,
> > +      and the second being the endpoint that notifies this driver of a
> > +      role switch.  
> 
> You're describing this in terms of driver connections rather than h/w 
> connections.
> 
> But we've already got ways to describe the data connections. For 
> starters, it should be a child of the USB host.
> 
> And how does all this tie in with the USB connector binding?

The HiKey960/970 hardware has those components:

	- a DWC3 IP at the Kirin960/970 SoC;
	- an I2C-controlled host/budget PHY (rt1711h);
	- an in-board USB hub chip. Either one of those chips:
		- On HiKey960: USB5743
		- On HiKey970: TUSB8041
	- USB3 and Type-C ports:
		- On HiKey960: one Type-C port, two USB3 ports
		- On HiKey970: two Type-C ports, two USB3 ports

That makes the port connections more complex, as they are between
the PHY and the HUB.

This is at Kirin970 SoC DT schema (I omitted some properties, to make it
shorter):

	soc {
		gpio0: gpio@e8a0b000 {
			compatible = "arm,pl061", "arm,primecell";
			gpio-controller;
			#gpio-cells = <2>;
			gpio-ranges = <&pmx0 1 0 1 &pmx0 3 1 5>;
		};
		gpio4: gpio@e8a0f000 {
			compatible = "arm,pl061", "arm,primecell";
			gpio-controller;
			#gpio-cells = <2>;
			gpio-ranges = <&pmx0 0 18 8>;
		};
		gpio26: gpio@fff0f000 {
			compatible = "arm,pl061", "arm,primecell";
			gpio-controller;
			#gpio-cells = <2>;
			gpio-ranges = <&pmx1 0 30 1>;
		};

		i2c1: i2c@ffd72000 {
			compatible = "snps,designware-i2c";
		};

		usb3_otg_bc: usb3_otg_bc@ff200000 {
			compatible = "syscon", "simple-mfd";
			reg = <0x0 0xff200000 0x0 0x1000>;

			usb_phy: usbphy {
				compatible = "hisilicon,hi3670-usb-phy";
			};
		};

		usb31_misc_rst: usb31_misc_rst_controller {
			compatible = "hisilicon,hi3660-reset";
			#reset-cells = <2>;
			hisi,rst-syscon = <&usb3_otg_bc>;
		};

		usb3: hisi_dwc3 {
			compatible = "hisilicon,hi3670-dwc3";

			resets = <&crg_rst 0x90 6>,
				 <&crg_rst 0x90 7>,
				 <&usb31_misc_rst 0xA0 8>,
				 <&usb31_misc_rst 0xA0 9>;

			dwc3: usb@ff100000 {
				compatible = "snps,dwc3";
			};
		};
	};

This is the HiKey970 DT schema:

       hikey_usbhub: hikey_usbhub {
               compatible = "hisilicon,kirin970_hikey_usbhub";

               typec-vbus-gpios = <&gpio26 1 0>;
               otg-switch-gpios = <&gpio4 2 0>;
               hub_reset_en_gpio = <&gpio0 3 0>;
               hub-vdd-supply = <&ldo17>;
               usb-role-switch;

               port {
                       #address-cells = <1>;
                       #size-cells = <0>;

                       hikey_usb_ep0: endpoint@0 {
                               reg = <0>;
                               remote-endpoint = <&dwc3_role_switch>;
                       };
                       hikey_usb_ep1: endpoint@1 {
                               reg = <1>;
                               remote-endpoint = <&rt1711h_ep>;
                       };
               };
       };

	&usb_phy {
		phy-supply = <&ldo17>;
	};

	&i2c1 {
		status = "okay";

		rt1711h: rt1711h@4e {
			compatible = "richtek,rt1711h";

			usb_con: connector {
				compatible = "usb-c-connector";
				label = "USB-C";
				data-role = "dual";
				power-role = "dual";
				ports {
					#address-cells = <1>;
					#size-cells = <0>;
					port@1 {
						reg = <1>;
						usb_con_ss: endpoint {
							remote-endpoint = <&dwc3_ss>;
						};
					};
				};
			};
			port {
				#address-cells = <1>;
				#size-cells = <0>;

				rt1711h_ep: endpoint@0 {
					reg = <0>;
					remote-endpoint = <&hikey_usb_ep1>;
				};
			};
		};
	};



> 
> > +
> > +
> > +required:
> > +  - compatible
> > +  - typec-vbus
> > +  - otg-switch
> > +  - usb-role-switch
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    hisi_hikey_usb: hisi_hikey_usb {
> > +        compatible = "hisilicon,gpio_hubv1";
> > +        typec-vbus = <&gpio25 2 GPIO_ACTIVE_HIGH>;
> > +        otg-switch = <&gpio25 6 GPIO_ACTIVE_HIGH>;
> > +        hub-vdd33-en = <&gpio5 6 GPIO_ACTIVE_HIGH>;
> > +        usb-role-switch;
> > +
> > +        port {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            hikey_usb_ep0: endpoint@0 {
> > +                reg = <0>;
> > +                remote-endpoint = <&dwc3_role_switch>;
> > +            };
> > +            hikey_usb_ep1: endpoint@1 {
> > +                reg = <1>;
> > +                remote-endpoint = <&rt1711h_ep>;
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.31.1
> > 
> >   



Thanks,
Mauro
