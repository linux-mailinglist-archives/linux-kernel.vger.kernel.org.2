Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65235432E89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhJSGtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJSGs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:48:59 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90912C06161C;
        Mon, 18 Oct 2021 23:46:47 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id n2so4067941qta.2;
        Mon, 18 Oct 2021 23:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoewNDuKiwgSJLTwqWzb1Sriu8DiIwvWpOuR2ScPTk4=;
        b=QHs4n5hnOVcUomIu8wiPM8BfAY6BrwZYKx6S+ZGt9f7T2ShA549Gx9hhBhksM3REWk
         p19NXWIT7b5+ErfSPkcsQlQuuB4NFiz5sXw6czSEZcteUsEnA7aD+hydB2IyXD7YFzqP
         UoiE/4fqLRWGejfpdv0fMKRl3knzi0Ln0MjZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoewNDuKiwgSJLTwqWzb1Sriu8DiIwvWpOuR2ScPTk4=;
        b=UUxgIcK3Fk1r02i/RAYgzg2A5lo/Eb1MS1trU19JXCjR6miw6qguyr45TavMJwNnQC
         X2uG37mWcs53VsUR9t9DnIbO4ej0fWacVxykMLlNXlbwc49rBfH+SdkgZjXnFjU7sIHb
         Stb3sscf7bwKqlhqCrvfd/RveIeJ5yw9eBUZl1RATcSWwGLMNb8zPnKx6xxFdGGSb3jB
         zyyhAp0d8HmZr7QbkH6OCR2wVp73wT1SaY/EnO+JU1YSLlrgqGalWTTp/mG5G8xBCujE
         7YNQmjADVUUNIMF6G+jmUXeaskDe3PAw4ewnduoeLxLuMUFDY/2GaNAJdUXcMyzPzx7I
         fDjA==
X-Gm-Message-State: AOAM533fVNHBgiJKSdFGBsNEk5y4znVcHmLjMpYI8ALobfAiBk9klNSB
        aJd3Jkj1ezRQlWhbK+e43JyLHHD8WH2lm1Dwrms=
X-Google-Smtp-Source: ABdhPJxJYlKZwgLWJqa7Jjs3CaYkmR98qbL+qFd8eRHWChM/xN85crXRZyY/H6rVG/YAvcSTvVX2QuqlcrygIrn/byM=
X-Received: by 2002:ac8:5e49:: with SMTP id i9mr33068309qtx.145.1634626006635;
 Mon, 18 Oct 2021 23:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211019060155.945-1-quan@os.amperecomputing.com> <20211019060155.945-3-quan@os.amperecomputing.com>
