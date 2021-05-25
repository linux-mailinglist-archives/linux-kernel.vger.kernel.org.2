Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B36390041
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhEYLr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:47:58 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:55447 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231765AbhEYLr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:47:57 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 07:47:56 EDT
Received: from sas1-8418212adc37.qloud-c.yandex.net (sas1-8418212adc37.qloud-c.yandex.net [IPv6:2a02:6b8:c08:1581:0:640:8418:212a])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id C923A4AC242E;
        Tue, 25 May 2021 14:39:02 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas1-8418212adc37.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 6allm5Podn-d1Ju4LcU;
        Tue, 25 May 2021 14:39:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1621942742;
        bh=pNsRz16dxsxUb7vX/klTo6nF5ZnCKLjHiX1eYdJ+Xtg=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=PPNl21dLqMSZECQn5I/NLwuJOBTT9n/sfwFHOydRy7eyLnWI3FxyXUf+Tg7I0IhwS
         0ajdXuUCjejNkD65/bp6avgA5byDJjilYH3FFTQgi8LqxHECZU/s6hv/uI3udRRCJA
         gPbaCMxpo4M8V6SGgkZnT+one6TkKG/xHw43MX8Y=
Authentication-Results: sas1-8418212adc37.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id Cxstl27rCA-d0LWrau1;
        Tue, 25 May 2021 14:39:00 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Tue, 25 May 2021 14:38:58 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/1] ep93xx: clock: convert in-place
Message-ID: <20210525143858.235c9318@redslave.neermore.group>
In-Reply-To: <CACRpkdYkb+-y366esEDZBDMNQ7s6zOfHEPotNaTUi3m95QrBFw@mail.gmail.com>
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
        <CACRpkdYkb+-y366esEDZBDMNQ7s6zOfHEPotNaTUi3m95QrBFw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 12:19:27 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> move out as many drivers as possible to be modules and
> not compiled into the static kernel. Do we have candidates
> for that? Are people normally using modules on EP93xx?

AFAIK there is nothing left to convert. Everything is already done as
modules.
