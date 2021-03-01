Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C338327750
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhCAF6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:58:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:38688 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhCAF6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:58:48 -0500
IronPort-SDR: pQvcoh9IoeTCHbQSYbiSWgS5aLLwIfOK0k7oa0alVuzmyqa8813RePE/HeaaMh+y0T8In2Mv4U
 P1vfyvHz0rag==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="186481464"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="asc'?scan'208";a="186481464"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 21:56:54 -0800
IronPort-SDR: 0e5BwTNgXfL2LVjlSP/ux6lnLjyplCJvL982EGCFNXANgH0XHrezRXu5Gr3rPSWDS9plgShfFW
 9fbpa7OSX2VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="asc'?scan'208";a="435291292"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2021 21:56:16 -0800
Date:   Mon, 1 Mar 2021 13:40:00 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        jani.nikula@linux.intel.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: gnu: drm: i915: gvt: Fixed couple of spellings
 in the file gtt.c
Message-ID: <20210301054000.GT1551@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210222081838.30328-1-unixbhaskar@gmail.com>
 <c4d15313-78a6-a7c8-97c9-8291600f6264@infradead.org>
 <0a95e99c-57c0-cede-f9c7-9d76711596fd@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline
In-Reply-To: <0a95e99c-57c0-cede-f9c7-9d76711596fd@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.02.22 06:22:37 -0800, Randy Dunlap wrote:
> On 2/22/21 6:21 AM, Randy Dunlap wrote:
> > On 2/22/21 12:18 AM, Bhaskar Chowdhury wrote:
> >>
> >> s/negtive/negative/
> >> s/possilbe/possible/
> >>
> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >=20
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
>=20
> except the Subject has a typo in it.
> s/gnu/gpu/
>

And pls follow gvt subsys's subject line as drm/i915/gvt: xxx in future.
I'll fix the title and queue this.

Thanks!

> >> ---
> >>  drivers/gpu/drm/i915/gvt/gtt.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt=
/gtt.c
> >> index 897c007ea96a..dc5834bf4de2 100644
> >> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> >> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> >> @@ -1159,8 +1159,8 @@ static inline void ppgtt_generate_shadow_entry(s=
truct intel_gvt_gtt_entry *se,
> >>   * @vgpu: target vgpu
> >>   * @entry: target pfn's gtt entry
> >>   *
> >> - * Return 1 if 2MB huge gtt shadowing is possilbe, 0 if miscondition,
> >> - * negtive if found err.
> >> + * Return 1 if 2MB huge gtt shadowing is possible, 0 if miscondition,
> >> + * negative if found err.
> >>   */
> >>  static int is_2MB_gtt_possible(struct intel_vgpu *vgpu,
> >>  	struct intel_gvt_gtt_entry *entry)
> >> --
> >=20
> >=20
>=20
>=20
> --=20
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYDx+MAAKCRCxBBozTXgY
JxNLAJ9H8QRJ+FiCVfWFQbRijCYqCK83nACdEp+fCWBweP3cPc4NS/o5Bez6KZg=
=qKgC
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--
