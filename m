Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222BF30B913
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbhBBH7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:59:38 -0500
Received: from mail-vs1-f52.google.com ([209.85.217.52]:37919 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbhBBH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:59:33 -0500
Received: by mail-vs1-f52.google.com with SMTP id l192so3148366vsd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89LBUP1EwOlSAZ3wN5Ztlx7kj3QOve6gLNz9Zd6Ut4Y=;
        b=A50Tu/dPF8oxiO0guSb0Gx5I186nqNkaMO3tNfFOHT8dkBIcblANKZzRhUbUyMg0dT
         yhuM63nRn4OUe5EpIZO+lDAFXZzL/KlY1AVo4Xwzdv6qwfiwrU9q10EjllaueyCFXDSE
         VjJTtiwFlmEO/aMfCIjpL20H0v6CHGa4R940BlP1GPnKMX3F0+ZoxhLO7/ErRbZcaEyV
         WS+fH6AhfEHMu6Xk9fZoaPnMdO4NEX5Ih45ikSxbN2mdOotqEmGplsScVfyK8hTIKD8N
         quuxxiXapcxJ5z7Uks637HllEVqZZsfurWq67lbSsyC0i9YQCxswqDHxVKeniOQgZR5I
         S7uQ==
X-Gm-Message-State: AOAM533oAmWBoJKEp5Z/U4Z/bl7s3HMZWqh1hrLO5nlOlRLqhfNfNeAE
        V5nmMZ/H/caXSPF0edgIH6W1SXAHbehPXQ==
X-Google-Smtp-Source: ABdhPJyXRktH2Tv4C0CvIokLAuCSuwrfZrZLRg+SgAdN+JHB+5/fihZBioD7FbpPiZ41EDidAnL8Cw==
X-Received: by 2002:a05:6102:2db:: with SMTP id h27mr11513649vsh.11.1612252731334;
        Mon, 01 Feb 2021 23:58:51 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id p9sm1139127vsq.6.2021.02.01.23.58.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 23:58:50 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id g17so4591123vkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 23:58:50 -0800 (PST)
X-Received: by 2002:a1f:38c9:: with SMTP id f192mr3257323vka.24.1612252730254;
 Mon, 01 Feb 2021 23:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20210127172500.13356-1-andre.przywara@arm.com>
 <20210127172500.13356-7-andre.przywara@arm.com> <20210128101544.yyvrguk2jlgr4uwo@gilmour>
In-Reply-To: <20210128101544.yyvrguk2jlgr4uwo@gilmour>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 2 Feb 2021 15:58:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v65_Zvi_ydb0cx4YYu3v11ns57fa+PT-+qtdKn+N-fLugg@mail.gmail.com>
Message-ID: <CAGb2v65_Zvi_ydb0cx4YYu3v11ns57fa+PT-+qtdKn+N-fLugg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v5 06/20] mfd: axp20x: Allow AXP chips
 without interrupt lines
To:     Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 6:15 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Jan 27, 2021 at 05:24:46PM +0000, Andre Przywara wrote:
> > Currently the AXP chip requires to have its IRQ line connected to some
> > interrupt controller, and will fail probing when this is not the case.
> >
> > On a new Allwinner SoC (H616) there is no NMI pin anymore, and at
> > least one board does not connect the AXP's IRQ pin to anything else,
> > so the interrupt functionality of the AXP chip is simply not available.
> >
> > Check whether the interrupt line number returned by the platform code is
> > valid, before trying to register the irqchip. If not, we skip this
> > registration, to avoid the driver to bail out completely.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>
> Acked-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
