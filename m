Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6214D34006E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 08:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCRHs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 03:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhCRHsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 03:48:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87212C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:48:40 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so6482551pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 00:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=2Hpg/NuaBtBwQfUbFetkCYRA5pMldXXEVPqi57b9mGE=;
        b=DYsuBvfxTbcDA0ajEncbpb9yUISgGydoK2lGAyi8Wz6sglnzDSWhMQxpXR59LxDi0n
         U/FjJwhVoDsV9VbzhOd6okjZTQ3felq23dHHNCiRw7uSmQ06n5PlLGB7tB6N/nlP3oVO
         K5R4HkKO7hsD6tcx68TYcOXxbJEHVGTZJmWK9PWtxsHeSw8Z5Xl/TIWZURxQo3NjScir
         zWiQOATtlPRehEUK42HVtM8/UAssPo1WLK/6PE+qwAHAPvdgv4ZEajzp3Ia8IP35EDrM
         d2uG2XeK/ND6zl/vorIc/rnVYiBed+DPzY5KoBxKG6sbBN/IhdYdl8JxvbGpdS9X+YK9
         L8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=2Hpg/NuaBtBwQfUbFetkCYRA5pMldXXEVPqi57b9mGE=;
        b=q8mUKtwMD0vGCXG4cGvQFHZfuv/A/DIbdkA7PxT8j23z2cyelnOkMpXuQ8zCD/pqSk
         ZXITpr/txspTMXEIKPS3kJhv18LyPnQfmH5aVhY45yu32RaXS4mqKBKMeqsA8jQz0uVi
         oyStHZVxAEd9qguaXhOH88xFgUhNOB7J9jdf3bxmn75EimBZfGX/KwE4eDIQKNz/Qqf0
         VweKBi2pK6rj8eOGK76B3Ed7QSt+31g/NS8d1+DGEVz7JeYGPVvcLOEJaTNzwNOLIj65
         XjFi1JhgLbidGvLrEKyX3FzvszN6biOfBPKgph+ZylRYJEwsvsUmkwPvy3PPcKZUOt4w
         vwNg==
X-Gm-Message-State: AOAM532oBnh5pY0ipRiYHi1Ev+VDBe0+a3NEM/19PJdLfEDwey744AB/
        bFbXmNd/3wogKB2rAW2PnWw=
X-Google-Smtp-Source: ABdhPJy5qWFUrhBzudk3D2WqHJ15M10yxYm3fMm45oFT4/SJrIySu5lOZ5J7MmGSGtVtx+PS0vMhyw==
X-Received: by 2002:a17:90b:100a:: with SMTP id gm10mr2970961pjb.0.1616053719970;
        Thu, 18 Mar 2021 00:48:39 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id v26sm1312644pff.195.2021.03.18.00.48.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 00:48:39 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <F609AED4-2238-43E0-8095-1659F945E277@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_D5F2480D-0332-4EEC-8906-3CF58CF9DB05";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date:   Thu, 18 Mar 2021 00:48:37 -0700
In-Reply-To: <a0ca6dd974be42878a8f51b0a7bbe00f@huawei.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        chenjiashang <chenjiashang@huawei.com>,
        "Subo (Subo, Cloud Infrastructure Service Product Dept.)" 
        <subo7@huawei.com>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
 <20210317091820.5f4ab69e@omen.home.shazbot.org>
 <87a5f90a-d1ea-fe7a-2577-fdfdf25f8fd7@linux.intel.com>
 <a0ca6dd974be42878a8f51b0a7bbe00f@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_D5F2480D-0332-4EEC-8906-3CF58CF9DB05
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Mar 17, 2021, at 9:46 PM, Longpeng (Mike, Cloud Infrastructure =
Service Product Dept.) <longpeng2@huawei.com> wrote:
>=20

[Snip]

>=20
> NOTE, the magical thing happen...(*Operation-4*) we write the PTE
> of Operation-1 from 0 to 0x3 which means can Read/Write, and then
> we trigger DMA read again, it success and return the data of HPA 0 !!
>=20
> Why we modify the older page table would make sense ? As we
> have discussed previously, the cache flush part of the driver is =
correct,
> it call flush_iotlb after (b) and no need to flush after (c). But the =
result
> of the experiment shows the older page table or older caches is =
effective
> actually.
>=20
> Any ideas ?

Interesting. Sounds as if there is some page-walk cache that was not
invalidated properly.


--Apple-Mail=_D5F2480D-0332-4EEC-8906-3CF58CF9DB05
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBTBdUACgkQHaAqSaba
D1okIhAAocTfPO7VNXWn6f/yy3l6uWtFbUp4MQzB5obcM4QGYw/7Km/XbaVNeV+6
6GvQxQR8zgYS35A0EEJpKQEI43hkX5FlRcde3rhbLQljmXVyL+vCArw2P6b8k0Qf
7OexTH9bF7/l8lKe1Zz8HDD6KQRrO0zLwNZQkT1JnJoacS04HejS5WqVYQG+jx6G
C/ntNBNDEAFE2rM3UI+sQVcctkEq6/gd2rMz2L/aDNSYIXe4znTIGLqfNNd4lBUM
4OtGKTxsF8KJHchn4WUXkh4nenIQ8qYHeF+0yLrSJNX9c8/JG+E2e8A1aGTd5Bxe
Kh2q+b1Gx9F7nO9zVfg3fBU8yL+tHSNaWfHUkAUQyCjHMQEEPMQoxc2l4uQ4OF/l
Ce5TBH0VUb1tmY/kW2kjCGQub9Ez5WkQD5Hv2VHxXsEl5GhaEZNdop5IXLN99xhJ
gXNKdNOX1uV7yxMyXxvqUMkuRbOcTLt7jpeEn5zFd+VQat1dHBb4a4G0l7MdQCxA
ffyA90dVLGt9vSe9NA64llZUoM016izzHPsDghoRydNTCtNZK361LAgFkdaojCJB
oIBMSfDQlap/QCKPMylBUjYkh+SzeMB1cGSAoHnxoWTEgBCcwk6QIhKmo4dwJCAv
p+wN+DR6ojH6lNYvdho6eo1zcH237l7RSyMRhsyAMNHxqOmXpP8=
=5Q2D
-----END PGP SIGNATURE-----

--Apple-Mail=_D5F2480D-0332-4EEC-8906-3CF58CF9DB05--
