Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101DD337325
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhCKMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbhCKMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:54:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03425C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 04:54:59 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lKKq2-0005KZ-KO; Thu, 11 Mar 2021 13:54:50 +0100
Subject: Re: [Linux-stm32] [PATCH 5/8] ARM: dts: stm32: introduce
 stm32h7-pinctrl.dtsi to support stm32h75x
To:     dillon min <dillon.minfei@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        afzal.mohd.ma@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-6-git-send-email-dillon.minfei@gmail.com>
 <b5f96460-dcdf-f40a-89d7-89def5669d7b@foss.st.com>
 <CAL9mu0+YFC97OBNLH-gip+MFKfdX4rAaxsFB4rMNrgjmhc5=Rw@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <d2549995-2b46-3f9a-e3d5-0e2bc21465d7@pengutronix.de>
Date:   Thu, 11 Mar 2021 13:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0+YFC97OBNLH-gip+MFKfdX4rAaxsFB4rMNrgjmhc5=Rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dillon,

On 11.03.21 13:23, dillon min wrote:
> For stm32h7's new board support , I guess following the stm32f7/stm32f4's style
> is a reasonable way to do it, but add a little optimization。
> which means :
> old structure
> stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi  (referenced by
> stm32h743i-disco, -eval)
>                                 |--> stm32h750-pinctrl.dtsi
> (referenced by stm32h750i-art-pi, etc)
> add art-pi other board's pin definition in stm32h750-pinctrl.dtsi with
> xxx_pins_a, xxx_pins_b
> xxx_pins_a used for art-pi, xxx_pins_b used for other boards.
> 
> after more boards add in support, there will be more xxx_pin_c, .... defined
> 
> as the pin map is according to the hardware schematic diagram io connection.
> so, why not move xxx_pin_x to a board specific place. such as
> stm32h750i-art-pi.dts
> 
> new structure:
> 1, rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (only
> preserve gpioa...k,)
> 2, move xxx_pins_x from stm32h7-pinctrl.dtsi to
> stm32h7xx-disco/eval/art-pi/etc.dts (as they depends on hardware
> schematic)
> 
> stm32h7-pinctrl.dtsi --> stm32h743i-discon.dts
>                                 |--> stm32h743i-eval.dts
>                                 |--> stm32h750i-art-pi.dts
>                                 |--> stm32h7xxx.dts
> would you agree this ?

If the optimization you intend is reducing DTB size, you can flag
all pinctrl groups with /omit-if-no-ref/ to have dtc throw them
away if they are unused.

(But in general, I am in favor of having board-specific configuration
 in the board dts)

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
