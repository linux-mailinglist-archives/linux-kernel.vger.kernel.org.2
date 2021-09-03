Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF24002A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 17:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349717AbhICPxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 11:53:53 -0400
Received: from dnyon.com ([82.223.165.189]:56374 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235851AbhICPxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:53:52 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 04EC33FEB7;
        Fri,  3 Sep 2021 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630684371; bh=N5ikRjsunM6u4Rj6jCsrMSVHxexBHAHR5BNCYYEhc5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhYZ4ZHs0crDvHNWVNKHa5OgtJANem0yfORE1sURs0+UvlLGMg9DI9c0AEdvttxDA
         YiOkxygYikSY8Nr2KdyOTsKKak2bAIpRmyUYLdvzODGserD1Nm5wbvwkFSfO0WQHKL
         ZscIYdheGAxRdtvF/PeF1J9w34KY6hrAU15GrXVTcbES05SD/FMU+ajYPEidgkIHfq
         t75BoUzrGROloy1Dn87itkJiErZu8BLhUAYxN+WXKl5S0dns8aYKChE3paBMbIhych
         QqD9Hs37aMskC9Md993M8U6PDKr6Nkb1Bo6G8Z8+di3ZgfyYvIO4miQ08WptNtpuJf
         +rNje2K2hT9Rg==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Fri, 03 Sep 2021 17:52:29 +0200
Message-ID: <11848098.O9o76ZdvQC@alexpc>
In-Reply-To: <CAHp75VeD8sbxcu==BF97yY4ZGtLbNAQSiTxq2cDvBSdCpXxsyw@mail.gmail.com>
References: <cover.1630632805.git.atafalla@dnyon.com> <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com> <CAHp75VeD8sbxcu==BF97yY4ZGtLbNAQSiTxq2cDvBSdCpXxsyw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On viernes, 3 de septiembre de 2021 10:18:14 (CEST) Andy Shevchenko wrote:
> On Fri, Sep 3, 2021 at 4:51 AM Alejandro <atafalla@dnyon.com> wrote:
> > From: Alejandro Tafalla <atafalla@dnyon.com>
> > 
> > Drive the reset gpio if defined in the DTS node.
> 
> ...
> 
> > +       reset_gpio
> > +               = devm_gpiod_get_optional(&i2c->dev, "reset",
> > GPIOD_OUT_LOW); +       if (IS_ERR(reset_gpio)) {
> > +               ret = PTR_ERR(reset_gpio);
> > +               return dev_err_probe(&i2c->dev, ret, "failed to request
> > GPIO reset pin");
> Not sure why my comments have been ignored here.
> 
> > +       }
> 
> --
> With Best Regards,
> Andy Shevchenko
Sorry, I misread your suggestion and didn't notice PTR_ERR was also in the 
same line.



