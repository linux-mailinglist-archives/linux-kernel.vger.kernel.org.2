Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804D941DEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349614AbhI3QTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 12:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349624AbhI3QTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 12:19:20 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B2C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:17:37 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i25so27536569lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9AydplMO/OhchranFJNxsujjEB+Eo9pfrveqj6lBlFg=;
        b=qUffUWOuFP3/0X04i77M7wE7tr9M3z9zUShjb3xRJsb7HIXmRnl2l3AxGvVjar7aFA
         unF5eCBPPT8czCY8/I4w32GSWCvamltkC677hJ2bFllO97iK036m/SlqreWhRTvmPLHQ
         4s2kSLW1ppCmS1NeQY3xYj2+0YKirmOPQhblVrGWGe+t4ZjIGZIP7wSWoJrRdXG7wSuW
         xL48DAlsGwZkwhAl3NEq4/XTb8i9C/M9x0JWQZw1pJ2ii6viWDd/GD+dghS7TTzjTKGa
         cPHyik+7LLS2fCB3XJkPyzqyg53L8yltVZITOkM4M/zR9KPrXiSqbMWZD9JeST//3i11
         9rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9AydplMO/OhchranFJNxsujjEB+Eo9pfrveqj6lBlFg=;
        b=HDFvo+wIDllJvXbfjkb0HunE0WTlzQ5cPsf3vwNZbiHVUk2C+iMs//ORPBG1XVxbQS
         YECD0fUmOan38HEHTuyxdPB3Sh3uACrYEgkrpPUtq5JCegqSiyhP59s5GvfTwazYC3xS
         oVUZS5NzQGtUhETim8XQr1/qfrQ8nQD0dBiMSW4bs0CWAJvrsji0UAb1x0TtcTdTQX8Q
         PPlXMVOrpeLmVgv7hAqI+Rug5pPKyeAI1E1YSEMdDWbtjN8vT0gtHOlYIuWuWdYX3BX8
         fVo7Jo3/HTOl10ofbk7/nkDPjzK0LtA0FuHUg6fHo/x1VVbhiK+QswubPVe4okCnpi6i
         GpgQ==
X-Gm-Message-State: AOAM530/XZHuk3CazqYOqYd0EIqZoTen/O+j98QZUvfobz5SM4MpEUCZ
        l45bIGDvYFUS9vKS6ZAePNQyI3CvlLzONY5nEetzIA==
X-Google-Smtp-Source: ABdhPJy+kwam2qnCIJA421Yva4o4+CPlZrt6f87kDQGjhOta3fQWnFUPvQVO3ABPx0RiMmhb2e/ysCCV5bMgqrYfB1A=
X-Received: by 2002:a2e:4e11:: with SMTP id c17mr6598678ljb.19.1633018656196;
 Thu, 30 Sep 2021 09:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210930095225.9718-1-jbx6244@gmail.com> <20210930095225.9718-3-jbx6244@gmail.com>
In-Reply-To: <20210930095225.9718-3-jbx6244@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Sep 2021 18:17:24 +0200
Message-ID: <CACRpkdZfzQK4LcwkwY-AbfXUaMssfUpKSa4VOSnuVLQPdapCYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: change gpio nodenames
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

Please funnel this through the SoC tree.

Yours,
Linus Walleij
