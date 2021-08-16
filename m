Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010263ED01F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhHPIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhHPIS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:18:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818C4C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 01:17:55 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gp6V84K4hz9sWX;
        Mon, 16 Aug 2021 18:17:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1629101873;
        bh=RLWKiSjAQCMHPOhU75/VtJgHuV4r1WMRmKsyWI+UWRw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AdKLPenQUm12RKLbPy2eMuMzsqW5QoiGXA8LW3X+USacgQ9gqSmKp0UvDTBowQC+s
         6Ynl42UdKhMDV0wwAYti8BgDr56dXJWauWYFKbaXggxokhR/Jtp+v/DRVRXHl5obBo
         9X+4hYcFj3LW32sZF0G/06xWF1tbVVYLfH5fpSpiv43+ccHRkgHFnYcm2rbJyurYh5
         ApXzHJkxEEKFmVesIuZcDNjGoc5RKV+MGEQCkIeAbPX0PcICvXEdIUWWy+afKqQQh4
         zqlqtcMylLLMn3ADamhuZCAb+z/V5eP6cIszNoIpVM/Lgt6e5BSnEOG30hXgJp1iO0
         7FunSlQta7lKQ==
Date:   Mon, 16 Aug 2021 18:17:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Hildenbrand <david@redhat.com>
Cc:     qiang.zhang@windriver.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slub: add cpus_read_lock/unlock() for
 slab_mem_going_offline_callback()
Message-ID: <20210816181751.17f98cc2@canb.auug.org.au>
In-Reply-To: <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
References: <20210816074605.30336-1-qiang.zhang@windriver.com>
        <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vjh3bEHm7.Fal8bpPQ+pRVZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vjh3bEHm7.Fal8bpPQ+pRVZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, 16 Aug 2021 10:04:13 +0200 David Hildenbrand <david@redhat.com> wro=
te:
>
> On 16.08.21 09:46, qiang.zhang@windriver.com wrote:
> > From: "Qiang.Zhang" <qiang.zhang@windriver.com>
> >=20
> > The flush_all_cpus_locked() should be called with cpus_read_lock/unlock=
(),
> > ensure flush_cpu_slab() can be executed on schedule_on CPU.
> >=20
> > Fixes: 1c84f3c91640 ("mm, slub: fix memory and cpu hotplug related lock=
 ordering issues") =20
>=20
> Which branch contains this commit? At least not linux.git or linux-next

It is Andrew's mmotm which is included in linux-next but gets rebased
often, so, for example, that SHA1 is no longer valid in linux-next
today (is is now fd917c6407fb).

This (unfortunately) make Fixes tags less useful for mmotm :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/Vjh3bEHm7.Fal8bpPQ+pRVZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEaHy8ACgkQAVBC80lX
0GwJDgf/arO+wfX/OLOUqc5HOrLH1Hj6N0kVI4C087Y4a+Zwcoch2KGUGTbj/dNj
aERoyV5vRfV5K1hlvbVrbaKL2wW6x8u51GHaeszZkErKiV6J1TMKylFNtMUKvYyA
9wONyCEdZlUsNxKn2M26MMle1qOAELpsMpFPxlhVNum4HU3c5IaFK8t8cwU3jds+
oWyp5aQV/QukcZl70lQmAguMnq/FYOK7W5h8a5irOaRmO6LefWc3EvcXMO9eRfCb
UO/zBz7lvVHfW1qGqHzip/IAjTPiG5ciYp4wK148TASyLKsg9p5hAaVNl0BLqPmB
6b81na+pg2rpjW9esmM4vu/tEMGymA==
=SbsZ
-----END PGP SIGNATURE-----

--Sig_/Vjh3bEHm7.Fal8bpPQ+pRVZ--
