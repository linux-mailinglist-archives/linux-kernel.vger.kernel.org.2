Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793EB403293
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 04:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhIHCXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 22:23:53 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:56465 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235450AbhIHCXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:23:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0E61B320039A;
        Tue,  7 Sep 2021 22:22:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Sep 2021 22:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=K
        BQJ2htm+9uNSNpB1V4iykXXKdsWXwGHJy4WSWj9p/Q=; b=lUJ3LpEP6r98th3O0
        4K+5iB0uku7U1jSOK/WhRYiypKj9nt7ZogjFa+Fm66/6Z8M1KRoFx3VZXUZMW5S/
        qWpEFpZ3HHtof6Bi1Pd+hORgHnB8f/fSNuDk1Rx7ZSGQ0RERuSiyzenegbRxKVDt
        RiKDUiHQAqKe9mhe5pqP1wgWPaO3hTKWEF0ePZZ7Yd0ZuvmNJNk4WfrhkonG3Rvp
        y/6zJTS0cMy/fYFbtGBm35Wb9pS7vg9KfswZxgTCREWv3C6A9VZzCxBLA06c2Dw1
        XK36GNt+oXpgiVEwgkqeZPyQEaP/PInSm9jPUDpKlTt1pieP9hSoaSt/6L3AmMaL
        mgVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=KBQJ2htm+9uNSNpB1V4iykXXKdsWXwGHJy4WSWj9p
        /Q=; b=GqKyIaWF9Rg4lLQtqUrcB6Q8Mg+DHcisLXb6tPIuvcoO0Km2/0DpNmm4K
        8Y7BXPAf7UMCwiYGERbbHtpqoFeK5VXTh9/tqxlw+9ptaVG7sR8o8vOsv02CMD7S
        +sxu6Mtw0x6uqfxw5dVZqpXNyt4TfPbfKPNEqMewDxjDcDIPZJXtU4Dmunf3/CoA
        E68tg9HeTcpDx+bt7/AKRdJwzdf1jv1ijHDt9j06r2sj7P8NnbL3i9b8PlYvdTjR
        DN7NMa8eXYCpGoWhBia74lUhJgA7C/fOUIuHqJ04z2zzZBO2VHeOR20eH0+q7EkJ
        9sfHN7jnVh+6Pj5Ucg09aCpemlHCg==
X-ME-Sender: <xms:cR44YfDcO0OZ7yVf7qw7FKwEJWqFCygHTI_X-MybMuLvr0Wu6FGALw>
    <xme:cR44YVjOMn66_rCD5pp3BDmvo2bWyLlQN13MrroHU19i4af5ghzUpNFsZ1MsKIfqA
    G_-5qfkEFv4LkBECg>
X-ME-Received: <xmr:cR44YalDheHy-e836mfcc8MrXLEBS_vNz7Jfc9vnZLUtPhRVq-HeD5H2r1kFxuxLCBLjZYh5X1VYGilZwkDGjKRda93sw_TDC7eSxXyjefV3r-zDGDMbACEW1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:cR44YRwRN_MmVcL7Z05EG1q1xe4egkawkUalaZ-dVv02Q12DEU7IcQ>
    <xmx:cR44YUQ15VGKT-eHqKDByJnYmNHQWwJMCVoVnvs4nHnd71mPwlLW3g>
    <xmx:cR44YUZiCWBgdwPOm1UppSHBnj7ZtKiPs7-uZn-r9USJWk_-LNT_Lw>
    <xmx:cx44YTFeGlIIrsXmGY3hPaxJxt8bsYR3MV8UCufFSY91Xy8lUY77aw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 22:22:41 -0400 (EDT)
Subject: Re: [PATCH] mailbox: sun6i: Make use of the helper function
 devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
References: <20210907074201.2553-1-caihuoqing@baidu.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <0d8c959b-d256-921c-e6a4-2f99e298b9cc@sholland.org>
Date:   Tue, 7 Sep 2021 21:22:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210907074201.2553-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/21 2:42 AM, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/mailbox/sun6i-msgbox.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Reviewed-by: Samuel Holland <samuel@sholland.org>
