Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC413C600E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhGLQGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 12:06:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:42330 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhGLQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:06:42 -0400
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 17CE636E;
        Mon, 12 Jul 2021 16:03:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 17CE636E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1626105834; bh=kSSlmFnL7JyG3z3y9i9yDbtGXvvJ9JyuZRsfDWOwbYw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OXP10x44qcYIGcYQCUmPrz5EcR0O+HYo51nCKSAV42R0LgHj2dh0F+I0GFjDbhPnj
         dbguVF7uuXCnNJVxHjMOBu0HZC7isKqpQAdEt4Gh4mXYIiTIb0k5QMIMHTW0V0oZJ4
         wWNLjSq9We8tYc3Z6hy9/F6OuBwaogCb6PQjcUnvR5qC2AkI9fR8CYjVNaUTKtlWBr
         5DmzSDIIepwIdaSHPGNUDzxIbQrPlPchfD0M6xMvEUCit797tWJh4p+cCyNvg7Nst6
         TJCEdOu99FPWpLPht7NBaRdtY6Ok/9vu4kSh7L9VtoUpdQQwZZIDZIR/N8Cb+MXq2S
         kIoWLBiLtZy2A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nishanth Menon <nm@ti.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, Christoph Hellwig <hch@lst.de>,
        Rahul T R <r-ravikumar@ti.com>
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
In-Reply-To: <20210703012931.30604-1-nm@ti.com>
References: <20210703012931.30604-1-nm@ti.com>
Date:   Mon, 12 Jul 2021 10:03:53 -0600
Message-ID: <87tukzr02e.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> Lets drop the unicode characters that peeped in and replace with
> equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
> rest of license files.
>
> This messes up code such as scripts/spdxcheck.py which assumed utf-8
> LICENSE files.
>
> Fixes: bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Christoph Hellwig <hch@lst.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
>
> Reported-by: Rahul T R <r-ravikumar@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> also see: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti=
.com/T/#u
>
>  LICENSES/dual/CC-BY-4.0 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/LICENSES/dual/CC-BY-4.0 b/LICENSES/dual/CC-BY-4.0
> index 45a81b8e4669..869cad3d1643 100644
> --- a/LICENSES/dual/CC-BY-4.0
> +++ b/LICENSES/dual/CC-BY-4.0
> @@ -392,7 +392,7 @@ Section 8 -- Interpretation.
>  Creative Commons is not a party to its public
>  licenses. Notwithstanding, Creative Commons may elect to apply one of
>  its public licenses to material it publishes and in those instances
> -will be considered the =E2=80=9CLicensor.=E2=80=9D The text of the Creat=
ive Commons
> +will be considered the "Licensor." The text of the Creative Commons
>  public licenses is dedicated to the public domain under the CC0 Public

...and I've applied this one as well.

Thanks,

jon
