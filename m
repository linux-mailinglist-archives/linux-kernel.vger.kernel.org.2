Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5834419862
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhI0QB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:01:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33967 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235344AbhI0QBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:01:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 294B35C00CA;
        Mon, 27 Sep 2021 12:00:03 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Mon, 27 Sep 2021 12:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=eh67QKmwClsy9IbTfPVdRQKHeIBl
        iV9TgpWJWy117KM=; b=K5CtSsMuBalnM6897s2eWHVH9+hZcDmaCXhYWOHPxRRG
        hG5CybuXTAIOPbaWS+Jryw1bah/jpa9UUPzGp5Vnu56I948lGsZn/zYUFT9ppky2
        K656rntCxEuGqbl+4affBOynqoM/rhxpdvue8LXAouC3/TH6keZ3Mp/8umTE6mfy
        LP0kDYweLMUomZFliYQRPSkIbTvWNHq7Kyt7kLpBU7Usq/DYC9pjvUR9zs8g+rfB
        39+Y4PfNT9VuJxCNq9M+Nxb85faJKbL59yWr1bmJ1yVDAeiKmCN3t1S4X5TPSOTg
        EmzRk54G5XvIc0CV0FwyTfQ2rzhIwJXiebpl2I7Hug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=eh67QK
        mwClsy9IbTfPVdRQKHeIBliV9TgpWJWy117KM=; b=kyA9yX+AEkSljXFw9pRcxE
        UHbrB1t6fKm/QXy2Poa4DXkGxuAOB0jIjEIfqlvJQZZpC5mMPTHSBpB6oQ8LDdkL
        UZT4eVVCUYXk0vDp9nt75y73E44g7kcBXECJB4yw0Inyc3TUeR8WB27S0hdeIgnk
        dRyM6nU26lFwNeKnaxjbjO3BAE+RBsu2+uNeNcsxAsu1EbisnOSozc/7BE1HNQZf
        xLnwLDqPU812yrbwoZ1BZuaNd4eTsRda83bS1zK0KizunOxNXJOR3gQPnaASa+2I
        kqq+oE2X4+gsaIvcocs0QmebB4lcFflMsRwATDrSq8cSwWs8RgInEqa3QejC8cig
        ==
X-ME-Sender: <xms:gupRYVT7mbB1KpWpLfvV9MDC1IAb1-T0Lc_pf9ZB7hMo2zyanvg7xQ>
    <xme:gupRYeyWw1pgTVtF5Bmt24gbjxybhrR6WGOC65e3vkKDKql45vIwpp5ibN57pWTiE
    WrEdrmbCUE5Vyz-Y-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejkedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeevvdegveduvdevvdfgleefgeeivdegheeiuedtleevvdeiveevleejfeev
    tdelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghv
X-ME-Proxy: <xmx:g-pRYa2izx8oz269K0ptP8BtFb83UgSimjKy1ZSBE3i7_b4OSQCvwA>
    <xmx:g-pRYdAd71ku9TzKiPFWFZuA_MHkMn2r5sWwikC8BXsp1qq1aLMIoA>
    <xmx:g-pRYehVnDf1J45dhJ5pHifrMaPjhOX22RRRHnuReg7VmxLzjMHniQ>
    <xmx:g-pRYQYmFX7JxWafUYA75r0__EwdLFfdXmxSwE9CjchbVf6-M8MuYA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DC14651C0062; Mon, 27 Sep 2021 12:00:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <df160284-55cb-4642-abc5-65f6aa61b48d@www.fastmail.com>
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
References: <20210927154306.387437-1-kbusch@kernel.org>
Date:   Mon, 27 Sep 2021 17:59:40 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Keith Busch" <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        "Orlando Chamberlain" <redecorating@protonmail.com>,
        "Aditya Garg" <gargaditya08@live.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Sep 27, 2021, at 17:43, Keith Busch wrote:
> Some apple controllers use the command id as an index to implementation
> specific data structures and will fail if the value is out of bounds.
> The nvme driver's recently introduced command sequence number breaks
> this controller.
>
> Provide a quirk so these spec incompliant controllers can function as
> before. The driver will not have the ability to detect bad completions
> when this quirk is used, but we weren't previously checking this anyway.
>
> The quirk bit was selected so that it can readily apply to stable.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214509
> Cc: Sven Peter <sven@svenpeter.dev>
> Reported-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reported-by: Aditya Garg <gargaditya08@live.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2: fixed logical bug checking the quirk setting
>
>  drivers/nvme/host/core.c | 4 +++-
>  drivers/nvme/host/nvme.h | 6 ++++++
>  drivers/nvme/host/pci.c  | 3 ++-
>  3 files changed, 11 insertions(+), 2 deletions(-)

Looks good to me, on the M1 with my out-of-tree driver:

Tested-by: Sven Peter <sven@svenpeter.dev>



Thanks,


Sven
