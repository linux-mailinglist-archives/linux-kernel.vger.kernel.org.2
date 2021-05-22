Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38E638D74D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhEVT45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhEVT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 15:56:56 -0400
X-Greylist: delayed 28899 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 May 2021 12:55:30 PDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 12:55:30 -0700 (PDT)
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id CCB4ABA789D;
        Sat, 22 May 2021 21:55:28 +0200 (CEST)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id xaTtz1sJs7kk; Sat, 22 May 2021 21:55:27 +0200 (CEST)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5c8:7bfc:b828:46e:de5f:e6a8])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Sat, 22 May 2021 21:55:27 +0200 (CEST)
Subject: Re: [PATCH v2] comedi: Make ni_mio_common a standalone module
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210522115345.821578-1-uwe@kleine-koenig.org>
 <6a09f2b6-afda-a901-abe6-1b45d51988e8@mev.co.uk>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <214467c2-b8ae-2da0-3866-64c660151582@kleine-koenig.org>
Date:   Sat, 22 May 2021 21:55:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <6a09f2b6-afda-a901-abe6-1b45d51988e8@mev.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HpWyFDNO4RBtma2Jl1zm0kM9RbiR0cwtt"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HpWyFDNO4RBtma2Jl1zm0kM9RbiR0cwtt
Content-Type: multipart/mixed; boundary="mQCUIkMCDA4MXdE5oGQdQRJ5vzfjp9WHo";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <214467c2-b8ae-2da0-3866-64c660151582@kleine-koenig.org>
Subject: Re: [PATCH v2] comedi: Make ni_mio_common a standalone module
References: <20210522115345.821578-1-uwe@kleine-koenig.org>
 <6a09f2b6-afda-a901-abe6-1b45d51988e8@mev.co.uk>
In-Reply-To: <6a09f2b6-afda-a901-abe6-1b45d51988e8@mev.co.uk>

--mQCUIkMCDA4MXdE5oGQdQRJ5vzfjp9WHo
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Ian,

On 5/22/21 7:54 PM, Ian Abbott wrote:
> It's not as simple as that.=C2=A0 "ni_mio_common.c" contains condional =
code=20
> that depends on whether the PCIDMA macro is defined or not before it is=20

> included.=C2=A0 "ni_pcimio.c" defines the PCIDMA macro but "ni_atmio.c"=20
and=20
> "ni_mio_cs.c" do not.

Uuah, indeed. I took a quick look and resolving that isn't trivial or=20
pretty.

I'll give up on this front.

Best regards
Uwe


--mQCUIkMCDA4MXdE5oGQdQRJ5vzfjp9WHo--

--HpWyFDNO4RBtma2Jl1zm0kM9RbiR0cwtt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCpYaoACgkQwfwUeK3K
7AkysQf9Ftq/9SVmQuEZ6u51hXmgU2QVEEdM74VArCkuF6bYUUH5TPOcgpbsOvTC
dOsBswVxVarl77rr0pyCpQvyeUS/D8iVfX/2QbTJ0Ca8lcK4JDgzmSxjcbvuw/Ul
1VoqqD+Gg2YWtB7iBpmPnCynYcNwUw1qtPnpgcrznAJSKIJjvRzOdjPt3RGeKvAS
gd55ANotjaugRNA6lu4UJcF2LvZ9kUGpkLzke3zhTmCBDT6JEt1788RWL6oOUJ4V
gvEskgffUtymv2UDF02M4Gs5/+DZj7eS6VrRsuzmuOOXCk+AipySTWp6g/edjQP5
kpiEmKzfrAxcA8y8Mte7Vurm9hLOdQ==
=Za4s
-----END PGP SIGNATURE-----

--HpWyFDNO4RBtma2Jl1zm0kM9RbiR0cwtt--
