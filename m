Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F2839ABBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 22:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFCU0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 16:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFCU0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 16:26:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2404C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 13:24:05 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a15so5421472qta.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K0U2vfO0s/gXz3YV0/zSFcReO1Jx7LkT5Q9OOSBMSss=;
        b=j1A98YTafAPvHjzQY+ZV3QAOa/LBVzmJgVhIbhQLSvdy7bXiODny1yOlaQlb7LWls1
         opVdTQxQBf3Q8hayY4a9lm9mPaZjJGGYSQ2H30V1xIUhm1pwHvYQ50/PtHnXUA6ijneI
         dnlEKejOa4+paYKemXhcp2qBAN9dE/b3ctD14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K0U2vfO0s/gXz3YV0/zSFcReO1Jx7LkT5Q9OOSBMSss=;
        b=bHdXV2FK+6N8GZC6SXyl6Ky9uemLA6i00xPZ0NYtddmPmL1EusLY0nBGLAw3rwTShS
         fHtyxqVn5Vu8YzzIetfWR/EcfhJR2/urGngwyhMS9xLQs0/FwYzmU03vOBq302EWt79z
         S356oimF52JBFBPNCvJfDmWiUy/hPNd96c4UfJhtEB+sHyKFMNBk+SB1UuKhxKsrE5o/
         IGyZIMFiTZaC1M0nVNmDFHyIFA4kz2BAyHfRuPBMj7dC7J+vkBtO9/kcq3KkQ67AtwDe
         NEbgagkvj6ulskoO3v/YuC9UdmhIW/ohty4HLptYOrrUudVBb44NpVKUF5eS+OhSOBas
         8i1Q==
X-Gm-Message-State: AOAM533Y1V1f0XsBvF3zz2GTeF1rvL3PP4co0vPp8lcLonoVgL/+Uoyw
        ubwpw0smHojYD+OLuNOYLnJZkkPWJgudbg==
X-Google-Smtp-Source: ABdhPJxdQIYW92hGYBc02Abeg9usQrrRTk38UQo6z2x1BMti1NsuuKUJPDURKv/KoZCD0dUs7a+NtA==
X-Received: by 2002:a05:622a:553:: with SMTP id m19mr1292788qtx.234.1622751844658;
        Thu, 03 Jun 2021 13:24:04 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 7sm2521503qtu.38.2021.06.03.13.24.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 13:24:04 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id b13so10583992ybk.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 13:24:03 -0700 (PDT)
X-Received: by 2002:a25:8191:: with SMTP id p17mr361035ybk.405.1622751843264;
 Thu, 03 Jun 2021 13:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210602191338.1995827-1-sujitka@chromium.org> <20210602121313.v3.1.Ia83c80aec3b9535f01441247b6c3fb6f80b0ec7f@changeid>
In-Reply-To: <20210602121313.v3.1.Ia83c80aec3b9535f01441247b6c3fb6f80b0ec7f@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Jun 2021 13:23:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vfi6SZsgJN3Jm+DrmW8KrySbn14BMOWQjW9ib-fqZd8Q@mail.gmail.com>
Message-ID: <CAD=FV=Vfi6SZsgJN3Jm+DrmW8KrySbn14BMOWQjW9ib-fqZd8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sc7180: Move sdc pinconf to
 board specific DT files
To:     Sujit Kautkar <sujitka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 2, 2021 at 12:14 PM Sujit Kautkar <sujitka@chromium.org> wrote:
>
> Move sdc1/sdc2 pinconf from SoC specific DT file to board specific DT
> files
>
> Signed-off-by: Sujit Kautkar <sujitka@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts      | 102 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 102 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi         | 102 -------------------
>  3 files changed, 204 insertions(+), 102 deletions(-)

FYI: Since there were no changes from v2 so you should have kept my
reviewed-by tag from v2. Here it is again, though:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
