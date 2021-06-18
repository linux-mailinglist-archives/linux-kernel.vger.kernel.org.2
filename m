Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1483ACC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhFRNsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:48:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50C2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:46:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t7so8714435edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QD9xhRAioQNunN9SK+0QTDKEdfDtThhO2Xm37dICDFc=;
        b=V13W1boCXIatp1eaWXZOyWLCCiXSh6ty+CfYaEGOxyP3PUVBtG056caWNaoJuIcSNS
         Dwo2K3pQXawPmrVfGnxISaHYANZ9kwjnclA/fj/nvCOUww+hVvfRazhOIWpFtg7deAmB
         PKfMBpmstwqxqBocaeD9NtOKGloufNOQf798Y2P/nBrMl/Q1yIiXyDCBbtIG+AK/mHFP
         6TI65Ylk6ZUvNZEAU9C3F/r7VxdThnsKdKIBN77nD531+uMWv0FxPQqKf2rBSmbxG2sF
         VPN1ZrWfJb+chBMwUXye52H/rmmgO2f1SfEBynnAXPmNaSwPQ+GZ7Ssdf6SKqiyRytYx
         /AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QD9xhRAioQNunN9SK+0QTDKEdfDtThhO2Xm37dICDFc=;
        b=I7OexK/DpEy3T7+jnWh5XYImxCp2owlKTzh4YteOEweAtFs5Osb3OGjXOxN+IkypCr
         fHFmKYUW0i0xjDyrPZwIeh2khQt3bBQYwApxkBmnI7yoRwEynY7+3hiCsgcfeUA9CTM8
         KFSEItTgJgBG4s4aWnYTRp+EVpWsSdd/+R1N98pGcQdwoQ7rJ3qctTbkj9/WQoHslwW8
         Wqu7ftmIdTHq961m7N0hdEwK3bC5aoqL9DxT6s32S+HY3jHfWgTlkgv9iPd9kVO246uu
         vUAadJzkLkzZ0DtxwiysKBegPJurYc14nPS9hM1B2i5AkPSBmDO2XE2oPsbNWabhEsY7
         H3CA==
X-Gm-Message-State: AOAM532AzoCNOmmC8Jpmw/eRqlX1INQSocPVmbKMG27yYLTLe5SN/nPK
        +qiJGYllYG3gb8BvloT7Z9s=
X-Google-Smtp-Source: ABdhPJzvyj6MT8ALd+YCXnRFMskZtQQQjcprk5AhHouCO07kFp4MgIEVpF6qHsiNP04/xO4xL4NLFw==
X-Received: by 2002:aa7:ccc1:: with SMTP id y1mr5060916edt.333.1624023964512;
        Fri, 18 Jun 2021 06:46:04 -0700 (PDT)
Received: from m4.home (tor-exit-2.zbau.f3netze.de. [2a0b:f4c0:16c:2::1])
        by smtp.gmail.com with ESMTPSA id fl21sm1092691ejc.79.2021.06.18.06.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 06:46:03 -0700 (PDT)
Sender: Domenico Andreoli <domenico.andreoli.it@gmail.com>
Received: from cavok by m4.home with local (Exim 4.94.2)
        (envelope-from <cavok@m4>)
        id 1luEoq-0000Zb-0U; Fri, 18 Jun 2021 15:46:00 +0200
Date:   Fri, 18 Jun 2021 15:45:59 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Leonardo Br?s <leobras.c@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: REGRESSION: v5.13-rc1 does not boot because of "of/pci: Add
 IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses"
Message-ID: <YMyjl4RHlsg9puj0@m4>
References: <YMyTUv7Jsd89PGci@m4>
 <a5e8f78b69ba412a86819a176a44c4f2a2e78ff0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ELI+/G/OgGpuSPwi"
Content-Disposition: inline
In-Reply-To: <a5e8f78b69ba412a86819a176a44c4f2a2e78ff0.camel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ELI+/G/OgGpuSPwi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 18, 2021 at 10:17:39AM -0300, Leonardo Br?s wrote:
> Hello Domenico,

Hi,

>=20
> If I got that correctly, my patche exposes an issue with host bridge
> windows.??
>=20
> There is already a patch approved that should fix the issue:
> http://patchwork.ozlabs.org/project/linux-pci/patch/20210614230457.752811=
-1-punitagrawal@gmail.com/

Yes, that also (alone on top of v5.13-rc6) restores my boot.

>=20
> Please check if it fixes the issue for you (also, if possible give
> feedback in the patch thread).=20

I will. Thanks!

Dom

