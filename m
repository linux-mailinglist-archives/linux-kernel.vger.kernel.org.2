Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E166130DD6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhBCPCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbhBCPB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:01:56 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04808C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 07:01:15 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c3so13834587ybi.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 07:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJ7CGQhYFtJFl07ok5/69cMGKvlS3zw3sFP/g+CPbqE=;
        b=uZRRLhF3y0eS4ljMgqi7OwEh7OK1K0i0l31vpn/9XZAt2nrvyjY193G5ODx9d1MwTy
         CtGWgi7zLNhfBfC4dS/zMN9ASHn+zM2vJMDusoIzh4ufmwXQieEUCQ7QXb9Rl/VCOMNw
         3+flaW4lom3bFvCog1A2VWA2/65sy9tTQUUfZ8mtd0ClAodwHZYBmr7VC+44oG182xst
         XYQkG68olRjlOj60fGtXQ8owKFIsLXXCAwQydtPH3kKTNOgXgRRJtjcn2NIak5mN33Sk
         jf0D6ymnpixxzJccr6sOkGqyLoBTwocxntAAov1uxolPvGX7AEI5sAMqCKnY2i4TB1J8
         Oj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJ7CGQhYFtJFl07ok5/69cMGKvlS3zw3sFP/g+CPbqE=;
        b=CZr5XoEr67I3jsGsbm+0Vzc265hVAbIvqZEnV2fJmTQAqqvWjRGW6D86Ey/ok6Nacf
         SEFv+Y0jMmSRn1GpdECvyAAWUOeIvbKW76UbG+UnTCV1mU8HlZD75NV7Hs/jMifsI4aT
         Uga6lgRU6vHnZWhJ3C7gwfXiI1HUi1KOnUr+PiFLZCED7nIj/y9ugQT4v+CguFo09xsk
         wMdG2E4tKB35Ia/rZ9GbZsnZhDqyJsBZE7/2J7HKh+PJV006TTYqzCFQB98KP9QndHik
         dme0OYGYSLrf6oIYmmmrSQZVeoiNsn//E9OeCPO1ElQ/jx63EGkCWbNz7RJwyfMNT+32
         cA2Q==
X-Gm-Message-State: AOAM533QIwK9Q4ESEy+kULAi+cnlyBo8Ajf3RTXfzZ7aY3qZ9iWZ+Fft
        91+SXI/543/PQ+yFQ0y5F7QgyZoHl7OGZjY21Ei08A==
X-Google-Smtp-Source: ABdhPJwRthCdZBCwaBHOQPF2SrN9ZvGM6S/fgfnLOLSpJL/wn3O50hA0qpEtO0YWCyaTDqZpAcvV9FeDz/C+DXAww/k=
X-Received: by 2002:a25:1457:: with SMTP id 84mr5080609ybu.74.1612364475171;
 Wed, 03 Feb 2021 07:01:15 -0800 (PST)
MIME-Version: 1.0
References: <1612346356-26445-1-git-send-email-amit.pundir@linaro.org>
In-Reply-To: <1612346356-26445-1-git-send-email-amit.pundir@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 3 Feb 2021 20:30:39 +0530
Message-ID: <CAMi1Hd1cCtSFMBjXm6=fwEeSYMYs5xvKPK25TxsxU9YDogxxDQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-xiaomi-beryllium: Add DSI and
 panel bits
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh.. This patch is not formatted on top of mainline. It doesn't
apply cleanly. Sorry about that. I'll fix that in the next version.

Regards,
Amit Pundir

On Wed, 3 Feb 2021 at 15:29, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> From: Sumit Semwal <sumit.semwal@linaro.org>
>
> Enabling the Display panel for beryllium phone (Xiaomi
> Pocophone F1) requires DSI labibb regulators and panel
> dts nodes to be added. It is also required to keep some
> of the regulators as always-on.
>
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
>  .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts      | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> index cd15ae0347e8..e09effa555f1 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
> @@ -160,6 +160,14 @@
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>                 };
>
> +               vreg_l14a_1p88: ldo14 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-boot-on;
> +                       regulator-always-on;
> +               };
> +
>                 vreg_l17a_1p3: ldo17 {
>                         regulator-min-microvolt = <1304000>;
>                         regulator-max-microvolt = <1304000>;
> @@ -194,6 +202,7 @@
>                         regulator-min-microvolt = <1200000>;
>                         regulator-max-microvolt = <1200000>;
>                         regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-boot-on;
>                 };
>         };
>  };
> @@ -207,6 +216,44 @@
>         firmware-name = "qcom/sdm845/cdsp.mdt";
>  };
>
> +&dsi0 {
> +       status = "okay";
> +       vdda-supply = <&vreg_l26a_1p2>;
> +
> +       ports {
> +               port@1 {
> +                       endpoint {
> +                               remote-endpoint = <&tianma_nt36672a_in_0>;
> +                               data-lanes = <0 1 2 3>;
> +                       };
> +               };
> +       };
> +
> +       panel@0 {
> +               compatible = "tianma,fhd-video";
> +               reg = <0>;
> +               vddi0-supply = <&vreg_l14a_1p88>;
> +               vddpos-supply = <&lab>;
> +               vddneg-supply = <&ibb>;
> +
> +               reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               port {
> +                       tianma_nt36672a_in_0: endpoint {
> +                               remote-endpoint = <&dsi0_out>;
> +                       };
> +               };
> +       };
> +};
> +
> +&dsi0_phy {
> +       status = "okay";
> +       vdds-supply = <&vreg_l1a_0p875>;
> +};
> +
>  &gcc {
>         protected-clocks = <GCC_QSPI_CORE_CLK>,
>                            <GCC_QSPI_CORE_CLK_SRC>,
> @@ -274,6 +321,14 @@
>
>  };
>
> +&mdss {
> +       status = "okay";
> +};
> +
> +&mdss_mdp {
> +       status = "okay";
> +};
> +
>  &mss_pil {
>         status = "okay";
>         firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mdt";
> --
> 2.7.4
>
