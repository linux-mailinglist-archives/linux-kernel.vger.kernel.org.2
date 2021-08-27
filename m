Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611523FA169
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 00:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhH0WJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 18:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhH0WJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 18:09:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3402C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:08:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h1so13894330ljl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 15:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XEW/384IhA3CWobFmryrUkVSFy3c72GULjkkLbVUYLY=;
        b=A3mbyj/cG7WKe4cw5mSHMR8rRWmvhJyRZWFUZ0mE/51CiMEO/LlRYgWE71a+HWr8bV
         OyxRD5LQh7Ej6OgjZBWIh3RAZWEd326/EZbjXi0YpvNLW/pW/ZennlFaHFL8bOnt/wRo
         GQhhhHaiA+vW87vec59eHp4wPCj0BN+36vUFIfONABw+psCSWsMWA/wzorKVAhs+CzJt
         WA/28Q81/gpK4BulcpMt9n/qkCwNTOWLfar5Vty+YXG3zCUfiQkBe1lfSgzOWfeCiAnj
         HurySp905xaUm3ttocom19BtQI0ea+k209pjaTAuMmGHb0UeA35FFARqo9MWy1vAyqap
         ZX1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XEW/384IhA3CWobFmryrUkVSFy3c72GULjkkLbVUYLY=;
        b=GDOeTpWEZd5qUw3rljJ1J9C1RUj+VewczNy7reyXk80DV3ENiBv4p4tkeHQ2Wa2O2n
         OCWCNOM0636corzkeSlEHHxa6TTBnXBD/0tOBc0xrgBa1z3zMfnq7XV05jIPBapxoI6Z
         Vl3ivEiBmvwempgjdQGJg7GkT7A1tdkUBoP2I3Qozg1UYyXWHCmGZqEUqFohxO+6GLEC
         6pY76SBpGugPt6frBWAWm8IEdoAEL8hD+OSBuzbAL7mkO0gyxTAWR7+i6hzmA+maX5pn
         9+sFbeh9UWkTyQUBky5D1dWvXKA88EBCoB9p6/m0TFfMJSDUBbNmgMBhheGybsORbX73
         NvOw==
X-Gm-Message-State: AOAM533FNJWlaT1tAaQBX3Q/22fRVTkRvUwaYAPKNTms0wGk+vr11qkF
        6O3BRZtfdxINQ74Hc8Hst3Jp9F7liZPHQv3ht5e30Q==
X-Google-Smtp-Source: ABdhPJx+GjMU78jt9HpKF2cTvfIk8z7bme8HTXNjK7t4lPfwdf6bERas4GQV7V7o36Nhr6Yr28VUc3MmTSywSSMhcDo=
X-Received: by 2002:a05:651c:1064:: with SMTP id y4mr9753570ljm.74.1630102127263;
 Fri, 27 Aug 2021 15:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210822193145.1312668-1-alvin@pqrs.dk> <20210822193145.1312668-3-alvin@pqrs.dk>
In-Reply-To: <20210822193145.1312668-3-alvin@pqrs.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Aug 2021 00:08:36 +0200
Message-ID: <CACRpkdYEg0-B6UBRhMFwOKV+1++ZMMH2tczuqZ_WhuRzd6n=zg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 2/5] dt-bindings: net: dsa: realtek-smi:
 document new compatible rtl8365mb
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Rasmussen <mir@bang-olufsen.dk>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 9:32 PM Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> rtl8365mb is a new realtek-smi subdriver for the RTL8365MB-VC 4+1 port
> 10/100/1000M Ethernet switch controller. Its compatible string is
> "realtek,rtl8365mb".
>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

And BTW: really happy to see kernel contributions from B&O!

Yours,
Linus Walleij
