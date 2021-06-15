Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958BE3A88ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFOS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOS4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:56:21 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:54:16 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id e22so12207099pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2ACARb2OHjYtM8uD12/aj9c2MPs3FdaKsjjUZsSDgRU=;
        b=dFhZ9Q1ZWyPaAtn6vDYshJvBAJRXL+r5Cmmd9vQXGdqIUOblds8OPmUQwDVdV9HDgC
         Z6ZQlmwGgq+RAQS3ybRQ9Af+TXTWLRcF4AKAcF30Sm1m0JujWbQiNl86VFz9yyJLKiqw
         ztDyAPYdz+hCLuywRhhP8JOalSaxiue85qDVPJWFi+YIsPT7+cLBTOetkLL/6ySqAIob
         eTh/VrJTDaIvd9xM2PGKMy2z1LWwx/2RJgGLq8eZCOEjK+ql8sBR3fN4kWqapaZpuERN
         NBjp4QyjeSTlfxxiqWHZ51VmoEX5GO0DiRHriOJiSNZUuFTpWk73tm8wXLBubJjfkl7r
         kFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2ACARb2OHjYtM8uD12/aj9c2MPs3FdaKsjjUZsSDgRU=;
        b=uZ6pqlKvNkNzhha65UM5aN/BSbYnDZapuRCk5/9b4sV+VPdFFI02L401ozEDTduqhz
         a3tkx+ExCFBLZKrTG55IHdPsBEjToKJr0YS6QS2AEVQx/gGO7O2uVerZcj6RfNu0Yfsk
         E4zI2DO7QWUHBhqNfLRGyofO43B9Mi/mgQFYs95p9SlfR/GulOqiM2KtpR3gm2pq5W4F
         7tdJ3C3aje771fqdABshDF4L1iP2NYpTlUeOBEKFzjYA22uUfSBEPNQ9V5cDoHidNS5C
         fiP0zDiPJrjLSFxpwrH+n8jQa1cJenmVUn8lk0IXeQeShSY8ha4shWUtvjLjZtvX3Pto
         FArw==
X-Gm-Message-State: AOAM5310zmKSgNXfr+y/cfKKm+EfxtiM7jpKuf0oUqktFNxjuwGeAaIV
        Vhzt3rRvGaNECv6DQINSTLs=
X-Google-Smtp-Source: ABdhPJx0Xt0KX5S/R5+hY+GWDA4NQKhTMqDFyha1xSK7kOvx1M0ART6PMpE4gmIhd5qWAj0YDJ/cEA==
X-Received: by 2002:aa7:920d:0:b029:2d9:2ead:70dd with SMTP id 13-20020aa7920d0000b02902d92ead70ddmr5575030pfo.67.1623783255160;
        Tue, 15 Jun 2021 11:54:15 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 20sm15880137pfi.170.2021.06.15.11.54.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jun 2021 11:54:14 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <2A56E50B-D577-4F84-8C95-D13042C96147@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date:   Tue, 15 Jun 2021 11:54:13 -0700
In-Reply-To: <20210615102947.GB20225@willie-the-truck>
Cc:     Joerg Roedel <joro@8bytes.org>, Jiajun Cao <caojiajun@vmware.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
To:     Will Deacon <will@kernel.org>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
 <20210611135746.GC15776@willie-the-truck>
 <D76DA59C-023F-43D1-B4ED-BFA65D9D064F@gmail.com>
 <20210615102947.GB20225@willie-the-truck>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Jun 15, 2021, at 3:29 AM, Will Deacon <will@kernel.org> wrote:
