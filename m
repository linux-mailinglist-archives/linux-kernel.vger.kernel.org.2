Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088D33FB13C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 08:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhH3Gbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 02:31:35 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:38851 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233322AbhH3Gbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 02:31:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 191D6320090B;
        Mon, 30 Aug 2021 02:30:39 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute2.internal (MEProxy); Mon, 30 Aug 2021 02:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=3wUCSqdn4FonUFpafSvfIdXbv2mC3Ro
        3b3RFFKqEObg=; b=czAu5DjLpag6n/8BPAeZxSGu9KJb6H9jLy8JVHsAyZnoP+j
        Oq3709PuwkL3BhYL8UVkuFWfQuLrWYbOf93AR92nPowNxedHlpnaAucZcyiOuemQ
        paUNqdoUBPsgj6v1LnHe9C7THdTtYAagK1zFh3KKLwlDsTtl5ef1gPE0lIHtaor4
        +T9JVNk/IF9tEY/RTu6iI6xkn1l1N6JmsSg9VqJPIPhBMLx3lcAZ7ACEUWkWkNO+
        LuaK5LndNcx8xYFh5PbTXvwy5oA9vhguOR0Rr8zzXdP/GWwWtyWex0AKqGOryqEq
        uqP4VYMiRSS1gC+EdwSo6mqnJJEi/s4oEq25zaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3wUCSq
        dn4FonUFpafSvfIdXbv2mC3Ro3b3RFFKqEObg=; b=VZTrSDRKIDYzo/oqyhisCI
        6IuY719g1AcEcQCR+qgMMbmFr/HUz/nv6fdB2kGvxhec1AyY6BxzAIPhydzLhEfG
        PXuqOz98VSHqELBcqmCGGAkFqpwOsdTK+YHfb6wpyRXGSKafTTKWaW8W6rnQaQcm
        xDL7kqwsEM3Xo58x+AHiKjq2dp6tnrSvAmw9qGYXAR/Py5DgI4mccCtNEfYTA8v4
        pe5EwXHs7hrn8kYPWQXuC40zfM6YrIfR+Kf3slj9oiy84GJTCr6dhbabfb79Pmyo
        xo2sLMyPT63p0kFBDBzi02aad6BbDGU/Mb5u08OUdpL6X04rsAIAQxqTYsI7uqIA
        ==
X-ME-Sender: <xms:DXssYQ_z3vrmYLilhgYqeKj4gRMNTl5w4Z2kSTa8uHz8BTYe-azOFg>
    <xme:DXssYYsTF3s9BFDEZZN8P7XvQR6oRyhzRfoOk5PFteaxIMLBV7C8SG8-0qMXqUnHu
    e94tWjLm6k1v2-DBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddukedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedv
    hefhveeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:DXssYWCM5qn0Y5zNn-hAslJ7GW4HFoE_4gJIe2cBy86bnn8xq95CxQ>
    <xmx:DXssYQdxq2a7tjlnOXmd2Md7NfzzfNzxCeWpMg3rCesnVG7j27DBuQ>
    <xmx:DXssYVMuQz9sSq6JZbah23vEbkZRyuVovVM8wcUsVsQqVYpTHLt5JA>
    <xmx:DnssYapNMWSV5MLSOw8zJyN-htBKlIhgF2e9q2VsDHYq-b_0Cxy7zQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 510D5AC0362; Mon, 30 Aug 2021 02:30:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1125-g685cec594c-fm-20210825.001-g685cec59
Mime-Version: 1.0
Message-Id: <a758fd4b-82d6-4980-8ca5-efd396d4f246@www.fastmail.com>
In-Reply-To: <f71cbfb9-b72c-39d2-6acb-dc83b6a496f8@roeck-us.net>
References: <20210724224424.2085404-1-linus.walleij@linaro.org>
 <20210724224424.2085404-2-linus.walleij@linaro.org>
 <20210821042010.GA1759866@roeck-us.net>
 <CACRpkdYObGTWni3sSa21iNsgikzj7t9MA6y4TNgkBTTYQt+coA@mail.gmail.com>
 <4d87c7af-d2e3-9456-130a-b35b507ff3a2@roeck-us.net>
 <567a65a8-077b-7394-c8e2-dbd9f063e02c@kaod.org>
 <4c87cee3-2dfb-41e7-a18b-5ed4687a6f7a@www.fastmail.com>
 <f71cbfb9-b72c-39d2-6acb-dc83b6a496f8@roeck-us.net>
Date:   Mon, 30 Aug 2021 16:00:10 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH 2/2]: Be stric clocksource/drivers/fttmr010ter on IRQs
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Aug 2021, at 14:28, Guenter Roeck wrote:
> On 8/29/21 9:16 PM, Andrew Jeffery wrote:
> [ ... ]
> >>
> >>> I don't have the manuals, so I can't say what the correct behavior is,
> >>> but at least there is some evidence that TIMER_INTR_STATE may not exist
> >>> on ast2400 and ast2500 SOCs.
> >>
> >> On Aspeed SoCs AST2400 and AST2500, the TMC[34] register is a
> >> "control register #2" whereas on the AST2600 it is an "interruptarch/arm/boot/dts/ast2600-facebook-netbmc-common.dtsi:#include
> >> status register" with bits [0-7] holding the timers status.
> >>
> >> I would say that the patch simply should handle the "is_aspeed" case.
> > 
> > Well, is_aspeed is set true in the driver for all of the 2400, 2500 and
> > 2600. 0x34 behaves the way this patch expects on the 2600. So I think
> > we need something less coarse than is_aspeed?
> > 
> 
> If I understand the code correctly, ast2400 and ast2500 execute
> fttmr010_timer_interrupt(), while ast2600 has its own interrupt handler.
> To make this work, it would probably be necessary to check for is_aspeed
> in fttmr010_timer_interrupt(), and only execute the new code if the flag
> is false. The existing flag in struct fttmr010 should be good enough
> for that.

Sounds good.

Andrew
