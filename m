Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A739BF6F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFDSSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:18:44 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:40456 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFDSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:18:44 -0400
Received: from [IPv6:2a02:a03f:eafb:ee01:47d6:9866:c9b9:c953] (unknown [IPv6:2a02:a03f:eafb:ee01:47d6:9866:c9b9:c953])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0CD7B208ABC;
        Fri,  4 Jun 2021 20:16:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1622830616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1B3gpGcjjMlyC7hzTnIAubrSPnRW7x5Aifrp6c2HkPs=;
        b=fGCxM0RwHo8oP0mHriHaEW4ovr79Kjf4bw6hLcrv8W9Xx7W0rBJY+k674TphdExIyFNeFU
        b87lvnRP0nVMK13hQgLCXjkGKOni8OuSsPXsLCkf7aVYk8/vHZViwf7d/kQOrGIYFD8sf9
        u/kSRW7Jwh/fW2r0plD4PPsbcOMrItPye06d8b3d5VD/vf5hVYU2gzB7w2qjxMrpchi8a4
        Bo2lpl+j9LEW76EP7W19Ny4UA4VFa2oAdVQiSVyCeQeIf2Z7Wi9y61y+mVYeEFMifvL7J1
        umeKuSL4A0e3jhdM8f399vR+thL5mbOSJZ+2SmWMStrw2I6JsHB5xMvPr6rOWg==
Message-ID: <8899fbf306051fa3cdd8bde92634de8134bce0fb.camel@svanheule.net>
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Jun 2021 20:16:53 +0200
In-Reply-To: <20210604172515.GG4045@sirena.org.uk>
References: <cover.1622743333.git.sander@svanheule.net>
         <20210604172515.GG4045@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, 2021-06-04 at 18:25 +0100, Mark Brown wrote:
> On Thu, Jun 03, 2021 at 08:25:08PM +0200, Sander Vanheule wrote:
> 
> > 1. I've opted to just ignore any bits that lie beyond the allowed address
> >    width. Would it be cleaner to raise an error instead?
> 
> It doesn't *really* matter, enforcement is probably a bit better as it
> might catch bugs.

Agreed.

> > 2. Packing of the clause-45 register addresses (16 bit) and adressed device
> >    type (5 bit) is the same as in the mdio subsystem, resulting in a 21 bit
> >    address. Is this an appropriate way to pack this information into one
> >    address for the regmap interface?
> 
> Either that or pass the type in when instantiating the regmap (it sounds
> like it should be the same for all registers on the device?).

I think the 'device type' field should be viewed more as a paging index. A phy
will have PMA/PMD ("generic phy") features, but will likely also have status and
settings in the AN (auto-negotiation) page. I'm sure Andrew knows a lot more
about this than I do.

> 
> > The reasoning behind (1) is to allow the regmap user to use extra bits
> > as a way to virtually extend the address space. Note that this actually
> > results in aliasing. This can be useful if the data read from to a
> > register doesn't have the same meaning as the data written to it
> > (e.g. GPIO pin input and output data). An alternative solution to this
> > would be some concept of "aliased registers" in regmap -- like volatile or
> > precious registers.
> 
> I think these registers are in practice going to either need to be
> volatile (how most of them work at the minute) or otherwise handled in
> regmap (eg, the page support we've got).  Having two different names for
> the same register feels like it's asking for bugs if any of the higher
> level functions of regmap get used.

This is actually an issue with a GPIO chip that I'm trying to implement [1]. To
set an output, data is written to the register. To get an input value, data is
read from the register. Since a register contains data for 16 GPIO lines, a
regular read-modify-write could erroneously overwrite output values. A pin
outside of the RMW mask could've changed to an input, and may now be reading a
different value. The issue I was running into, had to do with a RMW not being
written because the pin value apparently hadn't changed.

To work around the issue, I created a "virtual page" by adding an extra bit [2].
On reads and writes, they are aliased to the same actual register. However, by
having two different addresses, one can be marked as "volatile and read-only",
while the other is "non-volatile and write-only". The latter allows for caching,
ensuring that a RMW will use the (correct) cached value to calculate the updated
register value.

I didn't use the existing paging mechanism for this, since (I think) then I
would need to specify a register that contains the page index. But as I don't
have an actual page register, I would have to specify another existing register
with an empty mask. This could lead to useless bus activity if I accidentally
chose a volatile register.

[1] https://lore.kernel.org/lkml/84352c93f27d7c8b7afea54f3932020e9cd97d02.camel@svanheule.net/
[2] https://lore.kernel.org/lkml/56fb027587fa067a249237ecaf40828cd508cdcc.1622713678.git.sander@svanheule.net/


Best,
Sander

