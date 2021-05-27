Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3135B393965
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236521AbhE0Xt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbhE0XtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:49:22 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE84EC061761
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:47:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v5so2988990ljg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 16:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2q5bxqiL3RmhUQgZjWS0StDo6w0kZxEVUhgbpPjauE=;
        b=cSDGAxeChyN935ODp1inJLu7l0S13MyTsKIRSsqXOK6cXm+8i2omLijZJqU/JUH6Ah
         D/2OlVMBYcjb+AyQZg7J3MeEfF0BG3Vaugml//5QcemxM/+aFpgZvcLCb0bZfY0IIal3
         R5slk2oWlepD6l/bsYyrxkhjN43IBFyYL25ZFccy1lkZCi1dVZkWlfopwoxaSYvLqHj5
         Bf/dx6Knm3aucrzCINO61otLB0vyjLch4hgNIs2IoH8pmbWm2d5ZHGBinREHNkUXlMVA
         ZSfRBTBsslzQjNbsP+PZSrT3qPiw9bYhxfIrI1mTTzeUPb1fyeFG4n7X/NA0ROkKrpnJ
         T+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2q5bxqiL3RmhUQgZjWS0StDo6w0kZxEVUhgbpPjauE=;
        b=UWcKnM8POv7VwflOiwhNFFiJ5Fr5JRzY8mgPA/wG6aqRGdnu7oHY1RJUXu15fFqMf/
         iXB0dGVWahhNor/P92m1+xB7w7XMSOaRnlIm5f3pd+ROWB6tM/GOa1SSnXKE/yE4wwbe
         7YIU/6sg6yDsf9LoCpC2l4yutY1A692z5MiE1VaHC4SCkz3lyDBoG7cRaLrgDLtxoli8
         3+F10RIAdJGEM+Dxg7o3LKINKBaEAlR0h1q9m6jOz1hr+adHdeL7nUjFsZjAntEklsxD
         QCTF8Ja0ErrSN5hYCDY33HsPujs50f/yYez2NgpehUu0/ieZytAzACahK9VZcDL87loW
         oI0w==
X-Gm-Message-State: AOAM533eTyvGxl1KpYjKTMnO+jLd8cCpmi1miQ+GNFsSn1u45zMLFj7+
        /4V5V7SdEvGBVyi83FeKlQ7sfbZSVtlVCJM0ph0ZSA==
X-Google-Smtp-Source: ABdhPJzRZIXUM5v0L9y/J3SYmWZlTefoTYzbZzpPJiwkvhwh8H0h3EDZMkqNbakFaetCMO0USRSrvzBmrnlu03IJpJ4=
X-Received: by 2002:a2e:90c7:: with SMTP id o7mr4436100ljg.368.1622159266928;
 Thu, 27 May 2021 16:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210525055308.31069-1-steven_lee@aspeedtech.com> <20210525055308.31069-3-steven_lee@aspeedtech.com>
In-Reply-To: <20210525055308.31069-3-steven_lee@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 01:47:36 +0200
Message-ID: <CACRpkdZy0UwaJcYTiM9asVwNh4wuEYdMSrmqAPAiikbrvjtKpw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: aspeed-g6: Add pinctrl settings
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "moderated list:ASPEED PINCTRL DRIVERS" 
        <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED PINCTRL DRIVERS" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED PINCTRL DRIVERS" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 7:53 AM Steven Lee <steven_lee@aspeedtech.com> wrote:

> AST2600 supports 2 SGPIO master interfaces and 2 SGPIO slave interfaces.
> Currently, only SGPIO master 1 and SGPIO slve 1 in the pinctrl dtsi.
> SGPIO master 2 and slave 2 should be added in pinctrl dtsi as well.
>
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the Aspeed/ARM SoC tree.

Yours,
Linus Walleij
