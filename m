Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA68413DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhIUXKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhIUXKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:10:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD80C061574;
        Tue, 21 Sep 2021 16:08:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5506437B;
        Tue, 21 Sep 2021 23:08:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5506437B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632265730; bh=gUTHnTMzSXjgiZ2B1KSrN6Q7k9LMdsUSGEn394b4yrw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=acEf5RY5JpEJcIQfJOKBsMygMRdt5Oq6RsVPWELx+ScPoAB64Cza85wbakB/b1ADs
         n2/br6XuGRLKb45ztp6y8iVxec/P+xBT5pk8rR3ou7TbRoyIQ3IR0NBd4KwhNaKuTS
         Ve6GKJscYK716h2EZrrv3Ytsh+I8JWxRvMPoa1u+goNM8b6jlgtXeI4/pARpkLkqb2
         A9MU2lixpfdCifNSvcuh+35M8lPcGlx25sKCpANn0xzVnfE4Dz1I+O6NII+CTqMw2o
         jGD+YzhMCvgg6zJbxULsWfVctQDp6RUeF8IOTPj3nLDfMKeuGd0x5bb0xju21Ynlmt
         dSUny9n1HzTdw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add Octeon TX2 CN913x Flavors
In-Reply-To: <20210919143348.24338-1-pali@kernel.org>
References: <20210919143348.24338-1-pali@kernel.org>
Date:   Tue, 21 Sep 2021 17:08:49 -0600
Message-ID: <87fstxttku.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Marvell put CN913x into Octeon TX2 family but they are different from all
> other Octeon TX2 products. Instead CN913x is evolution from Armada 7k/8k
> products.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index f9b09b06e1d6..c3d3f27edfbb 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -244,6 +244,23 @@ EBU Armada family ARMv8
>    Device tree files:
>  	arch/arm64/boot/dts/marvell/armada-80*
>=20=20
> +  Octeon TX2 CN913x Flavors:
> +	- CN9130 (AP807 Quad + one internal CP115)
> +	- CN9131 (AP807 Quad + one internal CP115 + one external CP115 / 88F821=
5)
> +	- CN9132 (AP807 Quad + one internal CP115 + two external CP115 / 88F821=
5)
> +
> +  Core:
> +	ARM Cortex A72
> +
> +  Homepage:
> +	https://web.archive.org/web/20200803150818/https://www.marvell.com/prod=
ucts/infrastructure-processors/multi-core-processors/octeon-tx2/octeon-tx2-=
cn9130.html
> +
> +  Product Brief:
> +	https://web.archive.org/web/20200803150818/https://www.marvell.com/cont=
ent/dam/marvell/en/public-collateral/embedded-processors/marvell-infrastruc=
ture-processors-octeon-tx2-cn913x-product-brief-2020-02.pdf
> +
> +  Device tree files:
> +	arch/arm64/boot/dts/marvell/cn913*
> +
>  Avanta family

Applied, thanks.

jon
