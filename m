Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D25B38F2C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 20:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhEXSPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 14:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233315AbhEXSPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 14:15:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB373600D1;
        Mon, 24 May 2021 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621880057;
        bh=dl/SKugcPgrb9nTzVK9VQWZdc9S8UJAdzjdTYp1wOFE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=g4I2SUQAhQVUQOJUbCLmr5m0US/MaDMng6KFWcqy2eupcVaOGP7Y1QSJZQvMGi23g
         MK5WPk2hmf1F0qxXAx7XH4ntn7t8hh6H9Xh3MCESFzIzYUJtokNPQnMnoQKdn5C0Pd
         lfCoNPhU124pDfGLDhyTKhtsZDxx9dzaA/F7bhQTbf551t9KD8tjgZ/KRsh9uHhD03
         r0C7Q0LDo4Y+VoKG4a50AF1QZqIpMUd52T6Fy1oKjpdD+JgZA3/WfDsY9Q24ZGouuA
         YyX0J/n2JnOr66oUm8UsaCb9xW3ZBN1oaMSyqqT2BCW/iMgbAgq1sbQbJ4UiPMoufQ
         kWCT01k0rBUZw==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id D914327C0054;
        Mon, 24 May 2021 14:14:15 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Mon, 24 May 2021 14:14:15 -0400
X-ME-Sender: <xms:9-yrYCA4bc6LS_O56lNWVbp_r6O3l0gUHg6hXcPVK5glK9F-OwlUzw>
    <xme:9-yrYMjBY8qXQwW1GArk8fZxZOohpZR_PXvpUBUJTBRdfBX0guLyjnEOUCfrYVY1z
    K2SFqciEAS90wc7htw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejledguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnheptdfhheettddvtedvtedugfeuuefhtddugedvleevleefvdetleff
    gfefvdekgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:9-yrYFmKU9iQaLaJr1nBAw7kjpdSfd_IEtJ5vxQ56DBJYal7Ggye8Q>
    <xmx:9-yrYAxKzSYsw07r_rIF5HGA7G2EbBe6pgBTZ9ssP8FDXEk9DcdzNA>
    <xmx:9-yrYHQTQ916RrjXBHCd5Aq2RRlVm6HUOjKgIzLbZvBOphQs-JnCEg>
    <xmx:9-yrYCG7TdwbXA7RNECBysYAGcm53H5_ddDyy7XylQXi04PjBOh_ipghEoUHV2ypMSUDbw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 30E0951C0060; Mon, 24 May 2021 14:14:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <5a645958-10ab-46e7-9650-e5746a8d2276@www.fastmail.com>
In-Reply-To: <CAJvTdKnU6g2H-R67G8LCs4cs0_NqnOzoKbC3J+iNGayFE5RGMQ@mail.gmail.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-22-chang.seok.bae@intel.com>
 <8c8d91ae-5a3b-9523-725d-134840102df7@kernel.org>
 <CAJvTdKnU6g2H-R67G8LCs4cs0_NqnOzoKbC3J+iNGayFE5RGMQ@mail.gmail.com>
Date:   Mon, 24 May 2021 11:13:53 -0700
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
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, May 24, 2021, at 10:37 AM, Len Brown wrote:
> On Sun, May 23, 2021 at 11:09 PM Andy Lutomirski <luto@kernel.org> wrote:
> 
> > If we're going to start having different states with different
> > behaviors, let's make them real defines.
> >
> > #define XFEATURE_MASK_CLEARED_ON_CLONE ...
> 
> Probably a good idea.
> 
> However, "cleared on clone" isn't the property.
> The property is that the state is treated as VOLATILE.
> 

What does VOLATILE mean in this context?
