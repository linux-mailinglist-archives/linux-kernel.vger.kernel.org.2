Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1053033F7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhCQSNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhCQSMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:12:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF6FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:12:47 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g4so117664pgj.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6R9Mv6f/SaNEKn5oS7zETSYUY2J99UPpRh2/DtC6WYo=;
        b=Ki7fQrXA+Vka3JLESy0J33tQRpDAB3nTPTLvw8wkEoA5vk0q61j5m3xPs7/E2/EHda
         g7E+7LX8pQDuINwjsj+glVU699Jq6cfOqpsy8Mk8IOF1muSUgNUt7zxaPHxgTg/yxXv+
         r+kmFRZ9GTktHCCDzbOGFyM1mvakcfnQOzsGR6eRuzGyBpM50an2ybRT2nOW3ul2QDuk
         rac5Ie8I4ZUAkhgEzfYrPL+SughP5UXMJ3Aj8t1qXHp6z+3QJ0GT6gOljI1btqeKwUNp
         ++Gr/4yjF4aP1WyZy49uxG7s8rYAheYL7SucAK4YT6k2Wx2iKjLDLR2YAtam8NJoYzWF
         DejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6R9Mv6f/SaNEKn5oS7zETSYUY2J99UPpRh2/DtC6WYo=;
        b=jIzL0pE+nwnNK2oaaltp9oRpl9qdbyAl+RkGHtoDawfAMpx/Bdh8MWkVn567bELHOY
         9ePsrX7lUjPMGBswl5ghic11NjGSNaMWivGgJvPTi0kffXDKeP5vrh+PGJ79unCnNxnG
         uXRVPvoB30UVcDhzcDwGeGm69NKwvMO6gsrOSQHOocbO+rd2RyJOGQz7uGk6yuXHqFRB
         p/0fC8vr29qNw17h72P46/z6PoYOU07o7hPdUwt0wPmiZo7/je+Guoyd4GUEJG7Xr1k5
         5S1W57z6eMW/GVKKKC69kyQMbv3mxUVDa+jeBn2nNv4X0Aqyx9hRVVU4yOnlhaFxvc2n
         jqUg==
X-Gm-Message-State: AOAM533FEjH/5MsODZuKNbOK6zTEi65JrHtU4EZqhfsfAR1mlW4U19Xw
        zByGE2st6tsnmxuDOy+G7J0=
X-Google-Smtp-Source: ABdhPJw1qNhTe1UtCPMoD/xEOz3Hgnp4/s3ttvPRhs2IX2qHFVtIzt6dkiiDqvXfJponYkOR4Ks7jQ==
X-Received: by 2002:a63:e715:: with SMTP id b21mr3591899pgi.300.1616004766883;
        Wed, 17 Mar 2021 11:12:46 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id t18sm21238894pfq.147.2021.03.17.11.12.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Mar 2021 11:12:46 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date:   Wed, 17 Mar 2021 11:12:44 -0700
In-Reply-To: <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        chenjiashang <chenjiashang@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 17, 2021, at 2:35 AM, Longpeng (Mike, Cloud Infrastructure =
Service Product Dept.) <longpeng2@huawei.com> wrote:
>=20
> Hi Nadav,
>=20
>> -----Original Message-----
>> From: Nadav Amit [mailto:nadav.amit@gmail.com]
>>>  reproduce the problem with high probability (~50%).
>>=20
>> I saw Lu replied, and he is much more knowledgable than I am (I was =
just intrigued
>> by your email).
>>=20
>> However, if I were you I would try also to remove some =
=E2=80=9Coptimizations=E2=80=9D to look for
>> the root-cause (e.g., use domain specific invalidations instead of =
page-specific).
>>=20
>=20
> Good suggestion! But we did it these days, we tried to use global =
invalidations as follow:
> 		iommu->flush.flush_iotlb(iommu, did, 0, 0,
> 						DMA_TLB_DSI_FLUSH);
> But can not resolve the problem.
>=20
>> The first thing that comes to my mind is the invalidation hint (ih) =
in
>> iommu_flush_iotlb_psi(). I would remove it to see whether you get the =
failure
>> without it.
>=20
> We also notice the IH, but the IH is always ZERO in our case, as the =
spec says:
> '''
> Paging-structure-cache entries caching second-level mappings =
associated with the specified
> domain-id and the second-level-input-address range are invalidated, if =
the Invalidation Hint
> (IH) field is Clear.
> '''
>=20
> It seems the software is everything fine, so we've no choice but to =
suspect the hardware.

Ok, I am pretty much out of ideas. I have two more suggestions, but
they are much less likely to help. Yet, they can further help to rule
out software bugs:

1. dma_clear_pte() seems to be wrong IMHO. It should have used =
WRITE_ONCE()
to prevent split-write, which might potentially cause =E2=80=9Cinvalid=E2=80=
=9D (partially
cleared) PTE to be stored in the TLB. Having said that, the subsequent
IOTLB flush should have prevented the problem.

2. Consider ensuring that the problem is not somehow related to queued
invalidations. Try to use __iommu_flush_iotlb() instead of
qi_flush_iotlb().

Regards,
Nadav

--Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBSRpwACgkQHaAqSaba
D1pSbA/+LqJLr9Y2YXuVIsHqaLxly8NVGMOQ+GsbFBn8WkKdGfFNKkbyqmIE73Oh
JrhXL8onOumvjBRp7XOFq1xoL+MMbE0yhoxsnl4NzSgyTYV+DcrIIT0rntg6ci4f
WTkjI4h8s+lS6FAmN6zFQlGz30vkVle+TuTN3ZJgye+Ydisi95pSNm1OQu6R2bvK
wmXEuxM2LjGd49yCSxbzBcNVNR6fEKWqF8ADpIs+PoNUtCcHoILH0To3lchKc937
p/MSII7D6rIu4q9upUzzTYO5OEfsJcIcFjTRgPJ8f6nzEM8OrMK5jzB8kFOtysvs
JJ+zxpodFwYZnhllYENrtQwDIsMhWHDUQeNqlpnBRLM6FpbF+AHOd/jSOjz6TV1c
dw64BMAINGVTFm6aVdkJdOpM/LW7So7hkrJoReMG5GJMAs1JXRBeWHTzKGd/Liyy
q6LPUPVbYzi29ebcleg9JH+2olgeSzKy+D9XxvpOnIX6g5ypp1ehJj4NYXCvIi8p
/1Tw84I1glMNfure/jNU/XUlyrNYAkMHPrFdSslTUMCUHzFgAP+u3VX7xdvaN0xO
VfUdjww5pZqrTiZoOZXlwCc1Rp2aoEz9wKfU3Rf7hnH4oQxQR0z201l4mEMhjW3/
7u3U2lEys6WuqaD2B/RfgKxqNQ6dgZXthvez6N0EvE1Duv8DH90=
=m29n
-----END PGP SIGNATURE-----

--Apple-Mail=_A150222F-8DB0-4FA5-A6D7-57FC77A26ACC--
