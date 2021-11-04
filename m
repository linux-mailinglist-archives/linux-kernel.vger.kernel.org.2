Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3264455B4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 15:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhKDOxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 10:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231211AbhKDOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A20861059;
        Thu,  4 Nov 2021 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636037436;
        bh=+ScYrs56geA+JVEvXwm+mEfwnGUOecqgGRb77uoZlF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kb7kWMord4vvWaLR3T4JMSkl0b0WG6aH826x1VtSG+denUnqC89wrDp9u0TXTBLJu
         4poXElebzK+N5+QLpTd1yf1Ygp4Y7Bel6URPHSbviUKl9Vj0MrvjjMo7xhXUh0N3O+
         fxhIPtQNzuWb0HIs4XsW+lJ+mPcCfJhB5kCzU9Po5ko+7kJ8wolh1Wr48Ie0dQ2vWe
         G1IrWbAxVaSV7ETjAI/ohC7T4mHCi2E7yKIgxJxEUHw7Qrsc4cLEqTnG4/tDPqEitx
         UuVMvRbaFRBYhokOl7dMJBNl/KfvLLkp+lUNuSpFD1/ZaMZx4U7vlSise9lW0u2SuL
         WrhWuiXCgC44A==
Date:   Thu, 4 Nov 2021 14:50:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: allow to define reg_update_bits for no bus
 configuration
Message-ID: <YYPzN98RdHGEkK+n@sirena.org.uk>
References: <20211102214138.28873-1-ansuelsmth@gmail.com>
 <YYLAXL4HjgBGuF91@sirena.org.uk>
 <YYLnlbTFRUdLrmpW@Ansuel-xps.localdomain>
 <YYL/JwHxKsTmGT84@sirena.org.uk>
 <YYMEzTQhb8s31rzu@Ansuel-xps.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FKxAlgJ5d0/Mku5J"
Content-Disposition: inline
In-Reply-To: <YYMEzTQhb8s31rzu@Ansuel-xps.localdomain>
X-Cookie: Motorized vehicles only.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FKxAlgJ5d0/Mku5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 03, 2021 at 10:53:17PM +0100, Ansuel Smith wrote:
> On Wed, Nov 03, 2021 at 09:29:11PM +0000, Mark Brown wrote:

> > > > I don't understand this change.  The point of the check for volatile
> > > > there is that if the register isn't volatile then we need to ensure that
> > > > the cache gets updated with any change that happens so we need to go
> > > > through paths that include cache updates.  The presence or otherwise of
> > > > a bus does not seem at all relevant here.

> I think I'm missing something. The user case is a driver that
> have CACHE DISABLED. The !map->bus check is added just to limit this to
> a no bus configuration not to permit this with CACHE enabled. The limit
> I was referring was in the init function where the update_bits is
> assigned to the map. I honestly didn't notice that anything with cache
> disabled was flagged as volatile.

In what way would the presence or absence of a bus be relevant to a
decision about being able to safely use an _update_bits() operation?

> So the rest of the changes permit to declare a update_bits function
> for a no bus configuration is good?

Probably, I'd need to look again.

--FKxAlgJ5d0/Mku5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGD8zYACgkQJNaLcl1U
h9Dhqgf/UxMuTQmqu41Xm/7woaHbjWji4TZ0lgIVt2clcMPvj3alxTmnyXhhNICZ
ICcOQ1drhGgmmCmG8yu+nrnm5NZmY18vjL4VmUPgewC7Zz3b/wS6BrT7LXkQkUUH
DPmZdnoQZYv9KH5QrOXlU8c+jpZKynLpid7t06NRQ+sWX5a7rsYT2pR7HcZ6kj+S
ecUcP14gJjMKQ7S+dZW6ZRnWBC2hGNMVmk7JlG4YzldS5iOFGINh3HdRER6dZCDJ
JrxRa5frrKlECikRBjL3JeIFuFqoz0Clt/eu+LcihSNNxItUQ+V+TAEuwro7W4nk
XB8Cps3RjzKFRKee7u1GPBGJZN88Sw==
=sBPo
-----END PGP SIGNATURE-----

--FKxAlgJ5d0/Mku5J--
