Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F8C40ED21
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbhIPWLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 18:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhIPWLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:11:12 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4A9C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:09:50 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id b18so22821380lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRw/8kw3Gm47yGNo4b+3xVaG3u8h4lDetU6RLgvPpYM=;
        b=x/Atd5iS9d/mD7e9HXfAhFD5uoynPZEfLmRpaGeKsIRyjJmIuRY4PGeVuARgQr/FwA
         z9TQgvIsE8ni7UTcLOqpRGU0lICeTgik7+rFzVupx472d6voJt8IkwEGiT9sA4Cj8Rjk
         3q4FHT+HfeQgpXNtCMDUAEnP0rYTIpzwQxqNCRSKUDR/bwGQXKdjyq7V7FVHUHhsaEoL
         Kg0FnZEPCWmop4kA2f65sgqvDIfAvSqQwjla+WNXQ+9mA1XjDXfO2OimcRkWv/G1WpKt
         Xbef66PUeh/ljLs2sHHOjLOEcr1WKiQb0xKh1spWfeKjhoRnMYmeDEvSA5SP1EIZnmfD
         vzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRw/8kw3Gm47yGNo4b+3xVaG3u8h4lDetU6RLgvPpYM=;
        b=LJDVwen5cxQAfLpLiQoWilWsST8K8fH/VfBdylMorbZTULmjPsofL6IR1R1L9/KuOu
         11Tj+3LLPPFI/kOnusFmPVQEAztLfwhsVlTtMtmzL1Yj/BcqTcgBbNHwVDaGK2GxkeSh
         dSV+gaCGPV9gsbEVNdy8xVnjOzoVzx4n3DAd/+4BL+kGf9GpEI0RhnbU0ZOikFWJG9v1
         ws9FvBs7EyDn85RkE1hs5U+BJ2TSXtN+osTKE8K+SGur81j3ufTpCoRxAF9Jag8e5Oht
         oi5sG+Iaz3NyQN6wKRueF+6XhI+/R/2J2uKfb0bNMW0QJq1SGKpntVkMXwxyy//278hF
         eeyQ==
X-Gm-Message-State: AOAM531U5vQOI/V0ClASSP8OBIFR1s2BY/L7nSTFqccsEpSZNyLSCpOc
        kPk/J3qwCsoP4DYE824kvtpkTTQD20R9/UDydlSQLg==
X-Google-Smtp-Source: ABdhPJw2e9G19NVqKc7SICEm2HKhYNk5D7R4u6geiIOB2wtNdYcQ82XGr1cfIGnY1UlnIOCWgtx6ssTpN9N0Q64tSRU=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr5683022lfu.291.1631830188831;
 Thu, 16 Sep 2021 15:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210825082536.2547-1-caihuoqing@baidu.com>
In-Reply-To: <20210825082536.2547-1-caihuoqing@baidu.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 00:09:37 +0200
Message-ID: <CACRpkdYZa=67LxZWHfrFBfnSJmi=0CcHyZmoJvaPojugtuAdmg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: Kconfig: Remove repeated config dependency
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:25 AM Cai Huoqing <caihuoqing@baidu.com> wrote:

> remove it because "if (ARCH_U8500 || ARCH_NOMADIK)" is already used
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Oh right.

Patch applied.

Yours,
Linus Walleij
