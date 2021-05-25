Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1286538F8F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhEYDqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhEYDq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D53E9613D8;
        Tue, 25 May 2021 03:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621914299;
        bh=mphs2ytqcaHWAzF+Z5cAO+igIUR6zVq+Gj6ZgDHXbyk=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=FMVQiLP89zhd7WorJ7dURG4wUklGOjVyxBQ3q5XAv6wcavwjImwOTbcv5CSVUsSBE
         DY/xuHgVe/5yNp2w4aKLQa43agS3G6nvkRhbykojEthvZhUBCNZCn3wyKNY+TdmL7h
         EWVY0CbR5dDc3xrtknVpD8ciJWOalxuve+mX6aYKylGKyHMQQYxDRglyK+/+Rol4B8
         Kjt2/yu1oVcKg+5O8TU0zvlRyCqig9+Cuj40LdAu9WQmN1pwphgh/47SeaIT2M6Ucx
         uTnbWjf+fEuanLxS4vULhZq7bQ5Hc0LLoRBA7dp32RRsDdkmfBxdLrZpUm+0POgrPJ
         M6kdenIq2cJTA==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id E1BAA27C0054;
        Mon, 24 May 2021 23:44:57 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Mon, 24 May 2021 23:44:57 -0400
X-ME-Sender: <xms:uXKsYOB1FycFuGVqETdcmmkl9yZwiRmcLG-hKS1Uc5aPbuyx67A9vA>
    <xme:uXKsYIiMWuvaE9NomRslsGDIlPFtLszqucybvac9BcUIUVT4CaUl73vQ5nIAVSS5Q
    pbLjtkPDs6iHqfe-9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdektddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:uXKsYBlekASv_91zq6PL0Mg8TtGbXcfF-y4wF45EarL44SBqf5MEBw>
    <xmx:uXKsYMzy8Vfnz2BC30lqAnS4xbTwKoP96su4D7a-Thpb3wVOHQ1TfQ>
    <xmx:uXKsYDRte8qx8uWj9HAHr3OCGfPIzkftAsK0CSC4w4NTUKTtbId_bw>
    <xmx:uXKsYOH-ZoTpKcKe3zpBsxMd68VFHrayU1PtU9mYWygL-w4X99vO_CQSC0f0kaZvjK6c1Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E882951C0060; Mon, 24 May 2021 23:44:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <861e2ac3-b56b-4879-9a78-e20bac4906f1@www.fastmail.com>
In-Reply-To: <CAJvTdKkTSv7zc2eT1Ni6+k=V_faCCWmMo5oNunQQt-P7FkON-Q@mail.gmail.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-22-chang.seok.bae@intel.com>
 <8c8d91ae-5a3b-9523-725d-134840102df7@kernel.org>
 <CAJvTdKnU6g2H-R67G8LCs4cs0_NqnOzoKbC3J+iNGayFE5RGMQ@mail.gmail.com>
 <5a645958-10ab-46e7-9650-e5746a8d2276@www.fastmail.com>
 <CAJvTdKkTSv7zc2eT1Ni6+k=V_faCCWmMo5oNunQQt-P7FkON-Q@mail.gmail.com>
Date:   Mon, 24 May 2021 20:44:36 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Len Brown" <lenb@kernel.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Borislav Petkov" <bp@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 21/28] x86/fpu/amx: Initialize child's AMX state
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, May 24, 2021, at 11:21 AM, Len Brown wrote:
> On Mon, May 24, 2021 at 2:14 PM Andy Lutomirski <luto@kernel.org> wrot=
e:
>=20
> > What does VOLATILE mean in this context?
>=20
> Volatile means caller-saved.

Just like every other extended math register except some XMMs on Windows=
. (Thanks you so, so much, Microsoft, for screwing this up, and thank yo=
u Intel for indulging Microsoft.)

>=20
> Volatile registers can not be used for globals, static, or for
> parameter passing.
>=20
> ie. By the time the callee is running, they must be assumed to be inva=
lid.

Callees can=E2=80=99t assume anything about any of the registers unless =
explicitly specified. TILE is no different from RBP or XMM in this regar=
d.

>=20
> This means that any routine, including the target of a system call,
> such as fork/clone, can't assume that any data exists in these
> registers.
>=20

If we actually believe this, then we should clear xmm, ymm, zmm, etc on =
every system call.  Barring that, let=E2=80=99s come up with reasonable =
semantics, document it, and implement it.
