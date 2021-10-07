Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB384256CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242386AbhJGPnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhJGPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:43:13 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58644C061570;
        Thu,  7 Oct 2021 08:41:19 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5595F3F9;
        Thu,  7 Oct 2021 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633621278;
        bh=Sp4De8iMtZ/6e2Np59FI+yTdsoee6zx033jfHJqL1Pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=osSImv0naSv90iNaTrO7E06s7W++x6zvCTTPMROOgiTfywg5ODLiD6boZlkAh0jBO
         18YZTarxBxjDUQESB9+wTQfy6L5oZsNKFCJbzgM+oiUnN4rG+5myF5vXMEijHzTa3t
         9QLrBQncRbV0hoNa2Cqc/4rjtV5K6xRl0Uz4ksQU=
Date:   Thu, 7 Oct 2021 08:41:13 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH 0/9] Dynamic DT device nodes
Message-ID: <YV8VGeMreR6NJad4@hatter.bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
 <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net>
 <YV7Miz9RMMx/17A0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YV7Miz9RMMx/17A0@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 03:31:39AM PDT, Greg Kroah-Hartman wrote:
>On Thu, Oct 07, 2021 at 02:05:41AM -0700, Zev Weiss wrote:
>> On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
>> > On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>> > > This patch series is in some ways kind of a v2 for the "Dynamic
>> > > aspeed-smc flash chips via 'reserved' DT status" series I posted
>> > > previously [0], but takes a fairly different approach suggested by Rob
>> > > Herring [1] and doesn't actually touch the aspeed-smc driver or
>> > > anything in the MTD subsystem, so I haven't marked it as such.
>> > >
>> > > To recap a bit of the context from that series, in OpenBMC there's a
>> > > need for certain devices (described by device-tree nodes) to be able
>> > > to be attached and detached at runtime (for example the SPI flash for
>> > > the host's firmware, which is shared between the BMC and the host but
>> > > can only be accessed by one or the other at a time).
>> >
>> > This seems quite dangerous. Why do you need that?
>>
>> Sometimes the host needs access to the flash (it's the host's firmware,
>> after all), sometimes the BMC needs access to it (e.g. to perform an
>> out-of-band update to the host's firmware).  To achieve the latter, the
>> flash needs to be attached to the BMC, but that requires some careful
>> coordination with the host to arbitrate which one actually has access to it
>> (that coordination is handled by userspace, which then tells the kernel
>> explicitly when the flash should be attached and detached).
>>
>> What seems dangerous?
>>
>> > Why can't device tree overlays be used?
>>
>> I'm hoping to stay closer to mainline.  The OpenBMC kernel has a documented
>> policy strongly encouraging upstream-first development:
>> https://github.com/openbmc/docs/blob/master/kernel-development.md
>>
>> I doubt Joel (the OpenBMC kernel maintainer) would be eager to start
>> carrying the DT overlay patches; I'd likewise strongly prefer to avoid
>> carrying them myself as additional downstream patches.  Hence the attempt at
>> getting a solution to the problem upstream.
>
>Then why not work to get device tree overlays to be merged properly?
>Don't work on a half-of-a-solution when the real solution is already
>here.
>

I had been under the impression that the overlay patches had very dim 
prospects of ever being accepted and that this might be a more tractable 
alternative, but apparently was mistaken -- I'll look into what the 
outstanding issues were with that and perhaps take a stab at addressing 
them.


Zev

