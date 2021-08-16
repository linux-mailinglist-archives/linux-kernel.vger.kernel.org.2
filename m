Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E53ECF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhHPHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhHPHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:24:25 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BE9C061764;
        Mon, 16 Aug 2021 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KpEK3KVv4gdJEMERAyk5EYCGJBKw8tT8UtZLGJNCPAw=; b=QxNmD8G1f0oZcP7EGYLwHP3wk
        8gkPE5GbcwcTtH/GIh+KBR1vVM5Fh1Pqe2A9dhLh11HPntRDCm7PXvvj8KlNTpP384LAG1p/O8cXL
        bdeNsvfSjnTt8YHdfdNBJ2fv/pgASv0CfMbVir4BbXjByU5v6Lv20ZE3XP2AzpKq5ic/olS5Whk0+
        S/reez+avL4MI9pqCguARKTd6qMpVx7fvwgqC/WeV5BGzMMDJTV4pGfPrlVdWw4UkhId8Y0vHrqbi
        dAq0EOUt+PlENuDRmSipiyKTbtOAUJYLuyKXIq7oei0qfGv9pK4X/SAUWOZyJdgbOpslw6zWO77yI
        Noylnv8wA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47356)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mFWyJ-0007RQ-Qx; Mon, 16 Aug 2021 08:23:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mFWyH-0007nW-1w; Mon, 16 Aug 2021 08:23:45 +0100
Date:   Mon, 16 Aug 2021 08:23:45 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Leon Romanovsky <leon@kernel.org>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <20210816072344.GG22278@shell.armlinux.org.uk>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
 <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
 <20210816065552.GE1931@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816065552.GE1931@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 09:55:53AM +0300, Dan Carpenter wrote:
> On Sat, Aug 14, 2021 at 02:52:31PM +0000, Al Viro wrote:
> > On Sat, Aug 14, 2021 at 03:59:22PM +0200, Christophe JAILLET wrote:
> > 
> > > > +# prefer = {}; to = {0};
> > > > +		if ($line =~ /= \{ *0 *\}/) {
> > > > +			WARN("ZERO_INITIALIZER",
> > > > +			     "= {} is preferred over = {0}\n" . $herecurr);
> > 
> > Sigh...  "is preferred over" by whom?  Use the active voice, would you?
> > 
> > > [1] and [2] state that {} and {0} don't have the same effect. So if correct,
> > > this is not only a matter of style.
> > > 
> > > When testing with gcc 10.3.0, I arrived at the conclusion that both {} and
> > > {0} HAVE the same behavior (i.e the whole structure and included structures
> > > are completely zeroed) and I don't have a C standard to check what the rules
> > > are.
> > > gcc online doc didn't help me either.
> > 
> > http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf, but empty
> > initializer-list is gccism anyway.
> > 
> > Section 6.7.8 is the one to look through there.
> 
> That's out of date.  It changed in C11.  Both = { 0 } and = { } will
> clear out struct holes. The = { } GCC extension has always initialized
> struct holes.
> 
> http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf
> 
> For partial initializations then all the padding is zeroed.
> Unfortunately if you fully initialize the struct then padding is not
> initialized.

If we're going to discuss which C standard applies to the kernel,
then...

As Kbuild passes -std=gnu89, the kernel expects C89 behaviour with
GNU extensions from the compiler, both C99 and C11 are not that
relevant, although the GNU extensions include some bits from these
standards.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
