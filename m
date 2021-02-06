Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629D4311F41
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhBFSAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhBFSAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:00:51 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E38BC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pJ9l0Gm7ttcEwsXpjvfTeDJEweWQHyzuCvwSEpB3874=; b=gDNJrIzGbydqUakJBySlA47p+h
        bQwtbp3uIxAox1SGrkesAHq/YJ3NlgBthxY09Uu6+QfQmkZUIKzxrBlKHVuBg4/CiZPPf5J6RqXQd
        kayvZfBFEbedtbwE2Bu/mFHcJRa4ODkHO3i1dZGvWyK/A01IcC0xsqdVKvd10xC18t4c=;
Received: from p200300ccff3272001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff32:7200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1l8RsD-00022M-8y; Sat, 06 Feb 2021 19:00:01 +0100
Date:   Sat, 6 Feb 2021 18:59:56 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Letux-kernel] BOG: commit 89c7cb1608ac3 ("of/device: Update
 dma_range_map only when dev has valid dma-ranges") seems to break Pinephone
 display or LCDC
Message-ID: <20210206185956.64921c80@aktux>
In-Reply-To: <YB1f2kYMtHnM5ye1@aptenodytes>
References: <81FE44A3-38C8-4B78-BB77-C09B4FC80B0A@goldelico.com>
        <YBkh6IZfmzaLWYPp@aptenodytes>
        <E45AE13E-6A74-43E6-A7AE-B0D425B10344@goldelico.com>
        <YBlW3ES1E5SwUOpJ@aptenodytes>
        <13D0EFBB-E2A1-4BA3-9F99-CF2B85127074@goldelico.com>
        <YB1f2kYMtHnM5ye1@aptenodytes>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Feb 2021 16:10:18 +0100
Paul Kocialkowski <paul.kocialkowski@bootlin.com> wrote:

> Hey,
>=20
> On Tue 02 Feb 21, 16:07, H. Nikolaus Schaller wrote:
> > Hi Paul,
> >  =20
> > > Am 02.02.2021 um 14:42 schrieb Paul Kocialkowski <paul.kocialkowski@b=
ootlin.com>:
> > >=20
> > > Hi Nikolaus,
> > >=20
> > > On Tue 02 Feb 21, 11:50, H. Nikolaus Schaller wrote: =20
> > >> Hi Paul,
> > >>  =20
> > >>> Am 02.02.2021 um 10:56 schrieb Paul Kocialkowski <paul.kocialkowski=
@bootlin.com>:
> > >>>=20
> > >>> Hi Nikolaus,
> > >>>=20
> > >>> On Tue 02 Feb 21, 10:18, H. Nikolaus Schaller wrote: =20
> > >>>> Hi,
> > >>>> since v5.11-rc6 my Pinephone display shows some moir=C3=A9 pattern.
> > >>>>=20
> > >>>> I did a bisect between v5.11-rc5 and v5.11-rc6 and it told me that
> > >>>> the commit mentioned in the subject is the reason.
> > >>>>=20
> > >>>> Reverting it makes the display work again and re-reverting fail ag=
ain.
> > >>>>=20
> > >>>> IMHO it seems as if the display DMA of the pinephone (allwinner su=
ni-a54)
> > >>>> got influenced and stopped to scan the framebuffer.
> > >>>>=20
> > >>>> The only dma-ranges I could find are defined here:
> > >>>>=20
> > >>>> 	arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > >>>>=20
> > >>>> 	dma-ranges =3D <0x00000000 0x40000000 0xc0000000>;
> > >>>>=20
> > >>>> but I can't tell if they are "valid" or not.
> > >>>>=20
> > >>>> Any insights are welcome. And please direct to the right people/ma=
iling lists
> > >>>> if they are missing. =20
> > >>>=20
> > >>> This may not be strictly the same thing, but is this patch in your =
tree:
> > >>> https://patchwork.kernel.org/project/linux-arm-kernel/patch/2021011=
5175831.1184260-2-paul.kocialkowski@bootlin.com/
> > >>>=20
> > >>> If not, it's worth a try to add it. =20
> > >>=20
> > >> No, it hasn't arrived in v5.11-rc6 (or linux-next) yet.
> > >>=20
> > >> But it fixes the issue. =20
> > >=20
> > > Great! The patch should already be on its way to the next RC. =20
> >=20
> > Fine!
> >  =20
> > >=20
> > > And nice to see you're active on Pinephone as well! =20
> >=20
> > I have a developer unit and the LetuxOS kernel already supports it a li=
ttle. This is why I observed the issue with -rc6
> >  =20
> > > You might remember me from
> > > the Replicant project, as I've worked a bit on the GTA04 :) =20
> >=20
> > Sure, you are well remembered :)
> >=20
> > I still have the dream to revitalize Replicant 4.2 for the GTA04 just f=
or fun. I can already boot to Replicant touch screen with a v5.4 kernel. v5=
.10 fails when trying to spawn zygote... =20
>=20
> Oh I see! I think Android has made some significant progress is its abili=
ty
> to use mainline (4.2 was an early stage and I remember having to backport
> patches to use some mainline features back then).
>=20
> Maybe it would be easier with Replicant 6, but you'd have to go through t=
he
> device bringup phase again, which is never nice.
>=20
well, we have done some experimental Replicant 6 images, but it is
unbeleavable slow. Do not know why. The bootanimation process(even
though there is no "animation") draws a lot of cpu power.

Regards,
Andreas
