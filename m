Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C8C38F9AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhEYEsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:48:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhEYEsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:48:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E9E7613D5;
        Tue, 25 May 2021 04:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621918001;
        bh=vLP/Q4aOCG6Oa2I3J7oehXSVI9Mwkn7//OK8ywyD2Bs=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=XEPkzxoJikXui97PMGR9Aw1unUKQqv6v/gZqzMuJXRw4jtreuyaxa2FzxRPm6eFoh
         +CFmaS1SvoDjoFNLp+H29vzS6Q1Y0ztH8Ya0ZN0pNFUQg/nknolS16m4VhTRiVyQuX
         aI3hSdVwolsNOic0zndbcHd81P4OUfSZHSilSj43IY+raAYVg2fs0cUTnUWEKl0BH+
         QijOjFPeGfpLHgxi+XhmeZzkYmQ4hRvJDPj3/sznaw/BiWKEvsaWSwl+91aVNORYJc
         tCouH5JpA7CoWrLrdSgXRRTMlemt9fvPRwj4Gr/9c4RYCyrWVtjh6QeGZxdHSGiqC3
         vqFLlpZRjSUJQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4E0C427C0054;
        Tue, 25 May 2021 00:46:39 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Tue, 25 May 2021 00:46:39 -0400
X-ME-Sender: <xms:LoGsYLQnu7O0WoTqUnRqIpVa56ptki84jbHgLFjDn8Jyp81FACVL4A>
    <xme:LoGsYMy7QabiXMgx5rz508EcJMS4eXerA7NCQ6EaeFEMR-c_531U-z4bz0ZKBJn5k
    wyqPU-9GrByuB2wtGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdektddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:LoGsYA2WJtgvUDzzy-M0kextGMrXPFYjW5uB5E-ulgR9j0sLr3H8TQ>
    <xmx:LoGsYLD9HJLZ04cqQV5YXpHOhM3bdWwo_IQVcNydecOPuSDnmg-mjA>
    <xmx:LoGsYEjox_zOHbne5AsTVbE-hiUriP84FpkPY_T5jsrL5CwQf4HD9Q>
    <xmx:L4GsYNUbi0SBAPc0YVGNRFskbZWX7goP6yUB3LqV-kE9FluPzrtdTX2VJorwXHZ2bjNQpA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B9E2651C0060; Tue, 25 May 2021 00:46:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <ef151c13-1126-43b1-ab55-4bd86fa4c2c0@www.fastmail.com>
In-Reply-To: <CAJvTdKmq2qKgkkbeQzQ6dG14+EWZ_eTbz6c6neGLFo_X=PCJeg@mail.gmail.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-26-chang.seok.bae@intel.com>
 <6197fd94-76a9-a391-f290-7001a71add7f@kernel.org>
 <CAJvTdKmq2qKgkkbeQzQ6dG14+EWZ_eTbz6c6neGLFo_X=PCJeg@mail.gmail.com>
Date:   Mon, 24 May 2021 21:46:06 -0700
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
Subject: =?UTF-8?Q?Re:_[PATCH_v5_25/28]_x86/fpu/xstate:_Skip_writing_zeros_to_sig?=
 =?UTF-8?Q?nal_frame_for_dynamic_user_states_if_in_INIT-state?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, May 24, 2021, at 11:15 AM, Len Brown wrote:
> On Sun, May 23, 2021 at 11:28 PM Andy Lutomirski <luto@kernel.org> wro=
te:
>=20
> > But what happens if we don't have the XGETBV1 feature?  Are we makin=
g
> > AMX support depend on XGETBV1?
>=20
> Yes, AMX systems always have XGETBV.
>=20
> > How does this patch interact with "[PATCH v5 24/28] x86/fpu/xstate: =
Use
> > per-task xstate mask for saving xstate in signal frame"?  They seem =
to
> > be try to do something similar but not quite the same, and they seem=
 to
> > be patching the same function.  The result seems odd.
>=20
> The previous patch allowed non-AMX tasks to skip writing 8KB of zeros
> to their signal stack.  This patch builds on that to allow an AMX-task=

> in INIT to also skip writing 8KB of zeros to its signal stack.

If we ever have a task that is =E2=80=9Cnon-AMX=E2=80=9D but has non-INI=
T AMX, then either we or the hardware has seriously screwed up.

So the logic boils down to: if (a) optimize; if (b) optimize; where a im=
plies b.  I maintain my objection =E2=80=94 I think this is redundant.

>=20
> > Finally, isn't part of the point that we need to avoid even *allocat=
ing*
> > space for non-AMX-using tasks?  That would require writing out the
> > compacted format and/or fiddling with XCR0.
>=20
> The current signal stack ABI is that the user receives all
> architectural state in
> uncompressed XTATE format on the signal stack.  They can XRESTOR it
> and the right thing happens.
>=20
> We can optimize the data transfer (and we have), but we can't optimize=
 the space
> without changing that ABI.

We are between a rock and a hard place here.  On the one hand, our ABI (=
supposedly =E2=80=94 no one seems to have really confirmed this) has the=
 signal frame in uncompacted form.  On the other hand, our ABI most defi=
nitely has signal frames under 2kB by a decent amount.

I think we should apply a simple patch to Linux to add a boot parameter =
x86_extra_signal_space=3D8192 that will pad the signal frame by 8192 byt=
es.  And then we ask people to seriously test their workloads with that =
parameter set. If things break, then AMX in its current proposed form ma=
y be off the table.

At least my dynamic XCR0 proposal has the property that legacy programs =
and AMX can reliably coexist on the same system.
