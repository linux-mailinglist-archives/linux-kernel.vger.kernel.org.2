Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000B23FF326
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346952AbhIBSUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:20:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33169 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233296AbhIBSUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:20:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5AB1B5C01ED;
        Thu,  2 Sep 2021 14:19:36 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Thu, 02 Sep 2021 14:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=rWeCfc9VwEpivgH3ElxeF4AP9Em0
        hx7fi+pEfHiMVP4=; b=AuInL9tN1I1ovcXm4oG4VDeb5jtx8G5LKfAsBPLTi6Lf
        dnZAs/tBmxQBlex49291A2gqYLEcepIl5T7llHDUrBvJkRRHWXY/SfqfFloLxwUM
        fIWQ7LmoGv4Oc+uxNQH5TsXifPiY0sCO/gAzY3z6DSKJYEsExMZXbII69AoqY22l
        Bm4dJHFQn+YRHScbkKXtHyqBVhE1P083J6RZhUYPNFyud+JSzRNV++MHS+iEk6ci
        PoERh7wq7dUbh0ygvb39am+89kbKIdeFfolYAB6G/oh3vd6oYLY4aAM2PBRWZE0S
        iMm1hfgO+/YQjr5E8Ih5NkA0H4Gza0XUDW5QzQizVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=rWeCfc
        9VwEpivgH3ElxeF4AP9Em0hx7fi+pEfHiMVP4=; b=G2ACLst9n6EmcBeuB8t9Cn
        UBicpUedbICpaGir/glrW/F8YtEdsTQdUGbkupVVEgEt0yxShv1Zx/tW5wZK944B
        IzbJZxfsh6km8yo1bOllE/K/D9CXaqHmRIoWOcwMybF7ZNwCJ4VbyKpPkQw32AwD
        /mpI5FdyNtBjj8tlCMVR4SeT1+DnkjkWVWyhuVSWnbfRfHbtYhSlYcaLPzkVgEI9
        0fm7ydZz79dAdthQ8FdjXtgz5r9JVZCM9SXVoDXdj7VzrfdMR/smQne6fQ6A9qRA
        oEZXqavnx4GHO8CDDelMs03dJf7ZngDiWXGHoPDH8ZX56gyWWE2qSEIjkf5Xqofw
        ==
X-ME-Sender: <xms:thUxYVZuhxZYcoe_qdFU0FdyQ4gCxYPYbOaeeJlRqbKTPEYbZjrmUA>
    <xme:thUxYcZaCdjbboWop334Ue9vAs-H740nzRJW12JLCekcEGHoQbH6l2fCasjsD1-42
    zkeS9TE3tgzcLuj8d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvhedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepheejgfdttdefleefteejieefudeuheelkedtgedtjeehieetueelheeu
    hfegheegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:thUxYX_icb1Yp-gID7QAuwGMOImvvcuh6gjHKsc6OX1BV5lXF3Ifxg>
    <xmx:thUxYTr28i5ympL4m7VJYC9L6G7dTTPSozfvQEfsZ6b3izsU5zyvuw>
    <xmx:thUxYQq3ZszLDwtsPx25SdK5ff4GnVjVRxdxzyQ2Vw8C8cH9Drpn4Q>
    <xmx:uBUxYYIiN0F8L85rZKUf0uGrySzkqfGJkE9RfT4WvNi65pZzcH7qGg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8810451C0060; Thu,  2 Sep 2021 14:19:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <ac34e920-d1b4-4044-a8fe-5172d5ebfa9c@www.fastmail.com>
In-Reply-To: <YS/sMckPUJRMYwYq@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-4-sven@svenpeter.dev> <YS6fasuqPURbmC6X@sunset>
 <c8bc7f77-3b46-4675-a642-76871fcec963@www.fastmail.com>
 <YS/sMckPUJRMYwYq@sunset>
Date:   Thu, 02 Sep 2021 20:19:14 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     "Sven Peter" <iommu@lists.linux-foundation.org>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Alexander Graf" <graf@amazon.com>,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_3/8]_iommu/dma:_Disable_get=5Fsgtable_for_granul?=
 =?UTF-8?Q?e_>_PAGE=5FSIZE?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Sep 1, 2021, at 23:10, Alyssa Rosenzweig wrote:
> > My biggest issue is that I do not understand how this function is supposed
> > to be used correctly. It would work fine as-is if it only ever gets passed buffers
> > allocated by the coherent API but there's not way to check or guarantee that.
> > There may also be callers making assumptions that no longer hold when
> > iovad->granule > PAGE_SIZE.
> > 
> > Regarding your case: I'm not convinced the function is meant to be used there.
> > If I understand it correctly, your code first allocates memory with dma_alloc_coherent
> > (which possibly creates a sgt internally and then maps it with iommu_map_sg),
> > then coerces that back into a sgt with dma_get_sgtable, and then maps that sgt to
> > another iommu domain with dma_map_sg while assuming that the result will be contiguous
> > in IOVA space. It'll work out because dma_alloc_coherent is the very thing
> > meant to allocate pages that can be mapped into kernel and device VA space
> > as a single contiguous block and because both of your IOMMUs are different
> > instances of the same HW block. Anything allocated by dma_alloc_coherent for the
> > first IOMMU will have the right shape that will allow it to be mapped as
> > a single contiguous block for the second IOMMU.
> > 
> > What could be done in your case is to instead use the IOMMU API,
> > allocate the pages yourself (while ensuring the sgt your create is made up
> > of blocks with size and physaddr aligned to max(domain_a->granule, domain_b->granule))
> > and then just use iommu_map_sg for both domains which actually comes with the
> > guarantee that the result will be a single contiguous block in IOVA space and
> > doesn't required the sgt roundtrip.
> 
> In principle I agree. I am getting the sense this function can't be used
> correctly in general, and yet is the function that's meant to be used.
> If my interpretation of prior LKML discussion holds, the problems are
> far deeper than my code or indeed page size problems...

Right, which makes reasoning about this function and its behavior if the
IOMMU pages size is unexpected very hard for me. I'm not opposed to just
keeping this function as-is when there's a mismatch between PAGE_SIZE and
the IOMMU page size (and it will probably work that way) but I'd like to
be sure that won't introduce unexpected behavior. 

> 
> If the right way to handle this is with the IOMMU and IOVA APIs, I really wish
> that dance were wrapped up in a safe helper function instead of open
> coding it in every driver that does cross device sharing.
> 
> We might even call that helper... hmm... dma_map_sg.... *ducks*
> 

There might be another way to do this correctly. I'm likely just a little
bit biased because I've spent the past weeks wrapping my head around the
IOMMU and DMA APIs and when all you have is a hammer everything looks like
a nail.

But dma_map_sg operates at the DMA API level and at that point the dma-ops
for two different devices could be vastly different. 
In the worst case one of them could be behind an IOMMU that can easily map
non-contiguous pages while the other one is directly connected to the bus and
can't even access >4G pages without swiotlb support.
It's really only possible to guarantee that it will map N buffers to <= N
DMA-addressable buffers (possibly by using an IOMMU or swiotlb internally) at
that point.

On the IOMMU API level you have much more information available about the actual
hardware and can prepare the buffers in a way that makes both devices happy.
That's why iommu_map_sgtable combined with iovad->granule aligned sgt entries
can actually guarantee to map the entire list to a single contiguous IOVA block.


Sven
