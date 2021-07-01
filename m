Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B774A3B9264
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 15:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhGANic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 09:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhGANib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 09:38:31 -0400
X-Greylist: delayed 14678 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Jul 2021 06:36:00 PDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC6C061762;
        Thu,  1 Jul 2021 06:36:00 -0700 (PDT)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id 21629BEC22E;
        Thu,  1 Jul 2021 15:35:59 +0200 (CEST)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id 1xiJBhPXBdcc; Thu,  1 Jul 2021 15:35:58 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7b00:36f3:9aff:fec2:7e46])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Thu,  1 Jul 2021 15:35:57 +0200 (CEST)
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
To:     Dennis Gilmore <dgilmore@redhat.com>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210701004043.18585-1-dgilmore@redhat.com>
 <01f1b032-14a8-a6fa-9063-23de65fc6f43@kleine-koenig.org>
 <f46b234e0aaf4356804d5e1446910bbedcbddb51.camel@redhat.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <dbb04649-d56c-32ac-913c-5b5795851bf4@kleine-koenig.org>
Date:   Thu, 1 Jul 2021 15:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f46b234e0aaf4356804d5e1446910bbedcbddb51.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YvRvFodUNf3nRSgnK9VvTAA07ofwB48Cl"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YvRvFodUNf3nRSgnK9VvTAA07ofwB48Cl
Content-Type: multipart/mixed; boundary="CMaIT3Zveiav2h1hm2zKMLUREiKWD8hmX";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Dennis Gilmore <dgilmore@redhat.com>, linux-rockchip@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <dbb04649-d56c-32ac-913c-5b5795851bf4@kleine-koenig.org>
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: helios64: fixup USB setup
References: <20210701004043.18585-1-dgilmore@redhat.com>
 <01f1b032-14a8-a6fa-9063-23de65fc6f43@kleine-koenig.org>
 <f46b234e0aaf4356804d5e1446910bbedcbddb51.camel@redhat.com>
In-Reply-To: <f46b234e0aaf4356804d5e1446910bbedcbddb51.camel@redhat.com>

--CMaIT3Zveiav2h1hm2zKMLUREiKWD8hmX
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Dennis,

On 7/1/21 2:59 PM, Dennis Gilmore wrote:
> On Thu, 2021-07-01 at 11:31 +0200, Uwe Kleine-K=C3=B6nig wrote:
>> Hello,
>>
>> On 7/1/21 2:40 AM, Dennis Gilmore wrote:
>>> Without the usbdrd_dwc3_1 node defined u-boot will throw an error
>>> and
>>> reset the system.
>>
>> I wonder if this should better be fixed in u-boot then?!
>>
>>> All other rk3399 systems use this format
>>
>> This is true for the dwc nodes, however for the usb2 nodes there are
>> several that use this idiom (and even repeat the label name), see for
>> example the &u2phy0 node in
>> arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi .
>>
>=20
> looking at that file is where I got the idea to set it up as I have
> proposed, it follows the format I have submitted

I guess you didn't read exactly what I wrote and only looked at &usbdrd* =

but not &u2phy0.

Best regards
Uwe


--CMaIT3Zveiav2h1hm2zKMLUREiKWD8hmX--

--YvRvFodUNf3nRSgnK9VvTAA07ofwB48Cl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdxLAACgkQwfwUeK3K
7AlVQAf/RAQaPs27pUNomG8/r01G08LL88uLjlivWTkaxbrkeD+JsdQrkncdz2VR
8kkoLdLPPl/coBFB4YFYmtKIXiYCG6fvorW19ciVM7Pe/s5VJSyJAbMF24MUwPkr
IcugWcb5CVOTa4nuhWY3Up6C0q53IRFRACI72nlUc5mcq1h4nXuXCg5wFnFwOTNL
/pwamhX8gPZd+54+YU16JgFf1rbdIJc43uSMY1kjXn8QFPcxKwZGQMKtDMRE75Ha
50xbzSlXXSDndrZl3IeNJ3W4T+7I3tb3HFwhSjZVunLntoJAoFrVIEFQF7C3k6ey
4E/EhDeFsAHZhAC7d1EnWKcMU3MBNA==
=SvsZ
-----END PGP SIGNATURE-----

--YvRvFodUNf3nRSgnK9VvTAA07ofwB48Cl--
