Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43146305E74
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhA0OiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbhA0Ofr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:35:47 -0500
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD5C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 06:34:49 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 956AE2009F;
        Wed, 27 Jan 2021 15:34:46 +0100 (CET)
Subject: Re: short-circuit and over-current IRQs
To:     matti.vaittinen@fi.rohmeurope.com, Mark Brown <broonie@kernel.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
 <20210127122733.GC4387@sirena.org.uk>
 <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <c10cf8d6-f36a-60f4-93cc-807e11a7cec9@somainline.org>
Date:   Wed, 27 Jan 2021 15:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/01/21 13:56, Matti Vaittinen ha scritto:
> Hello Mark,
> 

Hey Matti, hey Mark!

> Nice to hear from you. :)
> 
> On Wed, 2021-01-27 at 12:27 +0000, Mark Brown wrote:
>> On Wed, Jan 27, 2021 at 12:01:55PM +0000, Vaittinen, Matti wrote:
>>
>>> Anyways - I was wondering if this is common thing amongst many
>>> PMICs?
>>> If yes - then, perhaps some generally useful regulator helper could
>>> be
>>> added to help implementing the IRQ disabling + scheduling worker to
>>> check status and re-enable IRQs? I think it *might* save some time
>>> in
>>> the future - and help making same mistakes many times :]
>>

It's probably worth it if more drivers need that: sometimes there is
HW supporting this feature and it doesn't get done because of the usual
lack of time.

Providing a helper would probably help.

>> If we've got two that's enough for a helper.  TBH I'm a bit surprised
>> that people are implementing hardware that leaves the outputs enabled
>> when it detects this sort of error, it's something that's usually an
>> emergency that needs shutting off quickly to prevent hardware damage.
> 
> I can only speak for BD9576MUF - which has two limits for monitored
> entity (temperature/voltage). One limit being 'warning' limit (or
> 'detection' as data-sheet says), the other being 'protection' limit.
> 
> I don't know guys who designed HW - I am located to a remote spot on
> the other side of the world and on top of that I am the odd "SW guy" so
> it's better to keep me out of the HW R&D decisions and especially the
> customers ;) - but I *guess* the idea has been that consumer driver(s)
> could do some 'recovery action' at 'warning' limit (which might make
> sense for example when temperature is increased to 'high' but not yet
> 'damaging' - I guess there is something that can be done with
> over/under voltages too...) and only kill the power if that doesn't
> help and situation (with temperature/voltage) gets worse.

I would tend to agree with you here, Matti. Also from what I understand,
the wanted outcome is software handling a possibly temporary issue with
you charging caps, external IC initialization using (expectedly) much
more power than needed before stabilizing, and eventually handling other
"real" issues for which there is a solution that may not even include
disabling the regulator itself, but some other handling on the connected
device driver.

Though, Mark: for example, on qcom labibb, there's "PBS" that is killing
the regulators on short-circuit condition and as you see, handling that
is a little trickier compared to the over-current one, where there is no
such auto-magic-thing...
.... I wouldn't know if it'd be a good idea to have a system like qcom's
PBS everywhere.
For the sake of protecting HW "paranoidly" though.. maybe :))

> 
> What I don't like is the fact that HW keeps IRQ asserted instead of
> having a state machine which would only generate IRQ when condition
> changes + status register to read current condition.
> 

Unless I've misunderstood this, you're describing a *very* common
behavior across regulators and other kinds of devices, but that's
not a problem. IMO, it's a solution (to quirky MCUs/SoCs/CPUs/blah).

Of course reading a register means that you waste more time before
deciding to "press the red button", but even on a slow bus like I2C,
it's anyway not reaching the point where that wasted time is relevant.
At least, in many cases.

> I will see if I can cook-up something decent - but as I said, I would
> appreciate any/all testing if I get patch crafted :)

I develop this stuff in my spare time: I can't make big promises, but
I can tell you that I will try to test your proposal on qcom-labibb as
soon as I will be able to.

Yours,
--Angelo

> 
> Best Regards
> 	Matti
> 

