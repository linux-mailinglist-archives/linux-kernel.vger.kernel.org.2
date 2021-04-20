Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F05364FD8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDTBa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 21:30:27 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:56785 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDTBa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 21:30:26 -0400
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 0EB92201;
        Mon, 19 Apr 2021 18:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1618882195;
        bh=VYFjr4t6oLyIYU+i/nAjqHq3YLqqBQtAhM9VQ/YS1AA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l4wAXrXhwoIxeq5kVB76AKWaujQnTA8uS4p76sHL6WAf7Nfp3ANPEJKNjSPln6Wka
         lOgwoqrezgtjOUFYdzCyqtNaPe3W4YCIm/B8jNSTPJ9ca04Yosen8oUmv1Yzmxt3w3
         MdeOTOMLiRRvqCsggPGFJkCy0trSVgDrhNf/z4Uc=
Date:   Mon, 19 Apr 2021 20:29:53 -0500
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: Re: Enabling pmbus power control
Message-ID: <YH4ukR5egB2eG0Vo@hatter.bewilderbeest.net>
References: <YGLepYLvtlO6Ikzs@hatter.bewilderbeest.net>
 <5105ada1-643a-8e58-a52d-d3c8dbef86b9@roeck-us.net>
 <20210330112254.GB4976@sirena.org.uk>
 <YGNdoYq5lyERVGLO@hatter.bewilderbeest.net>
 <20210330174221.GJ4976@sirena.org.uk>
 <YGNmaNzWOYrJROvX@hatter.bewilderbeest.net>
 <20210330180200.GK4976@sirena.org.uk>
 <20210330193810.GA235990@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210330193810.GA235990@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 02:38:10PM CDT, Guenter Roeck wrote:
>On Tue, Mar 30, 2021 at 07:02:00PM +0100, Mark Brown wrote:
>> On Tue, Mar 30, 2021 at 12:56:56PM -0500, Zev Weiss wrote:
>>
>> > Okay, to expand a bit on the description in my initial message -- we've
>> > got a single chassis with multiple server boards and a single manager board
>> > that handles, among other things, power control for the servers.
>> > The manager board has one LM25066 for each attached server, which acts as
>> > the "power switch" for that server.  There thus really isn't any driver to
>> > speak of for the downstream device.
>>
>> This sounds like you need a driver representing those server boards (or
>> the slots they plug into perhaps) that represents everything about those
>> boards to userspace, including power switching.  I don't see why you
>> wouldn't have a driver for that - it's a thing that physically exists
>> and clearly has some software control, and you'd presumably also expect
>> to represent some labelling about the slot as well.
>
>Absolutely agree.
>
>Thanks,
>Guenter

Hi Guenter, Mark,

I wanted to return to this to try to explain why structuring the kernel 
support for this in a way that's specific to the device behind the PMIC 
seems like an awkward fit to me, and ultimately kind of artificial.

In the system I described, the manager board with the LM25066 devices is 
its own little self-contained BMC system running its own Linux kernel 
(though "BMC" is perhaps a slightly misleading term because there's no 
host system that it manages).  The PMICs are really the only relevant 
connection it has to the servers it controls power for -- they have 
their own dedicated local BMCs on board as well doing all the usual BMC 
tasks.  A hypothetical dedicated driver for this on the manager board 
wouldn't have any other hardware to touch aside from the pmbus interface 
of the LM25066 itself, so calling it a server board driver seems pretty 
arbitrary -- and in fact the same system also has another LM25066 that 
controls the power supply to the chassis cooling fans (a totally 
different downstream device, but one that would be equally well-served 
by the same software).

More recently, another system has entered the picture for us that might 
illustrate it more starkly -- the Delta Open19 power shelf [0] supported 
by a recent code release from LinkedIn [1].  This is a rackmount power 
supply with fifty outputs, each independently switchable via an LM25066 
attached to an on-board BMC-style management controller (though again, 
no host system involved).  We (Equinix Metal) are interested in porting 
a modern OpenBMC to it to replace the dated, crufty, 
pre-Linux-Foundation version of OpenBMC it currently runs (as found in 
the linked repo).  The exact nature of the devices powered by its 
outputs is well outside the scope of the firmware running on that 
controller (it could be any arbitrary thing that runs on 12VDC), but we 
still want to be able to both (a) retrieve per-output 
voltage/current/power readings as provided by the existing LM25066 hwmon 
support, and (b) control the on/off state of those outputs from 
userspace.

Given the array of possible use-cases, an approach of adding 
power-switch functionality to the existing LM25066 support seems like 
the most obvious way to support this, so I'm hoping to see if I can get 
some idea of what an acceptable implementation of that might look like.  


Thanks,
Zev

[0] https://www.open19.org/marketplace/delta-16kw-power-shelf/
[1] https://github.com/linkedin/o19-bmc-firmware/tree/master/meta-openbmc/meta-linkedin/meta-deltapower

