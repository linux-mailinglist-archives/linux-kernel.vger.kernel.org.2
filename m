Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF540A510
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 06:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhINEBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 00:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhINEBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 00:01:42 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC5C061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:00:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id f2so21197172ljn.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 21:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOD/GRIKs+hdPdAcXN0XW4GSnCbiUQLX2JXAm1ArSmE=;
        b=niRWh4tvD3GcDqSTvNOxaxHwf05e+17mw+nVqh3ev2PMzFLop2wDcz1nYhqXjbvI17
         hiN7nMUA1/nY+yL5plpLJ3XjDo8HUd3Rfrjd0z6RCIyD5VwiXRLoeo0r6D3U1b+SCfp3
         AI/cYnJYcWtT831QQfVa5JwSQGx+qBsJ33AMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOD/GRIKs+hdPdAcXN0XW4GSnCbiUQLX2JXAm1ArSmE=;
        b=8R+dGThC7wguIunUkzmq0HI3Ns8zHaleXHnCCtyga1+2bljRDpS/eVDTfGm6pei3eY
         fmwjOmPp/jw7JGcfHy038JLvacxw75nQkcMV9QnISsXQSlNj6AYXqlt6fSn0pYqZBrH5
         PUqnCJLyF0QywgkYJyrdVZP0Y2CuYentpiCIi5hTtaGdi2HgBLAuncuRgYZhUdYEEWFo
         XfbJhW7EQSdTVANBmbkZXk8qPElhSYctDjUK+yKAUwIg609kV7ArjdFOF/VBNP3bvz5o
         yXna+L5aF3H0YIGzZF8CAfipUwbqkiYDtAqStvFrmAIQxFtl7bEVgMr8w53YVKMkday1
         LwUA==
X-Gm-Message-State: AOAM530asZzD0V5mMVC6IoSuJti0w8fjubMbdxgPcPJ5DxCrKE5OYlKK
        sCCz34KVyyAImCHXKRqOlIBF/ZYMcDVpDCNGHHIcAg==
X-Google-Smtp-Source: ABdhPJy+jSeXIvVMpE3aPsW4efziT8vLzw757JkH3TL5SFxgsB9djnQwYrYG3UxmJzgmTf/m5e2RGTHorMfuES6fSuU=
X-Received: by 2002:a2e:4951:: with SMTP id b17mr13688387ljd.414.1631592023693;
 Mon, 13 Sep 2021 21:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210914021633.26377-1-chun-jie.chen@mediatek.com> <20210914021633.26377-18-chun-jie.chen@mediatek.com>
In-Reply-To: <20210914021633.26377-18-chun-jie.chen@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 14 Sep 2021 12:00:12 +0800
Message-ID: <CAGXv+5GE4RaDxJ4oVDgmebG0GbBCiWGWD=-UikOHupn0Ojew=g@mail.gmail.com>
Subject: Re: [v3 17/24] clk: mediatek: Add MT8195 vdosys0 clock support
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

On Tue, Sep 14, 2021 at 10:18 AM Chun-Jie Chen
<chun-jie.chen@mediatek.com> wrote:
>
> Add MT8195 vdosys0 clock controller which provides clock gate
> control in video system. This is integrated with mtk-mmsys
> driver which will populate device by platform_device_register_data
> to start vdosys clock driver.
>
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
