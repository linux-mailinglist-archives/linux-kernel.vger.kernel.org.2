Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCA3A14AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhFIMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFIMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:44:04 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A5AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 05:42:09 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284] (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E5A9020B177;
        Wed,  9 Jun 2021 14:42:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623242528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h+vjUUCU4wSBBhM4Nks/zfyl16+i4xTmkh2sMIqyJqM=;
        b=ABHe94Gg9L0fNIE6zDsITYpw8TbuXErA4Swnm+64BIfGAJTAfPWzCqz/J079eTsRcNCs9D
        YcNi7L4WeQ5QEvcbKkBTeyqreZj8CAfHo/t8HdkTZgEhhW1aJ6Gi+wOFIB12FS91Pkeo+l
        zT79Ab75KBfdP+MUzruoFOgLkoEJ7bEIhd20Y+nt8gHzrzWwCOGiQl1D24M4PLs9eimQay
        /fBBlxs7gEGoq3nTj9T8SIEiranCj9+pidWq9JdKxFnVk0tAnaDcE9a2jhDv9d5XOg+OhJ
        OnoGujyW8OcrElRK4G1xVvDW+B9Dr5SXCfjZ/JKvpzGa9sgQMFEDRp6clpzZcA==
Message-ID: <ba7ef002d610ff5b5fc2c31411a1009587e2f068.camel@svanheule.net>
Subject: Re: [PATCH 1/2] Revert "regmap: mdio: Add clause-45 support"
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>
Date:   Wed, 09 Jun 2021 14:42:06 +0200
In-Reply-To: <20210609122401.GA20286@sirena.org.uk>
References: <cover.1623238313.git.sander@svanheule.net>
         <deed937f8fd63285e95acdfa8ca327638057811f.1623238313.git.sander@svanheule.net>
         <20210609122401.GA20286@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-06-09 at 13:24 +0100, Mark Brown wrote:
> On Wed, Jun 09, 2021 at 01:46:05PM +0200, Sander Vanheule wrote:
> > This reverts commit f083be9db060fbac09123d80bdffb2c001ac0e2b.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

I had grepped the commit log for other reverting patches, which also appear to
use this style, but I didn't check the regmap-specific ones.


> > There are currently no (planned) regmap users for C45 register access.
> > Remove support for now, to reduce dead code.
> 
> This then creates a bootstrapping issue for anyone who does need it - I
> can't see any way in which this causes problems or gets in the way?

If you would rather keep this, I should modify the other patch (regmap: mdio:
Reject invalid clause-22 addresses) to also cover C45 addresses.
Furthermore, there's an issue with a pointer const-ness in __regmap_init_mdio
that needs to be fixed if this code is staying.

I'll submit a v2 that fixes __regmap_init_mdio, and also applies the address
checks to C45 access.

Best,
Sander

