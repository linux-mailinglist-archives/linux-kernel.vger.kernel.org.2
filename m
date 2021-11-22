Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B1458B13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbhKVJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:11:08 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51311 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239004AbhKVJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:10:59 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D8E793200F3F;
        Mon, 22 Nov 2021 04:07:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 22 Nov 2021 04:07:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
        etlpASLH42NiBIGTaS6QxwEclALLVQkC/FuIBSS6F4E=; b=fN962dab+I7FeD8e
        EPfcDwJ7p5RRMP9P13w7je3BxmP8RYmHersLl9VhBh7Y1X9QxGAA/ab2hX3RWqb9
        /xy3ePinihrBnWucZ4fY5zXtC5w3tl8ZP/iJ+OGyFu8ZDkxdr156ieArN16JFq4c
        AGPva4OabTurCmHGjHQ+c1psII3J8ptZeFar2hHYvLZbv44t05rGcFkfiI7WO3sH
        OS7ze9zvPVEVU8qPv3OsvDF+Tc/3Bcr7iXeGYgO8X3aLBosRtHprhHDs1fz0fI96
        iU4EE8mo7mXOuMOTmHH3A4T2G2woZZo4TLP0EsXFc5cyBsUv1YzQilfqRqAJjt/t
        nH63HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=etlpASLH42NiBIGTaS6QxwEclALLVQkC/FuIBSS6F
        4E=; b=HlubHfRWIgEAlaFuqz6RwydLIFNtCOO4I6T01yDuaVsIURRibrsZ2fnEP
        TljUs8/39SzUbgYBQlXnv6/JcIkLZ87anoE5DHQVzdz8HoDD0WqmAKSV6qCbFzj/
        M1YCMe3pfGX4w6wAn9b042f+wpoicYeS32gp7wVX35H17bPvV7l+6x6yUuP9s/5L
        N7HYiraLODzvVkotytB2y8f7mdlu1cxDcpecF8dpW0ZVVrqk7oY8IMvhwTGdwCbU
        2fsSWPBLq3DeVqbD9VJTr/F77YOTMoXH7JVKDeTIOybX5lvsZeHOJxZTlWQfiR/t
        vg0z+geUwQieB/w6XAgAFI6a8dxyQ==
X-ME-Sender: <xms:512bYSCvy-eeydqlM4Gt8Fo9OB5rpxG76VHmTIMfTX7JJM3T7DSiMQ>
    <xme:512bYchshiocbvbuGkt33vGSxRTp8PJoWF7nRM80DAdGzn3oBewm50ppuIJkJUKh7
    go_PGW1f-XuFUz75fo>
X-ME-Received: <xmr:512bYVlZuJCbbPdtmi9da8vdMpCK0wyIWSdZmr3ASc0cKCx21QJJZgvPzEANNvgsvz432x_mzS3E0kDMnNcq-CcULZtvFmCj6Gc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgeegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihimhgvucft
    ihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtthgvrh
    hnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeegieekkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:512bYQxtsw_B8CevUJyXqmq0SGXxTlRXWBV_cRWa68ia3rb4aD6OOg>
    <xmx:512bYXT6sQ4Zrr2j_BZzT3S9ewrGgSAN7t3ZpWZWzi70sBl8xXa0sw>
    <xmx:512bYbZ3oiQNOVesUbMoQb-gfXDKD83-a85Cu41Y7DWmnwHJkEB7Uw>
    <xmx:512bYQS5BBYpINQ0tsSLiIYOMijq1F_ULixR3lQhnTLtfixV6KaTHg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Nov 2021 04:07:50 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     mripard@kernel.org, wens@csie.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Add I2C node
Date:   Mon, 22 Nov 2021 10:07:42 +0100
Message-Id: <163757205949.21212.16605527644553518863.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211121115002.693329-1-jernej.skrabec@gmail.com>
References: <20211121115002.693329-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Nov 2021 12:50:02 +0100, Jernej Skrabec wrote:
> Tanix TX6 has a LED display driven by FD650.
> 
> Currently there is no Linux driver nor any binding for it. However, we
> can at least provide I2C node in DT, so user space scripts or programs
> can manually control it.
> 
> 
> [...]

Applied to sunxi/linux.git (sunxi/dt-for-5.17).

Thanks!
Maxime
