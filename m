Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00773A137C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhFILxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239066AbhFILxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:53:19 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96CBC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:51:22 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284] (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 67DF020B13A;
        Wed,  9 Jun 2021 13:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623239480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vvIs7BSWDaUkVsbeyxXThQ2H+fkaFFZWCw9joFRm2U8=;
        b=gFjEON8hUCLabCORedO1Kj2zALBP73NqXdjJaPJl2JceI1Yn3mrwVDJWHSPTXZwsPn5fm4
        ufW4IYocNDcO/eaSkLN32v+EzikBZW+XHuOmA4chMUDfVKOkhEjoaOZRIgLugdpVvClBpL
        rdJuaE1hKJKS1c1p2QuqVzwzNsBaDplr2NF+pkenHn6wGjiRj5qhZIRbfraH7E/D3I+vnU
        npVioi5WSrM0ygi0LumM6JXDqXnaaT85CCOj6zn400/E57pL8dJi7luV8BKQl0LD3yUKiF
        4JuGtsUOWHyIrrZhTgLR/LqDrSCgpNf4BGs+xJQNzzE5K9g1WqxM/n11Q+aB9Q==
Message-ID: <3328306a4d5b4f8f58b3b8666eeccac714440da8.camel@svanheule.net>
Subject: Re: [PATCH] regmap: mdio: Reject invalid clause-22 addresses
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Date:   Wed, 09 Jun 2021 13:51:18 +0200
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

Hi Mark,

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

It appears that this has caused you to merge the RFC patches instead. I've
posted two new patches, to bring the code in line with the discussion on the
original RFC patches. See:
https://lore.kernel.org/lkml/cover.1623238313.git.sander@svanheule.net/

My apologies for the extra work this has caused.

Best,
Sander

