Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5064D424FAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240413AbhJGJHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:07:42 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:37829 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhJGJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:07:41 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B54F0F6;
        Thu,  7 Oct 2021 02:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633597547;
        bh=m8q3ivL4JNCs32ZTM2MObocXXvZZ0W1tFJVUtNGkFTo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bHul7hklIuebeh7G55Y6p0NYVNaTJUWiM8AusuYh/yvLMc68T/jZr57bQqtm137Qx
         TTowiEFnPLLwhTTzX6T53EhX5grk/BiRFRiPNcRwk7NruSlyTjHZz7msTpDRr47dFu
         fQA8Vvc9186bmCEsWWzYAuF+qPu9L4x1tcyk0+VE=
Date:   Thu, 7 Oct 2021 02:05:41 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Message-ID: <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
>On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>> This patch series is in some ways kind of a v2 for the "Dynamic
>> aspeed-smc flash chips via 'reserved' DT status" series I posted
>> previously [0], but takes a fairly different approach suggested by Rob
>> Herring [1] and doesn't actually touch the aspeed-smc driver or
>> anything in the MTD subsystem, so I haven't marked it as such.
>>
>> To recap a bit of the context from that series, in OpenBMC there's a
>> need for certain devices (described by device-tree nodes) to be able
>> to be attached and detached at runtime (for example the SPI flash for
>> the host's firmware, which is shared between the BMC and the host but
>> can only be accessed by one or the other at a time).
>
>This seems quite dangerous. Why do you need that? 

Sometimes the host needs access to the flash (it's the host's firmware, 
after all), sometimes the BMC needs access to it (e.g. to perform an 
out-of-band update to the host's firmware).  To achieve the latter, the 
flash needs to be attached to the BMC, but that requires some careful 
coordination with the host to arbitrate which one actually has access to 
it (that coordination is handled by userspace, which then tells the 
kernel explicitly when the flash should be attached and detached).

What seems dangerous?

>Why can't device tree overlays be used?

I'm hoping to stay closer to mainline.  The OpenBMC kernel has a 
documented policy strongly encouraging upstream-first development: 
https://github.com/openbmc/docs/blob/master/kernel-development.md

I doubt Joel (the OpenBMC kernel maintainer) would be eager to start 
carrying the DT overlay patches; I'd likewise strongly prefer to avoid 
carrying them myself as additional downstream patches.  Hence the 
attempt at getting a solution to the problem upstream.

>
>> To provide that
>> ability, this series adds support for a new common device-tree
>> property, a boolean "dynamic" that indicates that the device may come
>> and go at runtime.  When present on a node, the sysfs file for that
>> node's "status" property is made writable, allowing userspace to do
>> things like:
>>
>>   $ echo okay > /sys/firmware/devicetree/.../status
>>   $ echo reserved > /sys/firmware/devicetree/.../status
>>
>> to activate and deactivate a dynamic device.
>>
>> Because it leans on the OF_DYNAMIC machinery internally, this
>> functionality will only work on busses that register for OF reconfig
>> notifications and handle them appropriately (presently platform, i2c,
>> and spi).  This series does not attempt to solve the "dynamic devices
>> further down the tree" problem [2]; my hope is that handling for OF
>> reconfig notifications can be extended to other families of devices
>> (e.g. individual MTD spi-nor flash chips) in the future.
>
>What about ACPI and software nodes?

I'm afraid I don't understand the question, can you elaborate on what 
you mean?

>How will all this affect the host?

Assuming the coordination mentioned above is done properly, the host 
will be in a quiesced state whenever the BMC is accessing the flash and 
hence won't notice much of anything at all (the BMC will detach the 
flash and relinquish control of it back to the host before the host is 
reactivated).


Zev

