Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F9436A46F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 05:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhDYDm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 23:42:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:50792 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhDYDmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 23:42:54 -0400
IronPort-SDR: Sxs4YW2Ef7G5bj8z/FMj9YmYw3FiC/Q8pofyIBWE6XowzDluk6wfSh77oSaYY6svYTxzoIi22K
 2ylobwNBMY+Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="257515117"
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="asc'?scan'208";a="257515117"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2021 20:42:15 -0700
IronPort-SDR: QY+nLf0PEWY6cNSFN4RpP9DwEuiGKVLwBwo6DaVrQ0Rl8wa1eRn/mnEEQu87wF/AN5Gzv8NFap
 rq3xkJNGEjXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,249,1613462400"; 
   d="asc'?scan'208";a="453924991"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2021 20:42:11 -0700
Date:   Sun, 25 Apr 2021 11:23:56 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/gvt: fix DRM_I915_GVT dependency on VFIO_MDEV
Message-ID: <20210425032356.GH1551@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210422133547.1861063-1-arnd@kernel.org>
 <20210422135810.GG2047089@ziepe.ca>
 <20210423035426.GG1551@zhen-hp.sh.intel.com>
 <20210423120709.GH2047089@ziepe.ca>
 <20210423092009.45fb4567@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HSHpc5A+GJc9BHcd"
Content-Disposition: inline
In-Reply-To: <20210423092009.45fb4567@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HSHpc5A+GJc9BHcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.04.23 09:20:09 -0600, Alex Williamson wrote:
> On Fri, 23 Apr 2021 09:07:09 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> > On Fri, Apr 23, 2021 at 11:54:26AM +0800, Zhenyu Wang wrote:
> > > On 2021.04.22 10:58:10 -0300, Jason Gunthorpe wrote: =20
> > > > On Thu, Apr 22, 2021 at 03:35:33PM +0200, Arnd Bergmann wrote: =20
> > > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > >=20
> > > > > The Kconfig dependency is incomplete since DRM_I915_GVT is a 'boo=
l'
> > > > > symbol that depends on the 'tristate' VFIO_MDEV. This allows a
> > > > > configuration with VFIO_MDEV=3Dm, DRM_I915_GVT=3Dy and DRM_I915=
=3Dy that
> > > > > causes a link failure:
> > > > >=20
> > > > > x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `ava=
ilable_instances_show':
> > > > > gvt.c:(.text+0x67a): undefined reference to `mtype_get_parent_dev'
> > > > > x86_64-linux-ld: gvt.c:(.text+0x6a5): undefined reference to `mty=
pe_get_type_group_id'
> > > > > x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `des=
cription_show':
> > > > > gvt.c:(.text+0x76e): undefined reference to `mtype_get_parent_dev'
> > > > > x86_64-linux-ld: gvt.c:(.text+0x799): undefined reference to `mty=
pe_get_type_group_id'
> > > > >=20
> > > > > Clarify the dependency by specifically disallowing the broken
> > > > > configuration. If VFIO_MDEV is built-in, it will work, but if
> > > > > VFIO_MDEV=3Dm, the i915 driver cannot be built-in here.
> > > > >=20
> > > > > Fixes: 07e543f4f9d1 ("vfio/gvt: Make DRM_I915_GVT depend on VFIO_=
MDEV")
> > > > > Fixes: 9169cff168ff ("vfio/mdev: Correct the function signatures =
for the mdev_type_attributes")
> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > >  drivers/gpu/drm/i915/Kconfig | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-) =20
> > > >=20
> > > > Oh kconfig stuff like this makes my head hurt, thanks for finding it
> > > >=20
> > > > I also can't see an alternative to this ugly thing, besides having =
the
> > > > i915 guys properly modularize this code someday
> > > >=20
> > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > >  =20
> > >=20
> > > I don't really want this mess to propagate further. We should move
> > > mdev related stuff to kvmgt module instead, so not pretend any more to
> > > possibly use that for other hypervisor..
> > >=20
> > > Sorry that I didn't realize this issue when Jason proposed this. Let
> > > me do the left cleanup. =20
> >=20
> > It would be good, but Alex should still take this patch for the
> > upcoming merge window, you can revert it when you do all the cleanups
>=20
> I can include it, but I'll wait for confirmation from Zhenyu.  Thanks,
>=20

I'm ok with this, future cleanup fixes would still go through i915 pull,
it only lefts for some tests, will send that for next kernel.

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

thanks

--HSHpc5A+GJc9BHcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYITgxwAKCRCxBBozTXgY
J2T7AJ9yDlnQ6y9aVF3WKqEHYjs1IkyqqgCeNScoYKrtNTN0zqHTDzyDwpsQZZ4=
=gRew
-----END PGP SIGNATURE-----

--HSHpc5A+GJc9BHcd--
