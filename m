Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4D3EC367
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhHNO5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:57:42 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:36956 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbhHNO5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:57:41 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEv1T-00BihQ-Gp; Sat, 14 Aug 2021 14:52:31 +0000
Date:   Sat, 14 Aug 2021 14:52:31 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Leon Romanovsky <leon@kernel.org>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] checkpatch: prefer = {} initializations to = {0}
Message-ID: <YRfYr0fsM1R7O5x6@zeniv-ca.linux.org.uk>
References: <20210805104353.GD26417@kili>
 <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b94e688-a070-998a-3014-96bcbaed4cae@wanadoo.fr>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 03:59:22PM +0200, Christophe JAILLET wrote:

> > +# prefer = {}; to = {0};
> > +		if ($line =~ /= \{ *0 *\}/) {
> > +			WARN("ZERO_INITIALIZER",
> > +			     "= {} is preferred over = {0}\n" . $herecurr);

Sigh...  "is preferred over" by whom?  Use the active voice, would you?

> [1] and [2] state that {} and {0} don't have the same effect. So if correct,
> this is not only a matter of style.
> 
> When testing with gcc 10.3.0, I arrived at the conclusion that both {} and
> {0} HAVE the same behavior (i.e the whole structure and included structures
> are completely zeroed) and I don't have a C standard to check what the rules
> are.
> gcc online doc didn't help me either.

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf, but empty
initializer-list is gccism anyway.

Section 6.7.8 is the one to look through there.

> Can someone provide some rational or compiler output that confirms that {}
> and {0} are not the same?

Easily: compare
	int x[] = {0};
and
	int x[] = {};

For more obscure example,
	int x = {0};
is valid, if pointless, but
	int x = {};
will be rejected even by gcc.

Incidentally, do *NOT* assume that initializer will do anything with padding
in a structure, no matter how you spell it.  Neither {} nor {0} nor explicit
initializer for each member of struct do anything to the padding.  memset()
does, but anything short of that leaves the padding contents unspecified.
