Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F43D3E58E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbhHJLMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbhHJLMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:12:17 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA6DC061799
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:11:55 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id v3so8398801uau.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQ8oi+oE6PPUXMmBt4sVo8+CTE0W6oonn/nsHgSQPP8=;
        b=LhvSRqq1g5xnEb55wGh1S9Krd15ZRxQeukl0e/IVgfdBSxviDcb4flhDosmIoy9MOt
         JWT5myCThkFCOnKZ7N9OHA8aCrp6Kd/WMjJEndokcK9QBfv5bDsooCji6DQt2KxzyQsB
         yT/jQ0RDqUVl+AdJorVaUlWGTMNn/Z6riUjsiAedN17vW8L6FSwflobjseISmrSnABI6
         u03UgGzC4nlBrVVJh6TWjxWMnm4ie4hHSHu6M99Jp52Ze59Lli+tTHWAt7IhWJ0KcokO
         tkQqAk281Qyh3zgBAtilXehvyuZsOZ1etpfbO5A0lFB0757Pa+P+ju61QS+bf5j6n+Q8
         OE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQ8oi+oE6PPUXMmBt4sVo8+CTE0W6oonn/nsHgSQPP8=;
        b=kySxOhkPqUYiF9A4GWSMuQfVZQdqvrZYDc0gRIGUxGjfegOGaGSf8jSYeqA665jABU
         YcoCNMx8lEZ3XqBkpnLnDyLcD1R0t2GqfFjfjNxunVjE0J/rkggX9jzVBdL83uSO90Oh
         x+OwmfM1TfQyIcZVzcLwztzmXgDGpGx7DDzy6wfghe9YB/SA/Nh4aL39QPFcXpAwVXH0
         suL0GA/MTo0S61Gdrlgt+zPGl0y2swPVxCfaOD80yXoQ2n5vvBPJNIUrmLhKy4enUZnP
         ytRx0vh1qdXGFBsORpg1CzAxyA/np9sHBtFRFk7H+/ubpmtAkHPEaHFi6B0HXlXsRZwt
         n7ow==
X-Gm-Message-State: AOAM531b21OpMBYz+xlHxe1DTYkNUH5CGxNa5X7/OiSJuHOyDiNlzCRc
        ng/r3IDG20aToj5aEhM81off7xAAA57Jb9Bg9vFjyQ==
X-Google-Smtp-Source: ABdhPJwhKmFLkCUee1nqRnXB6F7pv7NhEc+p1zYHqfIMcwuJxy11DpS1gN5hW6sTVuypPApzCJg6q499nHwSH9nayLU=
X-Received: by 2002:ab0:6695:: with SMTP id a21mr20042466uan.19.1628593914605;
 Tue, 10 Aug 2021 04:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20210727202004.712665-1-dmitry.baryshkov@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Aug 2021 13:11:18 +0200
Message-ID: <CAPDyKFoQRbsvV-DLxV+gPRRCB2PVDdtWo5VU-q+pgDtQnu9gFA@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] clk: qcom: use power-domain for sm8250's clock controllers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2021 at 22:20, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On SM8250 both the display and video clock controllers are powered up by
> the MMCX power domain. Handle this by linking clock controllers to the
> proper power domain, and using runtime power management to enable and
> disable the MMCX power domain.
>
> Dependencies:
> - https://lore.kernel.org/linux-arm-msm/20210703005416.2668319-1-bjorn.andersson@linaro.org/
>   (pending)
>
> Changes since v5:
>  - Dropped devm_pm_runtime_enable callback to remove extra dependency
>
> Changes since v4:
>  - Dropped pm_runtime handling from drivers/clk/qcom/common.c Moved the
>    code into dispcc-sm8250.c and videocc-sm8250.c
>
> Changes since v3:
>  - Wrap gdsc_enable/gdsc_disable into pm_runtime_get/put calls rather
>    than calling pm_runtime_get in gdsc_enabled and _put in gdsc_disable
>  - Squash gdsc patches together to remove possible dependencies between
>    two patches.
>
> Changes since v2:
>  - Move pm_runtime calls from generic genpd code to the gdsc code for
>    now (as suggested by Ulf & Bjorn)
>
> Changes since v1:
>  - Rebase on top of Bjorn's patches, removing the need for setting
>    performance state directly.
>  - Move runtime PM calls from GDSC code to generic genpd code.
>  - Always call pm_runtime_enable in the Qualcomm generic clock
>    controller code.
>  - Register GDSC power domains as subdomains of the domain powering the
>    clock controller if there is one.
>
> ----------------------------------------------------------------
> Dmitry Baryshkov (8):
>       dt-bindings: clock: qcom,dispcc-sm8x50: add mmcx power domain
>       dt-bindings: clock: qcom,videocc: add mmcx power domain
>       clk: qcom: dispcc-sm8250: use runtime PM for the clock controller
>       clk: qcom: videocc-sm8250: use runtime PM for the clock controller
>       clk: qcom: gdsc: enable optional power domain support
>       arm64: dts: qcom: sm8250: remove mmcx regulator
>       clk: qcom: dispcc-sm8250: stop using mmcx regulator
>       clk: qcom: videocc-sm8250: stop using mmcx regulator
>
>  .../bindings/clock/qcom,dispcc-sm8x50.yaml         |  7 +++
>  .../devicetree/bindings/clock/qcom,videocc.yaml    |  7 +++
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               | 11 +---
>  drivers/clk/qcom/dispcc-sm8250.c                   | 28 ++++++++--
>  drivers/clk/qcom/gdsc.c                            | 59 ++++++++++++++++++++--
>  drivers/clk/qcom/gdsc.h                            |  2 +
>  drivers/clk/qcom/videocc-sm8250.c                  | 31 +++++++++---
>  7 files changed, 124 insertions(+), 21 deletions(-)
>

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
