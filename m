Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9973F6BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 00:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhHXWxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 18:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhHXWxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 18:53:12 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6BC0613D9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:52:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id a13so28361186iol.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaFUFYkq0aAQb9fBgckSLrpv7E3PmSpqoTQXohZW4cw=;
        b=IvPy+MabaZ/Bejpu9hF3104ynjKW9brt/qnAFarovpAHfVE+su5MGecyK0USm1S/TP
         gv+Ii7noRCgKZpU+IbZOBMPtf7xGO2HOjtHNFDsuSb4qW2gy/9DiqKx5AsTsBuyYfuiJ
         +E1hjLs3fjG3YKjZg1reMsmh46TSbvjKiIzfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaFUFYkq0aAQb9fBgckSLrpv7E3PmSpqoTQXohZW4cw=;
        b=fke7AR9o1oRTW5go9T0FFBsbGUgcPk8KZLYqzMGI53QHM90zNJ/sF8o+3VTQggnwnm
         F5gQgHPk5B3CUD3HiS+HjX6XPdFwVB+rn1aKXbYidPNBRoh3SeWWrqYzihNdlJlUEfM3
         SyZUVsLeiU9aZ8yA4Y6D11lSYZZvf1irDftsOzNJTb25tlfVPzV2g0yQYMdtM6dGtB8S
         sDrN5auv4dM2a4Fllk+h9LqdpaCPciP/jZNELznrAEXSFl8XrxqzsYiqTIk8PL0jV9cC
         OyvGWkfJKd75k4y+koSnQywX5yIUAD0LYJ+EHgsTRi9HMCtsIePmLlftCe3zjFoewXYb
         yygA==
X-Gm-Message-State: AOAM53323eboDBFToFrZnWMhDHEvFbrjuG9YlDLyBmEijZJ6mHO1ADQY
        mfJfy28IpEUFZItWmAmPqmpSZuDp6gabXw==
X-Google-Smtp-Source: ABdhPJxvwe5MAjrFXVlWZpoCt6M4+MpB1Bvs/H3NQfScSYNjWQ8WhwMC5Vs3ZMU/JIEXkrXirUJDVA==
X-Received: by 2002:a05:6638:81:: with SMTP id v1mr23443185jao.11.1629845547082;
        Tue, 24 Aug 2021 15:52:27 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id r18sm11039538ioa.13.2021.08.24.15.52.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 15:52:26 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id s16so22100579ilo.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 15:52:26 -0700 (PDT)
X-Received: by 2002:a92:cf4a:: with SMTP id c10mr24580250ilr.269.1629845546303;
 Tue, 24 Aug 2021 15:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <1628642571-25383-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1628642571-25383-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 24 Aug 2021 15:52:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1zARov=8q9ZSOS4BRe919uFLJh56b8WKk-9LF0r5KZA@mail.gmail.com>
Message-ID: <CAD=FV=U1zARov=8q9ZSOS4BRe919uFLJh56b8WKk-9LF0r5KZA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add clock controller ID headers
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 10, 2021 at 5:43 PM Taniya Das <tdas@codeaurora.org> wrote:
>
> Add the GPUCC, DISPCC and VIDEOCC clock headers which were dropped
> earlier.
>
> Fixes: 422a295221bb ("arm64: dts: qcom: sc7280: Add clock controller nodes")

IMO drop the "Fixes". To me having the "Fixes" there means that there
was a bug in the old patch. This isn't really fixing a bug.

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +++
>  1 file changed, 3 insertions(+)

Other than removing the "Fixes" then this seems like it would be nice
to land soon after the next -rc1 comes out so that patches that start
referring to the clocks in these controllers can take advantage of
them. Snooze 3 weeks till (presumably) -rc1 might come out.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
