Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD773FE101
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344563AbhIARPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:15:46 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57977 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238873AbhIARPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:15:45 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BB1B5C0076;
        Wed,  1 Sep 2021 13:14:48 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 01 Sep 2021 13:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=PjI/Na3u99SdyJiZLuyCXPem/Uar
        db9RSRjNBRnAjTs=; b=UdwBpIi5+aPrVMeubICwqzZ+llcAdAR05tucL01juVRT
        nGKaB+eE/Iy0StUKvrPNyTMRa5Ob/wahSGNbK3/Oa5r70yJ0jp6TBRhoKddJNpeh
        M3iy54fDqlgE7TitGBKfPp6fj5JKuU44ANcLFXh1oJN9ScYBovp9qTAD3eC2Cfme
        lp+dz+9mVa/b25VrDfNgxuhyE0zfhA+mbP7OwenJ2zLeNTqkDaOC1DvyzTRsM5A4
        rxi+OOZ8wncpD9ItTeXVJeL8iaqDaMu6/l2dp8sm0S6bgbHjf2gLsTmff3BA6kE9
        phgNq7Y44jC0ZvkF6QbkiklatyS3a2eL+YNIlqwZ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PjI/Na
        3u99SdyJiZLuyCXPem/Uardb9RSRjNBRnAjTs=; b=qy6Y0tkBC5GAe4YphlEuTp
        Gj2DToBLWWn022elJsSRXYOy7MkorEbyu7ghipPnL0kk+oMwTj/aKIutsJ2Tyhq/
        ncYlMQ6OUW/OGGQhA2VThCfr33apDPFGbSj3/eYFktwLGT+cA+2I/KfkNkwKc8+k
        /YyYFMSnArCzb7vq2hOUf9huZl63dlgVo9gk56kPdTs1nUNfr72uc3S81JPx+xJ7
        7hVbvT7GJWG964ruks4Ku/cQU3rpbseIgREaa7KPXa6BeYspCUXy6PukuQQZ51YB
        pb4XDuXp3dU1nQemEnFXmJpvXmSHtIaEeCR/g4GaM/xrelvxYoBe1HT4bczf/7Jw
        ==
X-ME-Sender: <xms:BbUvYQ1sNZhPhSWZ8wIVBe4sSyytxkhOf_z9JCSwcl03vMZPCBfnVA>
    <xme:BbUvYbHLxPe1UnR19Mh0Iz_PGkO5OCoFmF3Wr_QnrhXk-rmzgzuJDHaoaHfZbcf2n
    felhpgWMqlinKYmASY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:BbUvYY4YWIp3Eb0cjlTcK1NGDzD1hrSg7GgJW2rxK-EuY4W2S8kHBw>
    <xmx:BbUvYZ10XRl0fzvhCwZqF4SUKtlI4YUGzihYB7hXH5q8SHvrCx4PaQ>
    <xmx:BbUvYTF5j6atbFgqgrjN_jnYqxpqZx84e1kINutI5izBjfKDKxOq5w>
    <xmx:CLUvYS2kLBGQjA-3vfiLoeN_eHZSpnyrNkz9Yvh7O3ivVbhnvwUvmg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7845151C0061; Wed,  1 Sep 2021 13:14:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1126-g6962059b07-fm-20210901.001-g6962059b
Mime-Version: 1.0
Message-Id: <adee671d-976a-4906-8592-c7391da9906b@www.fastmail.com>
In-Reply-To: <YS6hl0gAOMoMxNhf@sunset>
References: <20210828153642.19396-1-sven@svenpeter.dev>
 <20210828153642.19396-7-sven@svenpeter.dev> <YS6hl0gAOMoMxNhf@sunset>
Date:   Wed, 01 Sep 2021 19:14:24 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Cc:     iommu@lists.linux-foundation.org, "Joerg Roedel" <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Alexander Graf" <graf@amazon.com>,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] iommu: Move IOMMU pagesize check to attach_device
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Aug 31, 2021, at 23:39, Alyssa Rosenzweig wrote:
> > +	if ((1 << __ffs(domain->pgsize_bitmap)) > PAGE_SIZE) {
> 
> Not a fan of this construction. Could you assign `(1 <<
> __ffs(domain->pgsize_bitmap))` to an appropriately named temporary (e.g
> min_io_pgsize) so it's clearer what's going on?

Good point, will do that for the next version.

> 
> > +		pr_warn("IOMMU page size cannot represent CPU pages.\n");
> 
> "Represent" how?
> 

Looks like I dropped an "exactly" there when taking this line from iova.c :)



Thanks,


Sven
