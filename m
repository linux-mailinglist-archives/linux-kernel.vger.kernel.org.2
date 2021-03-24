Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6F34743E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbhCXJNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:13:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:35907 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhCXJMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:12:36 -0400
IronPort-SDR: 2l2L3wdRiujAM6SfPtB+jjDEM8BUAfstJX6QqyblYhNjMmK8bkb1RMRRy5z7z5TlYlEkI953sb
 nvpNTBhxMB6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="210766544"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="asc'?scan'208";a="210766544"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 02:12:36 -0700
IronPort-SDR: JI68o37wZp30j1WEqZ5abBaZgg2b6omnIJC8cWSp49NMdkogrKfwPw5xtV2tqhWSZgNcdzfK7j
 4/RWaXXR+Pyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="asc'?scan'208";a="435915872"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2021 02:12:33 -0700
Date:   Wed, 24 Mar 2021 16:55:31 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: drivers/gpu/drm/i915/gvt/gtt.c:267:19: error: unused function
 'get_pt_type'
Message-ID: <20210324085531.GL1551@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <202103201405.UV0ZEGEW-lkp@intel.com>
 <CAKwvOdnik8k7-xMmwtVbwtnispGt03C0acPAPWJRuo7t+VkftQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="svZFHVx8/dhPCe52"
Content-Disposition: inline
In-Reply-To: <CAKwvOdnik8k7-xMmwtVbwtnispGt03C0acPAPWJRuo7t+VkftQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--svZFHVx8/dhPCe52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.03.23 15:15:29 -0700, Nick Desaulniers wrote:
> On Fri, Mar 19, 2021 at 11:45 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Nick,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   1c273e10bc0cc7efb933e0ca10e260cdfc9f0b8c
> > commit: 9f4069b055d1508c833115df7493b6e0001e5c9b drm/i915: re-disable -=
Wframe-address
>=20
> This in unrelated to my change.
>=20
> + Changbin, Zhenyu (authors of 3aff3512802) and Zhi (author of
> 054f4eba2a298) in case there's any interest in fixing this up.
> Otherwise I don't think these tiny helpful functions were meant to be
> used somewhere but are not, so there's not much value in cleaning them
> up.

I'll check that, should be some left over last big gtt code refactor.
Looks lkp guys don't apply -Wunused-function for gvt tree build test...

Thanks

>=20
> > date:   11 months ago
> > config: x86_64-randconfig-a016-20210319 (attached as .config)
> > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project fc=
c1ce00931751ac02498986feb37744e9ace8de)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D9f4069b055d1508c833115df7493b6e0001e5c9b
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kerne=
l/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 9f4069b055d1508c833115df7493b6e0001e5c9b
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Dx86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> drivers/gpu/drm/i915/gvt/gtt.c:267:19: error: unused function 'get_p=
t_type' [-Werror,-Wunused-function]
> >    static inline int get_pt_type(int type)
> >                      ^
> > >> drivers/gpu/drm/i915/gvt/gtt.c:590:20: error: unused function 'ppgtt=
_set_guest_root_entry' [-Werror,-Wunused-function]
> >    static inline void ppgtt_set_guest_root_entry(struct intel_vgpu_mm *=
mm,
> >                       ^
> >    2 errors generated.
> >
> >
> > vim +/get_pt_type +267 drivers/gpu/drm/i915/gvt/gtt.c
> >
> > 2707e44466881d6 Zhi Wang 2016-03-28  266
> > 054f4eba2a2985b Zhi Wang 2017-10-10 @267  static inline int get_pt_type=
(int type)
> > 054f4eba2a2985b Zhi Wang 2017-10-10  268  {
> > 054f4eba2a2985b Zhi Wang 2017-10-10  269        return gtt_type_table[t=
ype].pt_type;
> > 054f4eba2a2985b Zhi Wang 2017-10-10  270  }
> > 054f4eba2a2985b Zhi Wang 2017-10-10  271
> >
> > :::::: The code at line 267 was first introduced by commit
> > :::::: 054f4eba2a2985b1db43353b7b5ce90e96cf9bb9 drm/i915/gvt: Introduce=
 page table type of current level in GTT type enumerations
> >
> > :::::: TO: Zhi Wang <zhi.a.wang@intel.com>
> > :::::: CC: Zhenyu Wang <zhenyuw@linux.intel.com>
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

--svZFHVx8/dhPCe52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYFr+fwAKCRCxBBozTXgY
J3vXAKCPtf8STYADjG72OUoqbgywKc4nQgCdGMLTzkgkitUp3sYK5gxWEXciceE=
=+Pjp
-----END PGP SIGNATURE-----

--svZFHVx8/dhPCe52--
