Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4FF39DAD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFGLN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 07:13:59 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:52038 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhFGLN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 07:13:57 -0400
Received: from [IPv6:2a02:a03f:eafb:ee01:5442:57ed:f9a9:776c] (unknown [IPv6:2a02:a03f:eafb:ee01:5442:57ed:f9a9:776c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1902620A046;
        Mon,  7 Jun 2021 13:12:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623064325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nou6XjvAP38z4oa5xkvNMCbPRj0XuGTO8MSmyHC9tbc=;
        b=0CIoEbe2bjZp82XEL2fS56nGsET1uLod8YzG5YO6MH6rOoKDRibNF35DdqRDvjdrz8/smt
        5d4T8f8Yd+jn52iB/jnctD7u5euvKtAh/6eTbib4amAWiV9PvPvDB07KA4xA2zXLh+SqrB
        /Vbu7O+33wHHBK8dL8Kgv3h0PmRO4kDh7bn/eiayXis+gWI6xrKZUxS+B9jhzfVLvMcAyH
        J1iWydBTq5gdWD3dELSGbXAJlUZdXf3ht/1kmVtu8xH3QxsHUCgMQ7R54/cBvmZeJF2Sxw
        B61wEY8AJUdm1xt4EvDaAdSyoJwSdwVFgCOzmxIfwxawqVPp5tF2SNa7oJq4Wg==
Message-ID: <db0b921442d76ab64c52330a50664efd6d37c311.camel@svanheule.net>
Subject: Re: [PATCH] regmap: mdio: Reject invalid clause-22 addresses
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Date:   Mon, 07 Jun 2021 13:12:01 +0200
In-Reply-To: <20210607110355.GA5705@sirena.org.uk>
References: <cover.1622743333.git.sander@svanheule.net>
         <20210605083116.12786-1-sander@svanheule.net>
         <20210607110355.GA5705@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 12:03 +0100, Mark Brown wrote:
> On Sat, Jun 05, 2021 at 10:31:18AM +0200, Sander Vanheule wrote:
> > Currently a regmap configuration for regmap-mdio must have a register
> > address width of 5 bits (cf. clause-22 register access). This is not
> > enforced on the provided register addresses, which would enable
> > clause-45 MDIO bus access, if the right bit packing is used.
> 
> Please don't send new patches in reply to old patch serieses, it makes
> it hard to follow what's going on and what the current state of things
> is and makes it easy for things to get missed when threads get cleaned
> out.

Sorry, my bad. I usually have an updated cover letter in between updated
patches, but this was only one patch. I'll include a LKML-link to the previous
version(s) in the future, to keep an easy reference around.

Best,
Sander


