Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1617944EE51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 22:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhKLVGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 16:06:54 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:52887 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235742AbhKLVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 16:06:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D495032006F5;
        Fri, 12 Nov 2021 16:04:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 Nov 2021 16:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8FPYXt
        YY8uMK6gqNCM+Tfz9ygESeiWIujQT9sQlrWCQ=; b=jjc6aydAZiU4si6xn1cHmj
        OV3/K2KFFqqZT9MosJWJAicnWvse2/7lciSG7tXTWtGXAVK1zYf1fdIkCfO71Qsg
        T8j7jqThjbgQiLNGs0pwk/8nZjfGKqKzq6Vz08S5oAPL+c+58cd16VucVQ9a/DdX
        p6XPNzfGniCErpx37tD6ChyTEwXncBiBYrH7o8rkDJU/3YOBhEPrPEfDRB822i6o
        lnleGV/LWc01GtFPMkjG5xYCkLYCteXnbOzmTtg5euOXNDcLCK5ixwSF7aCQtuyF
        tCgMwvC16brPiQg7cnwQ/o6/famn9pzJgwOWfy8UCXkC0kB/1ix4AEbWH3fzAFlA
        ==
X-ME-Sender: <xms:v9aOYVX94JxMj5_H_XJD6iyU9whVgFp9sf85c2QU825wJO9S8Du12A>
    <xme:v9aOYVlXuHf4PStuQTu3SLUwAVnBT0pTnP9PeUPcGg1eHIWX-YjkCnKQQykMD_cHG
    22bckA4P6FQNedUKqI>
X-ME-Received: <xmr:v9aOYRZ_Y0PWhxfW_uP_huB7DhyvwDuiblaJNs6_uV1MXZ-Q-G98EBneV9NXehYrsI0tIOz1fPFn4HEKckgO1D1cYe3sCXltSSo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdefgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:v9aOYYVMtpZgVlgIrLY9CJbHzJgpgpTLaiGP8r77G6wcL3_c0dVYOw>
    <xmx:v9aOYfnWPRHFR9KWh_p6Dt22zqMOXp4Z_WrD1WnWbxZRd8zJsVkZHg>
    <xmx:v9aOYVfa6oKK3xavmdBqFJyxGOIxw34xt4H8RIdBKBx4KYg0FQYf2Q>
    <xmx:wNaOYYCiHzIep0uKiIb0Ih0f4BSVCHSL2Mys_ukFZtXhfBo2S_bnyw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Nov 2021 16:03:57 -0500 (EST)
Date:   Sat, 13 Nov 2021 08:03:52 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Mike Rapoport <rppt@kernel.org>, Sam Creasey <sammy@sammy.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] m68k: Enable memtest functionality
In-Reply-To: <CAMuHMdXsVvXCbmrdukLCd-AXrqT-LmCz427BdNNCbDUw9vmL1A@mail.gmail.com>
Message-ID: <9a70775c-25f8-a7e5-43b6-5aa385bf729f@linux-m68k.org>
References: <1a89fd7d58f22e4817cf5bb406cc191dc0bc9325.1636677401.git.fthain@linux-m68k.org> <CAMuHMdXsVvXCbmrdukLCd-AXrqT-LmCz427BdNNCbDUw9vmL1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2021, Geert Uytterhoeven wrote:

> > index 9f3f77785aa7..5b6575eb6d02 100644
> > --- a/arch/m68k/mm/motorola.c
> > +++ b/arch/m68k/mm/motorola.c
> > @@ -455,6 +455,8 @@ void __init paging_init(void)
> >
> >         flush_tlb_all();
> >
> > +       early_memtest(min_addr, max_addr);
> 
> So this is available only if MMU_MOTOROLA, not for Sun-3, Coldfire, or 
> nommu.
> 

That's because I can't test the others. If anyone would be willing to test 
a patch like this for Coldfire etc., please let me know and I'll send one.
