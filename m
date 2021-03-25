Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C24C348C89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 05:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhCYJPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 05:15:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E734C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:15:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w37so1409393lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 02:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQSUS0sWefxNSCHEC1KdchHT6ruHmXruWSe0jguDBe4=;
        b=o57KpS/SVqgB4aa8+prMDX4/0f/sQZGpgBQ8t5UkMLPn5Qn3CNlhP1s7Y7cH4Uk0Yt
         5+aTgDlMtpj8VahIttojhrrqsMz/i3HQcvat2q+Z9IlJEJlzy4HXE35AMDJMbCm+Fwag
         qFIWd7dGn1Dkpw/9bBN+AjxUmjgcMmvYPGwu96VWRx3Jk3pOWVzsmR2MflpGxpsR/+zI
         214Nl9OF95l2M2We75WAIh54bzfBMQE0D8P4KtGSM+lKlRhSnbRTreADGhK5Iq5E6anG
         Hinv7XgoNn7ofg5sU3fNhh/jDogg7F6goe/WLIVqPG5zG3KvOj4ZK71BAHaib2103KXC
         sl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQSUS0sWefxNSCHEC1KdchHT6ruHmXruWSe0jguDBe4=;
        b=BEuE+vnOJMecu+ub0ZAMd/m2j2QaNap77WqpFt7B9eeIhTHJG9qOEYBOrH3bhFfuIH
         QCAzGjRybmQ3kakngn/olyLcB02WHbSk0tmvoIcsgbe/s6/Ehdma4cv/Nu9axb+C+j36
         zFTAt7kgGotO40160bG5l2AdLNtN47wm25cNNUZXmV2rvfubJX3442W546l6YNszSrcg
         Xw5MAeV17ZprF4taITXsf5E0/pgfJR+Pl9RXPXNFqnpwmPf00nR6KnUl2dO3eVM7q1E+
         5nODxgC9i4EngZ3SWipBFEWaiz4W395oS1j6ALjU5+OVe1UhodiuKEK13J6mXGvuaO8+
         RAIg==
X-Gm-Message-State: AOAM533yqyOekJehe/vQl+TabdqXPDLHyPxIt+wbyaATmbzxKodnxBsj
        wxqZkh7WEBRv2MhRSb7+ILdu+5dw/magF3FE3Xflxw==
X-Google-Smtp-Source: ABdhPJwItH2xIo9/hQ0G/Dsu3MfocBFrbbbYJg+8rqc4pz2dbpv/HCAoF4I48/Ib6niSpMgouHHNNiCfW6MgVKURop4=
X-Received: by 2002:a19:548:: with SMTP id 69mr4426509lff.465.1616663729558;
 Thu, 25 Mar 2021 02:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210321033150.15380-1-zhiyong.tao@mediatek.com> <20210321033150.15380-2-zhiyong.tao@mediatek.com>
In-Reply-To: <20210321033150.15380-2-zhiyong.tao@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Mar 2021 10:15:18 +0100
Message-ID: <CACRpkdaO8YEBo53uUuUpegjFTwaZbtWtbKTUynAX_55p89Dfvg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: add lock in mtk_rmw function.
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com,
        hui.liu@mediatek.com, huang eddie <eddie.huang@mediatek.com>,
        jg_poxu@mediatek.com, Biao Huang <biao.huang@mediatek.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        Erin Lo <erin.lo@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, seiya.wang@mediatek.com,
        sj.huang@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 4:32 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:

> When multiple threads operate on the same register resource
> which include multiple pin, It will make the register resource
> wrong to control. So we add lock to avoid the case.
>
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>

Patch applied!

Yours,
Linus Walleij
