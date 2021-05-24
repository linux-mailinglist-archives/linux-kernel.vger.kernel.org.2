Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA738DE6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 02:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhEXAhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 20:37:53 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36527 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232058AbhEXAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 20:37:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A26B35802E4;
        Sun, 23 May 2021 20:36:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Sun, 23 May 2021 20:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=zkdYOgBr6Su2ai8/JFeN24jFqNEfx2N
        9VN/bHqPBWM8=; b=I1UgvuBWfB/H3UC2DCeyOvtYsiu44FCeM+ceMlNQh86h/rQ
        VH3oGHRSQZE0ESXyx5gleiDHAc+RQ2+DnK0aZu3tq5fh6KAseOuXmloxARAqUV66
        VHbUuprYslYzYg4o9o/6iuxZgENs+w/NX+6dfJ/zKphutE1aaZjGqhz9RTdIgAwi
        q/UoPr66PSotyBmtus5RHQOteW1qU3/YUcNvKtwkXOefEXTfoMou/DKRij0oefqS
        H3jArk5UBD0sMRcCoQWxd6TX1S8B2npJ9TUknbkOYXbsYZ5abIN3m/9wIiV+mInD
        EBvEZqWKPIE4iKchSiOI2ZDjgMuFaXzGvnH9r4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=zkdYOg
        Br6Su2ai8/JFeN24jFqNEfx2N9VN/bHqPBWM8=; b=n9NkXkhXcEEkTg2EhGUS7A
        axzagLdcosddoN2VOIizkliicbXB2tK1hic9l4puTgRUWdS/5Q8nqsUE8zeJx3hd
        Q+h6slEB/0q6AfR1uMV5NCth1yE2qHyy/aUa1ESklQxyXCKftAqXw7JtZgBVHR3M
        9EaaoYs1OiTjmyDdCIqs2EjtJbyY0XiWDiAm06D/uAjLgLzdVorBXKUw03wWSBiX
        tg6/8PmsesX5bisK1b1GAQfhOjZno1/C5ilMBWFIV750nBMfYspETlENVKIroN3M
        Wiun7ETMFWKsXiyGDuZfFJUf/n0HTbKonLDUzQKTo0QxRKwCzVO/XNhQ86dp+D4Q
        ==
X-ME-Sender: <xms:BPWqYA1T02O_wgqkUUutE61gLIrFB5ABfOtV2F9pdY9mVoKbS9csHg>
    <xme:BPWqYLEmintilSSGkp4bvbEkkObYCPDS6s3mfqOwUOK-SYzz8JfVmqR99ePVPtPKX
    EuqaGw5Vwgrzv_swg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:BPWqYI7XIdnyYpc88GTK0x4feDcqV4tnMSUyq8Qa-j1rTkYdYUPNyg>
    <xmx:BPWqYJ3H3frTV1PdvXsy9fo1aPhhCnKBZhYdIrYZJ-wu6HkMElJCiA>
    <xmx:BPWqYDHQxHjwgSFZ0HZuD6L0ydZzNpJqCTNCQvNNektIjgHhihqIEQ>
    <xmx:B_WqYDG5gJFy-RimBvuKtngX-3bz9X1LqNiHKDisST7-L-CX6BqcLg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B59E0A004B1; Sun, 23 May 2021 20:36:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <e0803983-a385-4972-9dcb-404b2006f674@www.fastmail.com>
In-Reply-To: <20210521173616.GK2921206@minyard.net>
References: <20210510054213.1610760-1-andrew@aj.id.au>
 <20210521173616.GK2921206@minyard.net>
Date:   Mon, 24 May 2021 10:06:00 +0930
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
        "Arnd Bergmann" <arnd@arndb.de>, "Zev Weiss" <zweiss@equinix.com>
Subject: Re: [PATCH v3 00/16] ipmi: Allow raw access to KCS devices
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

On Sat, 22 May 2021, at 03:06, Corey Minyard wrote:
> On Mon, May 10, 2021 at 03:11:57PM +0930, Andrew Jeffery wrote:
> > Hello,
> > 
> > This is the 3rd spin of the series refactoring the keyboard-controller-style
> > device drivers in the IPMI subsystem.
> 
> This is a nice set of cleanups outside of just allowing raw access.
> I'll let you handle Zev's comments and a few of mine.

Thanks for taking the time to review the series. I'll address the 
comments from you both in v4.

> 
> I almost hate to ask this, but would there be value in allowing the BT
> driver to use this abstract interface? 

Hmm. Possibly, but it's not something I've looked at yet. If we did 
want to go down that path I don't think it would be too difficult, but 
I don't have a need to touch the BT side of it right now.

> Or maybe it would be just too
> hard to get a common abstraction, more work than it's worth.  It's
> surprising that more people don't want BT as it's vastly superior to
> KCS.  

For bulk data, certainly. However for the use-cases I have I'm using 
the KCS interface as a control channel that isn't data intensive. 
Interrupts, a small command set (256 values are more than enough) and a 
status byte are all I'm really after, so BT is more than I need.

Plus for the systems I'm working on we're still using BT for in-band 
IPMI while we transition to MCTP/PLDM. The current BT implementation is 
working fine for that :)

Cheers,

Andrew
