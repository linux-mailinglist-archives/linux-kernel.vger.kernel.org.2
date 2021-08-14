Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D533EC362
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhHNOpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238522AbhHNOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:45:06 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47494C0613CF;
        Sat, 14 Aug 2021 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yTyK0uKOoSi7AVjCsk5/5RMEN0ZCT9jXzFnVBMbN2bc=; b=lIfqO7uwZI02NXO9QC2J3hrHJ
        hLsdVmwyJqFo0VuHVQH51kQsrpWQxfycCDdNCHI9Ex69H/THCdsjCTM2NecI2CS+444LDrvfGo72h
        f6one6iV2sBQOJiPVTXJLA5du7UOJRxLYUG7DWzlmWTaMxTz+Ta1WW/Nb/IqXUgWtA4Oy7vszUJ9z
        HR73u6/xxaU4LkZZyFaEcPRo1PRMNa6WienvkinDKt7ab9LyKcyvQsKlp/j639mY5LgIgd/Jw/7pJ
        VvpXeTC3SrFI7yt/lKGR68Q2eQWo4soTywbTOzhkdS/n7AJ5yLvqGgGqFYCxXpWHoGiJeU1iOZiX0
        ci+UK5PCg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47288)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1mEuth-0005Jg-Oz; Sat, 14 Aug 2021 15:44:29 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1mEutf-000684-T8; Sat, 14 Aug 2021 15:44:27 +0100
Date:   Sat, 14 Aug 2021 15:44:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <20210814144427.GZ22278@shell.armlinux.org.uk>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 03:59:22PM +0200, Christophe JAILLET wrote:
> Hi all,
> 
> Le 05/08/2021 à 12:43, Dan Carpenter a écrit :
> > The "= {};" style empty struct initializer is preferred over = {0}.
> > It avoids the situation where the first struct member is a pointer and
> > that generates a Sparse warning about assigning using zero instead of
> > NULL.  Also it's just nicer to look at.
> > 
> > Some people complain that {} is less portable but the kernel has
> > different portability requirements from userspace so this is not a
> > issue that we care about.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   scripts/checkpatch.pl | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 461d4221e4a4..32c8a0ca6fd0 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -4029,6 +4029,12 @@ sub process {
> >   			     "Using $1 is unnecessary\n" . $herecurr);
> >   		}
> > +# prefer = {}; to = {0};
> > +		if ($line =~ /= \{ *0 *\}/) {
> > +			WARN("ZERO_INITIALIZER",
> > +			     "= {} is preferred over = {0}\n" . $herecurr);
> > +		}
> > +
> >   # Check for potential 'bare' types
> >   		my ($stat, $cond, $line_nr_next, $remain_next, $off_next,
> >   		    $realline_next);
> > 
> 
> [1] and [2] state that {} and {0} don't have the same effect. So if correct,
> this is not only a matter of style.

This comes down to the fundamental question whether initialising a
pointer with the integer 0 is permitted or not. The first thing to
realise is that C allows integer 0 to be implicitly the null pointer.

So, initialising a pointer to integer 0 sets it to the null pointer.
Hence:
void *bar = 0;

is entirely legal, as is.
struct foo {
	void *bar;
};
struct foo foo = {0};

Things get more complex when you have:
struct foo {
	int bar[16];
};
struct foo foo = {0};

or:

struct foo {
	struct bar bar;
};
struct foo foo = {0};

Depending on your GCC version, GCC may or may not emit:

warning: missing braces around initializer [-Wmissing-braces]

Clang does emit a very similar warning (see the thread that Vladimir
linked to in the links in your email.)

C99 does permit this, but in terms of portability across the currently
supported compilers for the kernel, some will warn as per the above.
So, it's best to ensure that the extra { } are present, or just avoid
using the {0} notation and use the empty initialiser { }.

> When testing with gcc 10.3.0, I arrived at the conclusion that both {} and
> {0} HAVE the same behavior (i.e the whole structure and included structures
> are completely zeroed) and I don't have a C standard to check what the rules
> are.

It should do. C defines that unmentioned members in an initialiser
shall be "initialised implicitly the same as objects that have static
storage duration". Given the platforms we currently support with the
kernel, that basically means unmentioned members will be zeroed. The
empty initialiser lists no members, so all members are not mentioned,
so this applies.

Lastly, {0} is extra unnecessary typing. Apart from one's style (which
I think having warning-free builds trumps), I'm not sure why you'd
want the extra work of typing the extra 0. :)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
