Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF80A3F69D6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhHXT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhHXT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:28:27 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4972C061757;
        Tue, 24 Aug 2021 12:27:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 92C9250E9;
        Tue, 24 Aug 2021 19:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 92C9250E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1629833262; bh=A3+VlXR7mc/2eOlBpznq28QXal6oafqCqYoo9KBE/PI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YHVK1WzMhtZzxnvg59TwCg2BuM9OvZeQgGsbqWQOZzXxlo+MUopaIBCkQIKXBFNio
         Lft4dme6ifl8vv/wXfISAIADnTpHRe1yK7yfxCrgIdd1ESmh5D3L7BaRTWCXeRBfp9
         6OFrnfxqvOYorDEDpgzhVencgE95hWRbWRlSbaGZHUu6CfMXx+83ntjXdAvD2PraCo
         WHTXg818RWVDJPudcJRF0JU4DgL0CQ9ou0GWmdzLeylISsJhTcf0yqAe4OZnMtPLhN
         TSXj6xyBH/v1LYuyVx4VtrKOpVUR6gTysui8UHNqiAQoBgQLn++eY7iCgidM5ERkG5
         pG9ozTWh8/mnQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add 88F6825 model into list
In-Reply-To: <20210814124805.14568-1-pali@kernel.org>
References: <20210814124805.14568-1-pali@kernel.org>
Date:   Tue, 24 Aug 2021 13:27:41 -0600
Message-ID: <87a6l6mymq.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> 88F6825 is just 88F6820 but without encryption acceleration hardware and =
is
> used e.g. in DTS file arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> ---
> Depends on patch: https://lore.kernel.org/linux-doc/20210625215437.2156-1=
-pali@kernel.org/
> ---
>  Documentation/arm/marvell.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index 85169bc3f538..56bb592dbd0c 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -140,6 +140,7 @@ EBU Armada family
>  	- 88F6821 Armada 382
>  	- 88F6W21 Armada 383
>  	- 88F6820 Armada 385
> +	- 88F6825
>  	- 88F6828 Armada 388

Applied, thanks.

jon
