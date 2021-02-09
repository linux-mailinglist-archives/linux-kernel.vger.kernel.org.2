Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6640314591
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBIBXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:23:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:45812 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229638AbhBIBXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:23:38 -0500
IronPort-SDR: YO5X3yP3RxUpHjdw0wN0K+spbNwSwmhNqmUVp1nP6v5mqcJA0r01OHbfTG2G0lBwUQ1mtsyXWg
 EXzZxE/tg3KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="200877484"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="asc'?scan'208";a="200877484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 17:20:49 -0800
IronPort-SDR: xHgTaQxoX3hCq9xhgAsysDhisuAhKaBA0Jq/xrwpGKbGduBZuWoqTnJEx4QhkcIBxTPSeAHYZu
 Q8rbY5SyZ7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="asc'?scan'208";a="395838055"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by orsmga008.jf.intel.com with ESMTP; 08 Feb 2021 17:20:47 -0800
Date:   Tue, 9 Feb 2021 09:05:21 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [FYI PATCH] i915: kvmgt: the KVM mmu_lock is now an rwlock
Message-ID: <20210209010521.GB2043@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210208113437.94661-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7CZp05NP8/gJM8Cl"
Content-Disposition: inline
In-Reply-To: <20210208113437.94661-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7CZp05NP8/gJM8Cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021.02.08 06:34:37 -0500, Paolo Bonzini wrote:
> Adjust the KVMGT page tracking callbacks.
>=20
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: intel-gvt-dev@lists.freedesktop.org
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Thanks for that!

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

>  drivers/gpu/drm/i915/gvt/kvmgt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index 60f1a386dd06..b4348256ae95 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1703,7 +1703,7 @@ static int kvmgt_page_track_add(unsigned long handl=
e, u64 gfn)
>  		return -EINVAL;
>  	}
> =20
> -	spin_lock(&kvm->mmu_lock);
> +	write_lock(&kvm->mmu_lock);
> =20
>  	if (kvmgt_gfn_is_write_protected(info, gfn))
>  		goto out;
> @@ -1712,7 +1712,7 @@ static int kvmgt_page_track_add(unsigned long handl=
e, u64 gfn)
>  	kvmgt_protect_table_add(info, gfn);
> =20
>  out:
> -	spin_unlock(&kvm->mmu_lock);
> +	write_unlock(&kvm->mmu_lock);
>  	srcu_read_unlock(&kvm->srcu, idx);
>  	return 0;
>  }
> @@ -1737,7 +1737,7 @@ static int kvmgt_page_track_remove(unsigned long ha=
ndle, u64 gfn)
>  		return -EINVAL;
>  	}
> =20
> -	spin_lock(&kvm->mmu_lock);
> +	write_lock(&kvm->mmu_lock);
> =20
>  	if (!kvmgt_gfn_is_write_protected(info, gfn))
>  		goto out;
> @@ -1746,7 +1746,7 @@ static int kvmgt_page_track_remove(unsigned long ha=
ndle, u64 gfn)
>  	kvmgt_protect_table_del(info, gfn);
> =20
>  out:
> -	spin_unlock(&kvm->mmu_lock);
> +	write_unlock(&kvm->mmu_lock);
>  	srcu_read_unlock(&kvm->srcu, idx);
>  	return 0;
>  }
> @@ -1772,7 +1772,7 @@ static void kvmgt_page_track_flush_slot(struct kvm =
*kvm,
>  	struct kvmgt_guest_info *info =3D container_of(node,
>  					struct kvmgt_guest_info, track_node);
> =20
> -	spin_lock(&kvm->mmu_lock);
> +	write_lock(&kvm->mmu_lock);
>  	for (i =3D 0; i < slot->npages; i++) {
>  		gfn =3D slot->base_gfn + i;
>  		if (kvmgt_gfn_is_write_protected(info, gfn)) {
> @@ -1781,7 +1781,7 @@ static void kvmgt_page_track_flush_slot(struct kvm =
*kvm,
>  			kvmgt_protect_table_del(info, gfn);
>  		}
>  	}
> -	spin_unlock(&kvm->mmu_lock);
> +	write_unlock(&kvm->mmu_lock);
>  }
> =20
>  static bool __kvmgt_vgpu_exist(struct intel_vgpu *vgpu, struct kvm *kvm)
> --=20
> 2.26.2
>=20
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--7CZp05NP8/gJM8Cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCYCHfzAAKCRCxBBozTXgY
J3n+AJ9Pj+bM0fB2Uxzudpl3pyOKSapIIACfYnReH8KZw6239q6rLyJ7h+Qan8Q=
=JC7t
-----END PGP SIGNATURE-----

--7CZp05NP8/gJM8Cl--