>=20
> On Fri, Jun 11, 2021 at 09:50:31AM -0700, Nadav Amit wrote:
>>=20
>>=20
>>> On Jun 11, 2021, at 6:57 AM, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
>>>> From: Nadav Amit <namit@vmware.com>
>>>>=20
>>>> Refactor iommu_iotlb_gather_add_page() and factor out the logic =
that
>>>> detects whether IOTLB gather range and a new range are disjoint. To =
be
>>>> used by the next patch that implements different gathering logic =
for
>>>> AMD.
>>>>=20
>>>> Cc: Joerg Roedel <joro@8bytes.org>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Jiajun Cao <caojiajun@vmware.com>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Cc: iommu@lists.linux-foundation.org
>>>> Cc: linux-kernel@vger.kernel.org>
>>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>>> ---
>>>> include/linux/iommu.h | 41 =
+++++++++++++++++++++++++++++++++--------
>>>> 1 file changed, 33 insertions(+), 8 deletions(-)
>>>=20
>>> [...]
>>>=20
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>>> index f254c62f3720..b5a2bfc68fb0 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct =
iommu_domain *domain,
>>>> 	iommu_iotlb_gather_init(iotlb_gather);
>>>> }
>>>>=20
>>>> +/**
>>>> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is =
disjoint
>>>> + *
>>>> + * @gather: TLB gather data
>>>> + * @iova: start of page to invalidate
>>>> + * @size: size of page to invalidate
>>>> + *
>>>> + * Helper for IOMMU drivers to check whether a new range is and =
the gathered
>>>> + * range are disjoint.
>>>=20
>>> I can't quite parse this. Delete the "is"?
>>=20
>> Indeed. Will do (I mean I will do ;-) )
>>=20
>>>=20
>>>>   For many IOMMUs, flushing the IOMMU in this case is
>>>> + * better than merging the two, which might lead to unnecessary =
invalidations.
>>>> + */
>>>> +static inline
>>>> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather =
*gather,
>>>> +				    unsigned long iova, size_t size)
>>>> +{
>>>> +	unsigned long start =3D iova, end =3D start + size - 1;
>>>> +
>>>> +	return gather->end !=3D 0 &&
>>>> +		(end + 1 < gather->start || start > gather->end + 1);
>>>> +}
>>>> +
>>>> +
>>>> /**
>>>> * iommu_iotlb_gather_add_range - Gather for address-based TLB =
invalidation
>>>> * @gather: TLB gather data
>>>> @@ -533,20 +555,16 @@ static inline void =
iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>>>> 					       struct iommu_iotlb_gather =
*gather,
>>>> 					       unsigned long iova, =
size_t size)
>>>> {
>>>> -	unsigned long start =3D iova, end =3D start + size - 1;
>>>> -
>>>> 	/*
>>>> 	 * If the new page is disjoint from the current range or is =
mapped at
>>>> 	 * a different granularity, then sync the TLB so that the gather
>>>> 	 * structure can be rewritten.
>>>> 	 */
>>>> -	if (gather->pgsize !=3D size ||
>>>> -	    end + 1 < gather->start || start > gather->end + 1) {
>>>> -		if (gather->pgsize)
>>>> -			iommu_iotlb_sync(domain, gather);
>>>> -		gather->pgsize =3D size;
>>>> -	}
>>>> +	if ((gather->pgsize && gather->pgsize !=3D size) ||
>>>> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
>>>> +		iommu_iotlb_sync(domain, gather);
>>>>=20
>>>> +	gather->pgsize =3D size;
>>>=20
>>> Why have you made this unconditional? I think it's ok, but just not =
sure
>>> if it's necessary or not.
>>=20
>> In regard to gather->pgsize, this function had (and has) an
>> invariant, in which gather->pgsize always represents the flushing
>> granularity of its range. Arguably, =E2=80=9Csize" should never be
>> zero, but lets assume for the matter of discussion that it might.
>>=20
>> If =E2=80=9Csize=E2=80=9D equals to =E2=80=9Cgather->pgsize=E2=80=9D, =
then the assignment in
>> question has no impact.
>>=20
>> Otherwise, if =E2=80=9Csize=E2=80=9D is non-zero, then =
iommu_iotlb_sync() would
>> initialize the size and range (see iommu_iotlb_gather_init()),
>> and the invariant is kept.
>>=20
>> Otherwise, =E2=80=9Csize=E2=80=9D is zero, and =E2=80=9Cgather=E2=80=9D=
 already holds a range,
>> so gather->pgsize is non-zero and
>> (gather->pgsize && gather->pgsize !=3D size) is true. Therefore,
>> again, iommu_iotlb_sync() would be called and initialize the
>> size.
>>=20
>> I think that this change makes the code much simpler to read.
>> It probably has no performance impact as =E2=80=9Cgather=E2=80=9D is =
probably
>> cached and anyhow accessed shortly after.
>=20
> Thanks. I was just interested in whether it had a functional impact (I =
don't
> think it does) or whether it was just cleanup.
>=20
> With the updated comment:
>=20
> Acked-by: Will Deacon <will@kernel.org>

Thanks. I will add the explanation to the commit log, but not to the =
code in order not to inflate it too much.


--Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmDI91UACgkQHaAqSaba
D1rwyg/9GoaoYMhf+uaP86OBxYda+U2uFAA6GQ4ACRS1JKC9ki8j2OVNzmbK5+df
qYvA/Fp5MZ3dBfr7xEEwvM6AseNjSYRS84EF62x04ZxePRmNtTQ0Xw47qIGjJXLy
T39Qep/p84leB1e7caGN6ZjLlODllJk7ocPFx5fiKAb0mrQtMCz4D49GYCCregx4
Ml0oJo5LhngS+XK8+Iz32fmDUaShKnLuRqqNWM15VKTVGVz0L5TKPKFd2JH1uFne
/ynBYON5HSIUcxtlWfGT3xLnTiQJPqVGpDzS0Q4ZaJ8RkloNwd3/qwIsuhkNmPSR
9wgr+5S33LdjRmoOMQHmVVPsDqJFDNWbYL37Ceb2qdNsuZH9L1DwonKPJrHPcWo5
q3frnvsrSo66zyO0GLldDCmMYTOuy++7RN4aJTGNZTzi7qKuR/E195AvkCm4KmVK
HK+DQZy26g6hBb5SzHA6EPof6nex3cAbCJeBk2WVHRMBsOb3TMUkFW+X8Qywh98m
cvk4yNm4IaSTyjG5nAnbXwgSjSVPVvF3MEHXVtEaTMJ+bHINLxyDcCtXcXOqVA6A
irgb/+9B7iwnzNHrCo9Srq3s6liUbeEIGo04G4JG1UxGmAkR8AGySgtZhxvelQIZ
OpnBE5FKGV8MgXoNUFTdif7zRG1dZRAM3MtAIP0/CWwB9JYcfyU=
=7m8F
-----END PGP SIGNATURE-----

--Apple-Mail=_D4CD0FDC-849F-4E78-8CA9-CFD674D2A337--
