Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A433EFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhCQL5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhCQL5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:57:44 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:57:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u10so2766843lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 04:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n8lEKAP5tmFeQAnYvwrYiTflTL44w750U5WdG9uU0E=;
        b=D97uK5relVNUag4c14xbhpiGR63UmxR5Vgcyjg/JiHrBCt7q+Or0Twxt/OaOxa0608
         RM+lN+lwEZoWgWRuEBtnn9n1SmHX4TJHxGlwm2YLGqXDvmIMF/PwFnno+5C0pAbaz4oO
         AkH5CDGPj6KDuo1PvaPjVUON2lz2FhmmeizlwdSGCQcS95YrXPBpKhexL08n3jkM0XNr
         RTKJSEKwwR06JBy5JtJushv5Ss/S6oENbPTCODbEu74NaHm3tRHVEsKZh/BJvBj0W5j9
         wI84uL2kw2jKert808KLU9qX6PVB+ayVfk9U5gQs7i4FoHsDvtXzC5KDi02Tgg+3mXvk
         a74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n8lEKAP5tmFeQAnYvwrYiTflTL44w750U5WdG9uU0E=;
        b=Lt6Gn+kQGijul/4opCg7OKg1VayzCgr1c5cgXGmP1K7g4jL15VFaelWzsiI6V35kS3
         qp+YnRP/gvHAbU/eX8bmnViFFZlfg1Oom9xwbAdLfQPAz53xCJklQ5ZERIuCERV/PQKQ
         d10rsN6wN7Ks+OISzjNzXTUtiScqR+4Ed2fLqR3tOtBtR1DRiefLIb5zb75v6wkPaFiy
         3vfoYngoISLEY2Pt4LpAeMI8r2U7QSIR6sObe59oZarR3/hHiACTCvrrxVlWeOsH90fJ
         y7lVvsbYV2EcdkAq9YRkz/VebJd/emFFp5qlhk8HUkzwDodiJt7slMN1ETvCL6LZsJuD
         0lkQ==
X-Gm-Message-State: AOAM533TBo1prlfq34JP4ackp7WS8+Vyrz6FJjWHisZ27zAPgRxOxh8i
        WtIKjFkB117LVb8a7h/TgmhsV0+Gz9rfbyAcneU=
X-Google-Smtp-Source: ABdhPJwDiRxBiJIhWHpBHtNBplCV2HbWRI82c+TkdyI2ovMw94noWimGzg8EUEvXacIFHJ8313fNSp7h1pkLa3s54KA=
X-Received: by 2002:a2e:a58d:: with SMTP id m13mr2183644ljp.347.1615982262942;
 Wed, 17 Mar 2021 04:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210311192746.7362-1-heiko.thiery@gmail.com> <20210317080249.GT11246@dragon>
 <CAEyMn7b3qGupUh28rgf3THW7+8aNwCVnxtmOyS8MJXgJ3UuE7A@mail.gmail.com>
In-Reply-To: <CAEyMn7b3qGupUh28rgf3THW7+8aNwCVnxtmOyS8MJXgJ3UuE7A@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Mar 2021 08:57:31 -0300
Message-ID: <CAOMZO5B9hGHei56riPCvOjx-TmwLiEtB=3m4WZh5b8bsWowBpw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: configs: Enable PCIe support for imx8mq boards
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Mar 17, 2021 at 8:52 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> > Do we really want it to be built-in?  If so, it would be nice to have some
> > comments about that in commit log.
>
> Why would you not want it? I see other SOC PCI controllers are also
> enabled. I would like to have it because we have an Intel e1000 on our
> pitx-imx8m board and the seconds PCI slot is for a m.2 card. So we
> would have the PCI support with the default defconfig. On the NXP
> imx8mq EVK a m.2 is connected to the PCI interface.
>
> Is this the kind of comments you want?

You have selected the driver to be built-in:
CONFIG_PCI_IMX6=y

Shawn's question is why it needs to be built-in instead of a kernel module:

CONFIG_PCI_IMX6=m

On arch/arm64/configs/defconfig the preference is to select the
options as modules, whenever possible.

If it can't be a module and needs to be built-in, then please provide
a justification in the commit log.

Hope this can clarify.
