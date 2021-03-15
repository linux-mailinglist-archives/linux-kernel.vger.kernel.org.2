Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E841B33C7C0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhCOUca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhCOUcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:32:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:32:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id u7so10119960qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2ls2+uQXDv8BpiLhF8FqA6hSrXbISTdm9YVC3CFyBI=;
        b=NQkFyzbcqkBAqXKfDSY3JuEJR6crZshUOu6rzrEW0jsngl9EWtEH1RBMVVvCwjc6Ok
         q7rx5p5Av34yZ1bbeLphUDbwXPMMGbqNZ1KuUnWI+G8WdFMZFNJDlIBb8m1NXAXRfL0P
         hBWjbNt4w0IsbjfgXCV5/qUoBq4haMlKWj8IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2ls2+uQXDv8BpiLhF8FqA6hSrXbISTdm9YVC3CFyBI=;
        b=VEyke6umEf3khd1bYN9DGs+hGjk23/6ZCMs/Hifm72XiwKStQy934VTvWedVAd2aqR
         1wZxgjlQI3SWQBzXv3lP5cKWWcmpk2fqej82s/6HPYh3F2L1Dw/FYMp/0Q3KbHdFi5+o
         K2jndD8xI1V5Qscj5J07P1nPhakqw+sEG6TgApdhVOAoy7l7fLJnMROv64YjTjh5mCv8
         vQq5vlOyOMBc1P6vDiQWtoDVWs1ADZ5Dk/Mb1KmX0GBVTgvsHK6HzlECVacWJW2eSQAy
         8ubnqW4mcbkBCxzMsCOpRoXgnMkFKhlAHgrQBTP+dZ37omBjpA073f4PkAnA0rjC6c84
         2nRQ==
X-Gm-Message-State: AOAM5326MTd4eH7xS08VVgL/AqWeYTqBIX9uZgh+EaWLUoACd8YMWH9x
        KhCXDdHVo6AUrIS0Fx5yW+W5xebZajgDUA==
X-Google-Smtp-Source: ABdhPJzoEqPvgFJiC+Fca0ARZfrdHAveSmrVEoYJ7r15B8vyyjXTblVf9vmbBLGn05Or+qUCb3cl+A==
X-Received: by 2002:a05:622a:15cb:: with SMTP id d11mr4382233qty.230.1615840326967;
        Mon, 15 Mar 2021 13:32:06 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id a19sm13568513qkl.126.2021.03.15.13.32.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 13:32:06 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 133so34566956ybd.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:32:06 -0700 (PDT)
X-Received: by 2002:a25:dc4d:: with SMTP id y74mr2030271ybe.79.1615840325780;
 Mon, 15 Mar 2021 13:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210315132256.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
In-Reply-To: <20210315132256.1.I601a051cad7cfd0923e55b69ef7e5748910a6096@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Mar 2021 13:31:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uj+uFUrFxi_96KuzeBtFY_dQTLOfr74vzztCHsy_oivg@mail.gmail.com>
Message-ID: <CAD=FV=Uj+uFUrFxi_96KuzeBtFY_dQTLOfr74vzztCHsy_oivg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: Add "dmic_clk_en" for sc7180-trogdor-coachz
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 15, 2021 at 1:23 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> This was present downstream. Add upstream too.
>
> Cc: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Cc: Ajit Pandey <ajitp@codeaurora.org>
> Cc: Judy Hsiao <judyhsiao@chromium.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This applies atop the patch ("arm64: dts: qcom: Add sound node for
> sc7180-trogdor-coachz") [1].
>
> NOTE: downstream this property was present in each of the board
> revisions. There's actually no longer any reason for this and I'll
> shortly post a downstream patch to fix this.
>
> [1] https://lore.kernel.org/r/20210313054654.11693-3-srivasam@codeaurora.org/
>
>  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Argh, I just realized that upstream actually has this in -r1 but not
in -r2. So confusing! I'll send a quick v2. Sorry for the spam.

-Doug
