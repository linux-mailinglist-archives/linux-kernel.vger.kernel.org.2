Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76195308129
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhA1WeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhA1WeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:34:09 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4627EC061574;
        Thu, 28 Jan 2021 14:33:29 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D9B906178;
        Thu, 28 Jan 2021 22:33:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D9B906178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611873209; bh=UVegkeZMC0EyLKdgsRxZ+7kPDhyKPiN03S2ZHqq1Abw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jaf180puJcNABt1tVMWkLPuXcznla4wko7zlknqI0VCZku6SW2FBEVXIWY1XgWEd3
         /zXDadP28QZj+OmZQbiLch1un4nCCh2CQ00AzkU+pFxPdDFth+yXec0XHEIS/IUSyU
         /cdi11k3zmJAsN3poi8XOQZSOBisfqNVko8Hawxws2ppSzIBweGvV9KF8P9YiH5+42
         aTAijWdwhJUsAcgfE2ikz+cGOdju/Q3YIGVdIQqcd95MfdjIRQVlmbSOhBSka3v8oq
         WWVDsVQj5P/bPBBxGiDiknefHYrkDcCNJsE1lmVnrPFuZJza2AcMW8PVnKzXkI9AVL
         J978r11lLM0RA==
Date:   Thu, 28 Jan 2021 15:33:27 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Fix dead link to Armada
 37xx Product Brief
Message-ID: <20210128153327.0325efe5@lwn.net>
In-Reply-To: <20210125141341.32200-1-pali@kernel.org>
References: <20210125141341.32200-1-pali@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 15:13:41 +0100
Pali Rohár <pali@kernel.org> wrote:

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index b16e6f7e8dbe..fa22a72d4391 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -183,7 +183,7 @@ EBU Armada family ARMv8
>  	http://www.marvell.com/embedded-processors/armada-3700/
>  
>    Product Brief:
> -	http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
> +	http://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-37xx-product-brief-2016-01.pdf

Applied, thanks.

jon
