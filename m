Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6213F0FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhHSBWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234194AbhHSBWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FA1B610A3;
        Thu, 19 Aug 2021 01:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629336094;
        bh=wBgjHFxyA4Pd8pp/qIHRyLPoFmDr6Rc/KbRLNOpkl/U=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=DkFNrZcclcjm6iUsqX7i4UwHNWbHGs2mVfGzhEXAQdlchLkU8TiJpWpjgyBxl5eJ7
         DLgMXIP96Agi6VX+e6baVFg41gKoAV5WMj7kHcupb2rYSAEr16BApd5luoYguVhHAk
         Hng6YPOqbtlznS/9I2IUddaWaI4YDkdcqdY7pF1l3xEzo2JdWoySMpaJvl/nIri95z
         ZFAFAJGnTyBf+8/VW0zvUYX+SzpNnjFq8kgugIlDG4x1Cf4aXzL7CPnl5+6qMXPUsh
         jJGmUZ/fiheaxLvzMaLtRhrxjYCG/7bphGun6XnO3wG5sWLsyl5mbMinj12pkZgt8m
         hxUT/kjm7shwQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 36BFB27C0054;
        Wed, 18 Aug 2021 21:21:33 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Wed, 18 Aug 2021 21:21:33 -0400
X-ME-Sender: <xms:G7IdYTYIAXZigBjmmmafVEmCeEImg0OHBZwwN-OlqUbMPsmlhzflYw>
    <xme:G7IdYSYfj9kT2wtfPsx_m-lD0stbmI5TCEJNYOk9VYMiMWXAsvusn6K98SaO66eo3
    E3YCkIq5KMW8Nw58Zo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieevieeu
    feevuedvteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:G7IdYV-_VNpQcmJiG9-TMpAHXiOvX-C--rOvee5D762gAJ44lxhzpA>
    <xmx:G7IdYZpBfCx8uDQwbTRaYbWxGg3vPePQN5W6iyNlN5RsA7OqjnIPEQ>
    <xmx:G7IdYeoOFNYtdRT0KhpgSIQjTYmKV1CHtW3U5hASle5tWjBhtODcmw>
    <xmx:HbIdYac9vqe8oxEErgYA555A66TPU7MjHLD65Ix05qNcxaHx_IVGgI80k1c>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C75EAA038A7; Wed, 18 Aug 2021 21:21:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <ea7eddc4-decd-47b7-b98b-c04c441495d9@www.fastmail.com>
In-Reply-To: <3399412.qF98CnctbS@tjmaciei-mobl5>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <YR1HYRRN0HMTxXrw@zn.tnic> <BCC327C2-CF9F-4910-B626-315E515E9A3A@intel.com>
 <3399412.qF98CnctbS@tjmaciei-mobl5>
Date:   Wed, 18 Aug 2021 18:21:11 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thiago Macieira" <thiago.macieira@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_v9_12/26]_x86/fpu/xstate:_Use_feature_disable_(XFD)?=
 =?UTF-8?Q?_to_protect_dynamic_user_state?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 18, 2021, at 2:04 PM, Thiago Macieira wrote:
> On Wednesday, 18 August 2021 13:43:50 PDT Bae, Chang Seok wrote:
> > > Then our API needs improving. An app should be able to ask the ker=
nel
> > > "Do you support AMX?" get a proper answer and act accordingly.
> >=20
> > Maybe I=E2=80=99m missing something, but I wonder what=E2=80=99s the=
 difference from
> > reading  XCR0.
>=20
> That assumes the kernel will always enable the bits in XCR0, like it i=
s doing=20
> today and with your patch, because modifying it is a VM exit.
>=20
> But it's not the only possible solution. A future kernel could decide =
to leave=20
> some bits off and only enable upon request. That's how macOS/Darwin do=
es its=20
> AVX512 support.

The fact that Darwin does this strongly suggests that real programs can =
handle it, which increases my inclination for Linux to do the same thing.

>=20
> --=20
> Thiago Macieira - thiago.macieira (AT) intel.com
>   Software Architect - Intel DPG Cloud Engineering
>=20
>=20
>=20
>=20
