Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69D416CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbhIXHcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:32:43 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42439 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231921AbhIXHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:32:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 37A6B5C00CF;
        Fri, 24 Sep 2021 03:31:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 24 Sep 2021 03:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        WRE4Vc8es5gBLC69CH2rv/GotbTtWvdm553PxD4y3N0=; b=ncAUJ2uWWrB1I/9U
        AhxGaInplJFQGALBrZIoJEckkOeCe9bWz0u6/DrYeJD8DqVGgcBg1WPxRpfcW/uF
        8/E+TDy1aW+nqd+BtCjbUlwzLYJdUvDt0ikcVWEs8ybDt2T4qs4uMHbLjp9FvkmL
        F7CnaSLYiUCGaZJad0aLBiyZLUuymUkPRahSiy2ZIZY4WEeHtjGPV0jPp4X+aOYD
        6I0Yh3HaSIAELYHVNQ/oEPbeZJN8YeNNee+C+nm7U9wBJJ3VQ0Cjv40I/iUuUu3b
        7pj7/7kaoTYHbCTw2oYphc/sEymf+dAmLubSN40N0HfrSCgRHk3MNJK3RuTRN5o1
        zaJjAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=WRE4Vc8es5gBLC69CH2rv/GotbTtWvdm553PxD4y3
        N0=; b=Qpit1ne4KVJlVFy46eMfvI/eZF5G/J60h+XFmmt2L9QdnOhJOte35PPbF
        EifcOfBx8C+I5SQOGMx+UtNGOVoJmvdKaieQCCfk5+OD+uuPUT6ac2AQFufv458H
        Oezd2LZIBZ6iyNV2VVF0N6cr6raUf1CCygt6G9oHiOBSzWeUHD9/Alf4I2svO8UC
        8xFUmmG6fDzglG2af5+LiaRelOhCCVrYUOogC10FL750vHtLpiXViXc0Jg0HGSu2
        BFX/iw8NRy++4FYrLIiAGlPIkDJzrbUhTbYJN+ql8WmWFIfga0hQ9AWrenJiWXri
        Zv4eu475jFgaAYpcVaaYSCUqoVUjg==
X-ME-Sender: <xms:vX5NYctPEdzqsbwiDXaDC96_ErtrPx7F3Pnb2VIo2QJxiTWxIHdaHw>
    <xme:vX5NYZd3KSK1uJINw9lH0thmnMuZ1-n5IcoSuc9jKnrnBr4vURhRN5QOLDKwppDO6
    bArh1c2WU5env0auAk>
X-ME-Received: <xmr:vX5NYXztrfX4RRHmWqHopmzSmpxAAZw0uKIsHX7yH45JWnqscqSITB9meyC4UY0spz_ZEiLrq8RV5M-Yamc8uByfb8uWM55T5Wt9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepjeeugfegkeffgfeuvedtvddufffhjeffjeejvddvudduteehhfefhfef
    geeikeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vX5NYfPxnpmezvNHCxoyHzVQeM66CUXVnxMo2_P7Kr3EikHuxk_ncg>
    <xmx:vX5NYc8aVTjC32YXqFYEEXFm2_7Laz5elzS4D01VA1ZGvdjfGNsaiQ>
    <xmx:vX5NYXUADSw0lFGtMmJGp78IDGFr5fisUh2bC98xn3i1rv7-N7jn9Q>
    <xmx:vX5NYQQt4xCzgaeZ0tvzf_7Mp3XjVlpsjRwPN8OU4oQg4lwIhmrXPQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Sep 2021 03:31:08 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     roucaries.bastien@gmail.com, Chen-Yu Tsai <wens@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?Bastien=20Roucari=C3=A8s?= <rouca@debian.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] [PATCH] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
Date:   Fri, 24 Sep 2021 09:31:00 +0200
Message-Id: <163246857205.870206.2699530855804252485.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916081721.237137-1-rouca@debian.org>
References: <20210916081721.237137-1-rouca@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2021 08:17:21 +0000, roucaries.bastien@gmail.com wrote:
> From: Bastien Roucariès <rouca@debian.org>
> 
> Commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay
> config") sets the RX/TX delay according to the phy-mode property in the
> device tree. For the A20-olinuxino-lime2 board this is "rgmii", which is the
> wrong setting.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: sun7i: A20-olinuxino-lime2: Fix ethernet phy-mode
      commit: 55dd7e059098ce4bd0a55c251cb78e74604abb57

Best regards,
-- 
Maxime Ripard <maxime@cerno.tech>
