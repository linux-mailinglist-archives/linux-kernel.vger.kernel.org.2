Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508B2368BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 06:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhDWENR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 00:13:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:25764 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhDWENQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 00:13:16 -0400
IronPort-SDR: YhDqkqU0VRxfvlMhC3QkLjCvbb21EtwcXf7uJ7n+usRkXrId8DS35OmV9op3SvZ4S/f3cYhj5m
 4l6vxJxJZr2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192826021"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="asc'?scan'208";a="192826021"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 21:12:40 -0700
IronPort-SDR: nrk9t95tZ919uGBWhrlRupDvA67xEP9m+oDuc5Q6fst6eWRn+o8XlB4GQW2/9983TMqV2KZNxI
 wPuZdhh+XM1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="asc'?scan'208";a="453469907"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2021 21:12:35 -0700
Date:   Fri, 23 Apr 2021 11:54:26 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/gvt: fix DRM_I915_GVT dependency on VFIO_MDEV
Message-ID: <20210423035426.GG1551@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210422133547.1861063-1-arnd@kernel.org>
 <20210422135810.GG2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7WMexqIhC8AwFtpM"
Content-Disposition: inline
In-Reply-To: <20210422135810.GG2047089@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7WMexqIhC8AwFtpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.04.22 10:58:10 -0300, Jason Gunthorpe wrote:
> On Thu, Apr 22, 2021 at 03:35:33PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The Kconfig dependency is incomplete since DRM_I915_GVT is a 'bool'
> > symbol that depends on the 'tristate' VFIO_MDEV. This allows a
> > configuration with VFIO_MDEV=3Dm, DRM_I915_GVT=3Dy and DRM_I915=3Dy that
> > causes a link failure:
> >=20
> > x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `available=
_instances_show':
> > gvt.c:(.text+0x67a): undefined reference to `mtype_get_parent_dev'
> > x86_64-linux-ld: gvt.c:(.text+0x6a5): undefined reference to `mtype_get=
_type_group_id'
> > x86_64-linux-ld: drivers/gpu/drm/i915/gvt/gvt.o: in function `descripti=
on_show':
> > gvt.c:(.text+0x76e): undefined reference to `mtype_get_parent_dev'
> > x86_64-linux-ld: gvt.c:(.text+0x799): undefined reference to `mtype_get=
_type_group_id'
> >=20
> > Clarify the dependency by specifically disallowing the broken
> > configuration. If VFIO_MDEV is built-in, it will work, but if
> > VFIO_MDEV=3Dm, the i915 driver cannot be built-in here.
> >=20
> > Fixes: 07e543f4f9d1 ("vfio/gvt: Make DRM_I915_GVT depend on VFIO_MDEV")
> > Fixes: 9169cff168ff ("vfio/mdev: Correct the function signatures for th=
e mdev_type_attributes")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/gpu/drm/i915/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Oh kconfig stuff like this makes my head hurt, thanks for finding it
>=20
> I also can't see an alternative to this ugly thing, besides having the
> i915 guys properly modularize this code someday
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>=20

I don't really want this mess to propagate further. We should move
mdev related stuff to kvmgt module instead, so not pretend any more to
possibly use that for other hypervisor..

Sorry that I didn't realize this issue when Jason proposed this. Let
me do the left cleanup.

Thanks

--7WMexqIhC8AwFtpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYIJE6gAKCRCxBBozTXgY
J6G0AJ9jV+OfoH7vCSMZp4Y4fN0maPlC3gCaAwHGakKPCeQIPyHkDjbi9KCA64o=
=i7Nt
-----END PGP SIGNATURE-----

--7WMexqIhC8AwFtpM--
