Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6B39DBE5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:08:21 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:53056 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGMIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:08:20 -0400
Received: from [IPv6:2a02:a03f:eafb:ee01:5442:57ed:f9a9:776c] (unknown [IPv6:2a02:a03f:eafb:ee01:5442:57ed:f9a9:776c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 4B2F720A08C;
        Mon,  7 Jun 2021 14:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623067588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJjV7e9ExjMftww/0ZsC/ky/yP/0m/omfj/chFIbhAw=;
        b=wknirRcilwLa3Ld8rdx0q+12OprQ+lLdM/zAAN1GMds/u/Jwlr+4m4aIOd5Nf9kgRmZfwP
        06c/nDo2Vi0wyHOsyGHHGHNv+ryaVYP67h07rks6Yxd2Z4hNs9+qwn8pSHMGHS63OrNUFm
        ZHEOhruWNTd1FQl/JRoNpLAmMjkr6H2Bp65X3v/Q9gPSOaSTwX/J5G7fq+fs4sdswGl5co
        NmeakZMN9E0alwKNqfk3nj6Nj61xbXQC2nUnb3F9oiI2Kpo/LcF9IukmhFfHz1iB8LMW28
        ct3QmLngUXMMdivyVf+vojDIvyPHSOzD2hfY+XdMzvZCCIXKd6LcBw3mw0XNuQ==
Message-ID: <4fd1501f247e77c579a209cbf6a554aa3c8b73d2.camel@svanheule.net>
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Jun 2021 14:06:26 +0200
In-Reply-To: <20210607115448.GB5705@sirena.org.uk>
References: <cover.1622743333.git.sander@svanheule.net>
         <20210604172515.GG4045@sirena.org.uk>
         <8899fbf306051fa3cdd8bde92634de8134bce0fb.camel@svanheule.net>
         <20210607115448.GB5705@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, 2021-06-07 at 12:54 +0100, Mark Brown wrote:
> On Fri, Jun 04, 2021 at 08:16:53PM +0200, Sander Vanheule wrote:
> > On Fri, 2021-06-04 at 18:25 +0100, Mark Brown wrote:
> 
> > > I think these registers are in practice going to either need to be
> > > volatile (how most of them work at the minute) or otherwise handled in
> > > regmap (eg, the page support we've got).  Having two different names for
> > > the same register feels like it's asking for bugs if any of the higher
> > > level functions of regmap get used.
> 
> > This is actually an issue with a GPIO chip that I'm trying to implement [1].
> > To
> > set an output, data is written to the register. To get an input value, data
> > is
> > read from the register. Since a register contains data for 16 GPIO lines, a
> > regular read-modify-write could erroneously overwrite output values. A pin
> > outside of the RMW mask could've changed to an input, and may now be reading
> > a
> > different value. The issue I was running into, had to do with a RMW not
> > being
> > written because the pin value apparently hadn't changed.
> 
> If the hardware isn't able to read back the status of the pins in output
> mode (even if it's always reading back from the input circuit where is
> it getting other inputs from?) you're probably better off with just
> having an open coded cache separately than trying to make up fake
> registers that rely on current implementation details to work.
> 
> > I didn't use the existing paging mechanism for this, since (I think) then I
> > would need to specify a register that contains the page index. But as I
> > don't
> > have an actual page register, I would have to specify another existing
> > register
> > with an empty mask. This could lead to useless bus activity if I
> > accidentally
> > chose a volatile register.
> 
> This is clearly not paging, it would be totally inappropraite to use
> paging for this.

Thank you for the input. I'll take this to the RTL8231 thread, to see what I can
come up with as a cleaner solution, without abusing the regmap interface.


Best regards,
Sander

