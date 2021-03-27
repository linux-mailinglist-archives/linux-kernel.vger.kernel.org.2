Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1E34B442
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 05:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhC0Egz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 00:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhC0Egv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 00:36:51 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A9C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 21:36:50 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y2so1876867plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 21:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mkD8zOj3vYUxpklE5crr2Nc4MGr1kO5p6EdWYvS18hQ=;
        b=ncTg2Hsdw0l7VdTT1O9MouzHlSNItIIqMwfOeFwd0xpnARcBugYq5oCBKD1bbXZnt2
         dDMrHvS/oQs0sLTZrOspI+Xy2Ga3C7E/9XIrMJI4zTrX9jta+H1PKxLmLVenaK3HSms1
         I9OTnRm92lNMIi0SlQYK36SPKqexTwfuCkUBpBQU6oZjmY43IOOymAlYqM2UcOrOhNTD
         +uvcMuP4kONNxhM3zVL7oSAJU1I56j33TActSFOeZgrepZMfVL1EK9NcdjlIcRIN0OIY
         eLJapXUTi5+b0FwMgG9uf4+g7Bq0fiLBp64b4wWjCqNwvqecpHkL9P89SsBqW4trv9bZ
         qLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mkD8zOj3vYUxpklE5crr2Nc4MGr1kO5p6EdWYvS18hQ=;
        b=d1HUZFpAIK61saTb29Os0mya7UgnsLvJuZbGHNehfK7T11T76VPxNyYa2hR85a9oMA
         E9/TAAXfdK7mHflwNuC0e3VcL355V+Xb/I3fPNhW8vH5xR1z1SwfVNXgLYQuabHvuZ7g
         oCttob2tEjD7gSbjpFXhVZMEdRS/kX3z355gyp6YB2M4cEqxy8TtOpSBGB9uioL8wurV
         Xt5rQIrli8fKtjDd96tqkTe54ZkoLyvsR4oQ9O+/7FJXiPDSK2zk70Lu/xng0lsMkre8
         X8M5j37zpydtoNy9IPdNxt8+t5tyk23uuAOVNQSLHR2y7jMtfpzQmaL8G4KARrfiGTeW
         XaAA==
X-Gm-Message-State: AOAM533XvAG5a0POJRSxpRnjAUMiy5+ikTLP6Gdl7j1d4Nr7FFthgTdK
        umj9Wp9zibfW1fAc8kzyRVO4F2lKRKtGyQ==
X-Google-Smtp-Source: ABdhPJztdRRCfYBCQaJM3p9Go8WBNZPrCGTEYryZrJpFQOrm8DnyUGICJ4lrSxBhHjDP4MFc6D8+Kw==
X-Received: by 2002:a17:90a:a414:: with SMTP id y20mr16640992pjp.77.1616819809644;
        Fri, 26 Mar 2021 21:36:49 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id p25sm10875717pfe.100.2021.03.26.21.36.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 21:36:48 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <55A4B205-BC38-4F16-9EB9-54026C326E60@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date:   Fri, 26 Mar 2021 21:36:46 -0700
In-Reply-To: <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
Cc:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, chenjiashang <chenjiashang@huawei.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18861A144C085677931922018C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <e5b262c1ee14481ab68074be2a76b9d9@huawei.com>
 <55E334BA-C6D2-4892-9207-32654FBF4360@gmail.com>
 <14fe0083-cbff-884c-34db-ce3227e026f5@linux.intel.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 26, 2021, at 7:31 PM, Lu Baolu <baolu.lu@linux.intel.com> =
