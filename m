Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089363F24E4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHTCok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:44:40 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45575 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234797AbhHTCoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:44:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 13B07580B19;
        Thu, 19 Aug 2021 22:44:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 19 Aug 2021 22:44:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=8
        ib7lPalhLxy+mvQQtHrtvZJrUfHN851sDVcL+6mrQo=; b=nL4+7PC4gYMIQo9dU
        Aue4wmjuI/ysc5EzyUh6WHFY2kNoXf7xlik5qep/W2IC+5wr1aLri1Zk/WtN1dJu
        yeoqFP8RBhw9yBarxmQYA8jyf6yOWQBgEEQttfMFzj/GgZU0Bl91awt21/C8IP1H
        SUWaS6UwLHcx7sYnGmrMY3y/MD/9tgfYMPP6GzcSQJTeNy0O1Wq2KG7q7pSn6/Qt
        lkSTZwhfNgxk+PpocsqgJbVb25w7LbbqaHKfizzDR0l5kFnE/JJOMXlhpFb1/HfW
        0yqLoqshuSGFO7gm6P16kRtSPaAAKQRFI1h2E+rSNf5MefS6wIff10uTkQsXQJba
        PlLxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=8ib7lPalhLxy+mvQQtHrtvZJrUfHN851sDVcL+6mr
        Qo=; b=QhEJJfPfJt9DsihP2XKKUHWf3ODh46gi0Ujm6tb+nG65xKmi2ElRfABf/
        WUNzNgJd6d99gS6dMtdiQyw/EiK7CoUrwFHEQG2beJ2imMJOtk57fgFp9Y11Ab4r
        DankjNFnZYt1dyR3Setay2BjxaIhY2dGA/1KbXioQD06HzUYgRB2P8HX5bQQICR5
        8g6fEG0/TyVirHpRcDEmBo0jKaMolkOQGl3xGNP9OHfmwGYMQyxIiMMHOIeU4V4i
        +cEAveOs2e9wySMpxWDDeSQPhDLGE6ymFqiWS40f2FNTMq+P+GyrnVxyNRRvyQbH
        VASEGmuHVb2mj7iIchn2SDkJItY9w==
X-ME-Sender: <xms:7xYfYewfM4R0JUVJ-nIQgfW0n0i8sH1jRLzywLAkKiyimt8DLcIt8g>
    <xme:7xYfYaS7-JXdr8bjOlnOARg0or-t1sNilB7lb-f7cM982L2nIKyOKy1g-VM5XRnEM
    lRr8Varbsd1Qys6iA>
X-ME-Received: <xmr:7xYfYQWVDX4ECPliPr2IaB_qhvU4NCTfduJFmYimAZnZyAFcl6-G-CxcE1hEyavGPCdwtgENTLEK4uQUeGrJ2Po7z51rmbe47Ez2t8wY1tJRRBTxIXS9rvHWjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleekgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:8BYfYUhdKttyVerHsqI9rKFfSwQWvCjdKDZyhIIQ_12p_HN0N_v0EQ>
    <xmx:8BYfYQAsfAt5Yys-ds_EE1LtYQdzUB02iNfMdnjtix_b4RPE9lVpsA>
    <xmx:8BYfYVJYTYT0faU4ev0ey0M0WCPKI9afWQ-fZfm6e8McygFZax-OjA>
    <xmx:8hYfYZIjEjboHrAaTmddVXw1wxXm1AE1Rk94YXJj4IS69ybLOzJUcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 22:43:59 -0400 (EDT)
Subject: Re: [PATCH 13/17] mmc: sunxi: add support for R329 MMC controllers
To:     Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-14-icenowy@sipeed.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <9000e312-a0d7-fa52-0a48-439312e12572@sholland.org>
Date:   Thu, 19 Aug 2021 21:43:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210802062212.73220-14-icenowy@sipeed.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 1:22 AM, Icenowy Zheng wrote:
> The two MMC controllers in Allwinner R329 have a mixed feature set
> comparing to the previous SoCs' ordinary MMC and eMMC controllers.
> 
> Add support for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Samuel Holland <samuel@sholland.org>
