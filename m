Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336BB3AAEC3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFQI3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 04:29:15 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:54686 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhFQI3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 04:29:11 -0400
Received: from sas1-c5718652e2f2.qloud-c.yandex.net (sas1-c5718652e2f2.qloud-c.yandex.net [IPv6:2a02:6b8:c14:496:0:640:c571:8652])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id E1F264D42B11;
        Thu, 17 Jun 2021 11:27:02 +0300 (MSK)
Received: from sas1-f4dc5f2fc86f.qloud-c.yandex.net (sas1-f4dc5f2fc86f.qloud-c.yandex.net [2a02:6b8:c08:cb28:0:640:f4dc:5f2f])
        by sas1-c5718652e2f2.qloud-c.yandex.net (mxback/Yandex) with ESMTP id SWMBzrSHyP-R1HetQuf;
        Thu, 17 Jun 2021 11:27:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1623918422;
        bh=2SWMLvH+okViWY3oBxXtYxb9FxBK7+U6hLLdoAtQ0jk=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=EKt+/RHqsP/V33BVd4FgODZbVKI2GVQZZBKriCeep6HqpwmjeiS02xJLuLWEhNDyG
         Wk3ddjWZfLOrDlbtHo3/gn4e5co+PiYoOF5f+eVEAeIOK4v67IEfL6Mpj6gmZjh0j6
         WGCU5Sxviy4EANx4MKnDEwS8Ytwi6re6CzRAlqbo=
Authentication-Results: sas1-c5718652e2f2.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-f4dc5f2fc86f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id OEwAU8VULe-R0P8YNor;
        Thu, 17 Jun 2021 11:27:00 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Thu, 17 Jun 2021 11:26:53 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] ep93xx: clock: convert in-place to COMMON_CLK
Message-ID: <20210617112653.00002f5d@maquefel.me>
In-Reply-To: <8cdf2b130ae02ba00324d0a70cbbcd3ba53e1d09.camel@gmail.com>
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
        <20210525083340.27722-2-nikita.shubin@maquefel.me>
        <8cdf2b130ae02ba00324d0a70cbbcd3ba53e1d09.camel@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 00:42:05 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Hello Nikita!

Hi Alexander, i am currently AFK for about two weeks. 

I join the conversion ASAP.

Indeed i used clk_prepare_enable for some drivers and didn't included
it in resulting patch - my bad, sorry. 




