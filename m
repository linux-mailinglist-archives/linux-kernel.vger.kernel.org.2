Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8021D3A470A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 18:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhFKQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 12:53:34 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34384 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhFKQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:53:32 -0400
Received: by mail-pg1-f180.google.com with SMTP id l1so2958357pgm.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 09:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YxiModSScxrX6wWlEE0AEHNoN023vebR9RIyb3JQrHo=;
        b=TY+8/u7kG9aTVxM5eVsmnRQsN3HnGN8R42yXl3Ws2EBv2+N0JClnaMf2orLQfMtz/W
         e4YDzf08xvSGpj+S6YzlxHkjFigXzNHAkNG1MWjo97hLqwiS9ZLb5kulmRPkJ31lKF78
         6JO9qjkZ2loDpi+yfwM/sW9NtUyeI2d3DdZ5+fwCY//Bq6B2JyaOJns2XfzKk+2j8CE8
         AIyLI+/FjhDxs2cRSa28Si/2AfFAANJboEk9EiYeojtIZlI72gHGdBTUrVzNaC7YSHeC
         a3pz1IOquw/XUDP7KbfvI57ykBHjNnZbxeaXeUfKzHCGNqRO7VFoFjDjTahfrXwPXbBY
         ovQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YxiModSScxrX6wWlEE0AEHNoN023vebR9RIyb3JQrHo=;
        b=o32Xj04nW4IVVMIwUJp3jL8KJIxOgaWoljP6z/7KEV7l7XU43VlUvoG3kFPz8WC6p1
         adTNdkXz1ByXxeh9FY0ieBO65wib93VQBve0GpATgLeNhjK4pqP/ttpoHjhZsW7836Y+
         k+5n5xeRtGYa1weMdYuYarm8mUZ1FIJHWpDt5AOGYQc6esxeuWqGs5wr4InKuXe+xPJx
         wzpnf7NY1ht9s53KXeNXaqdYsPtdc6QHssUSbLTeQtWgixEuxl97ZTeFmfmEX1CA5Nf3
         hhcQk/+83v/NtLkRaaWtuePESmV/plG84rmsXSqzazgmGIolNtn9RvlDqJpIOvXJoPyA
         Gnlg==
X-Gm-Message-State: AOAM532oy6rd7J7QasHBsohFF8xlkFdEQe7UMHri9Ccft7X3aa9+Knak
        Noq7RZe2vTWXMkLKIeyO13k=
X-Google-Smtp-Source: ABdhPJzRaHiA/tU5kv1KSjGXKSf5EXl3CidBPqHwIaYUedvh9iRfEN9EVAU2EogEJpU5K7kFm0IjYQ==
X-Received: by 2002:a62:1d0f:0:b029:2d5:3ec2:feb8 with SMTP id d15-20020a621d0f0000b02902d53ec2feb8mr9364468pfd.19.1623430233840;
        Fri, 11 Jun 2021 09:50:33 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id k1sm5599107pfa.30.2021.06.11.09.50.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 09:50:32 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date:   Fri, 11 Jun 2021 09:50:31 -0700
In-Reply-To: <20210611135746.GC15776@willie-the-truck>
Cc:     Joerg Roedel <joro@8bytes.org>, Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
To:     Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
 <20210611135746.GC15776@willie-the-truck>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 11, 2021, at 6:57 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> Refactor iommu_iotlb_gather_add_page() and factor out the logic that
