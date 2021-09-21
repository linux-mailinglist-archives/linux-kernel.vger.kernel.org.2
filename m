Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4225E413DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 01:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhIUXJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 19:09:59 -0400
Received: from ms.lwn.net ([45.79.88.28]:53834 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhIUXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 19:09:58 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A4DB337B;
        Tue, 21 Sep 2021 23:08:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A4DB337B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1632265709; bh=CdsObx61OtVA6UmkkyHj1HJ0dVqZUkttfdTVmAMUUrc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MWZUX3OR2jLyzSwbvwPcjW9ol8lM0z8WzruV89oy4VTyABw8vr5Y8jw+kMt6eVpxT
         Z35nJbEJu8opiOrZ1sC8QGpj0mLbKx35l3ykPYGkMDBE+nEkhD3Ndi8TmbuH1zRl0j
         DJzzC89HBrFx4kxhn6p9TT7ljlkQy33HgZ+pkEMLKjxaIkaiKBePtqLmUxcDs3WMO9
         Q7J6wMChMC640nPKdihTJ9BkP7fL9b4myu+DwTyR/foyGu5rHMrVNbYPtbHxGBjoJX
         rYP23hhWqHIkT9DbkP9OugQLqZNrzRpVxN22EEtjWQWZdpfNC/RlrAiooYe3hv2TiV
         e9tdTOCaW6exQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add 88F6040 model into list
In-Reply-To: <20210919143327.24289-1-pali@kernel.org>
References: <20210919143327.24289-1-pali@kernel.org>
Date:   Tue, 21 Sep 2021 17:08:29 -0600
Message-ID: <87k0j9ttle.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  Documentation/arm/marvell.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
> index 56bb592dbd0c..f9b09b06e1d6 100644
> --- a/Documentation/arm/marvell.rst
> +++ b/Documentation/arm/marvell.rst
> @@ -212,6 +212,7 @@ EBU Armada family ARMv8
>  	arch/arm64/boot/dts/marvell/armada-37*
>=20=20
>    Armada 7K Flavors:
> +	  - 88F6040 (AP806 Quad 600 MHz + one CP110)
>  	  - 88F7020 (AP806 Dual + one CP110)

Applied, thanks.

jon
