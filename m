Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC8315C19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbhBJBV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:21:26 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35079 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234549AbhBIWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:54:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3064A580300;
        Tue,  9 Feb 2021 17:53:18 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 09 Feb 2021 17:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm2; bh=l5ys1
        Jo3tRmxlqloV0+pZ+k003qctrDL4OIi/ivkIUc=; b=txwXJv1Nqu7I7o55O4t6m
        zVxM6DmcyEsn66BNao0xVkEXsw6gbC3R4UB8ptjGPsW1srVVLjEQTQjk2ZV506y9
        W/JYanEiKGj2R/QW8L+rvkEyPiABuLtCo0a7khxJIMyNV7YimYb5wNWqBYepZu7k
        v2+pfwNjtqdf4vehN+KR6duc50eKA6UWce7UpcyozmMXcaDEOEM3PR/vrIfi7U+M
        zG6FZPWfGKKrDDVy5B36WCtNm0/dF0meI6qJP/Ry/5ohfTqjewbbjvkuOyiGt5Gf
        LXBKq+8f6+Z6lVkzuAwlCeGxOHHUciPLhNby4sZlFwLJDrOe+ooK0xToRYrRbYEL
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=l5ys1Jo3tRmxlqloV0+pZ+k003qctrDL4OIi/ivkI
        Uc=; b=TVw3Uu0wM1fQU7rzCNa+oaCySuPforuHDrHDc41T5EmSx0oIWMzqs8WhE
        GTI2MHiBraK6IDrqTxvoffWxlqHduvfR9QLgfpBgXrIOf8hlnLqBuktn/9vxcXNK
        1wfXbId6vV5WOS6FKmLZSQ+Wax+hlAkVz3owFIvYTcOk8O9/XYpJs9gwfdAr/uGE
        wXNfBje673VyJaRsfEtNz4yV6UOtd0V19sLWCkVnLXJa0Be6NF6LYRYPm4dwTCKV
        OdEDsX71OyeBCglqqk5m2E+bUrEtUprEkgCC8i9BnYlsh7rWLaiDx8h8Fv475g8T
        bPxCG8jpIEu7W87lLOcM5DbSG59UA==
X-ME-Sender: <xms:XBIjYAv2FSL9n4i2Nr68aHKOZoydQ4NbeU-0ONnJi0LZenGUTJg6EQ>
    <xme:XBIjYNfAgeKI24VS2gDw3XhueNSOhWUAAjFnZa5FPJD9ywy5rtMJ88cGbbFNCX9W6
    M-u2xpjzE7o7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheeigddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepnhhnvght
    uceonhhnvghtsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeeugeekvd
    ehheevheetieetudeljedvvddtieevvdeukeejgfeuheffueelueegueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnnhgvthesfhgrshhtmh
    grihhlrdhfmh
X-ME-Proxy: <xmx:XBIjYLydFDQBlbTqg485ALRSncGVF-1hd67fWE-v4kqGlLlXJuO18g>
    <xmx:XBIjYDN9sWj1yblCqT8ehRDvQxe07IdvaFkp9_3oxGpzelpCwnbkFw>
    <xmx:XBIjYA_lVesKWorggn5Mq89jXbDBvJgUk1SewEtI6NO6-XzTuEgkGg>
    <xmx:XhIjYEXRSTDVij0h7p8HRjG9x-pYMEIkLtl9oaMrbD0VcYRCi_7zAg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 87E12A0005E; Tue,  9 Feb 2021 17:53:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-93-gef6c4048e6-fm-20210128.002-gef6c4048
Mime-Version: 1.0
Message-Id: <93745280-dbe9-491c-a79d-c9c364b83880@www.fastmail.com>
In-Reply-To: <20210209224223.p22yhjdy7ibzepss@pali>
References: <d59ba191-43db-4b7b-b201-62a60ca752c0@www.fastmail.com>
 <20210209213330.hnc7op72zoj24mgz@pali>
 <7b0988cc-eeb8-4ea7-92f6-e8234ca910d3@www.fastmail.com>
 <20210209224223.p22yhjdy7ibzepss@pali>
Date:   Tue, 09 Feb 2021 14:52:56 -0800
From:   nnet <nnet@fastmail.fm>
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     a.heider@gmail.com, andrew@lunn.ch, gerald@gk2.net,
        gregory.clement@bootlin.com, kabel@kernel.org, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, luka.perkov@sartura.hr,
        miquel.raynal@bootlin.com, mturquette@baylibre.com,
        rmk+kernel@armlinux.org.uk, sboyd@kernel.org, tmn505@gmail.com,
        vladimir.vid@sartura.hr
Subject: =?UTF-8?Q?Re:_[PATCH_mvebu_v2_00/10]_Armada_37xx:_Fix_cpufreq_changing_b?=
 =?UTF-8?Q?ase_CPU_speed_to_800_MHz_from_1000_MHz?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021, at 2:42 PM, Pali Roh=C3=A1r wrote:
> On Tuesday 09 February 2021 13:45:08 nnet wrote:
> > On Tue, Feb 9, 2021, at 1:33 PM, Pali Roh=C3=A1r wrote:
> > > On Tuesday 09 February 2021 13:00:26 nnet wrote:
> > > > > If you have other Armada 3720 boards (Espressobin v5/v7, uDPU,=
 Devel Board, ...) then it will be nice to do an additional tests and ch=
eck if instability issues are finally fixed.
> > > >=20
> > > > These patches applied to the 5.4.96 in OpenWrt (98d61b5) work fi=
ne so far on an Espressobin v7 AFAICT per changing values in /sys/device=
s/system/cpu/cpufreq/policy0.
> > > >=20
> > > > Are these changes intended to work @1.2 GHz on the v7?
> > >=20
> > > Hello! Do you have 1.2 GHz A3720 SoC?
> >=20
> > Maybe (not)? ESPRESSObin_V7_1-0 on the underside.
>=20
> Look at the package of SoC chip. On top of the package is printed
> identifier 88F3720. On the last line should be one of the string:
> C080, C100, C120, I080, I100 which identifies frequency
> (080 =3D 800 MHz, 100 =3D 1 GHz, 120 =3D 1.2 GHz)
>=20
> Can you check what is printed on A3720 SoC package?

Both of mine are 88F3720-A0-C120.