>> detects whether IOTLB gather range and a new range are disjoint. To =
be
>> used by the next patch that implements different gathering logic for
>> AMD.
>>=20
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
>> 1 file changed, 33 insertions(+), 8 deletions(-)
>=20
> [...]
>=20
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index f254c62f3720..b5a2bfc68fb0 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct =
iommu_domain *domain,
>> 	iommu_iotlb_gather_init(iotlb_gather);
>> }
>>=20
>> +/**
>> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is =
disjoint
>> + *
>> + * @gather: TLB gather data
>> + * @iova: start of page to invalidate
>> + * @size: size of page to invalidate
>> + *
>> + * Helper for IOMMU drivers to check whether a new range is and the =
gathered
>> + * range are disjoint.
>=20
> I can't quite parse this. Delete the "is"?

Indeed. Will do (I mean I will do ;-) )

>=20
>>    For many IOMMUs, flushing the IOMMU in this case is
>> + * better than merging the two, which might lead to unnecessary =
invalidations.
>> + */
>> +static inline
>> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather =
*gather,
>> +				    unsigned long iova, size_t size)
>> +{
>> +	unsigned long start =3D iova, end =3D start + size - 1;
>> +
>> +	return gather->end !=3D 0 &&
>> +		(end + 1 < gather->start || start > gather->end + 1);
>> +}
>> +
>> +
>> /**
>>  * iommu_iotlb_gather_add_range - Gather for address-based TLB =
invalidation
>>  * @gather: TLB gather data
>> @@ -533,20 +555,16 @@ static inline void =
iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>> 					       struct iommu_iotlb_gather =
*gather,
>> 					       unsigned long iova, =
size_t size)
>> {
>> -	unsigned long start =3D iova, end =3D start + size - 1;
>> -
>> 	/*
>> 	 * If the new page is disjoint from the current range or is =
mapped at
>> 	 * a different granularity, then sync the TLB so that the gather
>> 	 * structure can be rewritten.
>> 	 */
>> -	if (gather->pgsize !=3D size ||
>> -	    end + 1 < gather->start || start > gather->end + 1) {
>> -		if (gather->pgsize)
>> -			iommu_iotlb_sync(domain, gather);
>> -		gather->pgsize =3D size;
>> -	}
>> +	if ((gather->pgsize && gather->pgsize !=3D size) ||
>> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
>> +		iommu_iotlb_sync(domain, gather);
>>=20
>> +	gather->pgsize =3D size;
>=20
> Why have you made this unconditional? I think it's ok, but just not =
sure
> if it's necessary or not.

In regard to gather->pgsize, this function had (and has) an
invariant, in which gather->pgsize always represents the flushing
granularity of its range. Arguably, =E2=80=9Csize" should never be
zero, but lets assume for the matter of discussion that it might.

If =E2=80=9Csize=E2=80=9D equals to =E2=80=9Cgather->pgsize=E2=80=9D, =
then the assignment in
question has no impact.

Otherwise, if =E2=80=9Csize=E2=80=9D is non-zero, then =
iommu_iotlb_sync() would
initialize the size and range (see iommu_iotlb_gather_init()),
and the invariant is kept.

Otherwise, =E2=80=9Csize=E2=80=9D is zero, and =E2=80=9Cgather=E2=80=9D =
already holds a range,
so gather->pgsize is non-zero and
(gather->pgsize && gather->pgsize !=3D size) is true. Therefore,
again, iommu_iotlb_sync() would be called and initialize the
size.

I think that this change makes the code much simpler to read.
It probably has no performance impact as =E2=80=9Cgather=E2=80=9D is =
probably
cached and anyhow accessed shortly after.

If anything, I can add a VM_BUG_ON() to check =E2=80=9Csize=E2=80=9D is
non-zero, although this code seems correct regardless of that.


--Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmDDlFcACgkQHaAqSaba
D1psvQ/9HvxhhClEEFqeQtBqS9yRwDhDfY5kgTJ+JKhwRPTTqTwa2FfULTlEPbhe
jbVQyUC+PfpxrxInOWkhJuwHAHlC8YnYW4Gc3Pvdd4m6IQzjbAkqpYBCq663Bd52
TPk75QPBDT9IAKfWXquU69qoe4qqTq/Kh9NZay5bpdMU7ScZDOnyrUc1rH2SyqUE
wt8x0uo+ml4IR61lfth29EiDj4k0inoUNHnf9fWQNGklNKOY3dEqhYb6C3qlIK1K
5B/2NkPFWGhdwysDDV/R37oR05OdYGskYE6a7paUHTFW8c1iPZqmR0PRAVQ79V/5
fFZCjeBp9Rp0rPvLVd6+tWHL++Wg5rvacmcFeGuBTCPXw3rJ/l1k8jdu0PZSK73M
TsRoczp+43Xg9BiAIoh5eJ/hH5pGSOYl9co12pGkjEHDguz6vG+6U3VyC04yBkPB
xz7CiDJ8fGlotm/zUbDPBpFNsW5yJgrsze2TvXTvF8ZOP4Pcc7CMQRbSTW2KbIVk
KbxnGPbGKmuECyVFhO1eC18uZOzClDYYg1TnxeYsXpoNAfJrJFdzb1QLvqwnmq7q
Oy+XfvvHjgYTLXH7cykdGwykP1p1CH1iK9NROpR6EHoKdjG1g0PJU+nNGJxiYrZ1
EXkbzwgn+LJG5U98nFzgt8Awe83fk6InMtfFzZ5zapnjtzFfvqg=
=Q2i+
-----END PGP SIGNATURE-----

--Apple-Mail=_76AC0899-3851-4BEA-A8FB-C0802A2D5203--
