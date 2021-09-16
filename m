Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A876D40EDDE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 01:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhIPXeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 19:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbhIPXeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 19:34:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D32C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:33:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so25141684lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rjHqvEYv6+gMyg4Tq+Rh/G8JnWMIR7cUG1Fmcv07v/Y=;
        b=mVwI96FJbGbROeb+waDs8Fr9jg58Ppg3G2f/qwPZr8axanVXE1bqdoj0ztls5rFeZs
         7VP7jjoGJfuz3jYXmZXGUUni8EfJ0lHPi6gBIwHP/3X+JyNUfkM64ieQN7Eup9QB3k9+
         vuJiV+V11n2Sz8DjTwNiUX7vhU6ELwHZd9a1rYo3jBA8DojYTwgzZN1KmzCSV73sP+lr
         XQiXPoqQ9zuPRQKFU7kB7mBZs4lDHUt202CByLC5d9bKgKa3M18kMIbzFQ/7AvVQvp2f
         Mv4pVqPYTnLLv3IYLLOI9QoERjjqo3vdcr/qYaQ/3TiL0X0yeZOBfspENrBEt6KUVBUs
         6vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rjHqvEYv6+gMyg4Tq+Rh/G8JnWMIR7cUG1Fmcv07v/Y=;
        b=QeUCFv68BLmg68Wks/7X3kklcl78QB0Qzi9NPyhvGIt0MHlDU+ah0LEXr8Uj+fTZe+
         gO70gbDcY/6uXVhxctFU4u0gdPP2lPee883LT5K0pISAPs/501ciPiQZt7rTdfFRc3DO
         OAbNSGEIi5JIYfj9D8WWjwnaozsA2AvgG06dBNDD7jhJT/b+KkgKb3h8PekjGm7f2hwX
         j5XA3ToTbJfW5sKWt3MQBtKH5f6ivrOhuLECO8TWopl2j9bcy5bBcqUSoYn72/sn4V8d
         f5wSjSHAezpIFyg+E3okuRT0u9NWF05W9frWWrB1dz8/YxDwJ5Gegqb8bmizcZF12W3T
         EzTQ==
X-Gm-Message-State: AOAM532TZrH7CDSuVuNkE7t1ah/7GjVbgPr7DkPhT2qPMKuDrXcj1jQe
        3zAg8I5rEsPs/VqNG3tnbnXkTd46BqFLtwJJDso7zA==
X-Google-Smtp-Source: ABdhPJx3qUqm8D+MvhzJv8yo3TmSo9hTYPFYIbXvo26tL6U4gur7fI6B/LsMvGG2bOFUWelJ1aarRW0hBAjmL6Wq+v0=
X-Received: by 2002:a19:f249:: with SMTP id d9mr5952890lfk.229.1631835180984;
 Thu, 16 Sep 2021 16:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210908013218.29702-1-wenbin.mei@mediatek.com> <20210908013218.29702-2-wenbin.mei@mediatek.com>
In-Reply-To: <20210908013218.29702-2-wenbin.mei@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 01:32:50 +0200
Message-ID: <CACRpkdYxSwr05eK1x+BAgHxgccQWGUxW-_q_xSGmfkTHEbs+5w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mmc: mtk-sd: add hs400 dly3 setting
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 3:32 AM Wenbin Mei <wenbin.mei@mediatek.com> wrote:

> Add hs400 dly3 setting for mtk-sd yaml
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Excellent doc!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
