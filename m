Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840303259FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 23:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhBYW6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 17:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhBYW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 17:58:38 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C47C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:57:57 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id f17so5434408qth.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1hhikhUfJgUYoJWHOz5mYG43dgdqvD25NKJhwkGGME=;
        b=W1Lg/r85qkEkqlSzP3K7bUkT8hCe1cymIs3mOxfNemlRXXDK1J99kIUqTtEdKHoD5P
         YrOMdAXcg4Y5Vqz8s0EoLdA6z553GS5BJPSOEyq6PKNcVO0NYEqr2XiIXYjyyIDEArGe
         AoKfPOdmJLAqN4FOF2o0ENH1UB6kPJ7E76H+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1hhikhUfJgUYoJWHOz5mYG43dgdqvD25NKJhwkGGME=;
        b=AlKB//3ozdOyKmL+C38x0eB8d424qoqopwc3fmNVG9r3tZoyuVKCeWP/32ZvnTnG69
         brhPpFHUz3pGi7tlzKVgFG6iUBCObDpwXe8r1g1K/UX3f3ZEZ3FviGTSAN2DFR1u2h3b
         QjZB/JKmUjPeHEfsdDDW37l2kxpNVWd/3zukiNPJHu54PkG5uWm8q4p3RPe56IUguTU8
         2ovT2hALe9yAWyILTZC+VsErEAM5JZcURueV5eVJn+hoMommQ61IR3hNtzEFP/xPwIEM
         JYFVSQ0hRyfY2J3n3VAduURlYFq44fkTkUkRiBKG8gRiAqZZiKIERyXh1I7sEm3g5gya
         KiyQ==
X-Gm-Message-State: AOAM531bvar6Uv6QWZjiyZ2fukZiZVTcHgsTj4bvFoJIT1kX56Jv433d
        U/WFW81jhZ1C1ZMZmCSTWLQbQEAqsCTrNA==
X-Google-Smtp-Source: ABdhPJznmCKxHPJQFTIAuhPzjzwe+auto5/hVcUcHVXxsWsCOg8K/5sYuffTcV2/62/uvErEgHyU+w==
X-Received: by 2002:ac8:6a16:: with SMTP id t22mr362641qtr.333.1614293876996;
        Thu, 25 Feb 2021 14:57:56 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id e15sm4637546qti.79.2021.02.25.14.57.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 14:57:56 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id c131so7071090ybf.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 14:57:56 -0800 (PST)
X-Received: by 2002:a25:4e83:: with SMTP id c125mr201182ybb.343.1614293875603;
 Thu, 25 Feb 2021 14:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20210225221310.1939599-1-dianders@chromium.org>
 <20210225141022.2.Id27e7e6f90c29bf623fa4880e18a14ba1dffd2d2@changeid> <a4a83576-9d95-80eb-0090-62526eba9095@somainline.org>
In-Reply-To: <a4a83576-9d95-80eb-0090-62526eba9095@somainline.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 Feb 2021 14:57:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WhjvqUau_Jz9ZLFukGUxRqGJTJN+sUt=yv2Q81FRzUWQ@mail.gmail.com>
Message-ID: <CAD=FV=WhjvqUau_Jz9ZLFukGUxRqGJTJN+sUt=yv2Q81FRzUWQ@mail.gmail.com>
Subject: Re: [PATCH 02/13] arm64: dts: qcom: Move sc7180 MI2S config to board
 files and make pulldown
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
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

On Thu, Feb 25, 2021 at 2:55 PM Konrad Dybcio
<konrad.dybcio@somainline.org> wrote:
>
> Hi,
>
>
> >
> > +&pri_mi2s_active {
> > +     pinconf {
> > +             pins = "gpio53", "gpio54", "gpio55", "gpio56";
> > +             drive-strength = <2>;
> > +             bias-pull-down;
> > +     };
> > +};
> > +
>
> You can omit pinconf{}, so the outcome would be:
> &pri_mi2s_active {
>
>     pins = ...
>
>     ...
>
> };
>
>
> This makes the DTs ever so shorter and is the style that's currently used for new submissions.
>
> Same goes for the nodes that are being referenced.

Yes, I agree.  That definitely makes sense going forward, but I think
it'll just add to the confusion to switch a dts for a given SoC
mid-stride.  ...or, if we do switch the style it should be done in a
separate (no-op) patch series.  This series is already giant enough...

-Doug
