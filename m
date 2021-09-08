Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB88403EE0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbhIHSKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhIHSKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:10:40 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F09C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 11:09:32 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so1079021ooe.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHTh1HO906gMjGsq/6c8x/AFAmsBhynFAoihw7tpJW4=;
        b=MlZxyo+1q1YTDCfKyB+mJppyYe+4VNRTPxxVr4MozOrje+oXFksFm6Q5vI0DvrHgmH
         lOgCE+iwZ640bunqIRN5j9A2mTl9AmFDjnQAtRHfma976UHd787FrR8RXpjWndw/RNUi
         zXK9niUZmv+A4Rxrv5pzbbTBVlCvolUMm7DKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHTh1HO906gMjGsq/6c8x/AFAmsBhynFAoihw7tpJW4=;
        b=zmk6cEGfxsOtz/tnY3vK+a7c7wv/jbNLF/qeVS/yeBmUjIPER1rqUAk8B18R3oWGHC
         YOnaJ3tcBVcRaD1J3d9xHtUQgiF29jC9hDmEUWtugFAJiohi9ronzXsym8aJyJPcHTxz
         IsrTzDuV2Od+WXM2Rzz2H7hJ4lJB9Lk73t/EKpeH2TsoNS7QOYo1G4HrUaaftolqFP8D
         pVgCPUOIBUg78HmvEoOundprrSSNyMuNzRBQ/K1b2OWz1dZ3LpBLXw0RVWszpPx4FWhy
         KoD00qFat16gYrCVi6vI0N4+M+rqS9xHHDC0ZO87ix2sYd+Y7/Lpkb0Xoc7ZYS+RCYba
         HIgw==
X-Gm-Message-State: AOAM532YzGYB0UXQTjk+MhTu9tLjmjM49+0J1HPHtM7sRoe1hAOBjZg8
        axq/Ywk7nt7iuaPjQIuTtK6+ZgSYYOeXSw==
X-Google-Smtp-Source: ABdhPJwFGhEmfWjcLGhnLgcYA/2CltBlxy13ISRKqP/yttSL+YGvgRNmVobmNXy3JiajRstx2Hjnaw==
X-Received: by 2002:a4a:e792:: with SMTP id x18mr4041178oov.53.1631124570569;
        Wed, 08 Sep 2021 11:09:30 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id t21sm584898otl.67.2021.09.08.11.09.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 11:09:29 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id v2so4180277oie.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 11:09:29 -0700 (PDT)
X-Received: by 2002:aca:4557:: with SMTP id s84mr3270975oia.77.1631124568911;
 Wed, 08 Sep 2021 11:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210907094628.RESEND.1.If29cd838efbcee4450a62b8d84a99b23c86e0a3f@changeid>
 <20210907094628.RESEND.2.Ibc87b4785709543c998cc852c1edaeb7a08edf5c@changeid> <CAD=FV=Uo7oK6a8X69KGneP8CvXE127ZxU7U59Rrz+_Dv6D5t3g@mail.gmail.com>
In-Reply-To: <CAD=FV=Uo7oK6a8X69KGneP8CvXE127ZxU7U59Rrz+_Dv6D5t3g@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 8 Sep 2021 11:09:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPLrpfnm70RLDD+c8Df8X3-q5FaOjCDWFSbzNwim1MisA@mail.gmail.com>
Message-ID: <CA+ASDXPLrpfnm70RLDD+c8Df8X3-q5FaOjCDWFSbzNwim1MisA@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] arm64: dts: rockchip: add Coresight debug
 range for RK3399
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 8:10 AM Doug Anderson <dianders@chromium.org> wrote:
> On Tue, Sep 7, 2021 at 9:46 AM Brian Norris <briannorris@chromium.org> wrote:
> > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > @@ -433,6 +433,54 @@ usbdrd_dwc3_1: usb@fe900000 {
> >                 };
> >         };
> >
> > +       debug@fe430000 {
>
> I think your sort order is wrong? 0xfe430000 comes before 0xfe900000?

Yep... In attempt to explain my own brain: perhaps I assumed the
USB-related nodes must be uninterrupted, which caused my sorting eyes
to skip over.

v2 is coming.

Thanks,
Brian
