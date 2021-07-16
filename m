Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6BE3CB398
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbhGPHyp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jul 2021 03:54:45 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59833 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbhGPHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:54:44 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2A134C0005;
        Fri, 16 Jul 2021 07:51:47 +0000 (UTC)
Date:   Fri, 16 Jul 2021 09:51:46 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        vitor.soares@synopsys.com, boris.brezillon@bootlin.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] i3c: master: svc: some bug fixes
Message-ID: <20210716095146.2182acb3@xps13>
In-Reply-To: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
References: <20210715082413.3042149-1-xiaoning.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clark,

Clark Wang <xiaoning.wang@nxp.com> wrote on Thu, 15 Jul 2021 16:24:09
+0800:

> Hi,
> 
> I am using SVC I3C module recently. I fix some problems and also have a
> question.
> 
> My question is:
> Can I3C bus support pure I2C mode in kernel?
> Or in other words, in mixed mode, must there be at least one I3C device on
> the I3C bus?
> 
> The pure I3C mode works fine. But when only have one I2C device on the
> I3C bus, the probe in function i3c_master_bus_init() will go error. Because
> there is no one on I3C bus can ACK the I3C message with I3C message speed. Then
> it will return error at function i3c_master_rstdaa_locked() because of no ACK
> for 0x7e start byte.
> When I use the following dtb configuration, the above problem occurs.
> &i3c2 {
> 	#address-cells = <3>;
> 	#size-cells = <0>;
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&pinctrl_i3c2>;
> 	i2c-scl-hz = <400000>;
> 	status = "okay";
> 
> 	lsm6dso_i2c: imu@6a {
> 		compatible = "st,lsm6dso";
> 		reg = <0x6a 0x0 0x50>;
> 	};
> };
> 
> But I saw a similar configuration example in
> /home/nxf47749/work/kernel/i3c/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt.
> I wonder if that can work normally?
> 
> I know the definition in the specification is:
> Mixed xxx Bus: I3C Bus topology with both I2C and I3C Devices present
> on the I3C Bus...
> But I think it is feasible to use pure I2C mode with I3C module.
> I am not sure why the use of pure I2C mode is restricted in the software.
> 
> If there are errors in my ideas, please correct me in time. Thank you all.

As you pointed out, I am not aware of a specific I2C only bus setting
but if you find a way to workaround the issue raised above by software
in a rather clean way, then... why not?

> Here are the fixes.
> 
> Clark Wang (4):
>   i3c: master: svc: move module reset behind clk enable
>   i3c: master: svc: fix atomic issue
>   i3c: master: svc: add support for slave to stop returning data
>   i3c: master: svc: set ODSTOP to let I2C device see the STOP signal
> 
>  drivers/i3c/master/svc-i3c-master.c | 45 +++++++++++++++++++----------
>  1 file changed, 30 insertions(+), 15 deletions(-)
> 

Thanks,
Miquèl
