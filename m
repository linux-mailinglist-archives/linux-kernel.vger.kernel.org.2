Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BD434AD17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhCZRGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:06:55 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:39363 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229871AbhCZRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:06:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 208075807EA;
        Fri, 26 Mar 2021 13:06:47 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Fri, 26 Mar 2021 13:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=Cto+EyA1XyjcLE2PX+93/pQcMeag
        m1IAD58rKTDVk4M=; b=bvq3t6Ypz3kHuIIjz44HfJzMpasxPpDj2mZeWxVz90Vi
        7yUFJby512eLEBQKPm58HSjeT/kZQExI86nRBhZp8FBKsSoLzwaLkIhi0Mv2aPes
        Pwbcc1DxqyxbMHiI9NPYT1sCqzuCSGexpjW6NP2jeM6S16btQ9O+U3fuBVj/Nlmu
        m4OqpXNdCGWKUAHf5quASINGzi52Q0CT6ohcQwtMpf+ZK2NtxRMAHCCYQHDP9sa3
        4rMBPzAuXf0VPt+dlDsXEhHEKpibH0o0spCAKgM3fo6idVpXEd/TV8EjXF7s00zQ
        LIwYsx+N9dLX78aEwrfrGxCZetSMYleU4ehsghawsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Cto+Ey
        A1XyjcLE2PX+93/pQcMeagm1IAD58rKTDVk4M=; b=t9Uuqvot2Mg61iccRpYVgS
        hRijFfGbvs5ElZ0yP60DTOdjleZDCqvxlueEsPWjdbOH+pa4nsYXLNK5J33e7g7d
        XiHg457+wQWfR1o0t9XFVqXXMbTHt9dAUdvqZbFBBjS1SBm71xySxK65gQ8Q6x4s
        JzSDuXS6wJ/aQqgkZ8gjhB0HBzjcUZbk28b3dH4vJ3QBQZ56GUb0NCERH0qJ/Vd+
        9J1H6OYvULhGRcBXz7dzNL2EicGcxM+O0xX2/uvBaZFhteuVOZJSRDIDuzbZ2Awk
        dc94FfgWZLIst1x+8X6sexb/ZvFx+xp6sjTn1DO1AWJl8Ny0LGVlTg5sfF/eCxsA
        ==
X-ME-Sender: <xms:pBReYObo6zn-am-chkHUkDXtGNOZJcGnzxRACWzJKK6Pv-YUjC-tTA>
    <xme:pBReYBbqrgz8L0bDpHThXGpRygzQa93Or9UsdMiJIQlIU7MSNmHh-08X3S3-xsTEs
    byV2-Lw73TawQH1LCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehvddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:pBReYI_HcWQBkUqaYLRjQl10c9Q86o1cTpDITKyX6UeWnJ0ra-fOCw>
    <xmx:pBReYAreczweL8wq4fZ_qelo28s1-XS2rh_h6gqqHK-YfqnXB20FFg>
    <xmx:pBReYJpKTnDItHpCS3p9Jp9dYP-TFWaJaHVUFBHZ1-f-vHHdlUcMSw>
    <xmx:phReYKSPRyHNf48Z_o1QYw7YAmk7XjVfEBAbCG925V5oT5G8Fly-q1EHj-M>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4981F51C005E; Fri, 26 Mar 2021 13:06:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <5907bd2e-858e-4f54-a3d1-3c3905e22422@www.fastmail.com>
In-Reply-To: <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <CAK8P3a0fvnYLrG=cGiOQ6u8aZnriTeM0R=MW7FX=94mO13Rq0w@mail.gmail.com>
 <c1bcd90d344c2b68@bloch.sibelius.xs4all.nl>
 <9f06872d-f0ec-43c3-9b53-d144337100b3@www.fastmail.com>
 <CAK8P3a2b7k6JkxecW=yu-NF+fkNCxJ3Ja36nQ7LK8hsuO=4=sw@mail.gmail.com>
Date:   Fri, 26 Mar 2021 18:06:23 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Rob Herring" <robh@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Mar 26, 2021, at 17:38, Arnd Bergmann wrote:
> On Fri, Mar 26, 2021 at 5:10 PM Sven Peter <sven@svenpeter.dev> wrote:
> > On Fri, Mar 26, 2021, at 16:59, Mark Kettenis wrote:
> > > Some of the DARTs provide a bypass facility.  That code make using the
> > > standard "dma-ranges" property tricky.  That property would need to
> > > contain the bypass address range.  But that would mean that if the
> > > DART driver needs to look at that property to figure out the address
> > > range that supports translation it will need to be able to distinguish
> > > between the translatable address range and the bypass address range.
> >
> > Do we understand if and why we even need to bypass certain streams?
> 
> My guess is that this is a performance optimization.

Makes sense.

> 
> There are generally three reasons to want an iommu in the first place:
>  - Pass a device down to a guest or user process without giving
>    access to all of memory
>  - Avoid problems with limitations in the device, typically when it
> only supports
>    32-bit bus addressing, but the installed memory is larger than 4GB
>  - Protect kernel memory from broken drivers
> 
> If you care about none of the above, but you do care about data transfer
> speed, you are better off just leaving the IOMMU in bypass mode.
> I don't think we have to support it if the IOMMU works reliably, but it's
> something that users might want.

Right now the IOMMU works very reliably while bypass mode seems to be tricky
at best. I think I partly know how to enable it but it looks like either not
every DART or DART/master combination even supports it or that there is
some additional configuration required to make it work reliably.

I had it working with the USB DART at one point but I needed to enable it in
all 16 streams of the IOMMU even though the pagetables only need to be setup
in one stream as indicated by the ADT.
I couldn't get it to work at all for the framebuffer IOMMU.

I think it's fine to skip it for now until it's either actually required due
to some hardware quirk or once we have users requesting support. Apple uses
almost all IOMMUs without bypass mode if that ADT is to be believed though.


Best,

Sven
