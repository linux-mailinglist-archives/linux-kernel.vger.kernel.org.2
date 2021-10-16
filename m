Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033CF430179
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243918AbhJPJXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 05:23:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52991 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235334AbhJPJXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 05:23:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 943335C00E0;
        Sat, 16 Oct 2021 05:21:37 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Sat, 16 Oct 2021 05:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=MsSJnDLehR0MBA3XNlTvyuJrdFmP
        tM7Fb8Vo/fka3Rs=; b=BhYx5Ek4z9ROYyKoY+j1uWg/pSMWRr+BIKwUVyTc7qT8
        AdlHq1Fr544ZuEp65rXnRkJgMb7cq1xpk3AtuB5xYMAZ8z9e5DhHiDdidnUh/9q+
        K+0PbcXu56yLP6/OD9iYMmyZo4+RsVyy4O6UwKAUFxuxBKEUqIOSlxvCRvx1JksA
        WMN3AS7KzImWmU79mKGK318Y6leVYDrZ9TOyc/uGMYzK4a+dfpotOIogsI1zP41A
        po/JemxoT0a7VL7zFQXBsHqmB0wZIcBxhXdcPxWkzZjzHgskZyW7QfmN8Wf6/g9o
        je4ujs1xQ5+LxOosGzygclA4uT8NbFYJ3nizm4FOAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MsSJnD
        LehR0MBA3XNlTvyuJrdFmPtM7Fb8Vo/fka3Rs=; b=gowAv4g/fZ/gMzr+sDMXk9
        E8esGKbFatvUjQh1M8CiEMXHyU2OeIw+YWH8rDFvfedqxH5r6V40PK56O5C3OvJH
        XZo8HISTt+MUcQxuJrWQIDuoTfytEPPjLusdna712ZmwKuGcAH6/rzHrcgo5oaCL
        MYzfOuVvmFpWH4a1iAhgwywZaaNAnamX4Mp/CTmSeogoyrpqEjTQe1YrcNRvk+JT
        8zY2IU4oSpMp2hCZOinyHpDVmLk+3qmVgDNSUEmBy4EOU3/T+4NyScwx5wYH+Jdd
        TASRUnEahegg9rJ2pHlok1Rrt12HbdobHloroNUVsKERW1dWeoRtdwXB45QoxO5A
        ==
X-ME-Sender: <xms:oJlqYfYsQySUQDQNvRG-cjXRGiTHjSuObxLa5loUXBtIxVQYKhgU0g>
    <xme:oJlqYeZEvdk9fvxkfJGaEtLv-vzipRGcjObiJqPfly-bFxT3eT_hx-H4GLU3DAIVp
    Rz20aN-qSKFPI1AS34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdduiedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeevvdegveduvdevvdfgleefgeeivdegheeiuedtleevvdeiveevleejfeev
    tdelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:oJlqYR9S5bDnnacDnomYlCJjL1142UOziwtC5lDCPa4hkadKNmwt1w>
    <xmx:oJlqYVo94zSIYUrlGgzrXuvUiWJcANRG-oq8Ml90V2tVO5JkmXZNAQ>
    <xmx:oJlqYaq_G4XHEIL8DfhxwtoZ9rZswhSIYsLk79zOiC7lHhexSMgamg>
    <xmx:oZlqYaLUOS4xsga9p2fd06XPDsT380U5fk6k4oEAWvOcH1r0qTcrDg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BDD1C2740061; Sat, 16 Oct 2021 05:21:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1345-g8441cd7852-fm-20211006.001-g8441cd78
Mime-Version: 1.0
Message-Id: <94e07975-f63e-4568-986f-71a278777e9d@www.fastmail.com>
In-Reply-To: <20210916154911.3168-1-sven@svenpeter.dev>
References: <20210916154911.3168-1-sven@svenpeter.dev>
Date:   Sat, 16 Oct 2021 11:21:16 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Jassi Brar" <jassisinghbrar@gmail.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Apple Mailbox Controller support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021, at 17:49, Sven Peter wrote:
> Hi,
>
> This is the second version of my series which adds support for the mailbox
> controllers found on the Apple M1.
>
> v1: https://lore.kernel.org/lkml/20210907145501.69161-1-sven@svenpeter.dev/
>
> Thanks to Jassi, Mark and Alyssa for the initial review. I've addressed
> your comments with the following changes:
>
>  - switched to txdone_irq instead of introducing a new mode
>  - switched to a threaded interrupt handler for receiving messages
>  - added co-processor examples to the device tree binding 
>  - reformatted the register defines and clarified multiple comments
>
> Best,
>
> Sven
>
> Sven Peter (2):
>   dt-bindings: mailbox: Add Apple mailbox bindings
>   mailbox: apple: Add driver for Apple mailboxes
>
>  .../bindings/mailbox/apple,mailbox.yaml       |  84 ++++
>  MAINTAINERS                                   |   3 +
>  drivers/mailbox/Kconfig                       |  12 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/apple-mailbox.c               | 431 ++++++++++++++++++
>  include/linux/apple-mailbox.h                 |  18 +
>  6 files changed, 550 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
>  create mode 100644 drivers/mailbox/apple-mailbox.c
>  create mode 100644 include/linux/apple-mailbox.h
>
> -- 
> 2.25.1

Hi Jassi,

Have you had a chance to look at this series yet?


Thanks,


Sven
