Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE5C438C02
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhJXVKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbhJXVKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:10:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF339C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:08:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l13so8616075lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMYhbLkgTSqPSv9vA6KWgK1dElOofvGFtWwEO+48qZ0=;
        b=CCBwZTOnWvYExKQ/vwM/BrgQ+/2VXEta4i/lTffNfw3ohsCrs5RF8Di2tkXD7R8Y7Z
         9ImYAeELkS9dIztoT86WgcADOmObC7RVpSFYpgz+/50LupX31VuzTNej6sUzePQuroY5
         r4gbHDF/oxnmeyx638YZb/RUOGb+ZDJRlKK6zjRIKV6O9pOvVSMwqo4B1ZDJI2E7YiQa
         BdQfBeiHzL+uRB5vyFdJhTXJW5CWDfqTTDIvKJX3frysFvikSP0rBDRSynt8SiCB4HjA
         Tymjj8+wz1PdvZyiVTQU+A4frz7K2AGDAhuCNaHznPdjZwP0S60w1qdbtF2nSki37b7q
         thMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMYhbLkgTSqPSv9vA6KWgK1dElOofvGFtWwEO+48qZ0=;
        b=X357CTJe5scCEEPIoHXb7zJ+6F7lBXPJTT8E8khRuMai34jgtS4ucdjpJybbURzL14
         jiW0xPxorqcqFgIAzLgBNnjurNVmSWgR1NheIxx3Svv+mO2GQnZfE18cPUzBGNpSVSly
         YmzBjrUOCTBd1bsOZZR0IbamKpvNYQk6JD5zun8r4QYIOIEquMcRoRc/kKjRECKbTy7Y
         DiM53tkhzO4a/9vC509c3LPihPiabRWniXZHbgXaZg+3t7gfYW6GiCG0vxWHOqGpXAym
         9KyL/YKXwwTlDDKwK2nt/rbrjvjOHAfCN1M2WnY4BSROfbGaCq7WlrEFtsU0Tumbih7T
         yadQ==
X-Gm-Message-State: AOAM531DR/BgUdFQCFulcjhj5+O3EWs6ho5zyOjP/NGEXukcP7MoC1s7
        ehmBEydLKn0Hy/4c40Z67j9rN99jok4b6ASO0/jOfg==
X-Google-Smtp-Source: ABdhPJwAZbQpExa3fIcxuElrdBQpPSxEtV7dAaKscoaT6LDhlGxWjuDzvnxdv0SLWc6JCN8hPKHAEbgB51S3lCZGu1s=
X-Received: by 2002:a05:6512:1316:: with SMTP id x22mr13096950lfu.291.1635109687054;
 Sun, 24 Oct 2021 14:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211022124036.5291-1-sam.shih@mediatek.com>
In-Reply-To: <20211022124036.5291-1-sam.shih@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Oct 2021 23:07:56 +0200
Message-ID: <CACRpkdagzzWtN6Gp-ZMZkAqq7JwL0nf63J7NC8jpF=ZfRJG4JQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Mediatek MT7986 pinctrl support
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Fri, Oct 22, 2021 at 2:40 PM Sam Shih <sam.shih@mediatek.com> wrote:

> This patch series add pinctrl support for mediatek mt7986 SoC series.
> It is based on patch series "Add basic SoC support for mediatek mt7986"
> https://lore.kernel.org/all/20211018114009.13350-1-sam.shih@mediatek.com/
> ---
> v9: added Acked-by and Reviewed-by tag

I have applied patches 1 & 2 applied to the pin control tree!
Thanks for your good work.

Please submit patches 3 & 4 to the Mediatek SoC tree.
Acked-by: Linus Walleij <linus.walleij@linaro.org>
for these.

Yours,
Linus Walleij
