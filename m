Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7742BDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhJMKxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhJMKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:53:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE6DC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:51:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id c16so10000388lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 03:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rKfrG5HHh3oByuKlWlvIaOLx1lvfyWUDrGma858qYu4=;
        b=PM4nQ3HIhjJ2Pk5nkf2WdoHIipWVFAbxEGjfZadAqybQ4lcctoKu6oL9ozmu4+CRTZ
         uYIVnj/KasRu8P5C8j4KeWBZdHkmqWbcg7FZJjB+IlCLrSuPl9oyPQNc/6z5IY0xtYk7
         iea0guujK7W4loKN/Bdg1IGrCMUqIZBnVFNemU99yxwV+YBihHQBEb1VKi1cfodpIegh
         CqhZR3NK8QqpiewaxmZ4tx9ILWzWKuWea8Qx64M/DM4EjYcwY7FVTJLLeQKSwvVgOxFh
         fwXO2hJYhvFlED8pENWDK/HoSvWXn+/0A/nSz63cQ16tnLAP5Vss6BNjbr+lMjQOKMFG
         T5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rKfrG5HHh3oByuKlWlvIaOLx1lvfyWUDrGma858qYu4=;
        b=0nJ2ywZHFBbvN/4rszsCtTXYB3ryQ+C6XpvUOF/bvSb3ssvmuSgDuueN1bN/qpPaPg
         ZeYYyqGoGgiWX6TWMmNGBJgzrT32jK9E8w5EvimJShLlIY3fh8KfaoelwF+npzBUCav7
         +lHVNzk3CP7C4RIORwY7qOYjDcUPFbz8/eM8NRzOynH2ovWynM28q6Ko+wNJD1bLYyq0
         WIZoi9znq1PY9QAtL7bF6EwEMHIhEiA+auHdoRtjCf/gb2ko3hfkPIPASfMEBnr9NT+G
         jveX2/XkLimtWCULWiwO/xG+3don4wQERzzj/3vwutnJNiiu1AIoDkN6bt4YdEwpbQxB
         Gp8w==
X-Gm-Message-State: AOAM531YhXoLwjiE3hIFQ8yFqJCpyXGPYqhbraeFusGyZgb8OcjNMX1x
        dSkhpIfEFNCH5Yat+rgc0fmL7YDPOzJG3xEd/n6Uqw==
X-Google-Smtp-Source: ABdhPJzSXmuXGLBC0odLomW50c6wMRcojgUpr4C5z0oUp4TqIelvRRd22KJdLKLOYhRHwdIro3XxaIq1Ttl1rW8y4uE=
X-Received: by 2002:a05:651c:4d2:: with SMTP id e18mr35521797lji.432.1634122268377;
 Wed, 13 Oct 2021 03:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211012123557.3547280-1-alvin@pqrs.dk> <20211012123557.3547280-3-alvin@pqrs.dk>
In-Reply-To: <20211012123557.3547280-3-alvin@pqrs.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Oct 2021 12:50:56 +0200
Message-ID: <CACRpkdaTZYgW8PWabUoKA97B6yOUUGaNsnXOrrxtHc38fU8Qnw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: move NET_DSA_TAG_RTL4_A to right
 place in Kconfig/Makefile
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

On Tue, Oct 12, 2021 at 2:37 PM Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:

> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Move things around a little so that this tag driver is alphabetically
> ordered. The Kconfig file is sorted based on the tristate text.
>
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
