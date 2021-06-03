Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6439AAF7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 21:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFCTeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 15:34:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhFCTeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:34:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C0FD611CC;
        Thu,  3 Jun 2021 19:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622748754;
        bh=rvC32MA8E3QrSBWjTg6LF33SlYkWLco0I2yCu23n7Ok=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=jhQeYpzgE6vlWf6TMVMtA+XVEhF3g/+sc+mtqLnWt9Jxq6VW05vCdwGdpHLzufuYS
         UwGtMjrFLjvxTtrXwJuljVurczSzpAyvwhISyhtF9mlHrjE5HfQoaQl5Edk52qoEvO
         fIAR9d5gHQbaop5gruCM9Lb2jdZgO0Vki7OQd9lPddn94/3XqQQhfbFgTNLMzDuhWZ
         qfQDXIjh/bpK09jMqCFV81DG209YazmpQjI81ykvp5KDwDs8VWUNxwQkPY0OgkctQR
         pcqnAZK3Wrh9q7duTaMgSjY9Ojm0reQwUN8R3uZYRnguJ2XWcuU7B5qmCg7FnR504O
         BMQUYhKYK2fxg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6FF6127C005B;
        Thu,  3 Jun 2021 15:32:32 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 03 Jun 2021 15:32:32 -0400
X-ME-Sender: <xms:Ti65YARuXTjJ3BHnKxxPhwSkEN4alc6eBsVdVZX7VFM1tHzIOxyOgw>
    <xme:Ti65YNyLRRxKCVBDmIPZpIaCS6oWxEjczPCeT15pkFl57T-PKotNNxIK4jcFo19NO
    s3Vs4kuPInKe7TqDrI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:Ti65YN2MdDOPGi9cterhA_MhwaeugS0qPfadYs_WiFpFbzqTVeVAiQ>
    <xmx:Ti65YED0zWXWevXVsCLnReGi2B61zP8LIx-LINBak-ESTbCZ0sdehQ>
    <xmx:Ti65YJhDZklB1wypCK3j_CL1JFPBrH3kprv63MgfcNLqQZuCN3eyiA>
    <xmx:UC65YAOlSD8pvDt4Vuj2PT11Fvc3F8j5ymkDv3XWdRtZblxt_ngBaZaSAMHEjR9C>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66F9C51C0060; Thu,  3 Jun 2021 15:32:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
In-Reply-To: <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
Date:   Thu, 03 Jun 2021 12:31:59 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Andi Kleen" <ak@linux.intel.com>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
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



On Thu, Jun 3, 2021, at 11:00 AM, Andi Kleen wrote:
>=20
> On 6/3/2021 10:33 AM, Andy Lutomirski wrote:
> > On 6/2/21 5:41 PM, Andi Kleen wrote:
> >> Only allow split mode when in a protected guest. Followon
> >> patches harden the split mode code paths, and we don't want
> >> an malicious host to force anything else. Also disallow
> >> indirect mode for similar reasons.
> > I read this as "the virtio driver is buggy.  Let's disable most of t=
he
> > buggy code in one special case in which we need a driver without bug=
s.
> > In all the other cases (e.g. hardware virtio device connected over
> > USB-C), driver bugs are still allowed."
>=20
> My understanding is most of the other modes (except for split with=20
> separate descriptors) are obsolete and just there for compatibility. A=
s=20
> long as they're deprecated they won't harm anyone.
>=20
>

Tell that to every crypto downgrade attack ever.

I see two credible solutions:

1. Actually harden the virtio driver.

2. Have a new virtio-modern driver and use it for modern use cases. Mayb=
e rename the old driver virtio-legacy or virtio-insecure.  They can shar=
e code.

Another snag you may hit: virtio=E2=80=99s heuristic for whether to use =
proper DMA ops or to bypass them is a giant kludge. I=E2=80=99m very sli=
ghtly optimistic that getting the heuristic wrong will make the driver f=
ail to operate but won=E2=80=99t allow the host to take over the guest, =
but I=E2=80=99m not really convinced. And I wrote that code!  A virtio-m=
odern mode probably should not have a heuristic, and the various iommu-b=
ypassing modes should be fixed to work at the bus level, not the device =
level.
