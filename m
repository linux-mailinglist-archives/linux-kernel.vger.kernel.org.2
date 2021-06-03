Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42539A3D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFCPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhFCPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:00:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42989C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 07:59:00 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1loooE-0002s8-PC; Thu, 03 Jun 2021 16:58:58 +0200
Subject: Re: [PATCH] ARM: dts: stm32: set stm32mp157c-odyssey DCMI pins
To:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <YLjl6lE+uZ5ZCdiS@nx64de-df6d00>
 <fcee4f30-446e-f4da-6d95-c9223cf82981@pengutronix.de>
 <YLjr6XaK7q3r8dmi@nx64de-df6d00>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7af54c28-1cc1-775e-a544-45a0f5f9957e@pengutronix.de>
Date:   Thu, 3 Jun 2021 16:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLjr6XaK7q3r8dmi@nx64de-df6d00>
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

On 03.06.21 16:49, Grzegorz Szymaszek wrote:
> Hello Ahmad,
> 
> On Thu, Jun 03, 2021 at 04:26:59PM +0200, Ahmad Fatoum wrote:
>> On 03.06.21 16:23, Grzegorz Szymaszek wrote:
>>> The Seeed Odyssey-STM32MP157C board has a 20-pin DVP camera output.
>>> stm32mp15-pinctrl.dtsi contains one pin state definition for the DCMI
>>> interface, dcmi-0, AKA phandle dcmi_pins_a. This definition is
>>> incompatible with the pins used on the Odyssey board, where:
>>> - there are 8 data pins instead of 12,
>>> - […]
>>>
>>> Override the dcmi_pins_a definition (as well as dcmi_sleep_pins_a) in
>>> the Odyssey device tree.
>>
>> Rather define a new pinctrl group (e.g. &dcmi_pins_b) and use that
>> instead of overriding an existing one.
> 
> Can I simply use dcmi_pins_b (as the first unused identifier) or is
> there some way to match specific pin groups to an identifier (b, c, d,
> and so on)?

Just take the next available. That's how I did it so far.

>> Current convention is also to place all STM32MP1 pinctrl nodes into
>> a central file, not in the individual board device trees.
> 
> Sure, I will update the patch.
> 
> Thanks for your comments!

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
