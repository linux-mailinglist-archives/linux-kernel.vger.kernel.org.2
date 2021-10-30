Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042654408DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhJ3NCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 09:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhJ3NCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 09:02:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDC6360EFF;
        Sat, 30 Oct 2021 12:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635598793;
        bh=oHZNPIIOWVnapw7CjqfF9ZXvF6wdYZNsVtNzLU2Uyw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssXoZ0apzp8LX3RfOj5eP7AgLS3A2pKgV3+YF4ljS0YvkiPJcCM/9zI8ajltv7B4j
         OClbxsNWsJ4hlZ/7siyBZ77EwIH+MYkH9nV6OcFTpkn8h33LybqIeApTLcKwW04dKD
         nFBe3pUhN/YjXu8r4aF45eQYnjF2c5xzLMrFFZuDNm7sBCjUBgl0d+C8vWX9O3ZmNw
         onrPaX71kNyt1uCszuaK5qw5Ae5YnQIrXjKylnCv740bnyDA8Rtz9QOcTsrN3DG6tg
         swpLIoVf2TRpcua5DL+9e1dQCf0N0LPaBKPTNkqVq6RWEjTmIBZ8/kIoexMkQlw2RU
         2ftuj7v3WmmyQ==
Received: by pali.im (Postfix)
        id 89C1C1083; Sat, 30 Oct 2021 14:59:51 +0200 (CEST)
Date:   Sat, 30 Oct 2021 14:59:51 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation: arm: marvell: Add some links to
 homepage / product infos
Message-ID: <20211030125951.q6vo5mkr3ww4s5bv@pali>
References: <20211008160105.24225-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008160105.24225-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I would like to remind this documentation patch.

On Friday 08 October 2021 18:01:03 Pali Rohár wrote:
> Webarchive contains some useful resources like product info or links to
> other documents.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index c3d3f27edfbb..d4fe191bb88c 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -103,6 +103,8 @@ Discovery family
>  
>                  Not supported by the Linux kernel.
>  
> +  Homepage:
> +        https://web.archive.org/web/20110924171043/http://www.marvell.com/embedded-processors/discovery-innovation/
>    Core:
>  	Feroceon 88fr571-vd ARMv5 compatible
>  
> @@ -119,6 +121,7 @@ EBU Armada family
>          - 88F6707
>          - 88F6W11
>  
> +    - Product infos:   https://web.archive.org/web/20141002083258/http://www.marvell.com/embedded-processors/armada-370/
>      - Product Brief:   https://web.archive.org/web/20121115063038/http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
>      - Hardware Spec:   https://web.archive.org/web/20140617183747/http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
>      - Functional Spec: https://web.archive.org/web/20140617183701/http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
> @@ -129,6 +132,7 @@ EBU Armada family
>    Armada 375 Flavors:
>  	- 88F6720
>  
> +    - Product infos: https://web.archive.org/web/20140108032402/http://www.marvell.com/embedded-processors/armada-375/
>      - Product Brief: https://web.archive.org/web/20131216023516/http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
>  
>    Core:
> @@ -169,6 +173,9 @@ EBU Armada family
>      NOTE:
>  	not to be confused with the non-SMP 78xx0 SoCs
>  
> +    Product infos:
> +        https://web.archive.org/web/20150101215721/http://www.marvell.com/embedded-processors/armada-xp/
> +
>      Product Brief:
>  	https://web.archive.org/web/20121021173528/http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
>  
> -- 
> 2.20.1
> 
