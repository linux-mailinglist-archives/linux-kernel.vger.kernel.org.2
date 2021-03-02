Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ADD32ABDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444158AbhCBUtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352020AbhCBRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:51:10 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC0C061225
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:28:06 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e2so17251932ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aPax3GL1qwe1HwLabdJUeK1LIyhAZJzxJUxC8g0CrqA=;
        b=zUMBuf2BI1C1L3cXsm5ETv5uy/TNdLURmncPes75wlQXzUc7LGrFJpIpB0tGX+DVzl
         Xq8xgRKJhdx70VSBYNnkiaF+TAisNndnUOVlmbku+mOplCwlWeP1WXK4UQ50qv7jDzyP
         RgglgTgURUrDzlSg8pkATeL54SG4LrzDACHTmxev6Uv1+Hs0cjrhvsXkRKIONTKe49cQ
         QyXQvbanzB7Bt2Qf1Ocgk/dEHOUiLBHhNLiNjHYI1/GmdTMhhd3OC/8Hyk70u4Ap9kDm
         3/MJz0tamQztGSqhOTCrEbQpJzituKpVIEX8mRk2Eq/v4vmnATbU31W8hfruFS8+f+lX
         AI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aPax3GL1qwe1HwLabdJUeK1LIyhAZJzxJUxC8g0CrqA=;
        b=i4Kg/9RVTV6vKb0fZ8UG/5bL6L21yxrQxD3ueSrrRLJVUbgOU5koIm9UpQcKwUDwIp
         3hBHBPlGxLVKcInSSUlrzS1r4xjKDd1OgeYhqU9fPAd/CgOOuvlcY9V5jlHA6WuUVDSL
         Ew2lO9FuBuRZzfrixaSBepXyAE/q4Dq1Cq9pJFi0pay7pGXU0rD/TUTZu+mEm2WKsQ6u
         72yoO4FuVgPqPd0a6dZ6ewcJaSVyCOjWpG6Sf+cLO1YvrfOm/2JG/kJkJZF2jA1YaKzk
         4U7BcH4uBBXKmkH8HjcNUIGuPC6sS8AJn0ygDwUMo0kphjd0TZkQX3wTk+YsVb73LEWU
         8ITQ==
X-Gm-Message-State: AOAM532R5bSkbw1HNby3djFQcIiMeINYg1CUzHp++t7i+N5+SiyyKwMV
        JEZcvGKOJ8rsQ8Xy0cV1feVCYTiCzreH1Y+GvUk6yA==
X-Google-Smtp-Source: ABdhPJwpVHsQIIpr4Wxk1imfzi1DhFf4KVqUC8erLVb6K34rLlG4dfMC2gAE/7BMpbwcrYTc43NzTLz/U3I4d78XTP0=
X-Received: by 2002:a2e:1649:: with SMTP id 9mr4062048ljw.74.1614698885189;
 Tue, 02 Mar 2021 07:28:05 -0800 (PST)
MIME-Version: 1.0
References: <20210225164216.21124-1-noltari@gmail.com> <20210225164216.21124-9-noltari@gmail.com>
In-Reply-To: <20210225164216.21124-9-noltari@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 16:27:53 +0100
Message-ID: <CACRpkdanuQAg9ON_-=NwOi7J_pYZS4zecH+r3tFKK-NuRa1P2Q@mail.gmail.com>
Subject: Re: [PATCH 08/12] pinctrl: add a pincontrol driver for BCM6368
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 5:42 PM =C3=81lvaro Fern=C3=A1ndez Rojas
<noltari@gmail.com> wrote:

> Add a pincontrol driver for BCM6368. BCM6368 allows muxing the first 32
> GPIOs onto alternative functions. Not all are documented.
>
> Signed-off-by: =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Same comments as for the other drivers :)

Yours,
Linus Walleij
