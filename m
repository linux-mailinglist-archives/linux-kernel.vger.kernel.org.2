Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACD533C9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 00:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhCOXLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 19:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhCOXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:10:56 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2650C06174A;
        Mon, 15 Mar 2021 16:10:55 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h18so11000819ils.2;
        Mon, 15 Mar 2021 16:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1/8bjLHF9FtwMFaIrmHVFR/MayJhXwBukDib3cdY7GY=;
        b=ArUXuTwfe8COX+YyUDzgYs7tL4IE2ubSbkRBYlCZOMSbT2GdqG1uj6sTeUJgdNdUJM
         oGbVsgw2CClsa0ULMBnC31/ovkbf0KM+xsdXHXFbejIHVahNiTyBN2h/XyAAaFWJfsDQ
         ZWtZ3yqz0G3PyIta1U77o9zaaz9DfA8P1maD8jBJWj5y/cRXJWKp87pj991BTyH+YeoD
         H45xdxbpOWQPlX+pyL/RdQd0+R6gVLdtCCfn8JCJTHOgsXWhLlvzL1+r60dSiYh+0KLp
         1wrIGnSRZgFFzTlkve80Ki7xdCVHajOvzs1RBurxDSQrTNP0LeInFHVRsghzj1WR8rVt
         JQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1/8bjLHF9FtwMFaIrmHVFR/MayJhXwBukDib3cdY7GY=;
        b=UzIbyJDLL/wxIA9GeMmnI/xSxt9/SzdxyygTC3U0yGtWWhSo4GuQp5VE0JM5qCyqdw
         RzyzxHPDpKulzeH9j/9sMvzSSOhbcaU/LDsnYqwDaD+BHgnef3Kd23RaluntQsvQnvMY
         E8xmQt/nmezLGJl0dcDstZCCXOuxDc2QBAF8Mq8MfjD/om07Lzrj49lk8/BryIKI4zjF
         Mi0xoCAO89c7EBUk+6TTF8mVj97RZgsjGKHAqxN+SrJErUcYmV3hrm6cKlwuUrdFxHSc
         5Y2K6ltGbv88gzeXSjQ9S3zfQPlBs+h39xjUz/y5vzpB2rxgXuqmxJm6sigf566SpQzF
         rHdQ==
X-Gm-Message-State: AOAM530wSmBU7s79kf5XZv6y+DYegUyLsS2qML8KQulXRFDMbp66Y9wr
        p2guPfCpnxTvxZpJShBDlh54cwpFHzgP47LmpoU=
X-Google-Smtp-Source: ABdhPJyOYSFpXTa2hRSPkxFSDK+rvPWmRI8qKW6ZsEElM5ncKyvXcpmfHxslLd2IPthmEFnvRPuMpJPXT3yxupgu674=
X-Received: by 2002:a92:1e12:: with SMTP id e18mr1567010ile.270.1615849855463;
 Mon, 15 Mar 2021 16:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
 <1615801436-3016-3-git-send-email-dillon.minfei@gmail.com> <20210315162645.GA981570@robh.at.kernel.org>
In-Reply-To: <20210315162645.GA981570@robh.at.kernel.org>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Mon, 15 Mar 2021 23:10:19 +0800
Message-ID: <CAL9mu0+19AVE7NidQcRukUhBkrMQZ0J_Tw15oz-4WiZq9RZdig@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: arm: stm32: Add compatible strings
 for ART-PI board
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        erwan.leray@foss.st.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        gregkh@linuxfoundation.org, erwan.leray@st.com,
        linux-serial@vger.kernel.org, afzal.mohd.ma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:26 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 15 Mar 2021 17:43:49 +0800, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > Art-pi based on stm32h750xbh6, with following resources:
> >
> > -8MiB QSPI flash
> > -16MiB SPI flash
> > -32MiB SDRAM
> > -AP6212 wifi, bt, fm
> >
> > detail information can be found at:
> > https://art-pi.gitee.io/website/
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.
>
Sorry for that, i forgot to remove patch 2 from v2/v3 theris, there
are no changes in v2/v3. please just ignore it , thanks.

Dillon,
Best Regards.
