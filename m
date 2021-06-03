Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E3039AD8A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFCWTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCWTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16EAB613DA;
        Thu,  3 Jun 2021 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622758680;
        bh=iBpJa3hzL2XnQctU7nWWRQdmYnS2ODgfQmpUYL+CSCM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=goelUiYeT6Jd2Jmn9BB/fItRWSNuABe7n2yK6Y+YJPyGwSX01/AthAUxdUNw+ZBdH
         SuI8LPItlruF68n+9wr3nEQOW+uYYfMZUBYrszZFMo2SmLpAk8GsqKT6u9BCvL11Bx
         uZRMvXJkNTJy06TL1KjRejiWcrQTNBFDUfs9Zi/gTSEIUsYx/6eh4Ij5+RUQIixemD
         8jHtfO2OfqpJi80x/AB6iHrf1XMwdrpN45cVP45y32uyXpkv1FDCf/r1uQ6I/oKpzI
         JJzK1yHiXw0s9MbQP0YbtwS4NlzJGdQzA5XkVHJkSGL/5RlC9hrb7xq8AbMJeGvGFG
         NLxrgQsCUFDhQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1243527C005B;
        Thu,  3 Jun 2021 18:17:58 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 03 Jun 2021 18:17:58 -0400
X-ME-Sender: <xms:FVW5YLRT78JmV-bHZ9AoDryQjuJpR4-ypqJw1C0C-16TJxC2oFmriQ>
    <xme:FVW5YMx3AI9fPNWvmQAADBmyIDRWJL7yTyuHGXL28y9SAPgQq7VzirqRGx0xVpkia
    IsFuAxUtvKzFe502yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedttddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:FVW5YA2iRJ4l6-6aEvi8DGy-dOXy17TT6tfVLK03N4Hb0RZn4VKu8g>
    <xmx:FVW5YLAZsPvtN18ZwPhBUul2PsMO1NgC1Ex4mVj-HhEuYLXza_GjtQ>
    <xmx:FVW5YEjUkutjA5TYGDJ6a-6t_a3_9zu1FdRmxDgB735q-gZm4hkPBQ>
    <xmx:FlW5YHMGvwhS2Xfc4aFRCXzjJLsEN6zIXvE9D9II2fdsqgvYRnWx5j0x4FjxAr4r>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0C3351C0060; Thu,  3 Jun 2021 18:17:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
In-Reply-To: <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
Date:   Thu, 03 Jun 2021 15:17:34 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Andi Kleen" <ak@linux.intel.com>, mst@redhat.com
Cc:     "Jason Wang" <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jun 3, 2021, at 12:53 PM, Andi Kleen wrote:
>=20
> > Tell that to every crypto downgrade attack ever.
>=20
> That's exactly what this patch addresses.
>=20
> >
> > I see two credible solutions:
> >
> > 1. Actually harden the virtio driver.
> That's exactly what this patchkit, and the alternative approaches, lik=
e=20
> Jason's, are doing.
> >
> > 2. Have a new virtio-modern driver and use it for modern use cases. =
Maybe rename the old driver virtio-legacy or virtio-insecure.  They can =
share code.
>=20
> In most use cases the legacy driver is not insecure because there is n=
o=20
> memory protection anyways.
>=20
> Yes maybe such a split would be a good idea for maintenance and maybe=20=

> performance reasons, but at least from the security perspective I don'=
t=20
> see any need for it.


Please reread my email.

We do not need an increasing pile of kludges to make TDX and SEV =E2=80=9C=
secure=E2=80=9D.  We need the actual loaded driver to be secure.  The vi=
rtio architecture is full of legacy nonsense, and there is no good reaso=
n for SEV and TDX to be a giant special case.

As I said before, real PCIe (Thunderbolt/USB-C or anything else) has the=
 exact same problem.  The fact that TDX has encrypted memory is, at best=
, a poor proxy for the actual condition.  The actual condition is that t=
he host does not trust the device to implement the virtio protocol corre=
ctly.

>=20
> >
> > Another snag you may hit: virtio=E2=80=99s heuristic for whether to =
use proper DMA ops or to bypass them is a giant kludge. I=E2=80=99m very=
 slightly optimistic that getting the heuristic wrong will make the driv=
er fail to operate but won=E2=80=99t allow the host to take over the gue=
st, but I=E2=80=99m not really convinced. And I wrote that code!  A virt=
io-modern mode probably should not have a heuristic, and the various iom=
mu-bypassing modes should be fixed to work at the bus level, not the dev=
ice level
>=20
> TDX and SEV use the arch hook to enforce DMA API, so that part is also=
=20
> solved.
>=20

Can you point me to the code you=E2=80=99re referring to?

>=20
> -Andi
>=20
>=20
