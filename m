Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A3E411324
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 12:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbhITKxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhITKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:53:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650CC061574;
        Mon, 20 Sep 2021 03:52:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b20so7266726lfv.3;
        Mon, 20 Sep 2021 03:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUuvxud1ILiBqpLp3iPBTO0pWqhZHIRgArAsJrtY6Ic=;
        b=B3Q/vcGgOsL+oOrfzTKjYb96gOiRHxrcEmy/5zwK84TTtIjsN+AWJaBIJ1K7IfXDUO
         UMEDMMaAUgePcbOauA+0wgIfPYMXSWRldAzY+p4nH9NaAEs1sLGXBbJOYs0827eL7lNt
         UB3u3lsMEVYI31X9r1w0H3hQ+zfQQo/uyhEWoCvdV+Qp3R7Qum7rzo528s42scFrpM07
         fCQx4A3txMdWdUanXHwTwW2QciQYmILpEflzn5wtTD2aUbmpDzuyHDBv9Xulkokj81pe
         4Tdy4lGLXtUZH6371eKSn+rjlgaa0+NCmPKwNk/AdqWw6mOSD0ILJUNUQxRHzw+d4l49
         GORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUuvxud1ILiBqpLp3iPBTO0pWqhZHIRgArAsJrtY6Ic=;
        b=zfSEn4h2gKhGb6KS1eHbbI7XFyEZ+pnmm2suNy0YiOL1HRgi8zEjUt9X+ku7ZaWqh/
         bSnfk50aQzFINTM19xe5XVehyh3aDCB/J6lnKsEeLIcZcc7SmuWa8YFf37usMbVJmciH
         ZhXvoV1FYNPlFSvbcD0DBkamYCA7viiDTRaoz394W1uFfO4CmcfDTa+97yVv6WC4w4n5
         5y199pdhFrCJRC++qgnAo+FBqK9zxfTmnm+iHbobFoYSH91BgWDSbjIcXop//zYKA5oC
         jpaeskpIyy87X3baelreqql9Y7Ze6p0/6ODZtB47qDROgZ15VogNheopE37wTksjBae9
         +BFw==
X-Gm-Message-State: AOAM531/Yw4TCkq2UFu22S45+8G26pzHQ09QqsfZJY8mb/aCl4b0upl5
        udAQRNxzwzhE2Ji6m7gU/fh/yYmkrdfnZcnsWN8=
X-Google-Smtp-Source: ABdhPJzPSKMyzG2tRN6z7Ncydail4FiF2coOaotkuj3SAk8aqa48dBROEKjHelpjWA+iTXVqokrfxGAvhSDO5tJ31xk=
X-Received: by 2002:ac2:561c:: with SMTP id v28mr18747243lfd.457.1632135131743;
 Mon, 20 Sep 2021 03:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEyMn7YqrRttqvJzJLA+yVo6WtBZww6QcXT12MMCi+bhjP4pTg@mail.gmail.com>
 <CAEyMn7ZhBfG7703YMr=EDQyf5mHDkLyET5iNqdXDOpJy9ti+rQ@mail.gmail.com>
 <CAOMZO5CZKdc=AmG1eds9Oy_uwqXDWLwPXk74phCDWdjrzkRC4A@mail.gmail.com>
 <CAEyMn7YaQbLoVy_5Rb+hiwhEj-kbnmCwb0B_soa+Kf0D6iH6oA@mail.gmail.com>
 <CAOMZO5CGuKQ0yVyoD86G3KnxoBd2fq+uCTTLoqVR-13Y5a-36Q@mail.gmail.com> <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com>
In-Reply-To: <CAEyMn7bN247-J=Qz-k3LZMVYb8pdYSP3BSCsNE9yyvfDfmdK0g@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Sep 2021 07:52:00 -0300
Message-ID: <CAOMZO5DEg81E23QBpsv44BxytEhNNoXy-r5BbnubUJTERzWYLQ@mail.gmail.com>
Subject: Re: imx8mm board crash in drivers/usb/chipidea/ci_hdrc_imx.c
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Yu Kuai <yukuai3@huawei.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Sep 20, 2021 at 6:17 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> Now it is clear to me. I used the dtb for my board that had already
> changed the phy node and tried to boot the "old" kernel 5.14. Thus no
> phy could be found. Nevertheless the kernel should not crash in case
> no phy was found.

Agreed. The patch I proposed earlier should fix the problem, correct?
https://pastebin.com/raw/yZKz1huL
