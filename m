Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4524072DD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhIJVUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhIJVU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:20:26 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0810C061757
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:19:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b10so4061665ioq.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lhyZTASH4SJRYSNnAF6nepknOxCtJqItrbtMVPCI0I=;
        b=HqKsNG9+E/mQtTSc/qswsz3jUSkK53rxZSIixGE9gzqlmB/R5arNOEIhFALiap9nOZ
         Qh4qv/DoUYwk3jrqlEpTng0e56wwgvnUoqWbc9CAb8q2XlxLEGrmbKEEmlZUWDOm3ZVC
         fZ5eKKXsnu6FK6QIN+kKvYtG5i8SC/c0vlCI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lhyZTASH4SJRYSNnAF6nepknOxCtJqItrbtMVPCI0I=;
        b=AGUfRVU3E03UVWqyjveui/7SnFM1R4tKB3Lwau2+zA5bquqT62daVIaDELFuHQkSoa
         tZrWZxzVTX8wvMznGbppPhXssSotdvZKbZ2y7lYrxeI5RaLXpp+GB/4WqjTyAL0BWf4r
         xA6gPs6TnHaPFS8USXUP+fNeTKoXnYG4j97SdRs7vN2c/1KE2bPVVgI8Qhc6bUEGUgOP
         sFY3/qMirOLG1ogrqSosCbZbMWqruV994CKKNrFutexxM4JzImHc8VbtW9ToAfRsdp8H
         C6ZJK1gYSqjr/q7vEium0CHfyckxkrAkvDF43lwuH0NQ/6UToHxgmjNC2uKc1NevxkU0
         LzEg==
X-Gm-Message-State: AOAM532QT3BNt1to6xcFv9mxoq8VVFcYipyD9jHabHtWMWw8ey4AXcWZ
        XV8degl4lsiDxb3fGcaC0J/RB48GrwTTaQ==
X-Google-Smtp-Source: ABdhPJw0vR+gIiBhWBeWypr9p80KI/se9JbFEWwP09YU855rdn1DPqvNXu6Iq/HFrIZfgYNb4AM38g==
X-Received: by 2002:a6b:c8c7:: with SMTP id y190mr8555243iof.210.1631308754102;
        Fri, 10 Sep 2021 14:19:14 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id d17sm3051970ilf.49.2021.09.10.14.19.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 14:19:13 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id b15so2986951ils.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 14:19:12 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr6317818ilm.120.1631308752557;
 Fri, 10 Sep 2021 14:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210909122053.1.Ieafda79b74f74a2b15ed86e181c06a3060706ec5@changeid>
In-Reply-To: <20210909122053.1.Ieafda79b74f74a2b15ed86e181c06a3060706ec5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Sep 2021 14:19:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UV_TG+zCsdYc5mqHFP5Cd8QuQNgYMtWNX9kENXpJXn4w@mail.gmail.com>
Message-ID: <CAD=FV=UV_TG+zCsdYc5mqHFP5Cd8QuQNgYMtWNX9kENXpJXn4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add sc7180-trogdor-homestar
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 9, 2021 at 12:21 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Homestar is a trogdor variant. The DT bits are essentially the same as
> in the downstream tree, except for:
>
> - skip -rev0 and rev1 which were early builds and have their issues,
>   it's not very useful to support them upstream
> - don't include the .dtsi for the MIPI cameras, which doesn't exist
>   upstream
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  .../dts/qcom/sc7180-trogdor-homestar-r2.dts   |  20 ++
>  .../dts/qcom/sc7180-trogdor-homestar-r3.dts   |  15 +
>  .../dts/qcom/sc7180-trogdor-homestar.dtsi     | 335 ++++++++++++++++++
>  4 files changed, 372 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
