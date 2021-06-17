Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1133AB550
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhFQODA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhFQOC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6883461241;
        Thu, 17 Jun 2021 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623938451;
        bh=Qld/pseRm0yfQ9yP2fU9GzvjQttVMbVMBgNd/24GmDw=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=T+f1Xp9tPYO3P+sYRvf+JXHpLZFTHGqXHDBQf5CnhnRXqaGVvFvsXOYTXF6+f7tPE
         mDzU39pXPO+nFKpDRpiu3Pge2Vto+9Vy1maAXnGqYAARJLgc6K4i5mSKTMNPwEAwIT
         3gAq4cZFDHECozCVWkYKkPYX3jlOuFjwlxkGllmVOWojRzr2QU1l2AVek3RxFaJsG5
         WVZBguBmrxBUKuVAz68m5N6tt/IEAiMsuIQFecLDD+s3iBkptE9XZACmrJLuPBLMge
         J4YiAHrIMyi+sUNqaTZkxsr6+8FYZBhq0N7bzKFLGhZ3B8O6jAfqYV6UrdTEGCNSts
         yY765r+FCchZw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7F8A227C0060;
        Thu, 17 Jun 2021 10:00:49 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Thu, 17 Jun 2021 10:00:49 -0400
X-ME-Sender: <xms:j1XLYIuq5A7mDHVgBGi8PVlzU0LEjDif4qXfh-E1BgfWPVOVOJQSkw>
    <xme:j1XLYFebr9LyFQsuJPB5kRHFjKJfJf_Km11tUaR-b6yhpVNuxqtRiVDlwi6zUjNth
    uMQ-SVrNwMTsv0UCwk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefuddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:j1XLYDym6Rc4o48KalyRsHBFsKzH7z-fiFyOoII0RUgFdvm8ggW2MQ>
    <xmx:j1XLYLMbCaZVxsaZLeu5zdrh2Gw0HodXyibv28DRiAl3Q--CfzMUZA>
    <xmx:j1XLYI9hC-By65EW7D_gup0ArReKUpqDmcdcv2RyYT6-krxnk4nE0Q>
    <xmx:kVXLYMSVfvDy4ND4pBPFSf0n_hO92uNNpRNoN2q1n4nN47K8QKVyELd5NPIlG4fS>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A3BEC51C0061; Thu, 17 Jun 2021 10:00:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <33241b25-4d45-4278-a4e6-ec9c12b0e1f3@www.fastmail.com>
In-Reply-To: <20210617135133.GA86101@C02TD0UTHF1T.local>
References: <cover.1623813516.git.luto@kernel.org>
 <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <20210617103524.GA82133@C02TD0UTHF1T.local>
 <20210617112305.GK22278@shell.armlinux.org.uk>
 <20210617113349.GB82133@C02TD0UTHF1T.local>
 <394219d4-36a6-4e7f-a03c-8590551b099a@www.fastmail.com>
 <20210617135133.GA86101@C02TD0UTHF1T.local>
Date:   Thu, 17 Jun 2021 07:00:26 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Mark Rutland" <mark.rutland@arm.com>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
        "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jun 17, 2021, at 6:51 AM, Mark Rutland wrote:
> On Thu, Jun 17, 2021 at 06:41:41AM -0700, Andy Lutomirski wrote:

> > In any event, I=E2=80=99m even more convinced that no new SYNC_CORE =
arches
> > should be added. We need a new API that just does the right thing.=20=

>=20
> My intuition is the other way around, and that this is a gnereally
> useful thing for architectures that require context synchronization.

Except that you can't use it in a generic way.  You have to know the spe=
cific rules for your arch.

>=20
> It's not clear to me what "the right thing" would mean specifically, a=
nd
> on architectures with userspace cache maintenance JITs can usually do
> the most optimal maintenance, and only need help for the context
> synchronization.
>=20

This I simply don't believe -- I doubt that any sane architecture really=
 works like this.  I wrote an email about it to Intel that apparently ge=
nerated internal discussion but no results.  Consider:

mmap(some shared library, some previously unmapped address);

this does no heavyweight synchronization, at least on x86.  There is no =
"serializing" instruction in the fast path, and it *works* despite anyth=
ing the SDM may or may not say.

We can and, IMO, should develop a sane way for user programs to install =
instructions into VMAs, for security-conscious software to verify them (=
by splitting the read and write sides?), and for their consumers to exec=
ute them, without knowing any arch details.  And I think this can be don=
e with no IPIs except for possible TLB flushing when needed, at least on=
 most architectures.  It would require a nontrivial amount of design wor=
k, and it would not resemble sys_cacheflush() or SYNC_CORE.

--Andy
