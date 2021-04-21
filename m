Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959FE3675ED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 01:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbhDUXwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 19:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244140AbhDUXwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 19:52:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E221C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:52:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id r128so42343620lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 16:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ivm6d4yVpz6wxqjoIxuxTg+SZhzN2ypG6TV5x80NnpM=;
        b=DMh7vheT5U1OIJur0PPhjCgM5nHDbuRtZKTMCNh6pCVV/J78UexrPAVn4kb7MOmtb8
         y72p4UVqo2EvCb/8KvfKprlcCXhGSXAvbqhHFAZxR04ya4nND/c6UPgyI8akLLD/IiR8
         GSxdbH9qipxY385l2TH39BZEORzRoDmUEyMqRzjgR9C68+3t1CocgMMpsBQxysF7hqK2
         Ug93Viu9Z+pAyWthIYb8MTYJvpIVXaxHpmHfO9eAXsTdw3ozXYDSPLMDHbqD32dnA0mM
         5Dye7puk3hpfFX1WvYz+oP/T3eFQ4+6tVEhASy0gssXbgMl1w76gEUfHyTTx5kVE6XHs
         6X2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ivm6d4yVpz6wxqjoIxuxTg+SZhzN2ypG6TV5x80NnpM=;
        b=Jrtnvy51v+TtDT71iDyHGwLVmc71if/Ewg/rg2p+3wICKyPpOUmJEr4izBp1PjoEla
         o9QYzkn8J7Dzw9vEcj/x38MLogplrjyFG2MdanJahkpDk1tFwl5m/wf3MdqEpMbV115Z
         Rzm0vPrfMo/SOpZ1QkuP63yWU9l/p/Sg2XE8ymA7KZxOJCnhXI4jeiLyK6O3QUX5uO0G
         ZgKH99DtUTTNcjYxP/HqTDnV1LXQSjM3p7Q2/+TC1/eQm8CpNh6oELvPvx5vQ4G38Wp5
         BSF68utVH2nRT/1cAEVM1kqvgR/BE4jGiasiEdair+LC1rskaMwS0b2iwoXdHVg/6I1C
         EdHg==
X-Gm-Message-State: AOAM531WIXRF19cdIJ5WRwptKT5pTwzsxNwl2zRHQpnpjptRqfHVv71Y
        HGvNrinPOjVxNcf7hz0J30zOIxEah3cSxod10wLgFw==
X-Google-Smtp-Source: ABdhPJzmJ0hXWQ9N9xQDOb/L2pSUh6o4Gu0ot0hyFhyWuTkhNKTzHl5RCW2okpKn6wl9vvF5CUOg2K8gHMnzBbiHjpw=
X-Received: by 2002:a05:6512:22d3:: with SMTP id g19mr469471lfu.291.1619049118562;
 Wed, 21 Apr 2021 16:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210413055702.27535-1-zhiyong.tao@mediatek.com>
In-Reply-To: <20210413055702.27535-1-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Apr 2021 01:51:46 +0200
Message-ID: <CACRpkdYtjG3LbcMiHmODggWRecSWGSm34vpEtti9x9SKdV9_BA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Mediatek pinctrl patch on mt8195
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        jg_poxu@mediatek.com, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, seiya.wang@mediatek.com,
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

On Tue, Apr 13, 2021 at 7:57 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> This series includes 4 patches:
> 1.add pinctrl file and inding document on mt8195.
> 2.add pinctrl driver on MT8195.
> 3.add pinctrl drive for I2C related pins on MT8195.
> 4.add pinctrl rsel setting on MT8195.
>
> Changes in patch v4:

Patches 1, 2 & 3 applied!

Now you only need to resend patch 4.

Yours,
Linus Walleij
