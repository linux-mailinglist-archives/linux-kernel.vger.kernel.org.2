Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36A35479B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 22:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbhDEUgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 16:36:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34678 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236422AbhDEUgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 16:36:42 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lTVxY-00EzFi-B3; Mon, 05 Apr 2021 22:36:32 +0200
Date:   Mon, 5 Apr 2021 22:36:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     linus.walleij@linaro.org, ulli.kroll@googlemail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: gemini: sl3516: Mainlining of NS 2502
Message-ID: <YGt00DdrToMTskp8@lunn.ch>
References: <YGtZeofmBv7hXK+a@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGtZeofmBv7hXK+a@Red>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 08:39:54PM +0200, Corentin Labbe wrote:

> 	mdio0: ethernet-phy {

Not relevant to the brokennes, but this should not be called
ethernet-phy. The example given in
Documentation/devicetree/bindings/net/mdio-gpio.txt is

mdio0: mdio

> 		compatible = "virtual,mdio-gpio";
> 		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> 			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		phy0: ethernet-phy@1 {
> 			reg = <1>;
> 			device_type = "ethernet-phy";
> 		};
> 	};

So you are using a bit-banging MDIO bus.

> 		gpio0: gpio@4d000000 {
> 			pinctrl-names = "default";
> 			pinctrl-0 = <&gpio0_default_pins>;
> 		};

and here is the gpio controller.

> 		ethernet@60000000 {
> 			status = "okay";
> 			ethernet-port@0 {
> 				phy-mode = "rgmii";
> 				phy-handle = <&phy0>;
> 			};
> 			ethernet-port@1 {
> 				/* Not used in this platform */
> 			};
> 		};

and this look O.K.

> libphy: Fixed MDIO Bus: probed
> mdio-gpio ethernet-phy: failed to get alias id

That does not look too good. But it is just a warning.

        if (pdev->dev.of_node) {
                bus_id = of_alias_get_id(pdev->dev.of_node, "mdio-gpio");
                if (bus_id < 0) {
                        dev_warn(&pdev->dev, "failed to get alias id\n");
                        bus_id = 0;
                }

If you look at the example in the documentation, it has

aliases {
        mdio-gpio0 = &mdio0;
};

If you add that, i guess this will go away.
  

> libphy: GPIO Bitbanged MDIO: probed
> tun: Universal TUN/TAP device driver, 1.6
> gmac-gemini 60000000.ethernet: Ethernet device ID: 0x000, revision 0x1
> gemini-ethernet-port 60008000.ethernet-port: probe 60008000.ethernet-port ID 0
> gemini-ethernet-port 60008000.ethernet-port: using a random ethernet address
> RTL8211B Gigabit Ethernet gpio-0:01: attached PHY driver (mii_bus:phy_addr=gpio-0:01, irq=POLL)

So a realtek PHY has been found on the MDIO bus. Good.

> gemini-ethernet-port 60008000.ethernet-port eth0: irq 30, DMA @ 0x0x60008000, GMAC @ 0x0x6000a000

and everything looks good.

> gemini-ethernet-port 6000c000.ethernet-port: probe 6000c000.ethernet-port ID 1
> gemini-ethernet-port 6000c000.ethernet-port: using a random ethernet address
> gemini-ethernet-port 6000c000.ethernet-port (unnamed net_device) (uninitialized): PHY init failed

And now it seems to of all gone horribly wrong :-(

This is the second Ethernet interface, the one you have commented as 

/* Not used in this platform */

I _think_ you just need to delete the entry, otherwise it tried to
probe it. And then that probe fails, it looks like it also fails the
working interface :-(
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host
>        valid_lft forever preferred_lft forever
> 2: eth0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop qlen 1000
>     link/ether b6:95:3c:18:98:62 brd ff:ff:ff:ff:ff:ff
> 3: sit0@NONE: <NOARP> mtu 1480 qdisc noop qlen 1000
>     link/sit 0.0.0.0 brd 0.0.0.0
> # udhcpc -i eth0
> udhcpc: started, v1.33.0
> gmac-gemini 60000000.ethernet: allocate 512 pages for queue
> gemini-ethernet-port 60008000.ethernet-port eth0: Unsupported PHY speed (-1) on gpio-0:01
> gemini-ethernet-port 60008000.ethernet-port eth0: Link is Down
> gemini-ethernet-port 60008000.ethernet-port eth0: link flow control: none
> udhcpc: socket: Address family not supported by protocol
> # gemini-ethernet-port 60008000.ethernet-port eth0: Link is Up - 1Gbps/Full - flow control rx/tx
> gemini-ethernet-port 60008000.ethernet-port eth0: link flow control: tx
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> 
> # udhcpc -i eth0
> udhcpc: started, v1.33.0
> udhcpc: socket: Address family not supported by protocol

That suggests the kernel you have build does not have PF_PACKET.
Enable CONFIG_PACKET_DIAG.

       Andrew
