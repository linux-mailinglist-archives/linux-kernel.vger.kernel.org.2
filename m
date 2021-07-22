Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3253D21BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhGVJ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:26:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:23475 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhGVJ0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:26:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="208496670"
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="asc'?scan'208";a="208496670"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 03:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,260,1620716400"; 
   d="asc'?scan'208";a="433069587"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.143])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jul 2021 03:06:54 -0700
Date:   Thu, 22 Jul 2021 17:45:16 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: refactor the i915 GVT support
Message-ID: <20210722094516.GQ13928@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210721155355.173183-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wjoFZxbW4tu+iR6v"
Content-Disposition: inline
In-Reply-To: <20210721155355.173183-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wjoFZxbW4tu+iR6v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.07.21 17:53:34 +0200, Christoph Hellwig wrote:
> Hi all,
>=20
> the GVT code in the i915 is a bit of a mess right now due to strange
> abstractions and lots of indirect calls.  This series refactors various
> bits to clean that up.  The main user visible change is that almost all
> of the GVT code moves out of the main i915 driver and into the kvmgt
> module.
>

The reason we isolated hypervisor specific code from core vgpu
emulation is to make multiple hypervisor support possible. Yes, we do
have Xen support but never got way into upstream...And we also have
third party hypervisors which leverage gvt function through current
hypervisor interface.

Sorry I may not have more time to check in details for now, but some
of them look fine to me. I'll review more after vacation or let Zhi check d=
etails.

Thanks!

> Tested on my Thinkpad with a Kaby Lake CPU and integrated graphics.
>=20
> Git tree:
>=20
>     git://git.infradead.org/users/hch/misc.git i915-gvt
>=20
> Gitweb:
>=20
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/i915-=
gvt
>=20
> Diffstat:
>  b/drivers/gpu/drm/i915/Kconfig                         |   31=20
>  b/drivers/gpu/drm/i915/Makefile                        |   30=20
>  b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c |    4=20
>  b/drivers/gpu/drm/i915/gvt/cfg_space.c                 |   89 --
>  b/drivers/gpu/drm/i915/gvt/cmd_parser.c                |    4=20
>  b/drivers/gpu/drm/i915/gvt/dmabuf.c                    |   36=20
>  b/drivers/gpu/drm/i915/gvt/execlist.c                  |   12=20
>  b/drivers/gpu/drm/i915/gvt/gtt.c                       |   55 -
>  b/drivers/gpu/drm/i915/gvt/gvt.c                       |  100 --
>  b/drivers/gpu/drm/i915/gvt/gvt.h                       |  132 ++-
>  b/drivers/gpu/drm/i915/gvt/interrupt.c                 |   38 -
>  b/drivers/gpu/drm/i915/gvt/kvmgt.c                     |  634 ++++------=
-------
>  b/drivers/gpu/drm/i915/gvt/mmio.c                      |    4=20
>  b/drivers/gpu/drm/i915/gvt/opregion.c                  |  148 ---
>  b/drivers/gpu/drm/i915/gvt/page_track.c                |    8=20
>  b/drivers/gpu/drm/i915/gvt/scheduler.c                 |   37=20
>  b/drivers/gpu/drm/i915/gvt/trace.h                     |    2=20
>  b/drivers/gpu/drm/i915/gvt/vgpu.c                      |   22=20
>  b/drivers/gpu/drm/i915/i915_drv.h                      |    7=20
>  b/drivers/gpu/drm/i915/i915_params.c                   |    2=20
>  b/drivers/gpu/drm/i915/intel_gvt.c                     |   64 +
>  b/drivers/gpu/drm/i915/intel_gvt.h                     |    4=20
>  drivers/gpu/drm/i915/gvt/Makefile                      |    9=20
>  drivers/gpu/drm/i915/gvt/hypercall.h                   |   82 --
>  drivers/gpu/drm/i915/gvt/mpt.h                         |  400 ----------
>  25 files changed, 541 insertions(+), 1413 deletions(-)

--wjoFZxbW4tu+iR6v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYPk+JAAKCRCxBBozTXgY
J09VAJ9C5w8OkOxQaT+Hh6GRuwyrHlKVPgCfR2B56jaNxNaxyz+943xRn2xdLCo=
=enIC
-----END PGP SIGNATURE-----

--wjoFZxbW4tu+iR6v--
