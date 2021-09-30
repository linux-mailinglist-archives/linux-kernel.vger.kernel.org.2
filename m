Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC25041DEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbhI3QSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbhI3QS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:18:27 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC95C06176D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:16:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g41so27361172lfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wrVVL6Q5oh52S40J0qY1IDd3nrzVJ/J8U0I1hgcarO4=;
        b=GGcKF1QOHQHdbK27J87+CXDf1OO+VZ4YO3NuP9kI2G8+4sWkeEA0OekFLzxL/L0w6H
         9nYnWC1zP7NmSdzsSEPUjMqDV5kXvs4oyZRlY+aUdk/RSgbjfZMi94mmTJTuz0cIMU9p
         CTHp6440J8LeqZSNzjqs6YNApx5rLH2OIRa3Jm1dJP+FE3e2aiK2ldl/2ss/r6oTcIfC
         7lXCk1V9kPA0b2fDE6xrjG7VoSAIAvbe8gVQUH2KDZT/66mrPBoSnKqW0oJzO54mqO21
         WYS+EE7VCVS+OxSjVYJ4cUrVK/qlUuYyTmB6bHW6Z7ZCkD5cXSRWMjDiSLmNxLiEoAbu
         JtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrVVL6Q5oh52S40J0qY1IDd3nrzVJ/J8U0I1hgcarO4=;
        b=MdBiX73i6QH7/GYZ/k9jyyox3BBwb6bpInPzwaQnDEDZmmQvIFiewJ0Qbxwo8sMYAi
         sSeOfkMNaZpsF5/+RRHkMTNPN1wcetZM46S1C4BAyxRQwkdyTzzgz2uuYsRKoK+DcJNx
         GPH7X+0xiE/HJJBybFOOCZdbCVVhUUgdzMoVbquG7TrSIqIlAdqN4Opr5gk+U3nDGBaU
         rYkfwOl4HQncn/Su9RoylruqVLIJxU/b0GZynDha0cJ5Pq0f2oSQrJjK+Noicn1y/cK/
         FgDiadodAxhUlwLNIb29r0jWoLuWhk3a2/31Fah9764mLRvwI/kuAAbMR0Gn0wtLP8h9
         9q2w==
X-Gm-Message-State: AOAM532ncBv2R9Q0Sz5X12d4GArazLxBK+Mhw9O+9Fwlp/446nXGgTUB
        na4OoQC8IlYbz1GBrtTMeca5pRsoF7XWW0NEX04kqA==
X-Google-Smtp-Source: ABdhPJzral1Se1YwknQbfsFc4flERKu85KncR+/GFdjE4b1oI/LFJgmnco2+Q+rENklt6Pbapdku3puvBG55dvJW1y4=
X-Received: by 2002:a2e:510a:: with SMTP id f10mr6681946ljb.358.1633018603142;
 Thu, 30 Sep 2021 09:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210930095225.9718-1-jbx6244@gmail.com> <20210930095225.9718-2-jbx6244@gmail.com>
In-Reply-To: <20210930095225.9718-2-jbx6244@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Sep 2021 18:16:32 +0200
Message-ID: <CACRpkdYvKiO_jU5rakwpkpDNq=gCjqtqnVebSECGuWioBOG4wg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: change gpio nodenames
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:52 AM Johan Jonker <jbx6244@gmail.com> wrote:

> Currently all gpio nodenames are sort of identical to there label.
> Nodenames should be of a generic type, so change them all.
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Please funnel this patch through the SoC tree.

Yours,
Linus Walleij
