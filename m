Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35063906B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbhEYQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhEYQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:31:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88540C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:30:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so6941622wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9nwt4Wpg0hmZ7kHGH/PciQ0lTJpG5RlqOKYlvkngWns=;
        b=V68yr1iVeGoSNSNnL4Tn+Pmqt8s71eX0caRne/9WoExjiHXAoGj69icDo54SlgjsI8
         nbt67XcFHWApel03RicpB5v/RqxlNyR4Orl+qvrLwHIAw7PoZzYB1l0zoE8861TxONAM
         AC6iItHOSzFS3KCJt6J2PmnMrTI0RKHBY+PfcXWUKGxgrQvDjS6nGVDJ+FKSnoCiQcfc
         cUOnBg6+ekCKLDSw1Acc3SUjs0CtH6ZRWSj0jMncgSNq0ddyomy7H42cj0EMl5wvLkiX
         9SnHoD674p2cGMkN+DhxdK6f/VsGX2jlwbNjsoZ84lqgt/jyyLH65f1Fi11a3iKNkL0O
         ZPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9nwt4Wpg0hmZ7kHGH/PciQ0lTJpG5RlqOKYlvkngWns=;
        b=JTNBCbPdEtccESTX0VcqP46T2VYPGNWCO8VfVNxcL6RHUeIIb+Ld8b6lUSLEAoAW4M
         1jTO1c39m3AFtKAy0QDxpLNLk0Y/QBerrHi+wDeb7783NLVI9Wk6yxE9Tbr09rtgczhi
         hGmkQvQ2P03jahXR9lGTYbAn21yWw4lAPbxJxMBgEnLGzwWxAvXncldlFBmrt7JKRxc/
         reZSv97500snl9Iflg2Fs/bB0hdWxMEswpWj2lo2ELchMT/PXeg/ySeEvWgthgQcEFDU
         VWE23h/yZd2IUQvW/JZtHqTB9RevcJgjBIylx9KtybV5lwmCDiMAxnj0AMoRsUDk1i+J
         R0Pg==
X-Gm-Message-State: AOAM531FE++wumfQRHa/DUAUdDAMuLg8SIooIriaBXilYehM3zH+UQg0
        3xKR22PPxLcHWCuMjvaI+Yi8qtY4lVAdOg==
X-Google-Smtp-Source: ABdhPJzZ0krWACNsjmS0+Hh2AvTmE8Bxm17Apsd2RbWDZmmWCCvsFgApYmgEVO2+2WxZdzlYFJzrtQ==
X-Received: by 2002:a05:600c:4e8e:: with SMTP id f14mr4686030wmq.65.1621960227081;
        Tue, 25 May 2021 09:30:27 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id e8sm16622464wrt.30.2021.05.25.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:30:26 -0700 (PDT)
Date:   Tue, 25 May 2021 17:30:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build
 as a module
Message-ID: <20210525163024.GD4005783@dell>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
 <20201020072532.949137-2-narmstrong@baylibre.com>
 <7hsga8kb8z.fsf@baylibre.com>
 <CAF2Aj3g6c8FEZb3e1by6sd8LpKLaeN5hsKrrQkZUvh8hosiW9A@mail.gmail.com>
 <87r1hwwier.wl-maz@kernel.org>
 <7hsg2au6sv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7hsg2au6sv.fsf@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Kevin Hilman wrote:

> Marc Zyngier <maz@kernel.org> writes:
> 
> > On Fri, 21 May 2021 10:47:48 +0100,
> > Lee Jones <lee.jones@linaro.org> wrote:
> >> 
> >> [1  <text/plain; UTF-8 (quoted-printable)>]
> >> On Tue, 20 Oct 2020 at 19:23, Kevin Hilman <khilman@baylibre.com> wrote:
> >> 
> >> > Neil Armstrong <narmstrong@baylibre.com> writes:
> >> >
> >> > > In order to reduce the kernel Image size on multi-platform distributions,
> >> > > make it possible to build the Amlogic GPIO IRQ controller as a module
> >> > > by switching it to a platform driver.
> >> > >
> >> > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> >
> >> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> >> > Tested-by: Kevin Hilman <khilman@baylibre.com>
> >> >
> >> > Tested as a module on meson-sm1-khadas-vim3l where the wired networking
> >> > uses GPIO IRQs.
> >> >
> >> 
> >> Good morning Neil, Kevin,
> >> 
> >> What happened to this set in the end?  I still don't see it in Mainline.
> >
> > Last time I tried this patch, it broke my test setup in non-obvious
> > ways. Has someone checked that the issue I reported back then has been
> > resolved now that fw_devlink is more usable?
> 
> Not yet, that's (still) on my TODO list... (well, TBH, I forgot about
> it, but I'll have another look.)

Superstar!  Thanks Kevin.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
