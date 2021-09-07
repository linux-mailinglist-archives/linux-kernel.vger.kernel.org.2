Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E8F402FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbhIGUya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhIGUy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:54:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B03C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:53:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y34so335752lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2nsQAg7kmIjIclpBrhtqlSTKrFIqUX3LxjUhDb/REE=;
        b=YCsQ08Usmp+NSFE2q8Vqqu+1k2Jxc19NJXOmL6Zp4reeKHQuFtk9hbHHDQ1Xmgd0m6
         bshPY/6nYk77pyO6ANj4wcbRwCSQa3QJ+vwudNf14BMBAQkxF89NI98nGh+WXthFEtpF
         5LV1zH69hfTjOdeQXh4bCWiJk6dplQNZp4kzI8t6aC8egWr7xwOHRDBBQEJqzp0P1BDl
         oHW89Ks9NHvUdtb9B3/rPkLOrYYDG3mpEf6+0nLOinqyHGlamXgbr/mEN/xCcKNiLapd
         6X+s0483+WA7SUQ5DE6qWrfJjZG3v8EsCt7AyCAnzxOW4A32rKdP6sCZxRm7mCBrh9oj
         G/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2nsQAg7kmIjIclpBrhtqlSTKrFIqUX3LxjUhDb/REE=;
        b=NHSzq7k5FEfMluZBOfS9Yw9naiexhZ9g8XLhQfDzWaRHTTtbrzFrUCwpl6lZrmJWuo
         wG5HTLsFD0bCLFmurXrhqtwhDdtHrKdG4NrdWvZTfcBmGS6UZr3VU2wMfT5ZBvxcC87M
         UtlFk67MYZm78esVf71KurEVSLF/ua79jPrsQyjhfRucIj4APWfVq1t7y7sHA5grE6+y
         1DWn8OBOe1hnzuFXnYY4ALfyGO4WULL6BsXGZBw6s9hLpD0prYHESMCgNJRH9EpqN2lc
         HXouurkfl/EL7JA3pAuiX9IDHTRmHS54+QDNocfCuRK9kR59oM/s9GLXx7VJr6fpgXz0
         +0+g==
X-Gm-Message-State: AOAM532FI4x1axe6oh9yQtGpsN9nfN0txP0vBqlmugNiudo2rWBd//Qh
        TMMxbv1UkXaU7MM0vSnw5BQJ/hoAvvWHaQWbl68lZQ==
X-Google-Smtp-Source: ABdhPJzhBFK+nc5T6nsZ3d/UNCMCN4OBLlDwQPAjHtpwLPGtbms1OHE1axqApJ9PGJSVbkInMFi0jFJ5cFAgNd5Hu4M=
X-Received: by 2002:a05:6512:e89:: with SMTP id bi9mr207568lfb.95.1631047999878;
 Tue, 07 Sep 2021 13:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <1630065205-7618-1-git-send-email-wenbin.mei@mediatek.com> <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
In-Reply-To: <1630065205-7618-2-git-send-email-wenbin.mei@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Sep 2021 22:53:08 +0200
Message-ID: <CACRpkdYeE9piO=sfdBdq-Wd9uQpxyAb6xWYJ+9-JMTjrWX9pXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Yue Hu <huyue2@yulong.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 1:53 PM Wenbin Mei <wenbin.mei@mediatek.com> wrote:

> Add hs400 dly3 setting for mtk-sd yaml
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
(...)

> +  mediatek,hs400-ds-dly3:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      HS400 DS dly3 delay setting.
> +    minimum: 0
> +    maximum: 31

Which unit is this? Clock cycles? Then please write that in the
binding description.

Yours,
Linus Walleij
