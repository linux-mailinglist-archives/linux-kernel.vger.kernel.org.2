Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37E241DDC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbhI3PnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345545AbhI3PnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:43:15 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EFC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:41:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i25so27072098lfg.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkiMt/G7bFXAXpJDQxe1pxlr8eHxyYeyKBiifpqcCv8=;
        b=cgIhgC2Dc4NbQWA+Np0faZRjXOIfA5Q6JS57HlBiEUSQSUzjg4MSeF5mSEA9WS0CGt
         QmPmhU1bRPjJ2fFdWpZ7Za+A+gMd7/S4KXUjERWkNLNvaFZv0jFlFkYfBNtsi1PjY+Fl
         bF3Tf/931BXCeVPfJNiYweKFHD76VytKHwKHubp1EE7fznmMpsb02OvqAFfSbohtFdHv
         wUi3B6dEfrHtvwHrKrQ+U4cRGTC4qUgbVSJWcabR86XIbSo6RJchJVnXr+GrVCwDLhbH
         Quzu5MAw6J5Fct26H4B0MUfbbS9p3k/KGUMnFU+iMrX3iuhR8QykVx51mEy/vYXEuT63
         9IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkiMt/G7bFXAXpJDQxe1pxlr8eHxyYeyKBiifpqcCv8=;
        b=SDBKuE9YxrlzPli7YpmgMh7Qz+AJPyOm0+cO4UZ+XZEPNwB3CDAAhqsiVUNo5mZE58
         cGUPCuKe7BCgXorPmLxK9JdagKVQaTjuxbJJznfEcjpG3YBmd3/2hhlVR8xIlu27Brlh
         V1zGKVI4rld3hVplvFVM7Jty/lEED69y6Kq4qOrKkRpAjJfndD4zRJOxEGT8LDHS9ALo
         5MH5vV2QFc0AskL9urefA5KFsp0H74YdgcYPzwIgUFijHDNzpvaC1cmEm44zPF/VZWe0
         4tW6zi/OMSFwd51pEu1YYIh5cUwdu2cMHZ6UHhf7orbjFEXO0qsXSXnz9q1MXIS+o9It
         +rrw==
X-Gm-Message-State: AOAM530FnoOzBcWhnxB6846ukDoFrNq5lYbKa4O8HqzR3axTFkxg6uZW
        e/jHIELEbpazIjNsPsDZn/EOCOA1f1bbzgfX2YkMRg==
X-Google-Smtp-Source: ABdhPJzbQx3xPiacL41rCJErivYDM0vWUswmTjCsb5uUGMEo7NJ89zBn/DGOalij/ndQl9CH3MaHruCT6FaEoOS8rOg=
X-Received: by 2002:a2e:4e11:: with SMTP id c17mr6415015ljb.19.1633016487609;
 Thu, 30 Sep 2021 08:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210924080632.28410-1-zhiyong.tao@mediatek.com>
 <20210924080632.28410-3-zhiyong.tao@mediatek.com> <YVTfDJNW5Pe3iAR/@robh.at.kernel.org>
In-Reply-To: <YVTfDJNW5Pe3iAR/@robh.at.kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 30 Sep 2021 17:41:16 +0200
Message-ID: <CACRpkdbWR_kmvMuHMTOjxLDqN6rq7zhrWcZxfi2L3Atau=TLSw@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] dt-bindings: pinctrl: mt8195: change pull up/down description
To:     Rob Herring <robh@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        hui.liu@mediatek.com, Light Hsieh <light.hsieh@mediatek.com>,
        Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

how do you want me to act with this patch set, as it is already
merged and I was pretty happy since it is a v14 and feeling
it was getting a bit over-reviewed....

Are the binding problems solvable in incremental patches
or do you think I should pull out the patch series?

Yours,
Linus Walleij
