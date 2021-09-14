Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EC440BB03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhINWPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 18:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbhINWPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 18:15:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B03C061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:13:59 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b18so447263lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWsTCdHYGd/aJ+PxtTnWChkbPZ5sbeK96OrviSNN3s8=;
        b=JwI9vP436C/kVkfUnMuUGF+nI4pwVjPPhEoYpHVyjC6EGPiJv+o1dTFRN2BzmBU3V4
         EFFigSIycU81Epm9FYDl8VXTUYBK94Abt6JH3NzRFHzQjqNB8+Xc85rqKExn/7wtwZ9S
         1pepJ65JI72LsWybw/vCvgtEqajrodwo4swId+LSjCBPfV1GdO9k2HaDOnW2jPNMJgYb
         CJLrmqwxBt/mVUwJmbdjcNK5WmsCwEyziri5Oa5TsCtutle5iOXW3uaRUMpZOOxPGC3y
         sFFYKLqsPpl8TFxyjNMvtL+5wHWLOECkG5cAa8mC4zVs9IHEMzq2SVXrkN3AX4PUeZvP
         oXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWsTCdHYGd/aJ+PxtTnWChkbPZ5sbeK96OrviSNN3s8=;
        b=jaMX7OjjYWdLC1mIPgzj0vLIim3FBJEEf+EysXZjv4VLEsxWajYhCC5QnDdMUfSZFX
         4ltoKLRQKtz/Vy0L7dLqLvCidVYXCNfjoek90XFYqPyztrI7Z1ksQIAcs/nbR8jbPOry
         DKKdh4usa4V2T8N7mHzh1MHZAYcbtHkiGp2uz0M0a0picGYqdSDzNkd2XkZxf6EdDKl7
         z9/Z0CZA7u1AszD1Ye/AYAgS8EwnCntBVaYM+rF5ppibiY+WWkmboqfayGlChgZlz9oy
         nk1gEeRmJ9FqnUoSq2ihHIIzpZfN1iXI0/YaxoVg24QdgcdbcDQCdrM9ZemlHiBeRznS
         0pvQ==
X-Gm-Message-State: AOAM5322C1gZL/XFSkikN8/T0kJTupkP1qFZFHCS5aYg3114BcbGfCtN
        BV0sU25H4AyvzJq5KXQvHMb5R5nbDRIH7lJ06+4kjQ==
X-Google-Smtp-Source: ABdhPJw++97HufaRBpmc24LoXmsRYCQ4n4TAIcOI/0662lI81pQdxcBwCQcnx6Q2PmqquC39Np2lofu+7pCvVqvvHVE=
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr14628711lfd.584.1631657638198;
 Tue, 14 Sep 2021 15:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210913192816.1225025-1-robh@kernel.org> <20210913192816.1225025-6-robh@kernel.org>
In-Reply-To: <20210913192816.1225025-6-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Sep 2021 00:13:46 +0200
Message-ID: <CACRpkdaykxaECTH6nY4Z-k0qwxq+-o28O=OUqNR4fDRxD0P0zg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] clk: versatile: clk-icst: Support 'reg' in
 addition to 'vco-offset' for register address
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 9:28 PM Rob Herring <robh@kernel.org> wrote:

> The ICST binding now also supports 'reg' in addition to 'vco-offset' for
> the VCO register address. Add support to the driver to get the VCO
> address from 'reg'.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

This is nice.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
