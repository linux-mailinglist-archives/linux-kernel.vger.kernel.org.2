Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6445864D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 21:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhKUUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 15:30:03 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54867 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhKUUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 15:30:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 75D835C01A5;
        Sun, 21 Nov 2021 15:26:57 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Sun, 21 Nov 2021 15:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=VMfbjnyI8P7NrgSPWxr6J23U6HLT
        vmBP1wblGX7ht00=; b=PiVhEF5uG4hTYuF4q0YsB0bt3SdfvXiKpQFnMT1k1REl
        beg6udr4YfSpjJWAg+M6GTwFVS/1k33rt4u1QdgIJ0cT694XgofcZHHeuMRV3p61
        82qBa75NYbcuEtKHy5liyGez9112s73VXMkBWutI07XGc0j1q5/YqVANqBpI1xfP
        3vYcfUtlyEHhQzdrSBCNullrPAkktmyYUGHC0+GlvC8WdA4cbgY7QA21q/Dp/ouQ
        Pwy1/8hTeezVxoV+769Up5BLClnK6MAKAxHppzXeqbIN+PfqMEpgV7Ib1rnb7Mjd
        v1b/DXQwLsrxLyIGEwvz0dXI+3U7tVLqqpznCidtXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VMfbjn
        yI8P7NrgSPWxr6J23U6HLTvmBP1wblGX7ht00=; b=mDVx1cMhy1DdQ0OwTfVD7Z
        P2dIAou/bmjhC+7uHN9dfWySETiXG7JzpbASmDL2THqpCMVac4IuvFNbwuN5qw5d
        aY/egy1yf0NZco+kOpcaepa/6sA1VPMnX3C7f0/h7vfPOWLWfXZNg76ehb94c+5v
        oOm9TCxbSEa7xLSjlzwT1XkYlcU+BfcwZDEuEIzjnvPgdSsa8HHWv/gNS7oZ+dos
        J5eNbQAtciOi35N6BjEkx4PqRiwGTKH4FxMSIT/x8OgfKYPxN/QTdTwzXQPKbMOj
        GqK0b68cyBPRwnIa/sTFecJdOkmY0HGwzIruD82q9c7APaMG0sOLuuNnHcPF1cog
        ==
X-ME-Sender: <xms:kauaYSd7wxkN2mCseXAoPfVB7P7NorOB897tSBOOVQ5c_XTrjJ7Ryw>
    <xme:kauaYcOVyjqzouz79LY7eAIhtrPsb9Z-8FmruFCUgltTlvgFGY93RHG305mcvxUUm
    mrEsRbxdtXMVhweMGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrgedvgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:kauaYThO8ysfCrm6gB8fTPV-9s7WuJ7jKepxvICuZ2sKfobjRth1sw>
    <xmx:kauaYf8JYj8pTFM5YWaIt8_B7k2nTtsfE5QkdNy9a9mSYDmyt4bhXQ>
    <xmx:kauaYesfEacWndW1UMguYvJxsn15Cak27XqmMqB6hAeHB3JQgN6L-w>
    <xmx:kauaYb8WYXHePDl9_fxLI3W8clubjLepeidcmnnuckvpDkWjxVB0xw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 478F0274055E; Sun, 21 Nov 2021 15:26:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <dfce075a-1f6e-49ce-8385-73f1c72a7394@www.fastmail.com>
In-Reply-To: <20211121171545.27402-4-j@jannau.net>
References: <20211121171545.27402-1-j@jannau.net>
 <20211121171545.27402-4-j@jannau.net>
Date:   Sun, 21 Nov 2021 21:26:36 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Janne Grunau" <j@jannau.net>, "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Marc Zyngier" <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: apple: add #interrupt-cells property to pinctrl
 nodes
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2021, at 18:15, Janne Grunau wrote:
> Required for devices trying to use pinctrl devices as interrupt
> controller.
>
> Fixes: 0a8282b83119 ("arm64: apple: Add pinctrl nodes")
> Signed-off-by: Janne Grunau <j@jannau.net>
> Cc: Mark Kettenis <kettenis@openbsd.org>

Reviewed-by: Sven Peter <sven@svenpeter.dev>
