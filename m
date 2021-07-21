Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B403D06AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhGUBlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:41:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:60809 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229903AbhGUBlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:41:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211418639"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="asc'?scan'208";a="211418639"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 19:21:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="asc'?scan'208";a="495105095"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.143])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2021 19:21:45 -0700
Date:   Wed, 21 Jul 2021 10:00:09 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xin Tan <tanxin.ctf@gmail.com>,
        yuanxzhang@fudan.edu.cn
Subject: Re: [PATCH] drm/i915/gvt: Convert from atomic_t to refcount_t on
 intel_vgpu_ppgtt_spt->refcount
Message-ID: <20210721020009.GG13928@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <1626432098-27626-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DNUSDXU7R7AVVM8C"
Content-Disposition: inline
In-Reply-To: <1626432098-27626-1-git-send-email-xiyuyang19@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DNUSDXU7R7AVVM8C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.07.16 18:41:38 +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations
>

Thanks for the patch. Is there any specific problem you run with current co=
de?
Any shadow ppgtt error?

> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 11 ++++++-----
>  drivers/gpu/drm/i915/gvt/gtt.h |  3 ++-
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index cc2c05e18206..62f3daff5a36 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -841,7 +841,7 @@ static struct intel_vgpu_ppgtt_spt *ppgtt_alloc_spt(
>  	}
> =20
>  	spt->vgpu =3D vgpu;
> -	atomic_set(&spt->refcount, 1);
> +	refcount_set(&spt->refcount, 1);
>  	INIT_LIST_HEAD(&spt->post_shadow_list);
> =20
>  	/*
> @@ -927,18 +927,19 @@ static struct intel_vgpu_ppgtt_spt *ppgtt_alloc_spt=
_gfn(
> =20
>  static inline void ppgtt_get_spt(struct intel_vgpu_ppgtt_spt *spt)
>  {
> -	int v =3D atomic_read(&spt->refcount);
> +	int v =3D refcount_read(&spt->refcount);
> =20
>  	trace_spt_refcount(spt->vgpu->id, "inc", spt, v, (v + 1));
> -	atomic_inc(&spt->refcount);
> +	refcount_inc(&spt->refcount);
>  }
> =20
>  static inline int ppgtt_put_spt(struct intel_vgpu_ppgtt_spt *spt)
>  {
> -	int v =3D atomic_read(&spt->refcount);
> +	int v =3D refcount_read(&spt->refcount);
> =20
>  	trace_spt_refcount(spt->vgpu->id, "dec", spt, v, (v - 1));
> -	return atomic_dec_return(&spt->refcount);
> +	refcount_dec(&spt->refcount);
> +	return refcount_read(&spt->refcount);
>  }
> =20
>  static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt);
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.h b/drivers/gpu/drm/i915/gvt/gt=
t.h
> index 3bf45672ef98..944c2d0739df 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.h
> +++ b/drivers/gpu/drm/i915/gvt/gtt.h
> @@ -38,6 +38,7 @@
>  #include <linux/kref.h>
>  #include <linux/mutex.h>
>  #include <linux/radix-tree.h>
> +#include <linux/refcount.h>
> =20
>  #include "gt/intel_gtt.h"
> =20
> @@ -243,7 +244,7 @@ struct intel_vgpu_oos_page {
> =20
>  /* Represent a vgpu shadow page table. */
>  struct intel_vgpu_ppgtt_spt {
> -	atomic_t refcount;
> +	refcount_t refcount;
>  	struct intel_vgpu *vgpu;
> =20
>  	struct {
> --=20
> 2.7.4
>=20
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--DNUSDXU7R7AVVM8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYPd/qQAKCRCxBBozTXgY
J4MVAJ95yNAURQh6cNjOk/8THKqisqplMwCbBUeMC3+rNCFCjrGdgeMCTprr3WI=
=isR6
-----END PGP SIGNATURE-----

--DNUSDXU7R7AVVM8C--
