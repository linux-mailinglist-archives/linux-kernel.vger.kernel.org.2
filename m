Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDFC3ADC66
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 05:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhFTDPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 23:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhFTDPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 23:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D68360FEE;
        Sun, 20 Jun 2021 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624158821;
        bh=3OedRV0Jb4/bcaLZQGAhpxa0h+tij6pqKNPN145wFtg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=m3WsNOKtp4jzqtFNvkEnXwBWBKEaHq1iJpCoYAYuZw6FYV7bn3AV7q32UaFdZt9ju
         SwlQWZ4a+j2W0ax0wWjN6wqrxqKxt8YuF+DH7sgu5fZkfkvLa9xDqiXrZH6CCXAYEP
         qgAc/0v0I1wn244W/VeqOdSr3Yk246f84+NJ0lT1TJgcyg5g0EnhnpICv4jT0Ky4ce
         cyXl+vSi+FyOrARAh5V0ewmxYFOpJLM5mcM1CYHR5duAoYV3NpQcGIGp0WgMb1zWau
         ha2qnz17SVBOk3MXXgbCqdMBScID5M3ZjitD8ce4YcEWkY9kk5/cYiRD9n49+q4Z4f
         nGj65fzUAkm+A==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1EB8B27C0054;
        Sat, 19 Jun 2021 23:13:39 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Sat, 19 Jun 2021 23:13:39 -0400
X-ME-Sender: <xms:YbLOYCimAvyoy4uurVdUTa3BBg-RSz-BEADV38uBstDhCb5NnXP9aQ>
    <xme:YbLOYDDLPtOLOWAkGz1fbVMiPRQoyWIbCYA1bQRcaRPMBTm-RYB1q5MePIGEevyMB
    nQj_-kXpJpRMAaBXtc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeefiedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:YbLOYKH76UMLika4uwQ9IaDQR8vP2GFOzj4CaUAWbVmhYxxOcduGpA>
    <xmx:YbLOYLQ1Av4XTkjtmjDZFqWT7k_YkTmAouaKWOc4Uwl3I2NkzgRp_g>
    <xmx:YbLOYPxZZPnyssfsUtWqUYIGG9azrOCpnchyNH9ScdqbuvYF9WEiyw>
    <xmx:Y7LOYEpjxfFbIX8sfyS6wLZg7n7dG8HmlyunRTsTicW4tHvDuaUl4XkuQ6o>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 160A351C0060; Sat, 19 Jun 2021 23:13:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-526-gf020ecf851-fm-20210616.001-gf020ecf8
Mime-Version: 1.0
Message-Id: <444d7139-e47a-4831-93d0-8eb5b9680fdc@www.fastmail.com>
In-Reply-To: <87bl81h3ih.ffs@nanos.tec.linutronix.de>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
 <20210601065217.23540-2-jiangshanlai@gmail.com>
 <87bl81h3ih.ffs@nanos.tec.linutronix.de>
Date:   Sat, 19 Jun 2021 20:13:15 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Lai Jiangshan" <jiangshanlai@gmail.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc:     "Steven Rostedt" <rostedt@goodmis.org>,
        "Lai Jiangshan" <laijs@linux.alibaba.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Arvind Sankar" <nivedita@alum.mit.edu>
Subject: =?UTF-8?Q?Re:_[RFC_PATCH_1/4]_x86/entry/nmi:_Switch_to_the_entry_stack_b?=
 =?UTF-8?Q?efore_switching_to_the_thread_stack?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Jun 19, 2021, at 3:51 PM, Thomas Gleixner wrote:
> On Tue, Jun 01 2021 at 14:52, Lai Jiangshan wrote:
> > From: Lai Jiangshan <laijs@linux.alibaba.com>
> >
> > Current kernel has no code to enforce data breakpoint not on the thr=
ead
> > stack.  If there is any data breakpoint on the top area of the threa=
d
> > stack, there might be problem.
>=20
> And because the kernel does not prevent data breakpoints on the thread=

> stack we need to do more complicated things in the already horrible
> entry code instead of just doing the obvious and preventing data
> breakpoints on the thread stack?

Preventing breakpoints on the thread stack is a bit messy: it=E2=80=99s =
possible for a breakpoint to be set before the address in question is al=
located for the thread stack.

None of this is NMI-specific. #DB itself has the same problem.  We could=
 plausibly solve it differently by disarming breakpoints in the entry as=
m before switching stacks. I=E2=80=99m not sure how much I like that app=
roach.

>=20
> Confused.
>=20
> Thanks,
>=20
>         tglx
>=20
