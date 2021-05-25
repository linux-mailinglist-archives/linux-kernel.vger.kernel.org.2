Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB54D38F9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 06:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhEYEtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 00:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhEYEtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 00:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B65C613BF;
        Tue, 25 May 2021 04:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621918097;
        bh=QUu5tfKQVM3Gw3sTzewlGAGgi5EaPocb4PRcBWNXEaA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=YH3atK/LXf/NOA5WEyNXtN7KtGkdkN1fesS2mF5gh0Z8F/nd6yFarWDrwlY/GxXfT
         PVmVZoLBEJqDCXtbsyYGJaVBCbsvW8SPPoNgofqevehJolP60+vWkXj8FEuujgyosM
         ZBapf7DJp+tNDFSxymfp85wNNGreaach9sRRmaj7sNDMdI3HzgEksOdR5XItV67S/f
         IC89s0V5m5jT9328/E4AdLwIKyahUasU7BXKN1vUKe2foQZX5D9PUyNA2pLx7xx/Lh
         6Q3ExSGlSy1xdz+BVzbKY+dopP2esePUQLM0Fhib1UtfuDKkFr4idEQ8UhIrFhSK07
         OZsgIOcKoP9HQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4120827C0054;
        Tue, 25 May 2021 00:48:15 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Tue, 25 May 2021 00:48:15 -0400
X-ME-Sender: <xms:j4GsYF_4TJFtDSxRJTWNO7aq5v54qSEWnhaW3oItrNCcpR369Srq4Q>
    <xme:j4GsYJs2daboDA50GN0rQRpB9q2lB79XeDzfY75xybcP6ZwLpAP7z2ieeTHbNNvG-
    WWByjIdZxfjfHcnlBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdektddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:j4GsYDDaO-frouqpiQRku1E-WzaRBYcyNwM7DgCKuGH_OALYLg30pg>
    <xmx:j4GsYJdypkN7aXrgIr56UONhvOM_USpS5Cm-hyXwDSBh8TJ3_iyz9w>
    <xmx:j4GsYKM4SirqeoT7kQx3LxZkJj8TFK8VeeYGx8bHo1Zh3MAiKDlZ_A>
    <xmx:j4GsYLiuVUNCpb-gC6Um14SnfNfYON01-ga63TGnNwNjx90i5xEEwnFnDHhrogIS9vjICA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1360A51C005F; Tue, 25 May 2021 00:48:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <c6b08bd7-816f-4683-9f68-716634d1529e@www.fastmail.com>
In-Reply-To: <CAJvTdK=ZRFxh1=e0q7JbtNDfQWrS1d3TzrMHGiTg2Eaq1LsRSw@mail.gmail.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-25-chang.seok.bae@intel.com>
 <de9f67eb-2be7-8950-749e-cc8eef5cc142@kernel.org>
 <CAJvTdK=ZRFxh1=e0q7JbtNDfQWrS1d3TzrMHGiTg2Eaq1LsRSw@mail.gmail.com>
Date:   Mon, 24 May 2021 21:47:53 -0700
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
Subject: =?UTF-8?Q?Re:_[PATCH_v5_24/28]_x86/fpu/xstate:_Use_per-task_xstate_mask_?=
 =?UTF-8?Q?for_saving_xstate_in_signal_frame?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, May 24, 2021, at 11:06 AM, Len Brown wrote:
> On Sun, May 23, 2021 at 11:15 PM Andy Lutomirski <luto@kernel.org> wro=
te:
> >
> > If I'm reading this right, it means that tasks that have ever used A=
MX
> > get one format and tasks that haven't get another one.
>=20
> No.  The format of the XSTATE on the signal stack is uncompressed XSAV=
E
> format for both AMX and non-AMX tasks, both before and after this patc=
h.
> That is because XSAVE gets the format from XCR0.  It gets the fields
> to write from the run-time parameter.
>=20
> So the change here allows a non-AMX task to skip writing data (zeros)
> to the AMX region of its XSTATE buffer.

I misread the patch. I still think this patch is useless.

>=20
> The subsequent patch adds the further optimization of (manually) check=
ing
> for INIT state for an AMX-task and also skip writing data (zeros) in t=
hat case.
>=20
> We should have done this optimization for AVX-512, but instead we
> guaranteed writing zeros, which I think is a waste of both transfer ti=
me
> and cache footprint.

If no one depends on it, it=E2=80=99s not ABI.

