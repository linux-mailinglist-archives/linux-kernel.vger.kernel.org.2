Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE303F73CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbhHYK41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbhHYK4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:56:24 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9A1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:55:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y6so42884873lje.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KtXsyPEoSgHBdmGP1qFsGT9RrscqrYn9YkfTv0ST8I=;
        b=F1U0ijMoJ+uQkTH7EAGMMDLpHekxkUXM+2SD8yUcKEs25h6R3TBXPRpl/5AbyiDFMp
         BFiGIYWwKmLgkr9pLHomKG//38jV5N+4G7knhte6u3A4z5PoYFAOhV9QzGB3RZKU0xRy
         oxZW4VlFokPe8hvZzOhJllirIQ4qcX5ZLBsY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KtXsyPEoSgHBdmGP1qFsGT9RrscqrYn9YkfTv0ST8I=;
        b=PMQVpdTG7KXAxd8Yd2cPYA5HGuwHkIYqmlgiv5jHUw8nlJQz4qUvxQmG1E+DaSaZqS
         7lrN7gfTMS+Pok2TwJeP4I8A4vM+QD1wLTJIG1Vk4SK0hAWXAwJ1GgiDQfM2Ftt0vT3i
         FUq0E6aBJ96F86PQRt9et3ZEgKs4NV78vF0fjyiqg1LPhVSyEsJjlSr7UN3bbt6M8tF6
         EQHkT/ctstAq2XAw+3vYH0i/u7f1s0xCRmy1bKbpuNiw8UFJ3gtp3ZC2jldzDePkhH40
         tr3e5uRQG7kqJ0hBIkUqSUpDc3BF1o5y9iDNkb1HdGJg1XqV3++GZFvCjK2NdPHaE3GU
         Fplg==
X-Gm-Message-State: AOAM533GI1Q8dY9k3kDl6OHJFIHz7lDhpk9rOCcMPXSpWR89hW76kfaA
        dxQ19YBBOzkn1XLyR8/5law5T6KOLibNs6MhzXeWYg==
X-Google-Smtp-Source: ABdhPJwSu+M1YeQxqLDZauUzq/Ihy/yhcPvX547+XWxq7oIDLMi7xFitdF7gXGp8kzYgBiuJeidB8DE6eyVKJQequNg=
X-Received: by 2002:a05:651c:211a:: with SMTP id a26mr22213894ljq.305.1629888937124;
 Wed, 25 Aug 2021 03:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210820111504.350-1-chun-jie.chen@mediatek.com> <20210820111504.350-19-chun-jie.chen@mediatek.com>
In-Reply-To: <20210820111504.350-19-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 25 Aug 2021 18:55:26 +0800
Message-ID: <CAGXv+5Eu1f+Mp5WE_BDRioqiZ1LPAyE=3SB5D8nNaHfposDHXA@mail.gmail.com>
Subject: Re: [v2 18/24] clk: mediatek: Add MT8195 vdosys1 clock support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 7:31 PM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vdosys1 clock controller which provides clock gate
> control for video system.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
> Integrate with mtk-mmsys driver which will pupulate device by
> platform_device_register_data to start vdosys clock driver

Same thing about the commit message. The reason behind such a design
should be documented and shared, so that other people looking at the
code will have the same context.


ChenYu
