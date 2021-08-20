Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2276D3F2E56
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbhHTOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbhHTOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:46:04 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFAAC061575;
        Fri, 20 Aug 2021 07:45:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f15so9784959ilk.4;
        Fri, 20 Aug 2021 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Md1apuMBbtZGhp/2epW+iQOyrSw2uquy06j3D56m54o=;
        b=Ai6knLwVhkPu4/LKOb4pLjAUfE6uHZ0Wn54g6Pog2illCYVkmx4zC27kNnpkqvEXyC
         EKLg4nK7c1mNcTZOVgILV2DVbdKyp+9lwy7QqwgldG0V5eP5Qn+cz95IcZxpesP4ejGp
         V9vqWFuOXzwQBTXUcnbyGQGjeJWQGYkBDYwIH/1SAqTPN091yO3srIbfQufNCA1BRNFS
         4/Vw4g2cP5Wr2VIdAE/wwaIEy3+qpTKRhbUFAu79HPVsEQmMs+T20kgZ5AiAIog3TUUq
         Rwpl5wJqge3rB5580A0ptJOdPv6yixDDJBQfysJJm67JHPiStG1HS6JR1q14A98i5mDr
         sCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Md1apuMBbtZGhp/2epW+iQOyrSw2uquy06j3D56m54o=;
        b=uiZC/NlXt4d4x7oheNftSGyE833xhM//SxGo/FHwQkvbjyijeVKGvQ01b7Nke5nP6k
         Ikkyk9DC4tRCyPastNo2DVdnysb5XteX9reYHeE2EetoVO+Vc0IUTEItr11B0wClH8RR
         +WU8NdCxzk8zDYH/npwqREKiyc3ezm1cKL2Vy5mW85riYBo2nvKnSEP2knPV3UiBSB5o
         NgmgIWFk/OeFLpmmt1vilv1mrp1xvU1tl6fJJ14afWMc1wQpzwlmaWEY6C85A8nSlE+b
         jiWCcnhLL+pPMvGYPbc08oN+7qrmiMBra+EgFMI2WA1njUt0gNRC92dcF12n9ej+kDgk
         RJ6w==
X-Gm-Message-State: AOAM530K0WnDYS20AlkmQrLn0MzDLY5BYAUgN4shuErl+ZgkgrnGCH9a
        m4bm+8IfvMCRmYSWYUw5cwtePoGXhy3e2FmMKMQ=
X-Google-Smtp-Source: ABdhPJy4LgmcbfJ9lizv4Iy8EJ16aEp4wSs4RpmryExfT/NRadcxjW4WRjAggGTa8t+i8JZcMdhXl4m0YDaYUtcbU2M=
X-Received: by 2002:a05:6e02:eca:: with SMTP id i10mr13465125ilk.27.1629470725831;
 Fri, 20 Aug 2021 07:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210820081458.83406-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210820081458.83406-1-krzysztof.kozlowski@canonical.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Fri, 20 Aug 2021 20:14:50 +0530
Message-ID: <CAGOxZ53oTWuSLupGKWd+XWPXJZQfZ28-Vo=wWT1exty0LpCfOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: exynos: align operating-points table name
 with dtschema in Exynos5433
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 1:51 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Align the name of operating-points node to dtschema to fix warnings like:
>
Did you miss adding warnings here?

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
Rest looks good.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi | 10 +++++-----
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi     |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
> index 8997f8f2b96c..72ccf18eb9d1 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
> @@ -87,7 +87,7 @@ bus_noc2: bus9 {
>                 status = "disabled";
>         };
>
> -       bus_g2d_400_opp_table: opp-table2 {
> +       bus_g2d_400_opp_table: opp-table-2 {
>                 compatible = "operating-points-v2";
>                 opp-shared;
>
> @@ -117,7 +117,7 @@ opp-100000000 {
>                 };
>         };
>
> -       bus_g2d_266_opp_table: opp-table3 {
> +       bus_g2d_266_opp_table: opp-table-3 {
>                 compatible = "operating-points-v2";
>
>                 opp-267000000 {
> @@ -137,7 +137,7 @@ opp-100000000 {
>                 };
>         };
>
> -       bus_gscl_opp_table: opp-table4 {
> +       bus_gscl_opp_table: opp-table-4 {
>                 compatible = "operating-points-v2";
>
>                 opp-333000000 {
> @@ -151,7 +151,7 @@ opp-166500000 {
>                 };
>         };
>
> -       bus_hevc_opp_table: opp-table5 {
> +       bus_hevc_opp_table: opp-table-5 {
>                 compatible = "operating-points-v2";
>                 opp-shared;
>
> @@ -175,7 +175,7 @@ opp-100000000 {
>                 };
>         };
>
> -       bus_noc2_opp_table: opp-table6 {
> +       bus_noc2_opp_table: opp-table-6 {
>                 compatible = "operating-points-v2";
>
>                 opp-400000000 {
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 6a6f7dd1d65c..ebd5091d68b4 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -239,7 +239,7 @@ cluster_a53_l2: l2-cache1 {
>                 };
>         };
>
> -       cluster_a53_opp_table: opp-table0 {
> +       cluster_a53_opp_table: opp-table-0 {
>                 compatible = "operating-points-v2";
>                 opp-shared;
>
> @@ -285,7 +285,7 @@ opp-1300000000 {
>                 };
>         };
>
> -       cluster_a57_opp_table: opp-table1 {
> +       cluster_a57_opp_table: opp-table-1 {
>                 compatible = "operating-points-v2";
>                 opp-shared;
>
> --
> 2.30.2
>


-- 
Regards,
Alim
