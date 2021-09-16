Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D490940DE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhIPPet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbhIPPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:34:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C45C061764
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:33:18 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p80so1792644iod.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms3bl+nA5Ri+3UB+CCMQr3zf572ukgQ7gcT+ysEOLx4=;
        b=GCuBZd4DCB9aZj+pCfyCiLjwRu4LhUZquIp2PLs8FEt7Xt+aP6AYFjmRNrx2pLdLQO
         H7VqSWn/4MDPPI8YJ+CbpDmTTH+DRt4JLmX64snOhw2xy7fLxCGXDfmETRL3oUxZLHDj
         kreR9rErzUvoNNTD8le00ZhaWU4Ln4dzaTOr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms3bl+nA5Ri+3UB+CCMQr3zf572ukgQ7gcT+ysEOLx4=;
        b=NLTDHGzO9k808e7UL/G3kd/9QKQHynVeBAEb2xcKLYWsiijiGG3FGsz1ddF/iJhQio
         ihn1367ttroO0GsTH1fElbpWabLfbc4q0N9uv7949Q3swTX33Ezo2Eb6qSq4pQu1M74i
         XPADP/3zxGLCtGArKEMM7oK/Suo+vOiI/FFkdLUIso7vKXVTjSZtj+2mSbfilOK/z3NN
         3wOm2LllFdqO8zUTGX6f0CeSLqzfxl4Z7Cj2c3e+ATjMGqe6pVEoAhPVtOCI+S5elfRV
         /+5vNOr/P9e+FqvosZMzng4qC11pJrZ7X3oKNk1gF3EBPjZPDr8BHUe/NP63y1kmbBlQ
         e1sw==
X-Gm-Message-State: AOAM531bbuii2Dc0WTisU193Z5NnZhS44jr+EdfxUfVEH0XQPbEu0Cqf
        HwwlYZ4hrtJCPA/WTVqZYqqALVmvIEGauw==
X-Google-Smtp-Source: ABdhPJwZo52eIULCr1vBxhzEwB7x8BbabijGQ8sWVKd1gXb1Z1nsVD2+GcZHilV8CrQ1jlr5+Kbbsg==
X-Received: by 2002:a5d:8185:: with SMTP id u5mr4910195ion.173.1631806397846;
        Thu, 16 Sep 2021 08:33:17 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id b19sm1840713ilc.41.2021.09.16.08.33.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 08:33:17 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id h20so6981158ilj.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:33:17 -0700 (PDT)
X-Received: by 2002:a05:6e02:1847:: with SMTP id b7mr4487370ilv.180.1631806396862;
 Thu, 16 Sep 2021 08:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210903122212.v2.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
In-Reply-To: <20210903122212.v2.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Sep 2021 08:33:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U=rT5dLz6S7_y6kuZ4R_ijDZtdn25-UkHw2QhNVUu-hw@mail.gmail.com>
Message-ID: <CAD=FV=U=rT5dLz6S7_y6kuZ4R_ijDZtdn25-UkHw2QhNVUu-hw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180-trogdor: Delete ADC config
 for unused thermistors
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 3, 2021 at 12:22 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The charger thermistor on Lazor, CoachZ rev1 and Pompom rev1+2 is
> either the wrong part or not stuffed at all, the same is true for
> the skin temperature thermistor on CoachZ rev1. The corresponding
> thermal zones are already disabled for these devices, in addition
> delete the ADC nodes of the thermistors.
>
> For Lazor and CoachZ rev1 also disable the PM6150 ADC and thermal
> monitor since none of the ADC channels is used.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - also disable the ADC for Lazor and CoachZ rev1
> - updated commit message
>
>  .../boot/dts/qcom/sc7180-trogdor-coachz-r1.dts     | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi | 12 ++++++++++++
>  .../boot/dts/qcom/sc7180-trogdor-pompom-r1.dts     |  8 ++++++++
>  .../boot/dts/qcom/sc7180-trogdor-pompom-r2.dts     |  8 ++++++++
>  4 files changed, 42 insertions(+)

I haven't done due diligence to review this patch since Stephen
already did, but it's been on the list of patches I was tracking that
I thought were ready to land. If there are no objections, it'd be a
keen time to land it. ;-)

-Doug
