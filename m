Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F283F399E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 10:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhHUI5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 04:57:01 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56143 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232802AbhHUI5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 04:57:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id AA9955808E8;
        Sat, 21 Aug 2021 04:56:20 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Sat, 21 Aug 2021 04:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=h9Kir/nZ4viveWZj6if1mMoXrM2T
        79miit0Y6rMxCEQ=; b=EM2C91GmGrHqFGh783WiDVgsDjZMi8pTb3mo5cYNpPHr
        iLozLvafGomEW2jN2hOZ2dPMcnKQ9P5XBjfjjQ9zUIZpwC3Hz2omaeCTxvIk65ea
        LBDI1sqVF/fNQT4P87gvAbLorb+8dEIuTh9rAYfp6dQJtgluVZEv9acoZXLXBIGq
        ps3zXaYO28KwnyJU4+ogxT2g+MLkJt3tGoO160MMcxG3pgaA12SMhsLXgdP9ThJa
        BE6+bJMal9DlVP0t41pJc21diaVTXdR4Ox+Pg2VLrGKUKqIG1iEX7Nu/cPP5jtEb
        QCyDOsKtynpx1kc66nzjDMDp1VFtqs8u4qWGWxLEWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=h9Kir/
        nZ4viveWZj6if1mMoXrM2T79miit0Y6rMxCEQ=; b=MFS74d/0EDmAvum/E8QaZB
        kH2F5bbYwUvVN3TIYhuipoMTqwB2Tr7LhmxxbbIE3i4ovfAS74wI9d8MWHLxty4R
        lHsBtPCFRmXBsCG5AeGUeACEyHukD0uwGz1K6fiQDVdPXk2G3Si01JbFhOYuXkZ2
        Gc+PW3qJvqstPUQ0unWos52Cc26LNEy/k5xC6Mc2Wst66LwdzatvWULAEx9FRpst
        ThwiknP0C6VZFmLD3wIvLBdu3P2XLYG6WWLU1DYPdYnHb9VmVe33q/Vx1RTjt3/K
        2mnnZsTnX71RKVE91Z5PDMYsAeg/AwRq+dA2f2gDz8Lpiq26wDIcQJ7g/K8LD8kw
        ==
X-ME-Sender: <xms:r78gYeEJvDR5AvsMahKMyU3TF8l58iVSlNe4YdHyeNDTq_x4K9P8vA>
    <xme:r78gYfV2UuZnfhGjNAVV1vXinzDSZsD7z9em63H0cLoJVwHnhopqVaA2OCMorDvsS
    bXRNnQCuyC6vfsIVTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:r78gYYIcOT94hR5G3e1oSh-RroUfbmvdg-RnBOuHaJWbrHjyHjhAww>
    <xmx:r78gYYFbqYMSwszfFwdoB8BYddxPImIjziBNPDm9lGUy5E7pDoXcgw>
    <xmx:r78gYUWggawHUsAA-3ynIaoqtseBuh391-tuWQ8eSotrs8Cc3f17uQ>
    <xmx:tL8gYaaGJviswBV6IMd-yrKua90y5suaZTYtN-KDNrhq0bYbmYT7IQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 023C451C0060; Sat, 21 Aug 2021 04:56:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1118-g75eff666e5-fm-20210816.002-g75eff666
Mime-Version: 1.0
Message-Id: <5704924b-e3e3-404a-a4f4-e38ece82673b@www.fastmail.com>
In-Reply-To: <914d7243-7f9d-425e-1ff7-6be218e04913@arm.com>
References: <cover.1628682048.git.robin.murphy@arm.com>
 <YRzvGxTW8m+NUcSi@8bytes.org> <914d7243-7f9d-425e-1ff7-6be218e04913@arm.com>
Date:   Sat, 21 Aug 2021 10:55:52 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Will Deacon" <will@kernel.org>,
        "Sven Peter" <iommu@lists.linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org, rajatja@google.com,
        chenxiang66@hisilicon.com,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Yong Wu" <yong.wu@mediatek.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Chunyan Zhang" <chunyan.zhang@unisoc.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Joerg Roedel" <joro@8bytes.org>
Subject: Re: [PATCH v4 00/24] iommu: Refactor DMA domain strictness
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Aug 18, 2021, at 17:13, Robin Murphy wrote:
> Sven - I've prepared the follow-up patches already[1], so consider 
> yourself off the hook (I see no point in trying to fix the nominal DART 
> cookie bugs between now and then) :)
> 

Great, thanks for taking care of that! :)
Just tested your branch and everything works. Feel free to add 
Acked-by: Sven Peter <sven@svenpeter.dev>
Tested-by: Sven Peter <sven@svenpeter.dev>


Best,


Sven