In-Reply-To: <20211019060155.945-3-quan@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 19 Oct 2021 06:46:34 +0000
Message-ID: <CACPK8Xe645Me=NnjKP8L40a+ADT1FteL==b7SRNPAGM=K9UC3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: aspeed: mtjade: Add I2C buses for NVMe devices
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 at 06:02, Quan Nguyen <quan@os.amperecomputing.com> wrote:
>
> This commit adds configuration i2c busses for 24 NVMe slots and
> 2 M2 NVMe slots found on Mt.Jade hardware reference platform
> with Ampere's Altra processor family.
>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> v2:
>   + Introduced in v2
>
>  .../arm/boot/dts/aspeed-bmc-ampere-mtjade.dts | 258 ++++++++++++++++++
>  1 file changed, 258 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> index 3515d55bd312..723c7063c223 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtjade.dts
> @@ -7,6 +7,50 @@ / {
>         model = "Ampere Mt. Jade BMC";
>         compatible = "ampere,mtjade-bmc", "aspeed,ast2500";
>
> +       aliases {
> +               /*
> +                *  i2c bus 50-57 assigned to NVMe slot 0-7
> +                */
> +               i2c50 = &nvmeslot_0;
> +               i2c51 = &nvmeslot_1;
> +               i2c52 = &nvmeslot_2;
> +               i2c53 = &nvmeslot_3;
> +               i2c54 = &nvmeslot_4;
> +               i2c55 = &nvmeslot_5;
> +               i2c56 = &nvmeslot_6;
> +               i2c57 = &nvmeslot_7;
> +
> +               /*
> +                *  i2c bus 60-67 assigned to NVMe slot 8-15
> +                */
> +               i2c60 = &nvmeslot_8;
> +               i2c61 = &nvmeslot_9;
> +               i2c62 = &nvmeslot_10;
> +               i2c63 = &nvmeslot_11;
> +               i2c64 = &nvmeslot_12;
> +               i2c65 = &nvmeslot_13;
> +               i2c66 = &nvmeslot_14;
> +               i2c67 = &nvmeslot_15;
> +
> +               /*
> +                *  i2c bus 70-77 assigned to NVMe slot 16-23
> +                */
> +               i2c70 = &nvmeslot_16;
> +               i2c71 = &nvmeslot_17;
> +               i2c72 = &nvmeslot_18;
> +               i2c73 = &nvmeslot_19;
> +               i2c74 = &nvmeslot_20;
> +               i2c75 = &nvmeslot_21;
> +               i2c76 = &nvmeslot_22;
> +               i2c77 = &nvmeslot_23;
> +
> +               /*
> +                *  i2c bus 80-81 assigned to NVMe M2 slot 0-1
> +                */
> +               i2c80 = &nvme_m2_0;
> +               i2c81 = &nvme_m2_1;
> +       };
> +
>         chosen {
>                 stdout-path = &uart5;
>                 bootargs = "console=ttyS4,115200 earlycon";
> @@ -445,6 +489,220 @@ rtc@51 {
>
>  &i2c5 {
>         status = "okay";
> +       i2c-mux@70 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_0_7: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +       };
> +
> +       i2c-mux@71 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x71>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_8_15: i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +
> +               nvmeslot_16_23: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +
> +       };
> +
> +       i2c-mux@72 {
> +               compatible = "nxp,pca9545";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x72>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvme_m2_0: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +
> +               nvme_m2_1: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +       };
> +};
> +
> +&nvmeslot_0_7 {
> +       status = "okay";
> +
> +       i2c-mux@75 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_0: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +               nvmeslot_1: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +               nvmeslot_2: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +               nvmeslot_3: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +               nvmeslot_4: i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +               nvmeslot_5: i2c@5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +               nvmeslot_6: i2c@6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +               nvmeslot_7: i2c@7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +               };
> +
> +       };
> +};
> +
> +&nvmeslot_8_15 {
> +       status = "okay";
> +
> +       i2c-mux@75 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_8: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +               nvmeslot_9: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +               nvmeslot_10: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +               nvmeslot_11: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +               nvmeslot_12: i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +               nvmeslot_13: i2c@5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +               nvmeslot_14: i2c@6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +               nvmeslot_15: i2c@7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +               };
> +       };
> +};
> +
> +&nvmeslot_16_23 {
> +       status = "okay";
> +
> +       i2c-mux@75 {
> +               compatible = "nxp,pca9548";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x75>;
> +               i2c-mux-idle-disconnect;
> +
> +               nvmeslot_16: i2c@0 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x0>;
> +               };
> +               nvmeslot_17: i2c@1 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x1>;
> +               };
> +               nvmeslot_18: i2c@2 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x2>;
> +               };
> +               nvmeslot_19: i2c@3 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x3>;
> +               };
> +               nvmeslot_20: i2c@4 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x4>;
> +               };
> +               nvmeslot_21: i2c@5 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x5>;
> +               };
> +               nvmeslot_22: i2c@6 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x6>;
> +               };
> +               nvmeslot_23: i2c@7 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       reg = <0x7>;
> +               };
> +       };
>  };
>
>  &i2c6 {
> --
> 2.28.0
>
