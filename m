Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270C034BBF7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 12:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhC1KMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 06:12:42 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:46845 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhC1KMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 06:12:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 51A895803E6;
        Sun, 28 Mar 2021 06:12:00 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 28 Mar 2021 06:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=nBe6ljCMRlw6er0PufR3dMQkO6P2
        OQ3CjgbK+DA+tuA=; b=bbAWshKfcr+rB4cJdWm3CkjUwNioIlF4TROC0fc1wuO2
        nVtN7JXZRa5ln66MvXH8qvWmZegP2LOeB1XGY37Le72bBbd0uYx7DFZgGvy/rNdX
        UiQ6P2kmNjJl4+nbSJ5uYERP5Go8ilF2xaZnHNHMe2PO4wgbo59726e1EDxI9f1B
        f8FgQSB5NE5DstYcE7Q/M+h6taAL9ZDtJRmHpECGL1BwAAZi37cQmDO1hEl/AMuW
        SpNjmCbjoIu0ZKIpQ7JshnUS2FM0AehjszrBwt/N18vSTah6VYtu9m3vnGGasXC+
        aV2u0zWiBSr3ziv7D2uQqtIHTX8G4XBh2Ep0Qkq0Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=nBe6lj
        CMRlw6er0PufR3dMQkO6P2OQ3CjgbK+DA+tuA=; b=ltmzC4HUDNqw/YfArBqfPh
        Fi9yLPs3NTk8sv6Hm41QJATrx6kbPaXWmssH47mk0qoq8j5YrX+7IDXHGVtEIdzB
        x44EWzRYGZDCKHxe/fkZpclhkUBRB8eOxbARUhYx9eMBOt49ajEroYVgmEb2u0uz
        JorjQHwvacnFDE6BN7KZUMMxdPPPL0ZV1Tzm2q9ZXNmu5UJU/yS0cKX58XxnIa9c
        O7RsLY5yJs4h3vFvxMNyxTEoKvK2g5dc/8lCP0BIJLOvo7x+mgLSd8+NdCE/mmvZ
        VgZnDmsvYjKjLurItEiLdabjxYsIYvcs7u4NJlBh/nkDwHNvfnNpTUXU024tcPIA
        ==
X-ME-Sender: <xms:blZgYFlZWfEKtbGttn1S7b6gCE4956G3tixMPq-F6575ygoaoCciLw>
    <xme:blZgYA0dU93EsLsB-L9snYC80XLOUKBzATjEcZ0JtkhDrpWWo1B2tN8I5wq0gJqJG
    78kifv5L-4Ku4J9970>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehiedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:b1ZgYLpk2e0OtRQReBDL8ps5fX-LgbN0HAOzOjVkXs-qkqdwQsQqUQ>
    <xmx:b1ZgYFlragLPcoFtNQXwDWFglkx4zLerW5q6L-_72SC1RDEPFkLVGg>
    <xmx:b1ZgYD1vEQSNP7fO1DwKoBMmlI3gCTj3l-Qk7znXSAKJH0f19cyBHw>
    <xmx:cFZgYMLv8rJCnH46Z6cqIZGqa2dB7Qce7i75yEtqDNj0If-8DFid8WqCRIM>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C680251C005E; Sun, 28 Mar 2021 06:11:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <9ea84c5b-55db-4b16-aede-bf972e35f1f3@www.fastmail.com>
In-Reply-To: <202103281719.Xb7Kqjb4-lkp@intel.com>
References: <20210328074009.95932-4-sven@svenpeter.dev>
 <202103281719.Xb7Kqjb4-lkp@intel.com>
Date:   Sun, 28 Mar 2021 12:11:34 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "kernel test robot" <lkp@intel.com>
Cc:     "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Rob Herring" <robh+dt@kernel.org>, kbuild-all@lists.01.org,
        "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>
Subject: Re: [PATCH v2 3/3] iommu: dart: Add DART iommu driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Sun, Mar 28, 2021, at 11:34, kernel test robot wrote:
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/iommu/apple-dart-iommu.c: In function 'apple_dart_finalize_domain':
> >> drivers/iommu/apple-dart-iommu.c:427:34: error: implicit declaration of function 'DMA_BIT_MASK'; did you mean 'BIT_MASK'? [-Werror=implicit-function-declaration]
>      427 |  domain->geometry.aperture_end = DMA_BIT_MASK(32);
>          |                                  ^~~~~~~~~~~~
>          |                                  BIT_MASK


Fixed by adding the missing <linux/dma-mapping.h> include for DMA_BIT_MASK.

>    drivers/iommu/apple-dart-iommu.c: In function 'apple_dart_attach_stream':
> >> drivers/iommu/apple-dart-iommu.c:456:11: error: implicit declaration of function 'kzalloc'; did you mean 'kvzalloc'? [-Werror=implicit-function-declaration]
>      456 |  stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>          |           ^~~~~~~
>          |           kvzalloc
> >> drivers/iommu/apple-dart-iommu.c:456:9: warning: assignment to 'struct apple_dart_stream *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      456 |  stream = kzalloc(sizeof(*stream), GFP_KERNEL);
>          |         ^
>    drivers/iommu/apple-dart-iommu.c: In function 'apple_dart_detach_stream':
> >> drivers/iommu/apple-dart-iommu.c:523:5: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
>      523 |     kfree(stream);
>          |     ^~~~~
>          |     kvfree
>    drivers/iommu/apple-dart-iommu.c: In function 'apple_dart_domain_alloc':
> >> drivers/iommu/apple-dart-iommu.c:627:14: warning: assignment to 'struct apple_dart_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      627 |  dart_domain = kzalloc(sizeof(*dart_domain), GFP_KERNEL);
>          |              ^
>    drivers/iommu/apple-dart-iommu.c: In function 'apple_dart_of_xlate':
> >> drivers/iommu/apple-dart-iommu.c:659:7: warning: assignment to 'struct apple_dart_master_cfg *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      659 |   cfg = kzalloc(struct_size(cfg, streams, 1), GFP_KERNEL);
>          |       ^
> >> drivers/iommu/apple-dart-iommu.c:663:13: error: implicit declaration 
> of function 'krealloc'; did you mean 'kvcalloc'? 
> [-Werror=implicit-function-declaration]
>      663 |   cfg_new = krealloc(
>          |             ^~~~~~~~
>          |             kvcalloc
>    drivers/iommu/apple-dart-iommu.c:663:11: warning: assignment to 
> 'struct apple_dart_master_cfg *' from 'int' makes pointer from integer 
> without a cast [-Wint-conversion]
>      663 |   cfg_new = krealloc(
>          |           ^
>    cc1: some warnings being treated as errors
> 
> 

Fixed by adding the missing <linux/slab.h> include for krealloc, kfree and kzalloc.


Thanks,

Sven
