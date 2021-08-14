Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63FC3EC358
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhHNOjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238512AbhHNOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:38:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE2D60EE2;
        Sat, 14 Aug 2021 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628951911;
        bh=uL6AX/4t+TzWi7LocyAGDouPiMye3Z/PsKFJKjjEim8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHx6kQbUH5M7bA5oE8fZP5jN/HxVGlyPKVAa1qnr9YH4F2V1GCwEwTXNx6p/jTVq7
         feKxC2eXe3n2n4fLMKFAxxw5hGH/3AIKmAvEjfEbodaLao2xJxxzMR/+M8hHouj8tV
         J77XoAfRT53GiSLdfSjtOZerSriWeu2e59kdqHG35COBJz84uhIgi/M4GQLhg8SHcL
         aDWznza8M26KN7uB8yq/c704W35y0ZHpvY/+CrrZ5CwCa4pqyjlJNhYQcIbZQRoAS3
         ZR3UtHxNTrJsHtQbTYyFUYPp/EILOT5+yyR9MLplLkmcPSs0Tsx3QESLD8GMdxUp4X
         XHE357aMkFEeg==
Date:   Sat, 14 Aug 2021 17:38:27 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <YRfVYxQ126AOuexl@unreal>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
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
> 
> When testing with gcc 10.3.0, I arrived at the conclusion that both {} and
> {0} HAVE the same behavior (i.e the whole structure and included structures
> are completely zeroed) and I don't have a C standard to check what the rules
> are.
> gcc online doc didn't help me either.
> 
> To test, I wrote a trivial C program, compiled it with gcc -S and looked at
> the assembly files.
> 
> 
> Maybe, if it is an undefined behavior, other compilers behave differently
> than gcc.
> 
> 
> However, the 2 persons listed bellow have a much better Linux and C
> background than me. So it is likely that my testings were too naive.

There are number of reasons why you didn't notice any difference.
1. {} is GCC extension
2. {} was adopted in latest C standards, so need to check which one GCC 10
is using by default.
3. Main difference will be in padding - {0} will set to zero fields but
won't touch padding, while {} will zero everything.

> 
> 
> Can someone provide some rational or compiler output that confirms that {}
> and {0} are not the same?
> 
> Because if confirmed, I guess that there is some clean-up work to do all
> over the code, not only to please Sparse!
> 
> 
> Thanks in advance.
> CJ
> 
> 
> 
> [1]: Russell King - https://lore.kernel.org/netdev/YRFGxxkNyJDxoGWu@shredder/T/#efe1b6c7862b7ca9588c2734f04be5ef94e03d446
> 
> [2]: Leon Romanovsky - https://lore.kernel.org/netdev/YRFGxxkNyJDxoGWu@shredder/T/#efe1b6c7862b7ca9588c2734f04be5ef94e03d446
