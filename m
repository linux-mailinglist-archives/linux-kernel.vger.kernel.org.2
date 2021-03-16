Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7445D33CC94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhCPEdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:33:52 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45099 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhCPEde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:33:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ACC005C00D2;
        Tue, 16 Mar 2021 00:33:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 16 Mar 2021 00:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=P
        EbI6kwHYhOjxsy2iAIPZ5kbB6BbfhodLAXzYl+6QNY=; b=h1dVsul+T0nnJPB4e
        G9KHvCJEuRPyE+lugziQsOX6KqMcTWpHThGuyx6aj/0bgKX2kM/nqWflaPr2Rpcz
        cUAp8j2/2frhNFeAAVqVvdI3i0ylRIsbTgABk+No9Uy28oBcTwWYFfjbHm2/8M+H
        0qpRmX6cdHmScXlCLKimMjgQGJ6TEbLMII+psOFwAiHplf3xZTMj/dt7AOqDyOOu
        KqjhUS0sT3XlfiK170X7ZygEVfCgpjNRyMmuAOHwKMlGN7WLXxA7+6fMQQsOT3Ya
        xOZBUxKbqc8JhHzJy249ABmIw9Ip3EPEgkpukn6ZdbsYjncynIPb8JT1gaPNB2Y9
        spd7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=PEbI6kwHYhOjxsy2iAIPZ5kbB6BbfhodLAXzYl+6Q
        NY=; b=MpkvqyNcHJeNcQYEwCW8kwbzBn/wxlTZaPYBPzAvu5UsZD37qm1q6wgKo
        ltMtiElR6Rf4G+PwddeSA8wb7uLBejVf0NuuFSuZhllIdBeYk+Twp7v9j1vfyLna
        Hv4HOBHqQnOu98zfE2zYahTn/IApI1YZGIVjXO9jv8tTbA59igFMuP6gBmeuvGYs
        lv/0ATwt7zKhFuZQYko+/s6XE2/IPgf9QWherWHcxNX4h/99chJoDpabOU1Pcrc0
        +z5rTWc62HlJRedYjLaoeDg7CC29HgDXJbI0zYkVqO4hcibfgd1krNxmwWPP9Df+
        6K3sehxs6Y1sNEIsNHga+EPDmSUJw==
X-ME-Sender: <xms:HDVQYKvvxlqk_mbso0uokl1Ie1VnV2ES5Llui2VMMDAIt7jKUXtE6w>
    <xme:HDVQYPfJoeWTG5nfcnmtTnSF6VGzNY9I5_d8Hd6Ozqz4A-DUjZL7IojIgelSpVMtj
    k8VU1l6q3i9pRTIHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefuddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:HDVQYFxAa3oWg3Ifd0dIkbXbNaeNyphqnXdwbhurX-jdl-uoYFsRRQ>
    <xmx:HDVQYFN7MN30_X15hGo0rDNi11Ke9thpU1wft8yd0DOQWuM1QPUUNQ>
    <xmx:HDVQYK_YOKO5Z30qDjBP9zVxukmlGTw9a7rcbgGTxNzeLALWyZqQKg>
    <xmx:HTVQYKyVS_-r44lb7CbMW5F_aU2Z5peHSHnTuWLdJ9PVZjEnmoasBA>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6682A24005A;
        Tue, 16 Mar 2021 00:33:32 -0400 (EDT)
Subject: Re: [PATCH v7 0/2] hwspinlock: add sun6i hardware spinlock support
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <95e93676-cfcf-1aed-1741-d69b72286033@sholland.org>
Date:   Mon, 15 Mar 2021 23:33:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1615713499.git.wilken.gottwalt@posteo.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/21 4:30 AM, Wilken Gottwalt wrote:
> Wilken Gottwalt (2):
>   dt-bindings: hwlock: add sun6i_hwspinlock
>   hwspinlock: add sun6i hardware spinlock support
> 
>  .../allwinner,sun6i-a31-hwspinlock.yaml       |  45 ++++
>  MAINTAINERS                                   |   6 +
>  drivers/hwspinlock/Kconfig                    |   9 +
>  drivers/hwspinlock/Makefile                   |   1 +
>  drivers/hwspinlock/sun6i_hwspinlock.c         | 210 ++++++++++++++++++
>  5 files changed, 271 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
>  create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c
> 

Thanks for the very thorough testing!

For both patches:
Reviewed-by: Samuel Holland <samuel@sholland.org>
