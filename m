Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475D431D569
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 07:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhBQGkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:40:13 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:57732 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbhBQGkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:40:00 -0500
Received: from antares.kleine-koenig.org (localhost [127.0.0.1])
        by antares.kleine-koenig.org (Postfix) with ESMTP id B7D5FB03DF5;
        Wed, 17 Feb 2021 07:39:14 +0100 (CET)
Received: from antares.kleine-koenig.org ([94.130.110.236])
        by antares.kleine-koenig.org (antares.kleine-koenig.org [94.130.110.236]) (amavisd-new, port 10024)
        with ESMTP id S8ReJb4Xkcck; Wed, 17 Feb 2021 07:39:13 +0100 (CET)
Received: from taurus.defre.kleine-koenig.org (unknown [IPv6:2a02:8071:b5ad:2000:7867:997:4a55:eb43])
        by antares.kleine-koenig.org (Postfix) with ESMTPSA;
        Wed, 17 Feb 2021 07:39:13 +0100 (CET)
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
 <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
 <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
From:   =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
Message-ID: <d1891be1-9345-9d2b-edcc-2a5ce2ac9360@kleine-koenig.org>
Date:   Wed, 17 Feb 2021 07:39:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn
Content-Type: multipart/mixed; boundary="hBBVWP2Xum3ONlVJRDp4uyuSeD8Sa6qHy";
 protected-headers="v1"
From: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang
 <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <d1891be1-9345-9d2b-edcc-2a5ce2ac9360@kleine-koenig.org>
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
 <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
 <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>
In-Reply-To: <CAPcyv4jq_8as=qUL8LJnNcM2UsrqEJqjc7+EHjs8XwuWCVZKPw@mail.gmail.com>

--hBBVWP2Xum3ONlVJRDp4uyuSeD8Sa6qHy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hello Dan,

On 2/17/21 4:55 AM, Dan Williams wrote:
>> One small comment on patch5, otherwise looks good.
>=20
> I take it back, patch5 looks good. I was going to ask about the return
> value removal for dax_bus_remove(), but that would need struct
> bus_type to change prototypes.

Changing struct bus_type::remove to return void is the eventual plan. To =

make this a pretty and easily reviewable patch I currently go through=20
all buses and make sure that for the prototype change I only have to do=20
one s/int/void/ and drop a "return 0" per bus.

> All merged to the nvdimm tree.

Great, thanks
Uwe


--hBBVWP2Xum3ONlVJRDp4uyuSeD8Sa6qHy--

--NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAsugYACgkQwfwUeK3K
7Anipwf+MQUO3Q+0QPOYdHW2iyztwa/+y2PBB7JgXTg7BWm3X0WiJ7B2ZUj9NKSx
2Z1oyu79E1w/mNFeXeVKJ/9HGEsClUCaag1AA2om/gKvSJmVFU48N4STJAZ5LAX/
tL6lLx4HDn1/mLXgIhsk3bdLQg959Q2BaBYmXFA/DOM+wRRYrnzI734WS/Vwst4b
50SijYxZSheaEJWVOT9cpK35C2qMifgs8dB9MyC2LmmD5P1rGL0BtztcmQSC3KSh
U5AvMnCnS9F+PAHWIbiAJKZxevIxDuOAMv7TyV7S2AY+KGW5wQS2isMHy8KhFRYm
1x8qvSbWvETF2H/4rzKM3s9yWg1S5w==
=lL31
-----END PGP SIGNATURE-----

--NVYrnRlgCQ2dWcNf6WA1OxAcEomB67SXn--
