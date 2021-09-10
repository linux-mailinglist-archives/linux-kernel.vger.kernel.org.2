Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4794070C7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhIJSHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhIJSHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:07:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E7D76113A;
        Fri, 10 Sep 2021 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631297199;
        bh=y7gzzPXHMkryt9e4+4AKiJdOsSmuXw9tQqMcv44sZO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZj3p9/AxT/C6MApqRK4nHQPKulw+LKH3LIemaam4nAojJ/zOqveJ//NsqBebMhHN
         B0vcjKK9OjuJkxOXGolJHy4oNDJjy9AvUMMxYTcZhhY5+3WPkQrosvJrcptfXY6ROF
         VFaSHruncpG+fCj2A0R9TFE/uEvx7o4d4b4ASo9ph/p7PzghQ6svl3Om8wDUgYx++o
         mUVD/47AuKw5cQhIKWU2UDLj6CisPbkVGKU5h/+wGixpHiyIiHQRkq9hY+EnPdreQz
         jmUYZPjsbHvDydbHG1wqJz+2xfIRY+X/om4Olq+XFymwHE227GrsCVaZ+1wSI+sH5n
         5po5YKvlxfd0g==
Date:   Fri, 10 Sep 2021 19:06:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH v2] kernel/locking: Add context to ww_mutex_trylock.
Message-ID: <20210910180601.GH4474@sirena.org.uk>
References: <20210907132044.157225-1-maarten.lankhorst@linux.intel.com>
 <YTiM/zf8BuNw7wes@hirez.programming.kicks-ass.net>
 <96ab9cf1-250a-8f34-51ec-4a7f66a87b39@linux.intel.com>
 <YTnETRSy9H0CRdpc@hirez.programming.kicks-ass.net>
 <a7e5d99d-39c4-6d27-3029-4689a2a1a17a@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <a7e5d99d-39c4-6d27-3029-4689a2a1a17a@linux.intel.com>
X-Cookie: You are standing on my toes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 09, 2021 at 11:32:18AM +0200, Maarten Lankhorst wrote:

> This is also useful in regulator_lock_nested, which may avoid dropping
> regulator_nesting_mutex in the uncontended path, so use it there.

Acked-by: Mark Brown <broonie@kernel.org>

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmE7nogACgkQJNaLcl1U
h9C1wAf8DRBLZNw/1NtB8vjzFkFGUyhl1QcogXZ/PZiQr8ZaYyuCxWV6f4cXYJOV
uoUy/RXBkW5rX4+TDqj2dDcugYffBDQ4XjLKAsNaUznOlo6kvlGtKwIoNibDGuoh
MYx9mFMNlSEhK2q2QVXhgVeKCc19e03XsN6EzN6fqzGCRKlGxdBRGWLZ1HkPfKia
eo2oFiowQmJdrm1INKM39md3CDY4z6e09p0fmIUs6nCl5VvgWls/FyNCMuILlw8C
BhimfCE429mqI4KDYr0ndzYNWXv+y4f2PI4EB+0aFhBxKYYj4xlBTwrXmiS/nxwR
/o/o58UBtmax/fFX4l5pT+u8Cj4WAA==
=X/vV
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
