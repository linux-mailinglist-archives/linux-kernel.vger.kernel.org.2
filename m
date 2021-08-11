Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B653E8F32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 12:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbhHKK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 06:58:59 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46395 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhHKK66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 06:58:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 452813200924;
        Wed, 11 Aug 2021 06:58:33 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute1.internal (MEProxy); Wed, 11 Aug 2021 06:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm2; bh=QukJRM727lS1gcuLKaQE+uIs0YGF
        NOFtD4CuEIR6MPc=; b=FNl7oUb5D9vB2uK/GMLSX1rHvVIjzLSnoEph6wFYu7DO
        mPzyzb+Si/Lx/uTQaJxWDbGGFfJdnCUBEUIt9GTeXK5KHZi6CUvcn2u7Unjl8Mek
        80Eocr9ZlWWmpuuakYZDbcVpMkJtA5DFr4p3/pMQ0utJThRtDtl4gnh6YXYZZx7x
        Cw3AsyAj1M/yXmjwNTFWQNFFC4F0GZTAANKYYVD2GypitECpjbfd6ZdifO4OeXJH
        q+dZBEd3SSm0DtqiPNhCs1Bpb1fLPtHdH4pBk4oX50WD0tknuoKrd1iG7gjPqp46
        /MMYlP9SpLS11tnk3G8fHGMzQtE4AO2MCKu2Q5kdqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QukJRM
        727lS1gcuLKaQE+uIs0YGFNOFtD4CuEIR6MPc=; b=RIOSccIeM5FEJgfw+v4sju
        ZivFE5AJkDojefZ/2o1JnvQwVvrY6ClDO7sFVhb8D2cGDtI8qYpb0zmdlt0Osdw4
        gavkSudCOi3AMyb1L9HBdXmgM4gXyS87C45yhUjPj3yJ+RgtkznvTRa/aSXo1oeF
        ZxqWUnxH8ksuKuEEqDZv8MzKmWF8ehxekzBCutoYedPGvEGD7Dus0wBXSULtZGQg
        DdCr9LJX2PiwPEbzXOkE9Pnb0psG2seZdsxWzyYW6qk9yy+k6vaJykwEyWjDsxAe
        Y0R7U58qYizLxW/4zfQspEDXG7iE5rUK6QtJkwpmuDd8X2w/Qr7yNQSQf8Wo8hBg
        ==
X-ME-Sender: <xms:V60TYXS5cIxUkw7NnUTXdaqwv0IO1sr8YQ87vbsnmxjJv5OmKHkdwQ>
    <xme:V60TYYxKg-kn_h4wB77yQzJn8LF6XsIobRvYFY7o7Nr6NakuaR8gCtlU1sgth7pao
    ZwRswsMsJOFtGXC4jI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudehvdef
    keffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:V60TYc3dUHrSsWRdqteQyKmRaqhGUg2N94cWYdgXFHfno-lS7yWr9w>
    <xmx:V60TYXAKlD-7k-yYd8Pab2xlnT8Ira7sl2lT5IIRHE-M_vJSwjHxBg>
    <xmx:V60TYQjW7A5CGo0XrIP6TdG99bWYGuYJdVIIRRYArSp8qx76mm90jg>
    <xmx:WK0TYYdzi1IUMOIDZnzq1vCG0Krr9Y3dT2ns2_8rNsn9wYhMuvLTqg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B01051C0060; Wed, 11 Aug 2021 06:58:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <ae4e4b9f-add0-4ab2-9c82-04124b1862b7@www.fastmail.com>
In-Reply-To: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
References: <44fcf525273b32c9afcd7e99acbd346d47f0e047.1628603162.git.geert+renesas@glider.be>
Date:   Wed, 11 Aug 2021 12:58:10 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Hector Martin" <marcan@marcan.st>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: APPLE_DART should depend on ARCH_APPLE
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch, thanks!

Acked-by: Sven Peter <sven@svenpeter.dev>

Sven

On Tue, Aug 10, 2021, at 15:47, Geert Uytterhoeven wrote:
> The Apple DART (Device Address Resolution Table) IOMMU is only present
> on Apple ARM SoCs like the M1.  Hence add a dependency on ARCH_APPLE, to
> prevent asking the user about this driver when configuring a kernel
> without support for the Apple Silicon SoC family.
> 
> Fixes: 05ce9d20d699b093 ("iommu/dart: Add DART iommu driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dfe81da483e9e073..e908b8222e4ed679 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -292,7 +292,7 @@ config SPAPR_TCE_IOMMU
>  
>  config APPLE_DART
>  	tristate "Apple DART IOMMU Support"
> -	depends on ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +	depends on ARCH_APPLE || (COMPILE_TEST && !GENERIC_ATOMIC64)
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE
>  	default ARCH_APPLE
> -- 
> 2.25.1
> 
> 
