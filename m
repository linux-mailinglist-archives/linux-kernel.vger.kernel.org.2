Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E953968A9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhEaUNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhEaUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 16:13:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88D7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 13:11:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t8so2840922pgb.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=A5NonEOJI6X+iSa1j5osPVCbT473seVAsEqrZiOMN5A=;
        b=MnIags46LmxB6Q3GOsE+JBcoVjjvtUOdTgdH469mEKkf9XnO7u8VWTm3Z9n+4APOZG
         TsGINJN+9ZfelJHlECtn5k8xB46vAegxMKSJD6cWWBPOu6pRqFrYY+vXTclVMRfRwph/
         4quX0X6cSSWgyJRPAA+mQyOuvOlMNsT9B+CMWC9L7xBIG5iYNw48vjoAGQDeD9j5ZEHK
         Mp9cNrVCxiDHppyuOIeblbqZpW8ZtQbQ952neMXcinbmN/kidMUaylkqpXy9sPSbMDLq
         +8NIIlM6FG+MzcdKkcyASkXtfEddf/SLPWEmDqbvXmNPGo8dp1jyOfixLHUe2tfy4e0J
         JlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=A5NonEOJI6X+iSa1j5osPVCbT473seVAsEqrZiOMN5A=;
        b=VudEOkRRVE+L1U/mHhZ4MD3aa59BKvqwhwemnTdvwWxondul+BakQmjY0fv7TylQ2Q
         BpJouRP/yGbZzDeSjVEcvMcgKaAqTc6X3jYWUZ4x668cSD+jD1qsOa/p/DsgyVE2uYM3
         in2Z+zXnjSnvwDI0kmVZ8E9D006p02mdrQAGX2nTgTE0+FSw8fyBXfbxbXt8JP1k664Y
         q57TAfNKz9zoSnRgEG4DoTCF071E/3Hjhr7LmHtCCORSy8gqEsmNhHVu67imBrMPkaK4
         r8xO0uOWP6ENFkDEAvymP6ASFXqSF2xaJVyFLQb/JogyPXLEhi65VuWDTbw+2TDikQrQ
         kLuQ==
X-Gm-Message-State: AOAM5323El0ZGVNUJ0UyStfV5+fyvBkGo3gsbi2gC80V9m9OIRWVqKzv
        n1AU5oF6V2PxZo1HITSmPP1XEJwvbviuew==
X-Google-Smtp-Source: ABdhPJzIBUpoLRhn9O4HGxhm1gdX1K8+NSNS8yoK8dol192cODOR+oKQ4O6WZQJga2mvzz39zk6JvA==
X-Received: by 2002:a63:f209:: with SMTP id v9mr4093567pgh.98.1622491907026;
        Mon, 31 May 2021 13:11:47 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id z185sm6794716pgb.4.2021.05.31.13.11.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 May 2021 13:11:45 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
Message-Id: <0CD8AE55-ACE2-4647-B88B-BD8CFB8EF710@gmail.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/4] iommu/amd: Fix wrong parentheses on page-specific
 invalidations
Date:   Mon, 31 May 2021 13:11:44 -0700
In-Reply-To: <YKOHmQcqW0bX59nV@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
To:     Joerg Roedel <joro@8bytes.org>
References: <20210502070001.1559127-1-namit@vmware.com>
 <20210502070001.1559127-2-namit@vmware.com> <YKOHmQcqW0bX59nV@8bytes.org>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On May 18, 2021, at 2:23 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> On Sat, May 01, 2021 at 11:59:56PM -0700, Nadav Amit wrote:
>> From: Nadav Amit <namit@vmware.com>
>>=20
>> The logic to determine the mask of page-specific invalidations was
>> tested in userspace. As the code was copied into the kernel, the
>> parentheses were mistakenly set in the wrong place, resulting in the
>> wrong mask.
>>=20
>> Fix it.
>>=20
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Jiajun Cao <caojiajun@vmware.com>
>> Cc: iommu@lists.linux-foundation.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: 268aa4548277 ("iommu/amd: Page-specific invalidations for more =
than one page")
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> drivers/iommu/amd/iommu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Applied this one for v5.13, thanks Nadav.
>=20
> Somehow the rest of the patch-set got screwed up during sending or so,
> at least I see some patches twice in my inbox and with different
> subjects.
>=20
> Can you please re-send patches 2-4 when -rc3 it out?

Joerg,

Thanks for your understanding. I sent a version based on -rc3 a week
ago.

I noticed that there was some confusion regarding rc numbers. Do you
need a new version based on rc4 or can you apply the version I sent?

Thanks,
Nadav


--Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESJL3osl5Ymx/w9I1HaAqSabaD1oFAmC1QwAACgkQHaAqSaba
D1pHBQ//bjXmrz56/GSk8vNkNa0Q9oZRsKy06eOkS+oUxh4qMwNQgBfbJ5oB2psG
5UBtczZyTK8QCLT4M8N/Ixp4wkpy0If1g7lJk+rmRGkwZCvjskZTTtJR1LFL7jcm
3BVeiM0K7VScOp/PPoKRXse7Aimx32RG+8a2DlYyYwVOXQ9hT4tOloc0pWP2QHYd
NAseialDlyb2t36IN2n5NaUGrXTRXomtOMLW8/aHHrmCBrU1X3mS1Wkm8NuL1p14
uetWJrrAlrmx3uOPRuZbgHlqA7Vw6X9GAoqVXrjaAkAXc7ucdtXN09u+H9jAG7pC
bV/qlFEQxXh8NTi4G16+ycGOyQ9WYR1fSUl6Y0/jYiEQPeI5eC0N54JICiQJ2QCk
9E7kJT78P+L9Ia3lpHWuECI1SIKidWgkqgFdaOvj3gtA5AEH2BSZC/+tkGchuPAT
GNzUeQjR172mmnX4L5LEYabN7MK9fOqH2FmcFIJCChGGW0Gc+IS+KANuMZk+7UoX
HGnHQIBmBvUe0oFvpIJdRvXwj/3mWARsGddyQpMcO+ifdp/GJOPBq1o6/y4PHDhe
6HVT0pkZlF/N2Le+73MLSsg/gn395i7MPeDy41BceljaqO+encNhEocq3IM59eZU
LaFcEG9pD/vhqZ4G8nPESMnqiLw9nmpAqkqwzmzBbOJvH23YSl0=
=BKpm
-----END PGP SIGNATURE-----

--Apple-Mail=_BBA08D47-C8FB-47BC-A7B3-A9C4053E98CB--
