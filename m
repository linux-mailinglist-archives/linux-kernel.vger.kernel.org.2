Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAE33E933
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhCQFqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQFqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:46:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3743C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:46:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o16so7149403pgu.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 22:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Ujp9UfR8Qd2e1W2rb8Yy7Ng5ueLzSwK0qByoLGFBS0s=;
        b=IGyWMaPRak736Km3uapC54943hh9Z69fyJb74NvV7tGffmojDAy2J0TLYmsM/q0Xth
         lC/B+nyXO6PcTCOHS5VLIrwBvOKxSp5YkMWsECi6yGg3N9ieJrWtQAnxEoiga56rDDRa
         B6nJ2M5LoaV+eipBjRBYuvw7qY+YYLxd67IjuRSEgzfL9VDhtKGlgXAo8fUI+kG6AVcd
         lBSRjnZVKXsRNsi1AKlCHP8QT3h01oMkgUyy6XIKEhZKAmro4B5x+Jf0+lW903EEihes
         itZwqExe6BFafZC+2fdMxVwf2SL2n1QXlATFiRAGnfPcHK6jUSIpG+MmzatiiIAu0o+Z
         H3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Ujp9UfR8Qd2e1W2rb8Yy7Ng5ueLzSwK0qByoLGFBS0s=;
        b=RbNmunM47xYBBJq7nfIZIVUi5+ka6VYgF8kmC5VKE4htfTFnyBNtr0nMN8KHHjJqbQ
         NUHU5wnXB4X57AtsYMfR90i1+b950ZNuV+HsV65mWDQvj0EMHrvWZ5J7bejhJdlItgo1
         lijzQkAKKjfNHSqgqNTgp1WSJrmPlZ5YifrY3dP6BnlmO1NFmEutxlawZ6YpeJJtPNfh
         2acgUdHADF1vQdbfb9i7tn6CddputTe/Ptsevc17Z6F3lxcOE/7PLYRW3OjpVu4Oy0yw
         AONBSrTnIKROmJbruO48wg+I1Sn7RDH8CefMU5X9tkBGzwcFqD2gjuVtRfLtKXcLVc4v
         U4ww==
X-Gm-Message-State: AOAM531SLhHMpRwqVimlQ258N6p3VDxldoV/UGSuhcY8eHX69GdzcaX3
        MIdtWOZVxknDjhEGD2i4aH88Fh6SZFitoA==
X-Google-Smtp-Source: ABdhPJwy8l3t4/GfWpvoU78y2CabIFXac1SEnv5gO5mnbDiGkzd7bDcWBUJZuuhHjMUxa7qaZSRwgA==
X-Received: by 2002:a62:7ecc:0:b029:1ee:f61b:a63f with SMTP id z195-20020a627ecc0000b02901eef61ba63fmr2683369pfc.57.1615959963049;
        Tue, 16 Mar 2021 22:46:03 -0700 (PDT)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id f15sm17787460pgg.84.2021.03.16.22.46.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Mar 2021 22:46:02 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: =?utf-8?Q?Re=3A_A_problem_of_Intel_IOMMU_hardware_=EF=BC=9F?=
Date:   Tue, 16 Mar 2021 22:46:00 -0700
In-Reply-To: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, will@kernel.org,
        alex.williamson@redhat.com, chenjiashang@huawei.com,
        iommu@lists.linux-foundation.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Mar 16, 2021, at 8:16 PM, Longpeng (Mike, Cloud Infrastructure =
Service Product Dept.) <longpeng2@huawei.com> wrote:
>=20
> Hi guys,
>=20
> We find the Intel iommu cache (i.e. iotlb) maybe works wrong in a =
special
> situation, it would cause DMA fails or get wrong data.
>=20
> The reproducer (based on Alex's vfio testsuite[1]) is in attachment, =
it can
> reproduce the problem with high probability (~50%).

I saw Lu replied, and he is much more knowledgable than I am (I was just
intrigued by your email).

However, if I were you I would try also to remove some =
=E2=80=9Coptimizations=E2=80=9D to
look for the root-cause (e.g., use domain specific invalidations instead
of page-specific).

The first thing that comes to my mind is the invalidation hint (ih) in
iommu_flush_iotlb_psi(). I would remove it to see whether you get the
failure without it.


--Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmBRl5gACgkQHaAqSaba
D1okkw//VQJJ39J/JKYVMkgwoAsIhX97StP/+FKhidQwmlC4lnKnDphGUObxcR8d
tFW33ZSpsywfKp1ZQS1Ygbeo9pHSKUiC+jqQb9IPJ7UlkQawfOxkbbJ2LpvwAWoF
YEVnjHfokaAYcop0tGcj/Da9kDBbiSgLd9Djkkwgl2sJiv+2xKC+j2NE09ppRr6X
tJWLFEUSiiJoWbhYsHTLXeiMtjnVYsIKBukqCE9A5uxzEypv3MNG/Ej56wILCx/m
CSQX2oUWbZ4Ngth+0erF6mYfrIvFNncewCzg27N5J2+dbnTvHxWbd/VAMD3vzqmO
+74AjWg8YVpxSqqA+nPouBc20xGJMM6q6QU4SXrV00c2HSoBHxglXsMc+3yiwPYN
Wh2OpP8G8J8DsnzgPKhxHVlTiEELmpw10RQoLnehCooOdOGnu7ALFoF7PWkl+qO5
aoKLQIm+Di2dURMfGR27b9QlByxxvM5B2MePpACp0OKwvrea83msUIve52hpXhZq
+1uAOLTs/mvLMMbzzvVsnPKHswWYULBjsFOKOuSTdgbfUc3tWpNcNlysBXZsDYg6
auFzIRun+IhdxsQQEalxCuEAhr8x3HCR+gkr95avp3G4JKWuwWW3A5ZYwEmP+Y9P
8VPpAZmQj9JFZBZX8Y739iXZ10XOdpA/c0a/sXGuNiYn0IuxvQ0=
=SsWK
-----END PGP SIGNATURE-----

--Apple-Mail=_32125005-ABF2-433B-8116-AA0CE5BE22AF--
