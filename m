Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C6B34B805
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 16:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhC0Pe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 11:34:26 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56821 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229582AbhC0PeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 11:34:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 67F1258055A;
        Sat, 27 Mar 2021 11:34:12 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sat, 27 Mar 2021 11:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=C7jUmzBlfmU9VFdYvmkyNor1Zqsj
        5fCr/9TW5SN6eG4=; b=cejNuovTAzdGTboZGSEobUwyj2OEBYn4LYOBN+UDnLmH
        f55CfBtYftdhKeCuZ+MGt8o7smZ0EaSsAfy9iVYge7EJ2AbYWRo1xUnr41Bsj5WC
        JfWy44cCOpuaKx9B37gWO3zrJa8jVeRXYWbzNs8k3Yqk+49lM5BhCWgHc6rnpnO7
        3wttehSaRphhIJ091wvtCkbu7dF8xxNryyGWIQzkq8y5wRdeQqep4R6dVRt33gCQ
        w3HIl+vARuRnFz9mUMMKR66Kfo1No4Szo0sW2mPFQa0kAmh74tIPEi3kNSHbEUX8
        MkGRf++HdPhPu6V7OjWwMP6vxHsLoyVuVe6ZUNfvdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=C7jUmz
        BlfmU9VFdYvmkyNor1Zqsj5fCr/9TW5SN6eG4=; b=KSStNAPRTX4FY94hwirZH5
        NtxQPIDTc2Tgq/dWZS3eABO/xJiFidm9zflpeUlb6i3Q6DAwnXeIYyVRqx1AcKLS
        1qz7rYzsaNhX+T//2nR9xIwnQM9K0NNPkBSEQIS+phXRVysFUK3lhqaps3z3lHrE
        F+9rTCBH0TKNRbHB5Y6roDui4sL0VdPnYuaQBSIYPO83epf8r2kGsg9eOp7b8JZa
        F0+XDu/dxfdZQvTO7HCp/wTbXjZEnAZhte+dAi6doLS88uyE8twBdGVHcyZBHGPg
        dpQ/9Y21a3E7TS2fZ4SJqnuOW5Z0qzShqpqbIu+WsrMMqxluMExX9TqFQwdfhPHQ
        ==
X-ME-Sender: <xms:clBfYOFPFuws3Bogj8L6vut9IW4jx38qBwnkGazFCO1hfksMFHfvtw>
    <xme:clBfYPVEppoHRsrWMflX_-brzskMBca5R-sXBE2kVM8R6P9Fz9EFP366wzJsdWzj8
    apJiIt9R_HhOVossw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpefgieegieffuefhtedtjefgteejteefleefgfefgfdvvddtgffhffduhedv
    feekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:clBfYILS-zl8gTS50EZ6Xnlf0E7o21PnqahQbGpOM0GfyYJ9tL70GA>
    <xmx:clBfYIHZFADctNDkDLF7q5lbiLRj-gRWHR9icvvmgbK1GtMPbOoTxQ>
    <xmx:clBfYEVGemGhCYso8sTXthkYfvkPDIe96iyd9aMHfUdaQo0fGTSzzw>
    <xmx:c1BfYDNrk4QCK_Cx8E802W2WRJYlwHEiW_qIyGoCM2tjsK1kUrDCZIeZ8f4>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6169E51C005E; Sat, 27 Mar 2021 11:34:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <26c9b3cc-a04f-444d-ada4-0c9bc99684e5@www.fastmail.com>
In-Reply-To: <33b3ce35-c42f-331a-79a2-e38917d588ef@arm.com>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
 <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
 <33b3ce35-c42f-331a-79a2-e38917d588ef@arm.com>
Date:   Sat, 27 Mar 2021 16:33:29 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Robin Murphy" <robin.murphy@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        "Will Deacon" <will@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
        "Hector Martin" <marcan@marcan.st>,
        "Marc Zyngier" <maz@kernel.org>, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


On Thu, Mar 25, 2021, at 12:50, Robin Murphy wrote:
> On 2021-03-25 07:53, Sven Peter wrote:
> > The iommu binding documentation [1] mentions that
> > 
> >      The device tree node of the IOMMU device's parent bus must contain a valid
> >      "dma-ranges" property that describes how the physical address space of the
> >      IOMMU maps to memory. An empty "dma-ranges" property means that there is a
> >      1:1 mapping from IOMMU to memory.
> > 
> > which, if I understand this correctly, means that the 'dma-ranges' for the
> > parent bus of the iommu should be empty since the DART hardware can see the
> > full physical address space with a 1:1 mapping.
> > 
> > 
> > The documentation also mentions that
> > 
> >       When an "iommus" property is specified in a device tree node, the IOMMU
> >       will be used for address translation. If a "dma-ranges" property exists
> >       in the device's parent node it will be ignored.
> > 
> > which means that specifying a 'dma-ranges' in the parent bus of any devices
> > that use the iommu will just be ignored.
> 
> I think that's just wrong and wants updating (or at least clarifying). 
> The high-level view now is that we use "dma-ranges" to describe 
> limitations imposed by a bridge or interconnect segment, and that can 
> certainly happen upstream of an IOMMU. As it happens, I've just recently 
> sent a patch for precisely that case[1].
> 
> I guess what it might have been trying to say is that "dma-ranges" 
> *does* become irrelevant in terms of constraining what physical memory 
> is usable for DMA, but that shouldn't imply that its meaning doesn't 
> just shift to a different purpose.

Should I add a patch to clarify this paragraph for v2 or submit a separate
one-off patch? I'm not entirely sure about the process here but I could add
a Suggested-by: to the commit if that's fine with you.



Best,

Sven
