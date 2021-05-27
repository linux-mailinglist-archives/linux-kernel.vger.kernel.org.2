Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA339365E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbhE0Th5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbhE0Thz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:37:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECB5D6124B;
        Thu, 27 May 2021 19:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622144181;
        bh=Xxt9QGo1nGRoPNpblLkxpQ64bQKNgD6MpGDI7Dhtkmo=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=R6an6CHqihH1IX2xl324s9B6Nfzu3T697miFBBSxzSIp/jwiizmprOTynWptF3uGC
         ZtvLb07uPWqCU69PAw+7W72OKzOR9TuTQSMPjd8w87uNnCvfbkJytLYmtiie8F4Z05
         VZLhXxPsf3C57bjdEMGHZ+o9dycFl3tPQtvbPFFmnjJBpC/5B1K6SxxSA2Gk9YjF15
         1z/lCI+aQ45k/jsjXYhDWmUk9tR++2MPwvM2Tr2i22Kt1SrPDgO19ssr6RZcE9GCmo
         YdpP8NvobCuGuQebQvG+FwvWMnH7knjVrfM4p8/wnuXNIowggcrRf4HsLCzkeYWd8I
         TUa+CIMgHDV1g==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 01D9927C0054;
        Thu, 27 May 2021 15:36:19 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 27 May 2021 15:36:20 -0400
X-ME-Sender: <xms:svSvYASfb1yUZxwZ0aWTLZa_g7ob89-NbCOl6wcLkas5RYysYj3EGA>
    <xme:svSvYNxoCvwEQHKFOVIcx61tQeTA_MSP8NoWh4TtQRS4dSckGI1mCGlKTn_Np0Wmi
    L6vY1d2rQ0zkLXUDsI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekhedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:svSvYN2l1BQqTRA-msGhUrGHhyoIObLuF1RT2SYxkwuxPLsN9Cf0RA>
    <xmx:svSvYECZLr4AJmwofvEHJftXpSqFie3b4WBjLawF7tpcFAg0izyf1g>
    <xmx:svSvYJiEyto0TbFEPO6jOgqUfamERVcMwA8gyWTZEdi4oHN2N9m1AQ>
    <xmx:s_SvYKW_HDOncQqn4Pc-OWnDJqZ6QbdKJ6Gmz6z5gBX5DAkXT9OrR7-5Z2v8hesy>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C97EA51C0060; Thu, 27 May 2021 15:36:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-468-gdb53729b73-fm-20210517.001-gdb53729b
Mime-Version: 1.0
Message-Id: <9a83ea72-7651-477e-b553-43ae12926ef6@www.fastmail.com>
In-Reply-To: <CAJvTdK=Z5LMU9ehFH2NVFCP7LLEvaTtywfuZHdwRb9-7hvE8KA@mail.gmail.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-16-chang.seok.bae@intel.com>
 <CAJvTdKnrFSS0fvhNz5mb9v8epEVtphUesEUV0hhNErMBK5HNHQ@mail.gmail.com>
 <CAJvTdKmzN0VMyH8VU_fdzn2UZqmR=_aNrJW01a65BhyLm6YRPg@mail.gmail.com>
 <YK9/Gu2Bse0Mc0F3@zn.tnic>
 <CAJvTdK=Z5LMU9ehFH2NVFCP7LLEvaTtywfuZHdwRb9-7hvE8KA@mail.gmail.com>
Date:   Thu, 27 May 2021 12:35:58 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Len Brown" <lenb@kernel.org>, "Borislav Petkov" <bp@alien8.de>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: second, sync-alloc syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, May 27, 2021, at 6:59 AM, Len Brown wrote:
> On Thu, May 27, 2021 at 7:14 AM Borislav Petkov <bp@alien8.de> wrote:
>=20
> > So if this second syscall doesn't sound really great, I'd say we sti=
ck
> > to the #NM-based allocation and keep this one in the bag for now and=

> > take it out only if it turns out that it makes sense as a use case.
>=20
> I agree.  Simple to add if later, if something requires it --
> though given it's modest incremental value, currently hard to justify.=

>=20
> > As tglx said: it is easy to add stuff later. It is a lot harder - ev=
en
> > impossible - to remove already present machinery.

Also, in case you haven=E2=80=99t been watching the other thread, this w=
hole thing needs to wait until the existing code gets cleaned up.   The =
current signal code is a disaster.

>=20
> Indeed.
>=20
> thanks!
> Len Brown, Intel Open Source Technology Center
>=20
