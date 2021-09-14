Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBAD40A509
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhINEBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhINEBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:01:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E05C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:59:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w4so21147978ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z5OlzavEWnufbwMW9A/eR0vP7IHNpTn//InG4QBRhEw=;
        b=kdFc8tUhNaNEhrjDOP4m70m5hJq0TXdnz0rnbOzc/ALBYlv6g7fMhlS0iOw5mps4Z7
         ItZH9GoCl/rufW5wf0ao/JmKP9qoFXhL30hH2UIGMLGgxz1UBWzLlcgU+FBz2FQa87nF
         fDmExZc8hr/dL1h/RSR1yAI8TWolCjG2LFBIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5OlzavEWnufbwMW9A/eR0vP7IHNpTn//InG4QBRhEw=;
        b=mAKHC7ksfaPioJ+3bcReLzdpNH6zJj8L9LwtSVsMXvsg2v+4fOV+7AcLQ7HO4MGd15
         sE6z4F+TSlwFlc08F0mJv37MOOgTm42AfIp2z6hSxfYeOeAd3ZUhna27m+d20XxVegfa
         cvpneWBgpQ50YmbveyBHQivLn707103NnAGsb9BO5r5s0fhkTd2oHFDVEpF0fuW+3Cma
         amknVJSTtADRkbKVzLcIO85VTVytyUGKe/tYZ3mJWNzfE619dpBE3ixFalfFVsy9X/PN
         jdamsEW4/HzWGlmleox1kWGcGfwwWX3goHbQjJ3pTCoyECSonGZJwA0BOQjaEuQnV/t3
         rObw==
X-Gm-Message-State: AOAM533d/0GStaUjGRxi64yMruLmsQfCyYZHg9o+Sqm2luiw9Jlk0NrW
        /bJ6rm4cVC7FnaAsjQiZAxg4/kzaHy6rLvhD1IggCQ==
X-Google-Smtp-Source: ABdhPJxz3tXcGotEGCpfsh/LNJdjDfZn+6Q7wCSUUy6z0nG1j2UL769wKfHW7P19kJeUhTBkHqpbx4AG7Tp9mwO3tE8=
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr13491184ljf.9.1631591987302;
 Mon, 13 Sep 2021 20:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-15-chun-jie.chen@mediatek.com>
In-Reply-To: <20210914021633.26377-15-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Sep 2021 11:59:36 +0800
Message-ID: <CAGXv+5ED0p4mgcB5sOwB3MQBy2+PYq-tcaqL7xW7FHRG07b_Yw@mail.gmail.com>
Subject: Re: [v3 14/24] clk: mediatek: Add MT8195 mfgcfg clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 10:17 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 mfg clock controller which provides clock gate
> control for GPU.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
