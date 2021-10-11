Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A544295EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhJKRmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhJKRmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C518260E78;
        Mon, 11 Oct 2021 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633974012;
        bh=wUgyPRlrN40w92/x9x5ZUj578p+SudX8ZQCQXPc7iE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLSqJblgUZU4lM6fwyhYUQQXHffLbkxsNzOlyze8/LHGACa8tYWpJVVqFHK6I9cZV
         LbrRB5JJYa7W6JVxY8icW/ieeYLBUA/tWBOaJdzptjaY2wQkI7+PX6dLMx75qivbr3
         pPAA8Hj8Gf0chdElnsV4MB0lDy1FNiF/kKjqHBIfbFg6n/iZzzLfEk5qeTUPc+XO8R
         GPVBfQMRusg3ItuZHlMeAEFxDetWBHPuMQ+KWI6fgz/CCb02+M+2pulyb6KY6LEUm3
         WT6tUywx2mRZgtH7X4WRvYiYqwMc0cZYTpDucMaiVmIQxansApA23u/zLY7+09WScU
         n+SDwztWm9nNA==
Date:   Mon, 11 Oct 2021 18:40:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] regmap: Fix possible double-free in
 regcache_rbtree_exit()
Message-ID: <YWR2+CAtFuGl4cSz@sirena.org.uk>
References: <20211011135526.282115-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2BLWWtuTBXTCPXy2"
Content-Disposition: inline
In-Reply-To: <20211011135526.282115-1-yangyingliang@huawei.com>
X-Cookie: May contain nuts.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2BLWWtuTBXTCPXy2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 11, 2021 at 09:55:26PM +0800, Yang Yingliang wrote:
> In regcache_rbtree_insert_to_block(), when 'present' realloc failed,
> the 'blk' which is supposed to assign to 'rbnode->block' will be freed,
> so 'rbnode->block' points a freed memory, in the error handling path of
> regcache_rbtree_init(), 'rbnode->block' will be freed again in
> regcache_rbtree_exit(), KASAN will report double-free as follows:
>=20
> BUG: KASAN: double-free or invalid-free in kfree+0xce/0x390
> Call Trace:
>  dump_stack_lvl+0xe2/0x152
>  print_address_description.constprop.7+0x21/0x150
>  kasan_report_invalid_free+0x6f/0xa0
>  __kasan_slab_free+0x125/0x140

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

> Set rbnode->block to NULL when the 'present' realloc failed to fix this.

This is not a good fix, it will both leak block and corrupt the data
structure since now there's a NULL pointer where there should be a data
block.  We should instead be moving the assignment of rbnode->block up
to immediately after the reallocation has succeeded so that the data
structure stays valid even if the second reallocation fails.

--2BLWWtuTBXTCPXy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkdvcACgkQJNaLcl1U
h9Bdjgf/SPGmHN0mEJymwELokYct2G8hrD7YhwoG25HFiUn+TKNU+8Xo+osr6YN4
i3zOPtD12cct/Z/DGL9eet8vVg2EaxWhdneUn7VPGTxOcjAbQUxDsYE28qpIgB7K
oLsvS/vSVXsfOy0Jp/OzuWa6Ppc+HHR91yLyoUAXBCFex3QhM80cYsxSQnyWCxgU
4Cr2TjYkusuYFjHzAPxh7sWv6y0nbESBjQaCLQbZEMhE89oOCukoP8qE6dssWYLz
jZoQBylpk66R8rAomAa28evusf0DRP/BYumbMwvaxyRv0MY7hNKrFGS4tF2Xs7Do
RBbrjwXbk20VE1gTtAdlhiXmor2Gjw==
=auXJ
-----END PGP SIGNATURE-----

--2BLWWtuTBXTCPXy2--
