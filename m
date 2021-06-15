Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE783A8BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 00:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhFOWp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 18:45:58 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55061 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229908AbhFOWp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 18:45:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D1FE458065E;
        Tue, 15 Jun 2021 18:43:51 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 15 Jun 2021 18:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=a1n+H/r58DrOu+6wcj/wMJNk6uExtCA
        2MLS3ZO7f12A=; b=lGj6R/+66HbO6xVEUCX76buv6MYW71elWUJJuPrcmmLSVGg
        svKC7FWTrs8kgjbZxZeevSFXao36yqVtBxP/SJjx7aqv5whuhtbhcgyvsqYBGnnz
        POsQYIVK+X62IRl4ktGGovtB/7KclgEiWAsVnWyaWh0y2/KQEKZnWWpJrVd5BFDi
        j1B1nTeLok8Hej78jMj7Edlesnvkr41HGlvwhBkvIQ5rcjjFMiG21qWzkoOxIbKb
        FgpLrlZw40QXDDqPj+l4ubawV9pN+Z9CdPoddm+8sO0vKtKOaug8ZhbUn2Mkpxfz
        oH/uBFekOOTAyJctyhS5ZFS8Duo/IZluq9vzdSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=a1n+H/
        r58DrOu+6wcj/wMJNk6uExtCA2MLS3ZO7f12A=; b=GqZUIEzV6YS275fl4SANx+
        mZErkEiN8pmieruei/4/wp0ZasHnttA8jHvz4L1dfXbZomBqaTVxxXzs4z4sjDJc
        QOVQWIM8G9gdpT6vIDkOQkfunV00dXbrhn2kAkQrRfPZmqg2KIVUzeTBPt2kJI5d
        6sFKhkeibJSOLDNU2dKLF9GSdG1L1R/Yq3rv/kwbQZ12oQb+1na1q5WqgbdJx+HU
        RobnuRNPk+DTNV/zTGAZXpX6+kerNGrABlmtgR80TTjUjKRbNW7xB3ZoSfjaPvrz
        sUUbpxvh24Op2NBqtJCRfUBGhMC0nWFicI6piKdc71NHLIXjgVn7pSfA42kGZtXA
        ==
X-ME-Sender: <xms:JS3JYLFzeUG-G4ItQU95L2gbxSG-t77RqVTH8B4ylREYwkm7YCifLg>
    <xme:JS3JYIVkyWuKHOZn0IqTg2KlJCobHOa936ZCHz1Q9z4-6s5CDPm3xdyXZz5mWGpVo
    KY1qwna4kxNwy5APg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedvkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:JS3JYNKiC80ZuBJ-BT-1pDa6_TI8kQttNo46T0kSG2r3f0eXEAsJfQ>
    <xmx:JS3JYJFruDxowjGWIQWZRpqCPBut-k8QluPUfUcVp-IL-wLsjiRGSg>
    <xmx:JS3JYBXXGa9e4LBN02HKMxWEQ_CXdUYqw4tYUCsqfsjN6sv5AuLivw>
    <xmx:Jy3JYCUF5sJgpAE65-7bbyiFrhZTXai1EEe-rJYJcUoyN2N-kZyGGQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6B5F3A00079; Tue, 15 Jun 2021 18:43:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <b1b7fd82-3edf-41a6-baa6-530bcf76c3ca@www.fastmail.com>
In-Reply-To: <20210615184657.GF2921206@minyard.net>
References: <20210608104757.582199-1-andrew@aj.id.au>
 <20210615184657.GF2921206@minyard.net>
Date:   Wed, 16 Jun 2021 08:13:27 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Corey Minyard" <minyard@acm.org>
Cc:     openipmi-developer@lists.sourceforge.net, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, "Tomer Maimon" <tmaimon77@gmail.com>,
        linux-aspeed@lists.ozlabs.org,
        "Avi Fishman" <avifishman70@gmail.com>,
        "Patrick Venture" <venture@google.com>,
        linux-kernel@vger.kernel.org, "Tali Perry" <tali.perry1@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
        linux-arm-kernel@lists.infradead.org,
        "Benjamin Fair" <benjaminfair@google.com>,
        "Arnd Bergmann" <arnd@arndb.de>, "Zev Weiss" <zweiss@equinix.com>,
        "Joel Stanley" <joel@jms.id.au>, "CS20 KWLiu" <KWLIU@nuvoton.com>
Subject: Re: [PATCH v4 00/16] ipmi: Allow raw access to KCS devices
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Jun 2021, at 04:16, Corey Minyard wrote:
> On Tue, Jun 08, 2021 at 08:17:41PM +0930, Andrew Jeffery wrote:
> > 
> > Hello,
> > 
> > This is the 4th spin of the series refactoring the keyboard-controller-style
> > device drivers in the IPMI subsystem.
> 
> Ok, no comments and everything looks good, I have this queued for the
> next Linux release.

Thanks!

Andrew
