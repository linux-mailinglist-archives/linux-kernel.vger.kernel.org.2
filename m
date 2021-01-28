Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3033B30812B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhA1Weo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:34:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:47770 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhA1Weg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:34:36 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CDAFA6173;
        Thu, 28 Jan 2021 22:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CDAFA6173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611873233; bh=fS59KfobZUM6JC6PVLLA2UYB8/xwg3yiTbkGxp5JOv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cIEOb+XEMweAqSOdtuRSPyS7DgAM3/hB3n94iZkgvcpPQW8VwbuirfujybQnFz2l4
         D3rjPn3v8BwjVwP+1qlKwuHUwFixnpbb9xWvbBpMBQnO2XYLeiLNshpBnzEDmzBR92
         N7xbEq2n4IDJjO/I4TXeFl8yxYGJd657EB0TsFXHQXmcX3ecoaWuK8d566ue/bfea/
         axgcvY1TciVGFMA7Bv0I2vzCHbK6QocgRiWbagtK+B9ohxBeGR1GFnz8MnMUntyd1L
         VunJIz0UsfZ0re0+7nGn2T24ECslWvFFj5SHLyNUYsKbNiG8QZ+p9LwsL2LMQjo8lI
         U3Og4SdfH/fEQ==
Date:   Thu, 28 Jan 2021 15:33:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Update link to
 unrestricted Armada 38x Functional Spec
Message-ID: <20210128153351.1b5a716d@lwn.net>
In-Reply-To: <20210125141529.32357-1-pali@kernel.org>
References: <20210125141529.32357-1-pali@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 15:15:29 +0100
Pali Rohár <pali@kernel.org> wrote:

> On Marvell website is documentation accessible without need to register or
> fill any other forms.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index fa22a72d4391..94cd73383594 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -127,7 +127,7 @@ EBU Armada family
>  	- 88F6828 Armada 388
>  
>      - Product infos:   http://www.marvell.com/embedded-processors/armada-38x/
> -    - Functional Spec: https://marvellcorp.wufoo.com/forms/marvell-armada-38x-functional-specifications/
> +    - Functional Spec: http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-38x-functional-specifications-2015-11.pdf

Applied, thanks.

jon