wrote:
>=20
> Hi Nadav,
>=20
> On 3/19/21 12:46 AM, Nadav Amit wrote:
>> So here is my guess:
>> Intel probably used as a basis for the IOTLB an implementation of
>> some other (regular) TLB design.
>> Intel SDM says regarding TLBs (4.10.4.2 =E2=80=9CRecommended =
Invalidation=E2=80=9D):
>> "Software wishing to prevent this uncertainty should not write to
>> a paging-structure entry in a way that would change, for any linear
>> address, both the page size and either the page frame, access rights,
>> or other attributes.=E2=80=9D
>> Now the aforementioned uncertainty is a bit different (multiple
>> *valid*  translations of a single address). Yet, perhaps this is
>> yet another thing that might happen.
>> =46rom a brief look on the handling of MMU (not IOMMU) hugepages
>> in Linux, indeed the PMD is first cleared and flushed before a
>> new valid PMD is set. This is possible for MMUs since they
>> allow the software to handle spurious page-faults gracefully.
>> This is not the case for the IOMMU though (without PRI).
>> Not sure this explains everything though. If that is the problem,
>> then during a mapping that changes page-sizes, a TLB flush is
>> needed, similarly to the one Longpeng did manually.
>=20
> I have been working with Longpeng on this issue these days. It turned
> out that your guess is right. The PMD is first cleared but not flushed
> before a new valid one is set. The previous entry might be cached in =
the
> paging structure caches hence leads to disaster.
>=20
> In __domain_mapping():
>=20
> 2352                                 /*
> 2353                                  * Ensure that old small page =
tables are
> 2354                                  * removed to make room for =
superpage(s).
> 2355                                  * We're adding new large pages, =
so make sure
> 2356                                  * we don't remove their parent =
tables.
> 2357                                  */
> 2358                                 dma_pte_free_pagetable(domain, =
iov_pfn, end_pfn,
> 2359 largepage_lvl + 1);
>=20
> I guess adding a cache flush operation after PMD switching should =
solve
> the problem.
>=20
> I am still not clear about this comment:
>=20
> "
> This is possible for MMUs since they allow the software to handle
> spurious page-faults gracefully. This is not the case for the IOMMU
> though (without PRI).
> "
>=20
> Can you please shed more light on this?

I was looking at the code in more detail, and apparently my concern
is incorrect.

I was under the assumption that the IOMMU map/unmap can merge/split
(specifically split) huge-pages. For instance, if you map 2MB and
then unmap 4KB out of the 2MB, then you would split the hugepage
and keep the rest of the mappings alive. This is the way MMU is
usually managed. To my defense, I also saw such partial unmappings
in Longpeng=E2=80=99s first scenario.

If this was possible, then you would have a case in which out of 2MB
(for instance), 4KB were unmapped, and you need to split the 2MB
hugepage into 4KB pages. If you try to clear the PMD, flush, and then
set the PMD to point to table with live 4KB PTES, you can have
an interim state in which the PMD is not present. DMAs that arrive
at this stage might fault, and without PRI (and device support)
you do not have a way of restarting the DMA after the hugepage split
is completed.

Anyhow, this concern is apparently not relevant. I guess I was too
naive to assume the IOMMU management is similar to the MMU. I now
see that there is a comment in intel_iommu_unmap() saying:

        /* Cope with horrid API which requires us to unmap more than the
           size argument if it happens to be a large-page mapping. */

Regards,
Nadav

--Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBetl8ACgkQHaAqSaba
D1q61Q/8CfEICk6tmSsbLNtp21OH6a/otwOCJzIOCoEAqSaRv5FlXXe+FedJWQqX
mg4KN1XuohWP7jxqXCBWTKxRF+TgEHoT3wfUp7JqmJxu040UQd9EUkcCwdzcBB+1
B7I3lf7AYPLYeIAy7iC+BMiiIrOASBThl4qzgBnNgigrYrOgVlnzF7YBs4lUTPKs
WZUqrrhLmzV/l58TuYsbtAtH/oQMdpaMKDAxCdagNMQbsAsZtz50B+vv1e+Olog7
bbKhec9psqhjR8zPfspwqyH6QR1UPM81eo8sHBeCBqbzn4bCELdm2jvCLTVhvszz
eo+z/InVgnji9PqObA5b8dFU6HFsld89nAb/ePQc49i3NcmZg50+j6tU9QaDi2Uk
1IR3X8shJSdm6pLxXhE+POJ4Ynrph0gbhdDJJNcWgDEr2h6GUjkY58yGhrSA+z02
JDWC5yaLYju75rnCnYvKcVzyGdKujvrWTVk201fILGJgQJGSqN8ixZKSouAjAPC9
cMernmrugecbMWB0yGL86XNMY8wjIOvhLIKcjzIGOfuiTTqaxMtVuY8u9fpRLR8/
00bqfwIkej9vBTDUF/zSy5WQeYrT+6OJXUgdxqaP1U1Qw+Fse50bsZjbxSWso512
KuqyucJkBJ+p6yVoENmQzEy+VLjODiRjMG9lYz37TcbaJWJ97ys=
=Vr9C
-----END PGP SIGNATURE-----

--Apple-Mail=_35D28607-8F18-4860-BA01-DF07CD351738--
