Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E146A4121A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357911AbhITSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356537AbhITSAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:00:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3893163226;
        Mon, 20 Sep 2021 17:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632158143;
        bh=VpPzOJ7JSFlZQX/49uPHcsjQmopp1WZE5YIOCxxbMeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LdBkN/ip4evGKFmWVmkES7ccjO28sPqQqrRpDnQHnYSCGOeK9JJp0HB0Q1OPAvyOx
         uFiZCzeg2tOzQbnKGwG2RX4yM1px21dn7Uoc1q/uBl9p+w3bTMbQhqgI5xkyz1Wiwg
         CZsRFmuMmRhpC++wHGj5WmPz7+XyKIoqm1zo0ZqTCcwMBO9FvtD6mz0OGikeSWvZ3u
         HBitj89SxWswO1aTRMWOENjdmmYn6l6v6C2vB8yzG+JE14NxEydV95p1iRgVR92+F4
         jPTyHe/LP9jOj4cU8DX+LphXSp3HzJiL2osNOmqG+HSR/qnnYI3KCUYu4XIAZtfwiR
         71kgS+M5zgkRw==
Date:   Mon, 20 Sep 2021 18:15:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Laura Abbott <laura@labbott.name>, Dave Hansen <dave@sr71.net>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>, ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Tech-board-discuss] IMPORTANT: CIVS opt-in for Technical
 Advisory Board voting
Message-ID: <20210920171500.GN4192@sirena.org.uk>
References: <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
 <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
 <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
 <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name>
 <20210920162329.GJ4192@sirena.org.uk>
 <5c88ae67-df7b-60ab-d087-bd244753c98f@labbott.name>
 <20210920164837.GK4192@sirena.org.uk>
 <ebcaac1d-9b97-81d9-28eb-eeb51c51673f@labbott.name>
 <20210920165716.GL4192@sirena.org.uk>
 <CAMuHMdVOEDLPRNi7YEV0foz5CRTq_7BHKiQCQY2JjkH7-=ZE9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVOEDLPRNi7YEV0foz5CRTq_7BHKiQCQY2JjkH7-=ZE9Q@mail.gmail.com>
X-Cookie: diplomacy, n:
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 20, 2021 at 07:11:26PM +0200, Geert Uytterhoeven wrote:

> Do you get the list when following the configuration URL at the
> bottom of the activation code email?

I tried that already (it's linked on their site) but it doesn't list
anything - you can deactivate and reactivate your mail which I tried but
at no point in that process does it show open polls that I noticed.

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFIwZMACgkQJNaLcl1U
h9AOwQf/dBAJaJ9CNa2gi9h2MeFjUl3ZtGiacpNWdpQBe9OD/yjRLvvLsgmGrmBy
SaI8HVzlfOVNN4AimKS5Q7piwf9fcH7Fj4VRREza6HIDsPkbCiZoSGhuutmFXRCy
gjeFEWYENjB/MdK5a+KgopGe1LdEXI1BEMEAlwQlaS9ZC7fCj7ZcQFF34oQor+LI
LD/SljWqLFNW9nl63o2VqlN0GZGaFaSLteYDtXIaGzdscV7v/35QZxpH7/pZcyUl
MQFTfleGhH2FHuPZIX1bGmWgGkjpDNOwjwvuU6m48V9khu5/RSl1m1SQ8lbl09sn
NVgPQiLVan+nB3VSoaHjfA4uQlYrpg==
=UQ3l
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--