>=20
> Best regards,
> Leonardo Bras
>=20
> On Fri, 2021-06-18 at 14:36 +0200, Domenico Andreoli wrote:
> > Hi Leonardo,
> >=20
> > Since v5.13-rc1 my NanoPI M4 (arm64 with pcie-attached nvme) does not
> > boot any more.
> >=20
> > I could bisect it down to your commit
> > 9d57e61bf72336e13e4cd3c31e93ab26266296a8, just
> > reverting it from v5.13-rc6 makes the boot happen again.
> >=20
> > The .dts file I use is arch/arm64/boot/dts/rockchip/rk3399-nanopi-
> > m4v2.dts.
> >=20
> > This is the output of lspci -vv:
> >=20
> > 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
> > Express Root Port (prog-if 00 [Normal decode])
> > ????????????????Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASn=
oop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > ????????????????Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=
 >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > ????????????????Latency: 0
> > ????????????????Interrupt: pin A routed to IRQ 90
> > ????????????????Bus: primary=3D00, secondary=3D01, subordinate=3D01, se=
c-latency=3D0
> > ????????????????I/O behind bridge: 00000000-00000fff [size=3D4K]
> > ????????????????Memory behind bridge: fa000000-fa0fffff [size=3D1M]
> > ????????????????Prefetchable memory behind bridge: 00000000-000fffff [s=
ize=3D1M]
> > ????????????????Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast=
 >TAbort-
> > <TAbort- <MAbort- <SERR- <PERR-
> > ????????????????BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Re=
set-
> > FastB2B-
> > ????????????????????????????????PriDiscTmr- SecDiscTmr- DiscTmrStat- Di=
scTmrSERREn-
> > ????????????????Capabilities: <access denied>
> > ????????????????Kernel driver in use: pcieport
> >=20
> > 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe
> > SSD Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
> > ????????????????Subsystem: Samsung Electronics Co Ltd NVMe SSD Controll=
er
> > SM981/PM981/PM983
> > ????????????????Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASn=
oop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > ????????????????Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast=
 >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > ????????????????Latency: 0
> > ????????????????Interrupt: pin A routed to IRQ 89
> > ????????????????NUMA node: 0
> > ????????????????Region 0: Memory at fa000000 (64-bit, non-prefetchable)
> > [size=3D16K]
> > ????????????????Capabilities: <access denied>
> > ????????????????Kernel driver in use: nvme
> > ????????????????Kernel modules: nvme
> >=20
> > Is there anything I can do to help you understanding why this is
> > happening?
> >=20
> > I apologize for not having bisected it earlier.
> >=20
> > Kind regards,
> > Domenico
> >=20
>=20

--=20
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05

--ELI+/G/OgGpuSPwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0znebYyV6RAN/q8htwRzp/vsqYEFAmDMo5MACgkQtwRzp/vs
qYEJkBAAoMT9x6vjOUM8K1lh/1NuqWTizGgaInm/apPqTvxUe4iAnFAC/LjDsMrv
jC/UKfm8fh7/grzJdguWF6IvJviJKu4l6n8c9n1dFWxIJ+mwN5AAyMHRPkHF8d8w
x63aRh3oizFLfUNfrgEw0AO+wt5wA+FOPYsKhU1eUjhPOtouNkIhhfonm7s0kmy4
wEGonqvwiH77DuYwlMPpCrC6E1u+2Hf2unn8BvPBApbQlayIH1rwiR0GevcGkOS/
IP1hMxfT8a7tpDVQ2lTIh6lqpAGpYKcTcmOt6AntwL8lDBy4CqSqrjxOmhiaPcEI
WahpTK5yK7PQuVJ9mCjTmkcRd5eoBiusvoMuwErILhRKc7JTT+IwIf479dC3J+kD
XGQ3Nl2SW4PWffKmGBuKejOpwb/XOYhL5Tvw8kiCT5wAATD6w+ncRawxI9HJedEw
61Ge8fQEMJkgI9zp9am64Zm38l3p0IGYT9GKE34YQe6KymndXc531CusC8/TZm7Y
p9iXymxQ7IhsnTiTn35mgc7wQHXmqM1stHLwoJgX2CL4QzwACDDaOYl5BtsmRkPJ
R4K+3X1bheRxvIRMcfIOu/GJRXAcZHVCxCM89575OwJ9fdxaTmfygV9kLKWdmVat
mcrGcbX57ENPqcYtfzX4WKl1ymsefBZ30JSdLxZbPTod7z76f04=
=Xj9Z
-----END PGP SIGNATURE-----

--ELI+/G/OgGpuSPwi--
