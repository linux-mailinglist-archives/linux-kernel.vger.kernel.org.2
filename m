Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA97391071
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhEZGNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:13:25 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:33689 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232734AbhEZGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:13:20 -0400
X-Greylist: delayed 77732 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2021 02:13:20 EDT
Received: from iva4-9c2d34c47e67.qloud-c.yandex.net (iva4-9c2d34c47e67.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:804:0:640:9c2d:34c4])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id D243A4A25D5;
        Wed, 26 May 2021 09:11:42 +0300 (MSK)
Received: from iva3-dd2bb2ff2b5f.qloud-c.yandex.net (iva3-dd2bb2ff2b5f.qloud-c.yandex.net [2a02:6b8:c0c:7611:0:640:dd2b:b2ff])
        by iva4-9c2d34c47e67.qloud-c.yandex.net (mxback/Yandex) with ESMTP id q58LaBNs9R-BgJ8EBH1;
        Wed, 26 May 2021 09:11:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1622009502;
        bh=hAffHH2iMr3UhtN/TePPD0jwrwjyWe4FKeJC2dlXO0U=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID:Cc;
        b=nV++GaJxIgALyMZvJdcU0HoIb3/cPVM3+SUDGXT9VLdQmpbA31qar8ELduiliBMxd
         3xTITFiiVNhhhlDPu4a3aYseGdvetmG0dE4Xbr+SS54avg2/5W0ZFWM9Nnmp7+Y2Pd
         tzy3MjT1J10K+L+BwITDSF6h7DqVG3HCZTmw0uuQ=
Authentication-Results: iva4-9c2d34c47e67.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva3-dd2bb2ff2b5f.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id MLA5o3te4s-BfLuLgvP;
        Wed, 26 May 2021 09:11:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Wed, 26 May 2021 09:11:40 +0300
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
Subject: Re: [RFC][PATCH 0/1] ep93xx: clock: convert in-place
Message-ID: <20210526091140.2e937ad7@redslave.neermore.group>
In-Reply-To: <b05ef6b2-9161-50a0-1c93-71bf8ec7fdb1@gmail.com>
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
        <b05ef6b2-9161-50a0-1c93-71bf8ec7fdb1@gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 21:39:27 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

Hello Alexander!

> Hello Nikita!
> 
> On 25/05/2021 10:33, Nikita Shubin wrote:
> > Alexander please look at provided patch, the size goes from
> > 
> > ```
> >    text    data     bss     dec     hex filename
> > 4491689  920748   92840 5505277  5400fd vmlinux
> > ```
> > 
> > to with patch applied:
> > 
> > ```
> >    text    data     bss     dec     hex filename
> > 4534485  927424   90304 5552213  54b855 vmlinux
> > ```
> > 
> > If this is not acceptable to you, than it's perfectly fine, i'll 
> > finish (actually only gpio left to rework to DT) and stash my
> > rework somewhere and can send link or patches to all interested.  
> 
> I don't think that 50k is a serios issue even for this HW.
> And Arnd is right, we still have some potential hidden within
> missing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION support.

Then i will proceed into finalizing and submitting it.

> 
> > But still if you have possibility to test clocks for video and I2S
> > it would be nice.  
> 
> I don't have video, but I2S and ADC, and earliest in 2 weeks.

Thank you very much!
