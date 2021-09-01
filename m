Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD52D3FE0DB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345743AbhIARDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 13:03:47 -0400
Received: from dnyon.com ([82.223.165.189]:56282 "EHLO dnyon.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344453AbhIARDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:03:47 -0400
Received: from dnyon.com (55.red-81-39-194.dynamicip.rima-tde.net [81.39.194.55])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dnyon.com (Postfix) with ESMTPSA id 999AD40442;
        Wed,  1 Sep 2021 17:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dnyon.com; s=mail;
        t=1630515768; bh=/+spJHj+Ngr9m35GSnygXoafdYZCPeBa4DB05TovR0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2LGBrWEX0C3n8KEvZH5G11zEQYiiY3u9PCs5Ke7nb6gx6CDWkMC4J0ul9t9p3HCIm
         fpMJ2/Y1I+F2zSjR9+TGDYH9vfvaLd11Bpq2B5v4V02naa8KKjh8WugkYyh8x6xZpY
         WjO6DOX4daGBi9/ULAastYAk/azCphtYEW9Uz0eGoZNtkoL49QKKzd9RvXWML+2Zh3
         aSZ1BzYLK367fPJCFZKpTzUToe+FvmdvdiEYpfRF8KoqgAtXiAJNlueNZsHi5dQ7Mo
         eMhFRQckw9kulJARNQjW25I6C/9YxyMj7h7chHXRhYweNK2V3wyg33ltWMVhi75PMv
         fRvIaavKwVXZQ==
From:   Alejandro Tafalla <atafalla@dnyon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: max98927: Handle reset gpio when probing i2c
Date:   Wed, 01 Sep 2021 19:00:59 +0200
Message-ID: <4673573.GXAFRqVoOG@alexpc>
In-Reply-To: <CAHp75VfgbA0upoHyDLPCRGrN+7H5mZiDu-GbQPxHid++Z9UqQA@mail.gmail.com>
References: <20210830104426.487246-1-atafalla@dnyon.com> <20210830104426.487246-2-atafalla@dnyon.com> <CAHp75VfgbA0upoHyDLPCRGrN+7H5mZiDu-GbQPxHid++Z9UqQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lunes, 30 de agosto de 2021 12:56:23 (CEST) Andy Shevchenko wrote:
> It simply as
> 
>                return dev_err_probe(&i2c->dev, PTR_ERR(reset_gpio),
>                        "failed to request GPIO reset pin");
> 
> > +       }
Alright, I'll make that change. Thank you.


