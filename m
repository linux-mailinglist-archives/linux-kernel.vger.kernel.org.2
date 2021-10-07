Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056BE424CDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 07:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhJGFqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 01:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbhJGFqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 01:46:05 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2690C061755;
        Wed,  6 Oct 2021 22:44:12 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B2C6D52;
        Wed,  6 Oct 2021 22:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633585452;
        bh=4QxACvASTOlPgoFStcPKHGJdR1GwmH42sE4PD4SlwQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GevjuFqwwjfb4HSagbqrFhW9XfpPGPJh/OSZTlApF9LSNteArJJ0SadJfXCYLuzZ4
         /k5A5wa0c/cqlO4JRyuAakgnA43Rr73V1zWen3qEvn40kcK9fqEDKeJ7tB9FwEL/U7
         UBmKRG3of6rc43xULnsAo81A01fxwa1IIvWMbVbo=
Date:   Wed, 6 Oct 2021 22:44:03 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 0/9] Dynamic DT device nodes
Message-ID: <YV6JIxh9TPrYNToQ@hatter.bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
 <99b43bbf-b63e-d684-dd61-3087e9f22dc4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99b43bbf-b63e-d684-dd61-3087e9f22dc4@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 07:46:08PM PDT, Florian Fainelli wrote:
>
>
>On 10/6/2021 5:09 PM, Zev Weiss wrote:
>>Hello,
>>
>>This patch series is in some ways kind of a v2 for the "Dynamic
>>aspeed-smc flash chips via 'reserved' DT status" series I posted
>>previously [0], but takes a fairly different approach suggested by Rob
>>Herring [1] and doesn't actually touch the aspeed-smc driver or
>>anything in the MTD subsystem, so I haven't marked it as such.
>>
>>To recap a bit of the context from that series, in OpenBMC there's a
>>need for certain devices (described by device-tree nodes) to be able
>>to be attached and detached at runtime (for example the SPI flash for
>>the host's firmware, which is shared between the BMC and the host but
>>can only be accessed by one or the other at a time).  To provide that
>>ability, this series adds support for a new common device-tree
>>property, a boolean "dynamic" that indicates that the device may come
>>and go at runtime.  When present on a node, the sysfs file for that
>>node's "status" property is made writable, allowing userspace to do
>>things like:
>>
>>   $ echo okay > /sys/firmware/devicetree/.../status
>>   $ echo reserved > /sys/firmware/devicetree/.../status
>>
>>to activate and deactivate a dynamic device.
>
>This is a completely drive by comment here, but cannot you already 
>achieve what you want today by making the SPI-NOR to be loaded as a 
>module, probe it when you need it from the BMC, and unbind or rmmod 
>the drive when you need it on the server/host attached to the BMC?
>
>Looking at [0] there appears to be enough signaling visible by the 
>BMC's user-space that it ought to be possible?
>
>Assuming that there may be multiple flash chips and you somehow need 
>to access one in order to complete the BMC device boot, but not the 
>other one(s), you could imagine unbinding the spi-nor driver from the 
>ones you don't want to drive and wait until you have appropriate 
>signaling made available to your or is there a risk of racing with the 
>host in doing so?

Hi Florian,

I sort of considered similar things at various points (in fact the 
bind/unbind technique is what I've been using as a stopgap so far), but 
I don't think it's ultimately a great solution.

In this particular case it happens that the driver for the host's BIOS 
flash (aspeed-smc) is the same driver used for the BMC's firmware flash 
and hence necessary for it to boot.  (OpenBMC also typically uses a 
non-modular kernel, for what it's worth.)

On BMC startup we don't know the state of the host, and while the mux 
that ultimately determines which processor has access to the BIOS flash 
defaults to connecting it to the host (so if we do attempt to attach it 
we'll simply fail clumsily and spew some errors to dmesg rather than 
causing catastrophic errors host-side), blindly starting to poke the 
BIOS flash without doing the proper coordination with the host first 
seems to me to be pretty squarely in the category of "things we 
shouldn't be doing" -- the desire to avoid that sort of clunkiness is a 
significant portion of what led me to pursue a better solution in the 
first place.

Additionally, while I don't know the details of the specific hardware 
involved, others in the OpenBMC community (or at least Andrew Jeffery) 
have indicated that pluggable DT devices would be useful for the systems 
they're working on as well, I suspect for things other than host 
firmware flashes.


Zev

